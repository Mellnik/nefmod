class WTFEquipMachinePistol extends Single;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.InventoryType == Class )
	{
		if ( KFHumanPawn(Owner) != none && !KFHumanPawn(Owner).CanCarry(Class'WTFEquipMachineDualies'.Default.Weight) )
		{
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'KFMainMessages', 2);
			return true;
		}

		return false; // Allow to "pickup" so this weapon can be replaced with dualies.
	}
	Return Super(KFWeapon).HandlePickupQuery(Item);
}

simulated function bool PutDown()
{
	if (  Instigator.PendingWeapon != none && Instigator.PendingWeapon.class == class'WTFEquipMachineDualies' )
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
     MagCapacity=16
     bKFNeverThrow=False
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipMachinePistolFire'
     Description="A deadly weapon"
     PickupClass=Class'BMTCustomMut.WTFEquipMachinePistolPickup'
     ItemName="Machine Pistol"
}
