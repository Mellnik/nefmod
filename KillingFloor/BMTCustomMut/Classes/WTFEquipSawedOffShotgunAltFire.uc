class WTFEquipSawedOffShotgunAltFire extends BoomStickAltFire;

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
     KickMomentum=(X=-150.000000,Z=66.000000)
     maxVerticalRecoilAngle=6400
     maxHorizontalRecoilAngle=1800
     AmmoClass=Class'BMTCustomMut.WTFEquipSawedOffShotgunAmmo'
     ShakeRotMag=(X=100.000000,Y=100.000000,Z=800.000000)
     ShakeOffsetMag=(X=12.000000,Y=4.000000,Z=20.000000)
     ProjectileClass=Class'BMTCustomMut.WTFEquipBoomStickPellet'
     aimerror=4.000000
     Spread=6000.000000
}
