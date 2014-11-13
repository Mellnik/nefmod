class WTFEquipCrossbowFire extends KFShotgunFire;

simulated function bool AllowFire()
{
	return (Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire);
}

function float MaxRange()
{
    return 2500;
}

function DoFireEffect()
{
   Super(KFShotgunFire).DoFireEffect();
}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSharpshooter')
			ProjectileClass=Class'BMTCustomMut.WTFEquipCrossbowArrow';

		else
			ProjectileClass=Class'BMTCustomMut.WTFEquipCrossbowArrow';
	}
	else
		ProjectileClass=Class'BMTCustomMut.WTFEquipCrossbowArrow';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     EffectiveRange=2500.000000
     maxVerticalRecoilAngle=200
     maxHorizontalRecoilAngle=50
     FireAimedAnim="Fire_Iron"
     bRandomPitchFireSound=False
     FireSoundRef="KF_XbowSnd.Xbow_Fire"
     NoAmmoSoundRef="KF_XbowSnd.Xbow_DryFire"
     ProjPerFire=1
     ProjSpawnOffset=(Y=0.000000,Z=0.000000)
     bWaitForRelease=True
     TransientSoundVolume=1.800000
     FireForce="AssaultRifleFire"
     FireRate=1.800000
     AmmoClass=Class'BMTCustomMut.WTFEquipCrossbowAmmo'
     ShakeRotMag=(X=3.000000,Y=4.000000,Z=2.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeOffsetMag=(X=3.000000,Y=3.000000,Z=3.000000)
     ProjectileClass=Class'BMTCustomMut.WTFEquipCrossbowArrow'
     BotRefireRate=1.800000
     aimerror=1.000000
     Spread=0.750000
     SpreadStyle=SS_None
}
