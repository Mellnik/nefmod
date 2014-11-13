class WTFEquipGlowstick extends M79GrenadeLauncher;

#exec OBJ LOAD FILE=WTFTex2.utx

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
     ReloadAnim="Select"
     FlashBoneName="Hands_R_wrist"
     WeaponReloadAnim="Select"
     Weight=0.000000
     bHasAimingMode=False
     IdleAimAnim="Idle"
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipGlowstickFire'
     FireModeClass(1)=Class'BMTCustomMut.WTFEquipGlowstickAltFire'
     Description="A deadly weapon"
     Priority=4
     InventoryGroup=5
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.WTFEquipGlowstickPickup'
     PlayerViewOffset=(X=0.000000,Y=0.000000,Z=0.000000)
     AttachmentClass=Class'BMTCustomMut.WTFEquipGlowstickAttachment'
     ItemName="Glowstick"
     Mesh=SkeletalMesh'KF_Weapons_Trip.Pipe_Trip'
     Skins(0)=Texture'WTFTex2.Glowstick.Glowstick'
}
