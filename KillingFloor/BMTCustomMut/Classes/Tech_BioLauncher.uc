class Tech_BioLauncher extends KFWeaponShotgun;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"

var texture ArmedSkin1;

static function PreloadAssets(Inventory Inv, optional bool bSkipRefCount)
{
	default.ArmedSkin1 = texture(DynamicLoadObject("SentryTechTex1.Weapon_Biolauncher.BioLauncher_Cmb", class'texture', true));

	super.PreloadAssets(Inv, bSkipRefCount);
}

static function bool UnloadAssets()
{
	if ( super.UnloadAssets() )
	{
		default.ArmedSkin1 = none;
		return true;
	}

	return false;
}

function float GetAIRating()
{
	local AIController B;

	B = AIController(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	return (AIRating + 0.0003 * FClamp(1500 - VSize(B.Enemy.Location - Instigator.Location),0,1000));
}

function byte BestMode()
{
	return 0;
}

function bool RecommendRangedAttack()
{
	return true;
}

//TODO: LONG ranged?
function bool RecommendLongRangedAttack()
{
	return true;
}

function float SuggestAttackStyle()
{
	return -1.0;
}

defaultproperties
{
     MagCapacity=6
     ReloadRate=1.234000
     ReloadAnim="Reload"
     ReloadAnimRate=1.200000
     WeaponReloadAnim="Reload_M32_MGL"
     Weight=6.000000
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     SleeveNum=2
     MeshRef="KF_Weapons2_Trip.M32_MGL_Trip"
     SkinRefs(0)="SentryTechTex1.Weapon_Biolauncher.BioLauncher_Cmb"
     SelectSoundRef="SentryTechSounds.Weapon_BioLauncher.BioLauncher_Select"
     PlayerIronSightFOV=70.000000
     ZoomedDisplayFOV=40.000000
     FireModeClass(0)=Class'BMTCustomMut.Tech_BioLauncherFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.650000
     CurrentRating=0.650000
     Description="An Advanced Semi Automatic Bio Launcher."
     DisplayFOV=65.000000
     Priority=20
     InventoryGroup=4
     GroupOffset=6
     PickupClass=Class'BMTCustomMut.Tech_BioLauncherPickup'
     PlayerViewOffset=(X=18.000000,Y=20.000000,Z=-6.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.Tech_BioLauncherAttachment'
     IconCoords=(X1=253,Y1=146,X2=333,Y2=181)
     ItemName="Bio Launcher"
     LightType=LT_None
     LightBrightness=0.000000
     LightRadius=0.000000
}
