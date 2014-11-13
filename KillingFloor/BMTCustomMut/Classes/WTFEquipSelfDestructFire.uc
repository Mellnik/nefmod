class WTFEquipSelfDestructFire extends PipeBombFire;

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksDemolitions')
			ProjectileClass=Class'BMTCustomMut.WTFEquipSelfDestructProj';

		else
			ProjectileClass=Class'BMTCustomMut.WTFEquipSelfDestructProj';
	}
	else
		ProjectileClass=Class'BMTCustomMut.WTFEquipSelfDestructProj';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     ProjectileSpawnDelay=0.400000
     bWaitForRelease=False
     FireRate=0.050000
     AmmoClass=Class'BMTCustomMut.WTFEquipSelfDestructAmmo'
     ProjectileClass=Class'BMTCustomMut.WTFEquipSelfDestructProj'
}
