class Tech_BioLauncherFire extends KFShotgunFire;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"



function float MaxRange()
{
    return 2500;
}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSentryTechPerk')
			ProjectileClass=Class'BMTCustomMut.Tech_BioLauncherProj';

		else
			ProjectileClass=Class'BMTCustomMut.Tech_BioLauncherProj';
	}
	else
		ProjectileClass=Class'BMTCustomMut.Tech_BioLauncherProj';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     EffectiveRange=2500.000000
     maxVerticalRecoilAngle=200
     maxHorizontalRecoilAngle=50
     FireAimedAnim="Iron_Fire"
     FireSoundRef="SentryTechSounds.Weapon_BioLauncher.BioLauncher_Fire"
     StereoFireSoundRef="SentryTechSounds.Weapon_BioLauncher.BioLauncher_Fire"
     NoAmmoSoundRef="KF_M79Snd.M79_DryFire"
     ProjPerFire=1
     ProjSpawnOffset=(X=50.000000,Y=10.000000)
     bWaitForRelease=True
     TransientSoundVolume=1.800000
     FireForce="AssaultRifleFire"
     FireRate=0.330000
     AmmoClass=Class'BMTCustomMut.Tech_BioLauncherAmmo'
     ShakeRotMag=(X=3.000000,Y=4.000000,Z=2.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeOffsetMag=(X=3.000000,Y=3.000000,Z=3.000000)
     ProjectileClass=Class'BMTCustomMut.Tech_BioLauncherProj'
     BotRefireRate=1.800000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stNadeL'
     aimerror=42.000000
     Spread=0.015000
}
