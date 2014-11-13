class PBFire extends KFShotgunFire;

var()           class<Emitter>  ShellEjectClass;            // class of the shell eject emitter
var()           Emitter         ShellEjectEmitter;          // The shell eject emitter
var()           name            ShellEjectBoneName;         // name of the shell eject bone

simulated function InitEffects()
{
    super.InitEffects();

    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
    if ( (ShellEjectClass != None) && ((ShellEjectEmitter == None) || ShellEjectEmitter.bDeleteMe) )
    {
        ShellEjectEmitter = Weapon.Spawn(ShellEjectClass);
        Weapon.AttachToBone(ShellEjectEmitter, ShellEjectBoneName);
    }
}

function DrawMuzzleFlash(Canvas Canvas)
{
    super.DrawMuzzleFlash(Canvas);
    // Draw shell ejects
    if (ShellEjectEmitter != None )
    {
        Canvas.DrawActor( ShellEjectEmitter, false, false, Weapon.DisplayFOV );
    }
}

function FlashMuzzleFlash()
{
    super.FlashMuzzleFlash();

    if (ShellEjectEmitter != None)
    {
        ShellEjectEmitter.Trigger(Weapon, Instigator);
    }
}

simulated function DestroyEffects()
{
    super.DestroyEffects();

    if (ShellEjectEmitter != None)
        ShellEjectEmitter.Destroy();
}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSharpshooter')
			ProjectileClass=Class'BMTCustomMut.PBSBullet';
		else if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksFirebug')
			ProjectileClass=Class'BMTCustomMut.PBFBullet';
		else if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksDemolitions')
			ProjectileClass=Class'BMTCustomMut.PBExpBullet';
		else
			ProjectileClass=Class'BMTCustomMut.PBBullet';
	}
	else
		ProjectileClass=Class'BMTCustomMut.PBBullet';
		
	return Super.SpawnProjectile(Start,Dir);
}

simulated function bool AllowFire()
{
	return (!KFWeapon(Weapon).bIsReloading && Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire);
}

function float MaxRange()
{
    return 25000;
}

function DoFireEffect()
{
   Super(KFShotgunFire).DoFireEffect();
}

defaultproperties
{
     ShellEjectClass=Class'ROEffects.KFShellEject9mm'
     ShellEjectBoneName="Shell_eject"
     EffectiveRange=25000.000000
     maxVerticalRecoilAngle=1200
     maxHorizontalRecoilAngle=200
     FireAimedAnim="Iron_Fire"
     StereoFireSound=Sound'pb_S.pb_shoot'
     bRandomPitchFireSound=False
     ProjPerFire=1
     ProjSpawnOffset=(Y=0.000000,Z=0.000000)
     bWaitForRelease=True
     TransientSoundVolume=1.800000
     FireSound=Sound'pb_S.pb_shoot'
     NoAmmoSound=Sound'KF_HandcannonSnd.50AE_DryFire'
     FireForce="AssaultRifleFire"
     FireRate=0.250000
     AmmoClass=Class'BMTCustomMut.PBAmmo'
     ShakeRotMag=(X=75.000000,Y=75.000000,Z=400.000000)
     ShakeRotRate=(X=12500.000000,Y=12500.000000,Z=10000.000000)
     ShakeRotTime=3.500000
     ShakeOffsetMag=(X=6.000000,Y=1.000000,Z=8.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BMTCustomMut.PBBullet'
     BotRefireRate=0.650000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stKar'
     aimerror=40.000000
     Spread=0.010000
}
