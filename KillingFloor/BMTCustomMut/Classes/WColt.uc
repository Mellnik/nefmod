//==================================================
// Whisky's Colt Python
//==================================================
class WColt extends KFWeapon;

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
     FirstPersonFlashlightOffset=(X=-20.000000,Y=-22.000000,Z=8.000000)
     MagCapacity=6
     ReloadRate=7.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload"
     HudImage=Texture'WhiskyColt_T.WColt_Unselected'
     SelectedHudImage=Texture'WhiskyColt_T.WColt'
     Weight=4.000000
     bHasAimingMode=True
     IdleAimAnim="IronIdle"
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     SleeveNum=0
     TraderInfoTexture=Texture'WhiskyColt_T.Trader_WColt'
     ZoomedDisplayFOV=65.000000
     FireModeClass(0)=Class'BMTCustomMut.WColtFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KF_9MMSnd.9mm_Select'
     AIRating=0.250000
     CurrentRating=0.250000
     bShowChargingBar=True
     Description="A Colt Python .375"
     DisplayFOV=70.000000
     Priority=150
     InventoryGroup=2
     GroupOffset=1
     PickupClass=Class'BMTCustomMut.WColtPickup'
     PlayerViewOffset=(X=20.000000,Y=25.000000,Z=-10.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.WColtAttachment'
     IconCoords=(X1=434,Y1=253,X2=506,Y2=292)
     ItemName="Colt Python"
     Mesh=SkeletalMesh'W_Colt_Python_A.colt_weapon'
     Skins(1)=Texture'WhiskyColt_T.ColtV2_T'
}
