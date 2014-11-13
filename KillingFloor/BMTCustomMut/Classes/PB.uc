//=============================================================================
// PB Inventory class
//=============================================================================
class PB extends KFWeapon;

#exec OBJ LOAD FILE=..\sounds\pb_S.uax
#exec OBJ LOAD FILE=..\Textures\pb_T.utx

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
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Single9mm"
     HudImage=Texture'pb_T.PB_unselected'
     SelectedHudImage=Texture'pb_T.PB'
     Weight=4.000000
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=60.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'pb_T.Trader_PB'
     bIsTier2Weapon=True
     ZoomedDisplayFOV=50.000000
     FireModeClass(0)=Class'BMTCustomMut.PBFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'pb_S.pb_draw'
     AIRating=0.450000
     CurrentRating=0.450000
     bShowChargingBar=True
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=65.000000
     Priority=100
     InventoryGroup=2
     GroupOffset=3
     PickupClass=Class'BMTCustomMut.PBPickup'
     PlayerViewOffset=(X=30.000000,Y=20.000000,Z=-10.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.PBAttachment'
     IconCoords=(X1=250,Y1=110,X2=330,Y2=145)
     ItemName="PB"
     bUseDynamicLights=True
     Mesh=SkeletalMesh'PbpistolDT_A.Pb_Pistol'
     Skins(0)=Combiner'pb_T.pb_cmb'
     Skins(1)=Combiner'KF_Weapons_Trip_T.hands.hands_1stP_military_cmb'
     TransientSoundVolume=1.000000
}
