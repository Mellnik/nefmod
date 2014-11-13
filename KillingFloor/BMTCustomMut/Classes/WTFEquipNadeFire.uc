class WTFEquipNadeFire extends FragFire;

#exec OBJ LOAD FILE=WTFSounds.uax

var KFPlayerReplicationInfo KFPRI;

//OVERRIDING FOR MY CUSTOM NADE TYPES
function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local Projectile g;
	local vector X, Y, Z;
	local float pawnSpeed;

	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'WTFPerksFirebug')
			g = Weapon.Spawn(Class'BMTCustomMut.WTFEquipNadeFlame', instigator,, Start, Dir);
		else if (KFPRI.ClientVeteranSkill == Class'WTFPerksCommando')
			g = Weapon.Spawn(Class'BMTCustomMut.WTFEquipNadeStun', instigator,, Start, Dir);
		else if (KFPRI.ClientVeteranSkill == Class'WTFPerksFieldMedic')
			g = Weapon.Spawn(Class'BMTCustomMut.MedicNade', instigator,, Start, Dir);
		else if (KFPRI.ClientVeteranSkill == Class'WTFPerksDemolitions')
			g = Weapon.Spawn(Class'BMTCustomMut.WTFEquipNadeHE', instigator,, Start, Dir);
		else if (KFPRI.ClientVeteranSkill == Class'WTFPerksSupportSpec')
			g = Weapon.Spawn(Class'BMTCustomMut.WTFEquipNadeHE', instigator,, Start, Dir);
		else if (KFPRI.ClientVeteranSkill == Class'WTFPerksBerserker')
			//g = Weapon.Spawn(Class'BMTCustomMut.WTFEquipNadeImpact', instigator,, Start, Dir);
			g = Weapon.Spawn(Class'BMTCustomMut.WTFEquipNadeThrowingKnife', instigator,, Start, Dir);
	}

	if (g == None)
	{
		g = Weapon.Spawn(Class'BMTCustomMut.WTFEquipNadePlain', instigator,, Start, Dir);
	}

	if (g != None)
	{
		Weapon.GetViewAxes(X,Y,Z);
		pawnSpeed = X dot Instigator.Velocity;

		if ( Bot(Instigator.Controller) != None )
		{
			g.Speed = mHoldSpeedMax;
		}
		else
		{
			g.Speed = mHoldSpeedMin + HoldTime*mHoldSpeedGainPerSec;
		}

		g.Speed = FClamp(g.Speed, mHoldSpeedMin, mHoldSpeedMax);
		g.Speed = pawnSpeed + g.Speed;
		g.Velocity = g.Speed * Vector(Dir);
		//g.Damage *= DamageAtten;
	}

	return g;
}

defaultproperties
{
     ProjectileClass=Class'BMTCustomMut.WTFEquipNadePlain'
}
