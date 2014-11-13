class WTFEquipSelfDestruct extends PipeBombExplosive;

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
     SkinRefs(0)="WTFTex.Selfdestruct.Selfdestruct"
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipSelfDestructFire'
     AmmoClass(0)=Class'BMTCustomMut.WTFEquipSelfDestructAmmo'
     Description="A deadly weapon"
     Priority=232
     InventoryGroup=1
     GroupOffset=0
     PickupClass=Class'BMTCustomMut.WTFEquipSelfDestructPickup'
     AttachmentClass=Class'BMTCustomMut.WTFEquipSelfDestructAttachment'
     ItemName="Self Destruct!"
}
