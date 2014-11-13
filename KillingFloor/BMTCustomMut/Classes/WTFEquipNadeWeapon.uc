class WTFEquipNadeWeapon extends Frag;

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
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipNadeFire'
     Description="A deadly weapon"
     PickupClass=Class'BMTCustomMut.WTFEquipNadePickup'
     ItemName="Grenade"
}
