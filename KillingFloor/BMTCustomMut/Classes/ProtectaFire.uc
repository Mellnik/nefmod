class ProtectaFire extends ShotgunFire;

simulated function bool AllowFire()
{
	if(KFWeapon(Weapon).bIsReloading)
		return true;
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

function DrawMuzzleFlash(Canvas Canvas)
{
    super.DrawMuzzleFlash(Canvas);
}

function FlashMuzzleFlash()
{
    super.FlashMuzzleFlash();
}

simulated function DestroyEffects()
{
    super.DestroyEffects();
}

defaultproperties
{
     RecoilRate=0.100000
     maxVerticalRecoilAngle=2000
     maxHorizontalRecoilAngle=700
     StereoFireSound=Sound'Protecta_A.striker_shot_stereo'
     ProjPerFire=10
     bWaitForRelease=False
     bModeExclusive=False
     FireSound=Sound'Protecta_A.striker_shot_stereo'
     NoAmmoSound=Sound'Protecta_A.striker_empty'
     FireRate=0.300000
     AmmoClass=Class'BMTCustomMut.ProtectaAmmo'
     ProjectileClass=Class'BMTCustomMut.ProtectaBullet'
     BotRefireRate=0.250000
     aimerror=2.000000
     Spread=3000.000000
}
