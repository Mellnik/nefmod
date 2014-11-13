class Tech_ShockRifleFire extends shotgunfire;

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSentryTechPerk')
			ProjectileClass=Class'BMTCustomMut.Tech_ShockRifleBullet';

		else
			ProjectileClass=Class'BMTCustomMut.Tech_ShockRifleBullet';
	}
	else
		ProjectileClass=Class'BMTCustomMut.Tech_ShockRifleBullet';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     maxVerticalRecoilAngle=800
     maxHorizontalRecoilAngle=250
     FireSoundRef="KF_RifleSnd.Rifle_Fire"
     StereoFireSoundRef="KF_RifleSnd.Rifle_FireST"
     NoAmmoSoundRef="KF_RifleSnd.Rifle_DryFire"
     ProjPerFire=1
     FireAnimRate=0.900000
     FireRate=0.915000
     AmmoClass=Class'BMTCustomMut.Tech_ShockRifleAmmo'
     ShakeRotMag=(X=100.000000,Y=100.000000,Z=500.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=10.000000,Y=3.000000,Z=12.000000)
     ProjectileClass=Class'BMTCustomMut.Tech_ShockRifleBullet'
     BotRefireRate=0.650000
     aimerror=0.000000
     Spread=0.007000
}
