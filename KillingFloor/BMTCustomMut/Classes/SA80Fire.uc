class SA80Fire extends KFShotgunFire;

#exec OBJ LOAD FILE=WTFSounds.uax


simulated function bool AllowFire()
{


	if(KFWeapon(Weapon).bIsReloading)
		return false;
	if(KFPawn(Instigator).SecondaryItem!=none)
		return false;
	if(KFPawn(Instigator).bThrowingNade)
		return false;

	if(KFWeapon(Weapon).MagAmmoRemaining < 1)
	{
    	if( Level.TimeSeconds - LastClickTime>FireRate )
    	{
    		LastClickTime = Level.TimeSeconds;
    	}

		if( AIController(Instigator.Controller)!=None )
			KFWeapon(Weapon).ReloadMeNow();
		return false;
	}

	return super(WeaponFire).AllowFire();
}

function float MaxRange()
{
    return 25000;
}

function DoFireEffect()
{
   Super(KFShotgunFire).DoFireEffect();
}

function DrawMuzzleFlash(Canvas Canvas)
{
    super.DrawMuzzleFlash(Canvas);

}

function FlashMuzzleFlash()
{
    super.FlashMuzzleFlash();

}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSharpshooter')
			ProjectileClass=Class'BMTCustomMut.SA80Bullet';

		else
			ProjectileClass=Class'BMTCustomMut.Sa80Bullet';
	}
	else
		ProjectileClass=Class'BMTCustomMut.SA80Bullet';
		
	return Super.SpawnProjectile(Start,Dir);
}


defaultproperties
{
	 EffectiveRange=25000.000000
	 KickMomentum=(X=-5.000000,Z=5.000000)
     RecoilRate=0.070000
     maxVerticalRecoilAngle=200
     maxHorizontalRecoilAngle=75
	 FireAimedAnim="Fire"
     bWaitForRelease=True
     bModeExclusive=False
     TransientSoundVolume=180.000000
     FireLoopAnim="Fire"
     FireEndAnim="Idle"
     FireSound=Sound'WTFSounds.SA80Fire'
     FireForce="ShockRifleFire"
     FireRate=0.600000
	 NoAmmoSound=Sound'B94_SN.empty'
     AmmoClass=Class'BMTCustomMut.SA80Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=250.000000,Y=500.000000,Z=250.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=4.000000,Y=4.000000,Z=4.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BMTCustomMut.SA80Bullet'
     BotRefireRate=3.750000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
     aimerror=0.000000
     Spread=0.000000
}
