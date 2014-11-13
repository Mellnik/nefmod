class DeagleExt extends MK23Pistol;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.InventoryType == Class )
	{
		if ( KFHumanPawn(Owner) != none && !KFHumanPawn(Owner).CanCarry(class'BMTCustomMut.DualDeagleExt'.Default.Weight) )
		{
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'KFMainMessages', 2);
			return true;
		}

		if ( KFPlayerController(Instigator.Controller) != none )
		{
			KFPlayerController(Instigator.Controller).PendingAmmo = WeaponPickup(Item).AmmoAmount[0];
		}

		return false; // Allow to "pickup" so this weapon can be replaced with dual MK23.
	}

	return Super.HandlePickupQuery(Item);
}

function float GetAIRating()
{
	local Bot B;


	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	return (AIRating + 0.0003 * FClamp(1500 - VSize(B.Enemy.Location - Instigator.Location),0,1000));
}

function byte BestMode()
{
    return 0;
}

simulated function bool PutDown()
{
	if ( Instigator.PendingWeapon.class == class'BMTCustomMut.DualDeagleExt' )
	{
		bIsReloading = false;
	}

	return super(KFWeapon).PutDown();
}

simulated function SuperMaxOutAmmo()
{
	if ( bNoAmmoInstances )
	{
		if ( AmmoClass[0] != None )
			AmmoCharge[0] = 100000;
		if ( (AmmoClass[1] != None) && (AmmoClass[0] != AmmoClass[1]) )
			AmmoCharge[1] = 100000;
		return;
	}
	if ( Ammo[0] != None )
		Ammo[0].AmmoAmount = 100000;
	if ( Ammo[1] != None )
		Ammo[1].AmmoAmount = 100000;
}

defaultproperties
{
     MagCapacity=8
     ReloadRate=2.200000
     HudImage=Texture'KillingFloorHUD.WeaponSelect.handcannon_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.handcannon'
     Weight=4.000000
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Handcannon'
     FireModeClass(0)=Class'BMTCustomMut.DeagleFireExt'
     SelectSound=Sound'KF_HandcannonSnd.50AE_Select'
     Description=".50 calibre action express handgun. This is about as big and nasty as personal weapons are going to get. But with a 7 round magazine, it should be used conservatively.  "
     Priority=100
     GroupOffset=3
     PickupClass=Class'BMTCustomMut.DeaglePickupExt'
     PlayerViewOffset=(X=5.000000,Y=20.000000,Z=-10.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.DeagleAttachmentExt'
     ItemName="Handcannon"
     Mesh=SkeletalMesh'KF_Weapons_Trip.Handcannon_Trip'
     Skins(0)=Combiner'KF_Weapons_Trip_T.Pistols.deagle_cmb'
}
