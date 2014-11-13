class WTFEquipFlaregun extends M79GrenadeLauncher;

#exec OBJ LOAD FILE=WTFTex.utx

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
     Weight=1.000000
     SkinRefs(0)="WTFTex.Flaregun.Flaregun"
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipFlaregunFire'
     Description="A deadly weapon"
     Priority=5
     InventoryGroup=5
     GroupOffset=3
     PickupClass=Class'BMTCustomMut.WTFEquipFlaregunPickup'
     AttachmentClass=Class'BMTCustomMut.WTFEquipFlaregunAttachment'
     ItemName="Flaregun"
}
