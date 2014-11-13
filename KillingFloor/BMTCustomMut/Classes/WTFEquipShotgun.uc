class WTFEquipShotgun extends KFWeaponShotgun;

function bool AllowReload()
{
	local KFPlayerReplicationInfo KFPRI;
	local WTFEquipShotgunFire FM0;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI == none || !(KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSupportSpec' || KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksCommando') )
		return super(KFWeapon).AllowReload();
			
	if (bIsReloading) //doubletap reload to switch shell types anytime you can reload
	{
		FM0 = WTFEquipShotgunFire(FireMode[0]);
		
		if ( FM0.GetShellType() == 1 )
		{
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(class'BMTCustomMut.WTFEquipBoomstickSwitchMessage',0); //loading slugs
			FM0.SetShellType(0);
		}
		else
		{
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(class'BMTCustomMut.WTFEquipBoomstickSwitchMessage',1); //loading shot
			FM0.SetShellType(1);
		}
		return false;
	}
	
	return super(KFWeapon).AllowReload();
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
     FirstPersonFlashlightOffset=(X=-25.000000,Y=-18.000000,Z=8.000000)
     ForceZoomOutOnFireTime=0.010000
     MagCapacity=8
     ReloadRate=0.666667
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Shotgun"
     HudImage=Texture'KillingFloorHUD.WeaponSelect.combat_shotgun_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.combat_shotgun'
     Weight=8.000000
     bTorchEnabled=True
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Combat_Shotgun'
     PlayerIronSightFOV=70.000000
     ZoomedDisplayFOV=40.000000
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipShotgunFire'
     FireModeClass(1)=Class'KFMod.ShotgunLightFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KF_PumpSGSnd.SG_Select'
     AIRating=0.600000
     CurrentRating=0.600000
     bShowChargingBar=True
     Description="A rugged tactical pump action shotgun common to police divisions the world over. It accepts a maximum of 8 shells and can fire in rapid succession. "
     DisplayFOV=65.000000
     Priority=135
     InventoryGroup=3
     GroupOffset=2
     PickupClass=Class'BMTCustomMut.WTFEquipShotgunPickup'
     PlayerViewOffset=(X=20.000000,Y=18.750000,Z=-7.500000)
     BobDamping=7.000000
     AttachmentClass=Class'BMTCustomMut.WTFEquipShotgunAttachment'
     IconCoords=(X1=169,Y1=172,X2=245,Y2=208)
     ItemName="Shotgun profession"
     Mesh=SkeletalMesh'KF_Weapons_Trip.Shotgun_Trip'
     Skins(0)=Combiner'KF_Weapons_Trip_T.Shotguns.shotgun_cmb'
     TransientSoundVolume=1.000000
}
