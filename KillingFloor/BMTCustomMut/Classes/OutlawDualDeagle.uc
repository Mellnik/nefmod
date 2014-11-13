//=============================================================================
// Dual 50 Cal Inventory class
//=============================================================================
class OutlawDualDeagle extends Dualies;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.InventoryType==Class'OutlawDeagle' )
	{
		if( LastHasGunMsgTime < Level.TimeSeconds && PlayerController(Instigator.Controller) != none )
		{
			LastHasGunMsgTime = Level.TimeSeconds + 0.5;
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'KFMainMessages', 1);
		}
	
		return True;
	}
	
	return Super.HandlePickupQuery(Item);
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
		altThirdPersonActor.LinkMesh(DualDeagleAttachment(ThirdPersonActor).BrotherMesh);
	}
}

function GiveTo( pawn Other, optional Pickup Pickup )
{
	local Inventory I;
	local int OldAmmo;
	local bool bNoPickup;

	MagAmmoRemaining = 0;
	
	For( I = Other.Inventory; I != None; I =I.Inventory )
	{
		if ( Deagle(I) != none )
		{
			if( WeaponPickup(Pickup) != none )
			{
				OldAmmo = WeaponPickup(Pickup).AmmoAmount[0];
			}
			else
			{
				OldAmmo = Weapon(I).AmmoAmount(0);
				bNoPickup = true;
			}
			
			MagAmmoRemaining = Deagle(I).MagAmmoRemaining;
			
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
		MagAmmoRemaining = Clamp(MagAmmoRemaining + Class'OutlawDeagle'.Default.MagCapacity, 0, MagCapacity);
	}
	
	Super(Weapon).GiveTo(Other, Pickup);
	
	if ( bNoPickup )
	{
		AddAmmo(OldAmmo, 0);
		Clamp(Ammo[0].AmmoAmount, 0, MaxAmmo(0));
	}
	else
	{
		if ( KFPlayerController(Instigator.Controller) != none && KFPlayerController(Instigator.Controller).PendingAmmo > 0 )
		{
			AddAmmo(KFPlayerController(Instigator.Controller).PendingAmmo, 0);
			KFPlayerController(Instigator.Controller).PendingAmmo = 0;			
		} 
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
		I = Spawn(Class'OutlawDeagle');
		I.GiveTo(Instigator);
		Weapon(I).Ammo[0].AmmoAmount = OtherAmmo;
		Deagle(I).MagAmmoRemaining = MagAmmoRemaining/2;
		MagAmmoRemaining = Max(MagAmmoRemaining-Deagle(I).MagAmmoRemaining,0);
	}

	Pickup = Spawn(Class'OutlawDeaglePickup',,, StartLocation);
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
	if ( Instigator.PendingWeapon.class == class'OutlawDeagle' )
	{
		bIsReloading = false;
	}

	return super.PutDown();
}

simulated function SuperMaxOutAmmo()
{
	if ( bNoAmmoInstances )
	{
		if ( AmmoClass[0] != None )
			AmmoCharge[0] = 10000;
		if ( (AmmoClass[1] != None) && (AmmoClass[0] != AmmoClass[1]) )
			AmmoCharge[1] = 10000;
		return;
	}
	if ( Ammo[0] != None )
		Ammo[0].AmmoAmount = 10000;
	if ( Ammo[1] != None )
		Ammo[1].AmmoAmount = 10000;
}

defaultproperties
{
     altFlashBoneName="tip01"
     MagCapacity=18
     FlashBoneName="tip"
     HudImage=Texture'KillingFloorHUD.WeaponSelect.dual_handcannon_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.dual_handcannon'
     bTorchEnabled=False
     AimInSound=Sound'KF_HandcannonSnd.50AE_Aim'
     AimOutSound=Sound'KF_HandcannonSnd.50AE_Aim'
     StandardDisplayFOV=60.000000
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Dual_Handcannons'
     ZoomedDisplayFOV=50.000000
     FireModeClass(0)=Class'BMTCustomMut.OutlawDualDeagleFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     SelectSound=Sound'KF_HandcannonSnd.50AE_Select'
     AIRating=0.450000
     CurrentRating=0.450000
     Description="Dual .50 calibre action express handgun. Dual 50's is double the fun."
     DisplayFOV=60.000000
     Priority=6
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.OutlawDualDeaglePickup'
     PlayerViewOffset=(X=25.000000)
     BobDamping=6.000000
     AttachmentClass=Class'KFMod.DualDeagleAttachment'
     IconCoords=(X1=250,Y1=110,X2=330,Y2=145)
     ItemName="Dual Outlaw Deagles"
     Mesh=SkeletalMesh'KF_Weapons_Trip.Dual50_Trip'
     DrawScale=1.000000
     Skins(0)=Combiner'KF_Weapons_Trip_T.Pistols.deagle_cmb'
}
