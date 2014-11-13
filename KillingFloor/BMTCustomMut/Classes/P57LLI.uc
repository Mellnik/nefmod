class P57LLI extends KFWeapon
	config(user);

#exec OBJ LOAD FILE="FivesevenLLI_A.ukx"

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

defaultproperties
{
     MagCapacity=20
     ReloadRate=2.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Single9mm"
     HudImage=Texture'FivesevenLLI_A.FivesevenLLI_T.FivesevenLLI_Unselected'
     SelectedHudImage=Texture'FivesevenLLI_A.FivesevenLLI_T.FivesevenLLI_selected'
     Weight=2.000000
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'FivesevenLLI_A.FivesevenLLI_T.FivesevenLLI_Trader'
     bIsTier2Weapon=True
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=32.000000
     FireModeClass(0)=Class'BMTCustomMut.P57LLIFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectAnimRate=1.000000
     SelectSound=Sound'FivesevenLLI_A.FivesevenLLI_Snd.FivesevenLLI_select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="The FN Five-seven, trademarked as the Five-seveN, is a semi-automatic pistol designed and manufactured by FN Herstal in Belgium."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=0.000000
     Priority=80
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=2
     GroupOffset=7
     PickupClass=Class'BMTCustomMut.P57LLIPickup'
     PlayerViewOffset=(X=25.500000,Y=19.000000,Z=-6.000000)
     BobDamping=5.000000
     AttachmentClass=Class'BMTCustomMut.P57LLIAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="FN Five-seveN"
     Mesh=SkeletalMesh'FivesevenLLI_A.fivesevenLLI_mesh'
     Skins(0)=Combiner'FivesevenLLI_A.FivesevenLLI_T.Fiveseven_tex_1_cmb'
     Skins(1)=Texture'KF_Weapons3_Trip_T.hands.Priest_Hands_1st_P'
     Skins(2)=Shader'FivesevenLLI_A.FivesevenLLI_T.Fiveseven_tex_2_shdr'
     Skins(3)=Shader'FivesevenLLI_A.FivesevenLLI_T.Fiveseven_tex_3_shdr'
     TransientSoundVolume=1.250000
}
