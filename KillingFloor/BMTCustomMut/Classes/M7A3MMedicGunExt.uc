class M7A3MMedicGunExt extends M7A3MMedicGun;

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
     Weight=3.000000
     FireModeClass(0)=Class'BMTCustomMut.M7A3MFireExt'
     FireModeClass(1)=Class'BMTCustomMut.M7A3MAltFireExt'
     PickupClass=Class'BMTCustomMut.M7A3MPickupExt'
     AttachmentClass=Class'BMTCustomMut.M7A3MAttachmentExt'
}
