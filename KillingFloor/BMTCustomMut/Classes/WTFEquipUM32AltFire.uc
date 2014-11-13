class WTFEquipUM32AltFire extends M32Fire;

//only for demos
event ModeDoFire()
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none && KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksDemolitions')
		Super.ModeDoFire();
}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksDemolitions')
			ProjectileClass=Class'BMTCustomMut.WTFEquipUM32ProximityMine';

		else
			ProjectileClass=Class'BMTCustomMut.WTFEquipUM32ProximityMine';
	}
	else
		ProjectileClass=Class'BMTCustomMut.WTFEquipUM32ProximityMine';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     ProjectileClass=Class'BMTCustomMut.WTFEquipUM32ProximityMine'
}
