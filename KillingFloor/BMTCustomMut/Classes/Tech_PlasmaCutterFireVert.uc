class Tech_PlasmaCutterFireVert extends BenelliFire;

var()   Emitter     Flash2Emitter;
var()   Emitter     Flash3Emitter;
var()   name        MuzzleBoneTop;
var()   name        MuzzleBoneBottom;

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

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
                Weapon.AttachToBone(FlashEmitter, 'MainTip');

    if ( (FlashEmitterClass != None) && ((Flash2Emitter == None) || Flash2Emitter.bDeleteMe) )
    {
        Flash2Emitter = Weapon.Spawn(FlashEmitterClass);
        Weapon.AttachToBone(Flash2Emitter, MuzzleBoneTop);
    }

    if ( (FlashEmitterClass != None) && ((Flash3Emitter == None) || Flash3Emitter.bDeleteMe) )
    {
        Flash3Emitter = Weapon.Spawn(FlashEmitterClass);
        Weapon.AttachToBone(Flash3Emitter, MuzzleBoneBottom);
    }

}

simulated function DestroyEffects()
{
    super.DestroyEffects();

    if (Flash2Emitter != None)
        Flash2Emitter.Destroy();

    if (Flash3Emitter != None)
        Flash3Emitter.Destroy();
}

function FlashMuzzleFlash()
{
    super.FlashMuzzleFlash();

    if (Flash2Emitter != None)
        Flash2Emitter.Trigger(Weapon, Instigator);

    if (Flash3Emitter != None)
        Flash3Emitter.Trigger(Weapon, Instigator);
}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSentryTechPerk')
			ProjectileClass=Class'BMTCustomMut.Tech_PlasmaCutterBullet';

		else
			ProjectileClass=Class'BMTCustomMut.Tech_PlasmaCutterBullet';
	}
	else
		ProjectileClass=Class'BMTCustomMut.Tech_PlasmaCutterBullet';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     MuzzleBoneTop="TopTip"
     MuzzleBoneBottom="BottomTip"
     RecoilRate=0.040000
     maxVerticalRecoilAngle=100
     maxHorizontalRecoilAngle=20
     FireAimedAnim="Fire_IronVert"
     StereoFireSound=Sound'SentryTechSounds.Fire.PlasmaCutter_FireST'
     ProjPerFire=3
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireAnim="FireVert"
     TweenTime=0.025000
     FireSound=Sound'SentryTechSounds.Fire.PlasmaCutter_Fire'
     NoAmmoSound=Sound'KF_HandcannonSnd.50AE_DryFire'
     FireRate=0.250000
     AmmoClass=Class'BMTCustomMut.Tech_PlasmaCutterAmmo'
     ShakeRotMag=(X=75.000000,Y=75.000000)
     ShakeRotRate=(Z=10000.000000)
     ShakeRotTime=3.500000
     ShakeOffsetMag=(Y=1.000000,Z=8.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BMTCustomMut.Tech_PlasmaCutterBullet'
     BotRefireRate=0.650000
}
