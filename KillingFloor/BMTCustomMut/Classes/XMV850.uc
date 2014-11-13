class XMV850 extends KFWeapon
	config(user);

#exec OBJ LOAD FILE=XMV850_A.ukx
#exec OBJ LOAD FILE=XMV850_Snd.uax
#exec OBJ LOAD FILE=XMV850_SM.usx
#exec OBJ LOAD FILE=XMV850_T.utx
#exec OBJ LOAD FILE=XMV850S.uax

var float DesiredSpeed;
var float BarrelSpeed;
var int BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;

var         LaserDot                    Spot;                       // The first person laser site dot
var()       float                       SpotProjectorPullback;      // Amount to pull back the laser dot projector from the hit location
var         bool                        bLaserActive;               // The laser site is active
var         LaserBeamEffect             Beam;                       // Third person laser beam effect

var()		class<InventoryAttachment>	LaserAttachmentClass;      // First person laser attachment class
var 		Actor 						LaserAttachment;           // First person laser attachment

replication
{
	reliable if(Role < ROLE_Authority)
		ServerSetLaserActive;
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if (Role == ROLE_Authority)
	{
		if (Beam == None)
		{
			Beam = Spawn(class'LaserBeamEffect');
		}
	}
}

simulated event WeaponTick(float dt)
{
	local Rotator bt;
	local Vector StartTrace, EndTrace, X,Y,Z;
	local Vector HitLocation, HitNormal;
	local Actor Other;
	local vector MyEndBeamEffect;
	local coords C;

	super.WeaponTick(dt);

	if( Role == ROLE_Authority && Beam != none )
	{
		if( bIsReloading && WeaponAttachment(ThirdPersonActor) != none )
		{
			C = WeaponAttachment(ThirdPersonActor).GetBoneCoords('tip');
			X = C.XAxis;
			Y = C.YAxis;
			Z = C.ZAxis;
		}
		else
		{
			GetViewAxes(X,Y,Z);
		}

		// the to-hit trace always starts right in front of the eye
		StartTrace = Instigator.Location + Instigator.EyePosition() + X*Instigator.CollisionRadius;

		EndTrace = StartTrace + 65535 * X;

		Other = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true);

		if (Other != None && Other != Instigator && Other.Base != Instigator )
		{
			MyEndBeamEffect = HitLocation;
		}
		else
		{
			MyEndBeamEffect = EndTrace;
		}

		Beam.EndBeamEffect = MyEndBeamEffect;
		Beam.EffectHitNormal = HitNormal;
	}

	bt.Roll = BarrelTurn;
	SetBoneRotation('Barrels', bt);
	DesiredSpeed = 0.50;
	super.WeaponTick(dt);
}

simulated function Destroyed()
{
	if (Spot != None)
		Spot.Destroy();

	if (Beam != None)
		Beam.Destroy();

	if (LaserAttachment != None)
		LaserAttachment.Destroy();

	super.Destroyed();
}

simulated event Tick(float dt)
{
	local float OldBarrelTurn;

	super.Tick(dt);
	if(FireMode[0].IsFiring())
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.20 * dt, 0.40 * dt);
		BarrelTurn += int(BarrelSpeed * float(655360) * dt);
	}
	else
	{
		if(BarrelSpeed > float(0))
		{
			BarrelSpeed = FMax(BarrelSpeed - 0.10 * dt, 0.01);
			OldBarrelTurn = float(BarrelTurn);
			BarrelTurn += int(BarrelSpeed * float(655360) * dt);
			if(BarrelSpeed <= 0.03 && (int(OldBarrelTurn / 10922.67) < int(float(BarrelTurn) / 10922.67)))
			{
				BarrelTurn = int(float(int(float(BarrelTurn) / 10922.67)) * 10922.67);
				BarrelSpeed = 0.00;
				PlaySound(BarrelStopSound, SLOT_None, 0.50,, 32.00, 1.00, true);
				AmbientSound = none;
			}
		}
	}
	if(BarrelSpeed > float(0))
	{
		AmbientSound = BarrelSpinSound;
		SoundPitch = byte(float(32) + float(96) * BarrelSpeed);
	}
	if(ThirdPersonActor != none)
	{
		XMV850Attachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
	}
}

simulated function HandleSleeveSwapping();

simulated function bool StartFire(int Mode)
{
	if( Mode == 1 )
		return super.StartFire(Mode);

	if( !super.StartFire(Mode) )  // returns false when mag is empty
	   return false;

	if( AmmoAmount(0) <= 0 )
	{
    	return false;
    }

	AnimStopLooping();

	if( !FireMode[Mode].IsInState('FireLoop') && (AmmoAmount(0) > 0) )
	{
		FireMode[Mode].StartFiring();
		return true;
	}
	else
	{
		return false;
	}

	return true;
}

simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

	if(!FireMode[0].IsInState('FireLoop'))
	{
        GetAnimParams(0, anim, frame, rate);

        if (ClientState == WS_ReadyToFire)
        {
             if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))
            {
                PlayIdle();
            }
        }
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (Role == ROLE_Authority)
	{
		if (Beam == None)
		{
			Beam = Spawn(class'LaserBeamEffect');
		}
	}
}

simulated function DetachFromPawn(Pawn P)
{
	TurnOffLaser();

	Super.DetachFromPawn(P);

	if (Beam != None)
	{
		Beam.Destroy();
	}
}

simulated function bool PutDown()
{
	if (Beam != None)
	{
		Beam.Destroy();
	}

	TurnOffLaser();

	return super.PutDown();
}

// Use alt fire to switch fire modes
simulated function AltFire(float F)
{
	if(ReadyToFire(0))
	{
		ToggleLaser();
	}
}

