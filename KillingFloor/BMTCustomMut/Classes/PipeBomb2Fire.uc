class PipeBomb2Fire extends PipeBombFire;

#exec OBJ LOAD FILE=KF_AxeSnd.uax

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksDemolitions')
			ProjectileClass=Class'BMTCustomMut.PipeBomb2Proj';

		else
			ProjectileClass=Class'BMTCustomMut.PipeBomb2Proj';
	}
	else
		ProjectileClass=Class'BMTCustomMut.PipeBomb2Proj';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     bWaitForRelease=False
     FireRate=0.050000
     AmmoClass=Class'BMTCustomMut.PipeBomb2Ammo'
     ProjectileClass=Class'BMTCustomMut.PipeBomb2Proj'
}
