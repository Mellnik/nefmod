class WTFFlamerFireSpray extends WTFFlamerFire;

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksFirebug')
			ProjectileClass=Class'BMTCustomMut.WTFFlamerSprayProj';

		else
			ProjectileClass=Class'BMTCustomMut.WTFFlamerSprayProj';
	}
	else
		ProjectileClass=Class'BMTCustomMut.WTFFlamerSprayProj';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     ProjPerFire=4
     FireRate=0.103300
     ProjectileClass=Class'BMTCustomMut.WTFFlamerSprayProj'
     aimerror=2.000000
     Spread=3000.000000
}
