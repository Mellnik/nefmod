class Tech_MachineDualies extends KFWeapon;

#exec obj load file="SentryTechTex1.utx"


var KFPlayerReplicationInfo KFPRI;
var bool LastZTState; //LastZedTimeState

var name altFlashBoneName;
var name altTPAnim;
var Actor altThirdPersonActor;
var name altWeaponAttach;

/**
 * Handles all the functionality for zooming in including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomIn(bool bAnimateTransition)
{
    super.ZoomIn(bAnimateTransition);

    if( bAnimateTransition )
    {
        if( bZoomOutInterrupted )
        {
            PlayAnim('GOTO_Iron',1.0,0.1);
        }
        else
        {
            PlayAnim('GOTO_Iron',1.0,0.1);
        }
    }
}

/**
 * Handles all the functionality for zooming out including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomOut(bool bAnimateTransition)
{
    local float AnimLength, AnimSpeed;
    super.ZoomOut(false);

    if( bAnimateTransition )
    {
        AnimLength = GetAnimDuration('GOTO_Hip', 1.0);

        if( ZoomTime > 0 && AnimLength > 0 )
        {
            AnimSpeed = AnimLength/ZoomTime;
        }
        else
        {
            AnimSpeed = 1.0;
        }
        PlayAnim('GOTO_Hip',AnimSpeed,0.1);
    }
}


function bool HandlePickupQuery( pickup Item )
{
	if ( Item.InventoryType==Class'MachinePistol' )
	{
		if( LastHasGunMsgTime<Level.TimeSeconds && PlayerController(Instigator.Controller)!=none )
		{
			LastHasGunMsgTime = Level.TimeSeconds+0.5;
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'KFMainMessages',1);
		}
		return True;
	}
	Return Super.HandlePickupQuery(Item);
}

function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;
	return (AIRating + 0.00092 * FMin(800 - VSize(B.Enemy.Location - Instigator.Location),650));
}

function byte BestMode()
{
    return 0;
}

function bool RecommendRangedAttack()
{
	return true;
}

function float SuggestAttackStyle()
{
    return -0.7;
}

function AttachToPawn(Pawn P)
{
	local name BoneName;

	Super.AttachToPawn(P);

	if(altThirdPersonActor == None)
	{
		altThirdPersonActor = Spawn(AttachmentClass,Owner);
		InventoryAttachment(altThirdPersonActor).InitFor(self);
	}
	else altThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
	BoneName = P.GetOffhandBoneFor(self);
	if(BoneName == '')
	{
		altThirdPersonActor.SetLocation(P.Location);
		altThirdPersonActor.SetBase(P);
	}
	else P.AttachToBone(altThirdPersonActor,BoneName);

	if(altThirdPersonActor != None)
		Tech_MachineDualiesAttachment(altThirdPersonActor).bIsOffHand = true;
	if(altThirdPersonActor != None && ThirdPersonActor != None)
	{
		Tech_MachineDualiesAttachment(altThirdPersonActor).brother = Tech_MachineDualiesAttachment(ThirdPersonActor);
		Tech_MachineDualiesAttachment(ThirdPersonActor).brother = Tech_MachineDualiesAttachment(altThirdPersonActor);
		altThirdPersonActor.LinkMesh(Tech_MachineDualiesAttachment(ThirdPersonActor).BrotherMesh);
	}
}

simulated function DetachFromPawn(Pawn P)
{
	Super.DetachFromPawn(P);
	if ( altThirdPersonActor != None )
	{
		altThirdPersonActor.Destroy();
		altThirdPersonActor = None;
	}
}

simulated function Destroyed()
{
	Super.Destroyed();

	if( ThirdPersonActor!=None )
		ThirdPersonActor.Destroy();
	if( altThirdPersonActor!=None )
		altThirdPersonActor.Destroy();
}

//simulated function Vector GetTipLocation()
//{
//    local Coords C;
//    C = GetBoneCoords('tip');
//    return C.Origin;
//}

simulated function vector GetEffectStart()
{
    local Vector RightFlashLoc,LeftFlashLoc;

    RightFlashLoc = GetBoneCoords(default.FlashBoneName).Origin;
    LeftFlashLoc = GetBoneCoords(default.altFlashBoneName).Origin;

    // jjs - this function should actually never be called in third person views
    // any effect that needs a 3rdp weapon offset should figure it out itself

    // 1st person
    if (Instigator.IsFirstPerson())
    {
        if ( WeaponCentered() )
            return CenteredEffectStart();

        if( bAimingRifle )
        {
            if( KFFire(GetFireMode(0)).FireAimedAnim != 'FireLeft_Iron' )
            {
                return RightFlashLoc;
            }
            else // Off hand firing.  Moves tracer to the left.
            {
                return LeftFlashLoc;
            }
    	}
    	else
    	{
            if (GetFireMode(0).FireAnim != 'FireLeft')
            {
                return RightFlashLoc;
            }
            else // Off hand firing.  Moves tracer to the left.
            {
                return LeftFlashLoc;
            }
    	}
    }
    // 3rd person
    else
    {
        return (Instigator.Location +
            Instigator.EyeHeight*Vect(0,0,0.5) +
            Vector(Instigator.Rotation) * 40.0);
    }
}
function GiveTo( pawn Other, optional Pickup Pickup )
{
	local Inventory I;
	local int OldAmmo;
	local bool bNoPickup;

	MagAmmoRemaining = 0;
	For( I=Other.Inventory; I!=None; I=I.Inventory )
	{
		if( MachinePistol(I)!=None )
		{
			if( WeaponPickup(Pickup)!= none )
			{
				WeaponPickup(Pickup).AmmoAmount[0]+=Weapon(I).AmmoAmount(0);
			}
			else
			{
				OldAmmo = Weapon(I).AmmoAmount(0);
				bNoPickup = true;
			}

			MagAmmoRemaining = MachinePistol(I).MagAmmoRemaining;

			I.Destroyed();
			I.Destroy();

			Break;
		}
	}
	if( KFWeaponPickup(Pickup)!=None && Pickup.bDropped )
		MagAmmoRemaining = Clamp(MagAmmoRemaining+KFWeaponPickup(Pickup).MagAmmoRemaining,0,MagCapacity);
	else MagAmmoRemaining = Clamp(MagAmmoRemaining+Class'MachinePistol'.Default.MagCapacity,0,MagCapacity);
	Super(Weapon).GiveTo(Other,Pickup);

	if ( bNoPickup )
	{
		AddAmmo(OldAmmo, 0);
		Clamp(Ammo[0].AmmoAmount, 0, MaxAmmo(0));
	}
}
function DropFrom(vector StartLocation)
{
	local int m;
	local Pickup Pickup;
	local Inventory I;
	local int AmmoThrown,OtherAmmo;

	if( !bCanThrow )
		return;

	AmmoThrown = AmmoAmount(0);
	ClientWeaponThrown();

	for (m = 0; m < NUM_FIRE_MODES; m++)
	{
		if (FireMode[m].bIsFiring)
			StopFire(m);
	}

	if ( Instigator != None )
		DetachFromPawn(Instigator);

	if( Instigator.Health>0 )
	{
		OtherAmmo = AmmoThrown/2;
		AmmoThrown-=OtherAmmo;
		I = Spawn(Class'MachinePistol');
		I.GiveTo(Instigator);
		Weapon(I).Ammo[0].AmmoAmount = OtherAmmo;
		MachinePistol(I).MagAmmoRemaining = MagAmmoRemaining/2;
		MagAmmoRemaining = Max(MagAmmoRemaining-MachinePistol(I).MagAmmoRemaining,0);
	}
	Pickup = Spawn(PickupClass,,, StartLocation);
	if ( Pickup != None )
	{
		Pickup.InitDroppedPickupFor(self);
		Pickup.Velocity = Velocity;
		WeaponPickup(Pickup).AmmoAmount[0] = AmmoThrown;
		if( KFWeaponPickup(Pickup)!=None )
			KFWeaponPickup(Pickup).MagAmmoRemaining = MagAmmoRemaining;
		if (Instigator.Health > 0)
			WeaponPickup(Pickup).bThrown = true;
	}

    Destroyed();
	Destroy();
}

simulated function bool PutDown()
{
	if ( Instigator.PendingWeapon.class == class'MachinePistol' )
	{
		bIsReloading = false;
	}

	return super.PutDown();
}





/////////||\\\\\\\\
//Fast Zed Movement\\
/////////||\\\\\\\\

simulated function BringUp(optional Weapon PrevWeapon)
{
    local int Mode;
    local KFPlayerController Player;
    local KFPlayerReplicationInfo KFPRI;

    HandleSleeveSwapping();

    // Hint check
    Player = KFPlayerController(Instigator.Controller);
    KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
    
   

    if ( Player != none && ClientGrenadeState != GN_BringUp )
    {
        if ( class == class'Single' )
        {
            Player.CheckForHint(10);
        }
        else if ( class == class'Dualies' )
        {
            Player.CheckForHint(11);
        }
        else if ( class == class'Deagle' )
        {
            Player.CheckForHint(12);
        }
        else if ( class == class'Bullpup' )
        {
            Player.CheckForHint(13);
        }
        else if ( class == class'Shotgun' )
        {
            Player.CheckForHint(14);
        }
        else if ( class == class'Winchester' )
        {
            Player.CheckForHint(15);
        }
        else if ( class == class'Crossbow' )
        {
            Player.CheckForHint(16);
        }
        else if ( class == class'BoomStick' )
        {
            Player.CheckForHint(17);
            Player.WeaponPulloutRemark(21);
        }
        else if ( class == class'FlameThrower' )
        {
            Player.CheckForHint(18);
        }
        else if ( class == class'LAW' )
        {
            Player.CheckForHint(19);
            Player.WeaponPulloutRemark(23);
        }
        else if ( class == class'Knife' && bShowPullOutHint )
        {
            Player.CheckForHint(20);
        }
        else if ( class == class'Machete' )
        {
            Player.CheckForHint(21);
        }
        else if ( class == class'Axe' )
        {
            Player.CheckForHint(22);
            Player.WeaponPulloutRemark(24);
        }
        else if ( class == class'DualDeagle' )
        {
            Player.WeaponPulloutRemark(22);
        }

        bShowPullOutHint = true;
    }

    if ( KFHumanPawn(Instigator) != none )
        KFHumanPawn(Instigator).SetAiming(false);

    bAimingRifle = false;
    bIsReloading = false;
    IdleAnim = default.IdleAnim;
    //Super.BringUp(PrevWeapon);

    // From Weapon.uc
    if ( ClientState == WS_Hidden || ClientGrenadeState == GN_BringUp || KFPawn(Instigator).bIsQuickHealing > 0 )
    {
        PlayOwnedSound(SelectSound, SLOT_Interact,,,,, false);
        ClientPlayForceFeedback(SelectForce);  // jdf

        if ( Instigator.IsLocallyControlled() )
        {
            if ( (Mesh!=None) && HasAnim(SelectAnim) )
            {
                if( ClientGrenadeState == GN_BringUp || KFPawn(Instigator).bIsQuickHealing > 0 )
                {
                    PlayAnim(SelectAnim, SelectAnimRate * (BringUpTime/QuickBringUpTime), 0.0);
                }
                else
                {
                    PlayAnim(SelectAnim, SelectAnimRate, 0.0);
                }
            }
        }

        ClientState = WS_BringUp;
        if( ClientGrenadeState == GN_BringUp || KFPawn(Instigator).bIsQuickHealing > 0 )
        {
            ClientGrenadeState = GN_None;
            SetTimer(QuickBringUpTime, false);
        }
        else
        {
            SetTimer(BringUpTime, false);
        }
    }

    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
    {
        FireMode[Mode].bIsFiring = false;
        FireMode[Mode].HoldTime = 0.0;
        FireMode[Mode].bServerDelayStartFire = false;
        FireMode[Mode].bServerDelayStopFire = false;
        FireMode[Mode].bInstantStop = false;
    }

    if ( (PrevWeapon != None) && PrevWeapon.HasAmmo() && !PrevWeapon.bNoVoluntarySwitch )
        OldWeapon = PrevWeapon;
    else
        OldWeapon = None;
}

simulated function WeaponTick(float dt)
{
    Super.WeaponTick(dt);

    //if we're in the same state as the last time we checked, no need to do anything right now, exit
    
    if (KFGameType(Level.Game) == None)
        return;
    
    if (KFGameType(Level.Game).bZEDTimeActive == LastZTState)
        return;
    
    
    
    //record new state
    LastZTState = KFGameType(Level.Game).bZEDTimeActive;
        
    //set movement speed
    if (KFGameType(Level.Game).bZEDTimeActive)
    {
        //InventorySpeedModifier is a straight + to speed and it is unregulated outside of changing weapons!
        KFHumanPawn(Instigator).InventorySpeedModifier=500; //it is an INT
        Instigator.AccelRate=100000.0;
        KFHumanPawn(Instigator).ModifyVelocity(dt, Instigator.Velocity);
    }
    else
    {
        ResetMovement();
    }
}

function ResetMovement()
{
    local KFHumanPawn P;
    P = KFHumanPawn(Instigator);
    
    P.InventorySpeedModifier = ((P.default.GroundSpeed * P.BaseMeleeIncrease) - Weight * 2);
    P.AccelRate=P.Default.AccelRate;
    P.AirControl=P.Default.AirControl;
    P.AirSpeed=P.Default.AirSpeed;
    P.ModifyVelocity(Level.TimeSeconds, P.Velocity);
}

defaultproperties
{
     altFlashBoneName="Tip_Left"
     altTPAnim="DualiesAttackLeft"
     altWeaponAttach="Bone_weapon2"
     FirstPersonFlashlightOffset=(X=-15.000000,Z=5.000000)
     MagCapacity=32
     ReloadRate=3.500000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     FlashBoneName="Tip_Right"
     WeaponReloadAnim="Reload_Dual9mm"
     HudImage=Texture'KillingFloorHUD.WeaponSelect.dual_9mm_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.dual_9mm'
     Weight=3.000000
     bTorchEnabled=True
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Dual_9mm'
     ZoomInRotation=(Pitch=0,Roll=0)
     ZoomedDisplayFOV=65.000000
     FireModeClass(0)=Class'BMTCustomMut.Tech_MachineDualiesFire'
     FireModeClass(1)=Class'KFMod.SingleALTFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KFPlayerSound.getweaponout'
     AIRating=0.440000
     CurrentRating=0.440000
     bShowChargingBar=True
     Description="A deadly weapon"
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=70.000000
     Priority=65
     InventoryGroup=2
     GroupOffset=2
     PickupClass=Class'BMTCustomMut.Tech_MachineDualiesPickup'
     PlayerViewOffset=(X=20.000000,Z=-7.000000)
     BobDamping=7.000000
     AttachmentClass=Class'BMTCustomMut.Tech_MachineDualiesAttachment'
     IconCoords=(X1=229,Y1=258,X2=296,Y2=307)
     ItemName="2x Machine Pistols"
     Mesh=SkeletalMesh'KF_Weapons_Trip.Dual9mm'
     DrawScale=0.900000
     Skins(0)=Texture'SentryTechTex1.Weapon_MachinePistol.MachinePistol_D'
     TransientSoundVolume=1.000000
}
