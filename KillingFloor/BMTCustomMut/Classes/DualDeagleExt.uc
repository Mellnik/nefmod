class DualDeagleExt extends Dualies;

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
	if ( Item.InventoryType==Class'DeagleExt' )
	{
		if( LastHasGunMsgTime<Level.TimeSeconds && PlayerController(Instigator.Controller)!=none )
		{
			LastHasGunMsgTime = Level.TimeSeconds+0.5;
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'KFMainMessages',1);
		}
		return True;
	}
	return Super.HandlePickupQuery(Item);
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
		DualDeagleAttachment(altThirdPersonActor).bIsOffHand = true;
	if(altThirdPersonActor != None && ThirdPersonActor != None)
	{
		DualDeagleAttachment(altThirdPersonActor).brother = DualDeagleAttachment(ThirdPersonActor);
		DualDeagleAttachment(ThirdPersonActor).brother = DualDeagleAttachment(altThirdPersonActor);
		altThirdPersonActor.LinkMesh(DualDeagleAttachmentExt(ThirdPersonActor).BrotherMesh);
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
		if( DeagleExt(I) != none )
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

			MagAmmoRemaining = DeagleExt(I).MagAmmoRemaining;

			I.Destroyed();
			I.Destroy();

			Break;
		}
	}
	if ( KFWeaponPickup(Pickup) != None && Pickup.bDropped )
	{
		MagAmmoRemaining = Clamp(MagAmmoRemaining + KFWeaponPickup(Pickup).MagAmmoRemaining, 0, MagCapacity);
	}
	else
	{
		MagAmmoRemaining = Clamp(MagAmmoRemaining + Class'DeagleExt'.Default.MagCapacity, 0, MagCapacity);
	}

	Super(Weapon).GiveTo(Other, Pickup);

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

	if( Instigator.Health > 0 )
	{
		OtherAmmo = AmmoThrown / 2;
		AmmoThrown -= OtherAmmo;
		I = Spawn(Class'DeagleExt');
		I.GiveTo(Instigator);
		Weapon(I).Ammo[0].AmmoAmount = OtherAmmo;
		DeagleExt(I).MagAmmoRemaining = MagAmmoRemaining / 2;
		MagAmmoRemaining = Max(MagAmmoRemaining-DeagleExt(I).MagAmmoRemaining,0);
	}
	Pickup = Spawn(Class'DeaglePickupExt',,, StartLocation);
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
	if ( Instigator.PendingWeapon.class == class'DeagleExt' )
	{
		bIsReloading = false;
	}

	return super.PutDown();
}

defaultproperties
{
     altFlashBoneName="tip01"
     MagCapacity=16
     FlashBoneName="tip"
     HudImage=Texture'KillingFloorHUD.WeaponSelect.dual_handcannon_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.dual_handcannon'
     bTorchEnabled=False
     StandardDisplayFOV=60.000000
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Dual_Handcannons'
     bIsTier2Weapon=True
     ZoomedDisplayFOV=50.000000
     FireModeClass(0)=Class'BMTCustomMut.DualDeagleFireExt'
     FireModeClass(1)=Class'KFMod.NoFire'
     SelectSound=Sound'KF_HandcannonSnd.50AE_Select'
     AIRating=0.450000
     CurrentRating=0.450000
     Description="Dual .50 calibre action express handgun. Dual 50's is double the fun."
     DisplayFOV=60.000000
     Priority=125
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.DualDeaglePickupExt'
     PlayerViewOffset=(X=25.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.DualDeagleAttachmentExt'
     IconCoords=(X1=250,Y1=110,X2=330,Y2=145)
     ItemName="Dual Handcannons"
     Mesh=SkeletalMesh'KF_Weapons_Trip.Dual50_Trip'
     DrawScale=1.000000
     Skins(0)=Combiner'KF_Weapons_Trip_T.Pistols.deagle_cmb'
}
