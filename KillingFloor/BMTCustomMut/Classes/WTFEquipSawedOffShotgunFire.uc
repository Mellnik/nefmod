class WTFEquipSawedOffShotgunFire extends BoomStickFire;

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSupportSpec')
			ProjectileClass=Class'BMTCustomMut.WTFEquipBoomStickPellet';

		else
			ProjectileClass=Class'BMTCustomMut.WTFEquipBoomStickPellet';
	}
	else
		ProjectileClass=Class'BMTCustomMut.WTFEquipBoomStickPellet';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     KickMomentum=(X=-315.000000,Z=165.000000)
     AmmoClass=Class'BMTCustomMut.WTFEquipSawedOffShotgunAmmo'
     ShakeRotMag=(X=150.000000,Y=150.000000,Z=1200.000000)
     ShakeOffsetMag=(X=12.000000,Y=4.000000,Z=20.000000)
     ShakeOffsetRate=(X=2000.000000,Y=2000.000000,Z=2000.000000)
     ProjectileClass=Class'BMTCustomMut.WTFEquipBoomStickPellet'
     aimerror=4.000000
     Spread=6000.000000
}