// Toggle the laser on and off
simulated function ToggleLaser()
{
	if( Instigator.IsLocallyControlled() )
	{
		if( Role < ROLE_Authority  )
		{
			ServerSetLaserActive(!bLaserActive);
		}

		bLaserActive = !bLaserActive;

		if( Beam != none )
		{
			Beam.SetActive(bLaserActive);
		}

		if( bLaserActive )
		{
			if ( LaserAttachment == none )
			{
				LaserAttachment = Spawn(LaserAttachmentClass,,,,);
				AttachToBone(LaserAttachment,'StandBase');
			}
			LaserAttachment.bHidden = false;

			if (Spot == None)
			{
				Spot = Spawn(class'LaserDot', self);
			}
		}
		else
		{
			LaserAttachment.bHidden = true;
			if (Spot != None)
			{
				Spot.Destroy();
			}
		}
	}
}

simulated function TurnOffLaser()
{
	if( Instigator.IsLocallyControlled() )
	{
		if( Role < ROLE_Authority  )
		{
			ServerSetLaserActive(false);
		}

		bLaserActive = false;
		LaserAttachment.bHidden = true;

		if( Beam != none )
		{
			Beam.SetActive(false);
		}

		if (Spot != None)
		{
			Spot.Destroy();
		}
	}
}

// Set the new fire mode on the server
function ServerSetLaserActive(bool bNewWaitForRelease)
{
	if( Beam != none )
	{
		Beam.SetActive(bNewWaitForRelease);
	}

	if( bNewWaitForRelease )
	{
		bLaserActive = true;
		if (Spot == None)
		{
			Spot = Spawn(class'LaserDot', self);
		}
	}
	else
	{
		bLaserActive = false;
		if (Spot != None)
		{
			Spot.Destroy();
		}
	}
}

simulated event RenderOverlays( Canvas Canvas )
{
	local int m;
	local Vector StartTrace, EndTrace;
	local Vector HitLocation, HitNormal;
	local Actor Other;
	local vector X,Y,Z;
	local coords C;

	if (Instigator == None)
		return;

	if ( Instigator.Controller != None )
		Hand = Instigator.Controller.Handedness;

	if ((Hand < -1.0) || (Hand > 1.0))
		return;

	// draw muzzleflashes/smoke for all fire modes so idle state won't
	// cause emitters to just disappear
	for (m = 0; m < NUM_FIRE_MODES; m++)
	{
		if (FireMode[m] != None)
		{
			FireMode[m].DrawMuzzleFlash(Canvas);
		}
	}

	SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );
	SetRotation( Instigator.GetViewRotation() + ZoomRotInterp);

	// Handle drawing the laser beam dot
	if (Spot != None)
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		GetViewAxes(X, Y, Z);

		if( bIsReloading && Instigator.IsLocallyControlled() )
		{
			C = GetBoneCoords('StandBase');
			X = C.XAxis;
			Y = C.YAxis;
			Z = C.ZAxis;
		}

		EndTrace = StartTrace + 65535 * X;

		Other = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true);

		if (Other != None && Other != Instigator && Other.Base != Instigator )
		{
			EndBeamEffect = HitLocation;
		}
		else
		{
			EndBeamEffect = EndTrace;
		}

		Spot.SetLocation(EndBeamEffect - X*SpotProjectorPullback);

		if(  Pawn(Other) != none )
		{
			Spot.SetRotation(Rotator(X));
			Spot.SetDrawScale(Spot.default.DrawScale * 0.5);
		}
		else if( HitNormal == vect(0,0,0) )
		{
			Spot.SetRotation(Rotator(-X));
			Spot.SetDrawScale(Spot.default.DrawScale);
		}
		else
		{
			Spot.SetRotation(Rotator(-HitNormal));
			Spot.SetDrawScale(Spot.default.DrawScale);
		}
	}

	//PreDrawFPWeapon();	// Laurent -- Hook to override things before render (like rotation if using a staticmesh)

	bDrawingFirstPerson = true;
	Canvas.DrawActor(self, false, false, DisplayFOV);
	bDrawingFirstPerson = false;
}

exec function SwitchModes()
{
	DoToggle();
}

defaultproperties
{
     BarrelSpinSound=Sound'XMV850S.XMV-BarrelSpinLoop'
     BarrelStopSound=Sound'XMV850S.XMV-BarrelSpinEnd'
     BarrelStartSound=Sound'XMV850S.XMV-BarrelSpinStart'
     LaserAttachmentClass=Class'KFMod.LaserAttachmentFirstPerson'
     MagCapacity=100
     ReloadRate=4.650000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload"
     Weight=9.000000
     IdleAimAnim="Idle"
     StandardDisplayFOV=55.000000
     bModeZeroCanDryFire=True
     SleeveNum=7
     TraderInfoTexture=Texture'XMV850_T.Special.Trader_XMV850'
     MeshRef="XMV850_A.XMV-850Minigun"
     SkinRefs(0)="XMV850_T.Special.XMV850_Main"
     SkinRefs(1)="XMV850_T.Special.Hands-Shiny"
     SkinRefs(2)="XMV850_T.Special.XMV850_Barrels_SD"
     SelectSoundRef="XMV850_Snd.XMV-PullOut"
     HudImageRef="XMV850_T.Special.XMV_unselected"
     SelectedHudImageRef="XMV850_T.Special.XMV"
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=20.000000
     FireModeClass(0)=Class'BMTCustomMut.XMV850Fire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="Putaway"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="Shut up and kill'em."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=55.000000
     Priority=232
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=4
     GroupOffset=7
     PickupClass=Class'BMTCustomMut.XMV850Pickup'
     PlayerViewOffset=(X=30.000000,Y=25.000000,Z=-16.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.XMV850Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="XMV 850"
     TransientSoundVolume=1.250000
}
