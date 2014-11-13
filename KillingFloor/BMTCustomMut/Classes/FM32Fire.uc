class FM32Fire extends KFShotgunFire;

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
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksFirebug')
			ProjectileClass=Class'BMTCustomMut.FM32Proj';

		else
			ProjectileClass=Class'BMTCustomMut.FM32Proj';
	}
	else
		ProjectileClass=Class'BMTCustomMut.FM32Proj';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     EffectiveRange=2500.000000
     maxVerticalRecoilAngle=200
     maxHorizontalRecoilAngle=50
     FireAimedAnim="Iron_Fire"
     FireSoundRef="KF_M32Snd.M32_Fire"
     StereoFireSoundRef="KF_M32Snd.M32_FireST"
     NoAmmoSoundRef="KF_M79Snd.M79_DryFire"
     ProjPerFire=1
     ProjSpawnOffset=(X=50.000000,Y=10.000000)
     bWaitForRelease=True
     TransientSoundVolume=1.800000
     FireForce="AssaultRifleFire"
     FireRate=0.330000
     AmmoClass=Class'BMTCustomMut.FM32Ammo'
     ShakeRotMag=(X=3.000000,Y=4.000000,Z=2.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeOffsetMag=(X=3.000000,Y=3.000000,Z=3.000000)
     ProjectileClass=Class'BMTCustomMut.FM32Proj'
     BotRefireRate=1.800000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stNadeL'
     aimerror=42.000000
     Spread=0.015000
}
