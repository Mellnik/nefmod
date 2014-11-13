class Glock18 extends KFWeapon;

function byte BestMode()
{
	return 0;
}

simulated function Notify_ShowBullets()
{
	local int AvailableAmmo;
	
	AvailableAmmo = AmmoAmount(0);

	if (AvailableAmmo == 0)
	{
		SetBoneScale (0, 0.0, 'bullet1');
		SetBoneScale (1, 0.0, 'bullet2');
		SetBoneScale (2, 0.0, 'bullet3');
	}
	else if (AvailableAmmo == 1)
	{
		SetBoneScale (0, 0.0, 'bullet1');
		SetBoneScale (1, 0.0, 'bullet2');
		SetBoneScale (2, 1.0, 'bullet3');
	}
	else if (AvailableAmmo == 2)
	{
		SetBoneScale (0, 0.0, 'bullet1');
		SetBoneScale (1, 1.0, 'bullet2');
		SetBoneScale (2, 1.0, 'bullet3');
	}	
	else
	{
		SetBoneScale (0, 1.0, 'bullet1');
		SetBoneScale (1, 1.0, 'bullet2');
		SetBoneScale (2, 1.0, 'bullet3');
	}
}

simulated function Notify_HideBullets()
{
	if (MagAmmoRemaining <= 0)
	{
		SetBoneScale (2, 0.0, 'bullet3');
	}
	if (MagAmmoRemaining <= 1)
	{
		SetBoneScale (1, 0.0, 'bullet2');
	}
	if (MagAmmoRemaining <= 2)
	{
		SetBoneScale (0, 0.0, 'bullet1');
	}
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
     MagCapacity=17
     ReloadRate=2.300000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Single9mm"
     HudImage=Texture'Glock18cLLI_A.Glock18cLLI_T.GlockLLI18c_Unselected'
     SelectedHudImage=Texture'Glock18cLLI_A.Glock18cLLI_T.GlockLLI18c_selected'
     Weight=0.000000
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     AimInSound=Sound'KF_HandcannonSnd.50AE_Aim'
     AimOutSound=Sound'KF_HandcannonSnd.50AE_Aim'
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'Glock18cLLI_A.Glock18cLLI_T.GlockLLI18c_Trader'
     ZoomedDisplayFOV=50.000000
     FireModeClass(0)=Class'BMTCustomMut.Glock18Fire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'Glock18cLLI_A.Glock18cLLI_Snd.Glock18cLLI_select'
     AIRating=0.450000
     CurrentRating=0.450000
     bShowChargingBar=True
     Description="Austrian auto production Glock18. Designed to arm the special units of the army and police."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=70.000000
     Priority=90
     InventoryGroup=2
     GroupOffset=3
     PickupClass=Class'BMTCustomMut.Glock18Pickup'
     PlayerViewOffset=(X=23.000000,Y=25.000000,Z=-9.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.Glock18Attachment'
     IconCoords=(X1=250,Y1=110,X2=330,Y2=145)
     ItemName="Glock18"
     bUseDynamicLights=True
     Mesh=SkeletalMesh'Glock18cLLI_A.Glock18cLLI_mesh'
     Skins(0)=Combiner'Glock18cLLI_A.Glock18cLLI_T.Glock18cLLI_tex_cmb'
     Skins(1)=Texture'KF_Weapons3_Trip_T.hands.Priest_Hands_1st_P'
     TransientSoundVolume=1.000000
}
