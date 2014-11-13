class BizonFire extends KFShotgunFire;

var float LastFireTime;

var()           class<Emitter>  ShellEjectClass;
var()           Emitter         ShellEjectEmitter;
var()           name            ShellEjectBoneName;

var()           float           MaxSpread;
var             int             NumShotsInBurst;
var()           bool            bAccuracyBonusForSemiAuto;

var(Recoil)		float			RecoilRate;
var(Recoil) 	int 			maxVerticalRecoilAngle;
var(Recoil) 	int 			maxHorizontalRecoilAngle;
var(Recoil)     float           RecoilVelocityScale;
var(Recoil)     bool            bRecoilRightOnly;

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

simulated function HandleRecoil(float Rec)
{
	local rotator NewRecoilRotation;
	local KFPlayerController KFPC;
	local KFPawn KFPwn;

    if( Instigator != none )
    {
		KFPC = KFPlayerController(Instigator.Controller);
		KFPwn = KFPawn(Instigator);
	}

    if( KFPC == none || KFPwn == none )
    	return;

	if( !KFPC.bFreeCamera )
	{
    	if( Weapon.GetFireMode(0).bIsFiring || (DeagleAltFire(Weapon.GetFireMode(1))!=none
    	 && DeagleAltFire(Weapon.GetFireMode(1)).bIsFiring) )
    	{
          	NewRecoilRotation.Pitch = RandRange( maxVerticalRecoilAngle * 0.5, maxVerticalRecoilAngle );
         	NewRecoilRotation.Yaw = RandRange( maxHorizontalRecoilAngle * 0.5, maxHorizontalRecoilAngle );

          	if( !bRecoilRightOnly )
          	{
                if( Rand( 2 ) == 1 )
                 	NewRecoilRotation.Yaw *= -1;
            }

    	    if( RecoilVelocityScale > 0 )
    	    {
                NewRecoilRotation.Pitch += (VSize(Weapon.Owner.Velocity)* RecoilVelocityScale);
        	    NewRecoilRotation.Yaw += (VSize(Weapon.Owner.Velocity)* RecoilVelocityScale);
    	    }
    	    NewRecoilRotation.Pitch += (Instigator.HealthMax / Instigator.Health * 5);
    	    NewRecoilRotation.Yaw += (Instigator.HealthMax / Instigator.Health * 5);
    	    NewRecoilRotation *= Rec;

 		    KFPC.SetRecoil(NewRecoilRotation,RecoilRate / (default.FireRate/FireRate));
    	}
 	}
}

simulated function float GetSpread()
{
    local float NewSpread;
    local float AccuracyMod;

    AccuracyMod = 1.0;

    if( KFWeap.bAimingRifle )
    {
        AccuracyMod *= 0.5;
    }

    if( Instigator != none && Instigator.bIsCrouched )
    {
        AccuracyMod *= 0.85;
    }

    if( bAccuracyBonusForSemiAuto && bWaitForRelease )
    {
        AccuracyMod *= 0.85;
    }

    NumShotsInBurst += 1;

	if ( Level.TimeSeconds - LastFireTime > 0.5 )
	{
		NewSpread = Default.Spread;
		NumShotsInBurst=0;
	}
	else
    {
        NewSpread = FMin(Default.Spread + (NumShotsInBurst * (MaxSpread/6.0)),MaxSpread);
    }

    NewSpread *= AccuracyMod;

    return NewSpread;
}

simulated function InitEffects()
{
    super.InitEffects();

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

function DoFireEffect()
{
   Super(KFShotgunFire).DoFireEffect();
}

/*simulated function bool AllowFire()
{
	return (!KFWeapon(Weapon).bIsReloading && Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire);
}
*/

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksDemolitions')
			ProjectileClass=Class'BMTCustomMut.BizonBullet';

		else
			ProjectileClass=Class'BMTCustomMut.BizonBullet';
	}
	else
		ProjectileClass=Class'BMTCustomMut.BizonBullet';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     ShellEjectClass=Class'ROEffects.KFShellEjectMac'
     ShellEjectBoneName="Shell_eject"
     bAccuracyBonusForSemiAuto=True
     RecoilRate=0.040000
     maxVerticalRecoilAngle=500
     maxHorizontalRecoilAngle=250
     bRecoilRightOnly=True
     FireAimedAnim="Fire"
     StereoFireSound=Sound'Bizon_A.Bizon_shoot_stereo'
     bRandomPitchFireSound=False
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireSound=Sound'Bizon_A.Bizon_shoot_mono'
     NoAmmoSound=Sound'Bizon_A.Bizon_empty'
     FireForce="AssaultRifleFire"
     FireRate=0.114000
     AmmoClass=Class'BMTCustomMut.BizonAmmo'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=350.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.750000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     ProjectileClass=Class'BMTCustomMut.BizonBullet'
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
     aimerror=42.000000
     Spread=0.005000
}
