class MP7MMedicGunExt extends MP7MMedicGun;

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
     MagCapacity=25
     FireModeClass(0)=Class'BMTCustomMut.MP7MFireExt'
     FireModeClass(1)=Class'BMTCustomMut.MP7MAltFireExt'
     PickupClass=Class'BMTCustomMut.MP7MPickupExt'
     ItemName="MP7M2 Medic Gun"
}
