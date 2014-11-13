class LilithKissFire extends KFShotgunFire;

var() Emitter Flash2Emitter;

var()           class<Emitter>  ShellEjectClass;            // class of the shell eject emitter
var()           Emitter         ShellEjectEmitter;          // The shell eject emitter
var()           name            ShellEjectBoneName;         // name of the shell eject bone
var()           Emitter         ShellEject2Emitter;          // The shell eject emitter
var()           name            ShellEject2BoneName;         // name of the shell eject bone

var name FireAnim2, FireAimedAnim2;
var name fa;
var float TraceRange;

var() vector SightedProjSpawnOffset;

simulated function InitEffects()
{
    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
        return;
    if ( (FlashEmitterClass != None) && ((FlashEmitter == None) || FlashEmitter.bDeleteMe) )
    {
        FlashEmitter = Weapon.Spawn(FlashEmitterClass);
        Weapon.AttachToBone(FlashEmitter, KFWeapon(Weapon).default.FlashBoneName);
    }
    if ( (FlashEmitterClass != None) && ((Flash2Emitter == None) || Flash2Emitter.bDeleteMe) )
    {
        Flash2Emitter = Weapon.Spawn(FlashEmitterClass);
        Weapon.AttachToBone(Flash2Emitter, LilithKiss(Weapon).default.altFlashBoneName);
    }

    if ( (SmokeEmitterClass != None) && ((SmokeEmitter == None) || SmokeEmitter.bDeleteMe) )
    {
        SmokeEmitter = Weapon.Spawn(SmokeEmitterClass);
    }
}

simulated function DestroyEffects()
{
    super.DestroyEffects();

    if (Flash2Emitter != None)
        Flash2Emitter.Destroy();
}

function DrawMuzzleFlash(Canvas Canvas)
{
    super.DrawMuzzleFlash(Canvas);
}

function FlashMuzzleFlash()
{
    if (Flash2Emitter == none || FlashEmitter == none)
        return;

    if( KFWeap.bAimingRifle )
    {
        if( FireAimedAnim == 'FireLeft' )
        {
            Flash2Emitter.Trigger(Weapon, Instigator);
        }
        else
        {
            FlashEmitter.Trigger(Weapon, Instigator);
        }
	}
	else
	{
        if(FireAnim == 'FireLeft')
        {
            Flash2Emitter.Trigger(Weapon, Instigator);
        }
        else
        {
            FlashEmitter.Trigger(Weapon, Instigator);
        }
	}
}

event ModeDoFire()
{
	local name bn;

	bn = Dualies(Weapon).altFlashBoneName;
	LilithKiss(Weapon).altFlashBoneName = LilithKiss(Weapon).FlashBoneName;
	LilithKiss(Weapon).FlashBoneName = bn;

	Super.ModeDoFire();

    if( KFWeap.bAimingRifle )
    {
    	fa = FireAimedAnim2;
    	FireAimedAnim2 = FireAimedAnim;
    	FireAimedAnim = fa;
	}
	else
	{
    	fa = FireAnim2;
    	FireAnim2 = FireAnim;
    	FireAnim = fa;
	}
	InitEffects();
}

function DoFireEffect()
{
    local Vector StartProj, StartTrace, X,Y,Z;
    local Rotator R, Aim;
    local Vector HitLocation, HitNormal;
    local Actor Other;
    local int p;
    local int SpawnCount;
    local float theta;

    Instigator.MakeNoise(1.0);
    Weapon.GetViewAxes(X,Y,Z);

    StartTrace = Instigator.Location + Instigator.EyePosition();// + X*Instigator.CollisionRadius;

    if( KFWeap.bAimingRifle )
    {
        StartProj = StartTrace + X*SightedProjSpawnOffset.X;

        if( FireAimedAnim == 'FireLeft_Iron')
        {
            StartProj = StartProj + -1 * Y*SightedProjSpawnOffset.Y + Z*SightedProjSpawnOffset.Z;
        }
        else
        {
            StartProj = StartProj + Weapon.Hand * Y*SightedProjSpawnOffset.Y + Z*SightedProjSpawnOffset.Z;
        }
	}
	else
	{
        StartProj = StartTrace + X*ProjSpawnOffset.X;

        if(FireAnim == 'FireLeft')
        {
            StartProj = StartProj + -1 * Y*ProjSpawnOffset.Y + Z*ProjSpawnOffset.Z;
        }
        else
        {
            StartProj = StartProj + Weapon.Hand * Y*ProjSpawnOffset.Y + Z*ProjSpawnOffset.Z;
        }
	}

    // check if projectile would spawn through a wall and adjust start location accordingly
    Other = Weapon.Trace(HitLocation, HitNormal, StartProj, StartTrace, false);

// Collision attachment debugging
 /*   if( Other.IsA('ROCollisionAttachment'))
    {
    	log(self$"'s trace hit "$Other.Base$" Collision attachment");
    }*/

    if (Other != None)
    {
        StartProj = HitLocation;
    }

    Aim = AdjustAim(StartProj, AimError);

    SpawnCount = Max(1, ProjPerFire * int(Load));

    switch (SpreadStyle)
    {
    case SS_Random:
        X = Vector(Aim);
        for (p = 0; p < SpawnCount; p++)
        {
            R.Yaw = Spread * (FRand()-0.5);
            R.Pitch = Spread * (FRand()-0.5);
            R.Roll = Spread * (FRand()-0.5);
            SpawnProjectile(StartProj, Rotator(X >> R));
        }
        break;
    case SS_Line:
        for (p = 0; p < SpawnCount; p++)
        {
            theta = Spread*PI/32768*(p - float(SpawnCount-1)/2.0);
            X.X = Cos(theta);
            X.Y = Sin(theta);
            X.Z = 0.0;
            SpawnProjectile(StartProj, Rotator(X >> Aim));
        }
        break;
    default:
        SpawnProjectile(StartProj, Aim);
    }

	if (Instigator != none )
	{
        if( Instigator.Physics != PHYS_Falling  )
        {
            Instigator.AddVelocity(KickMomentum >> Instigator.GetViewRotation());
		}
		// Really boost the momentum for low grav
        else if( Instigator.Physics == PHYS_Falling
            && Instigator.PhysicsVolume.Gravity.Z > class'PhysicsVolume'.default.Gravity.Z)
        {
            Instigator.AddVelocity((KickMomentum * 10.0) >> Instigator.GetViewRotation());
        }
	}
}

simulated function DoClientOnlyFireEffect()
{
    local Vector StartTrace;
    local Rotator R, Aim;

    if( KFWeap.bAimingRifle )
    {
        if( FireAimedAnim == 'FireLeft')
        {
            StartTrace = Instigator.Location + Instigator.EyePosition();
            StartTrace.Y  += (rand(30)+ 5);
        }
        else
        {
            StartTrace = Instigator.Location + Instigator.EyePosition();
        }
	}
	else
	{
        if(FireAnim == 'FireLeft')
        {
            StartTrace = Instigator.Location + Instigator.EyePosition();
            StartTrace.Y  += (rand(30)+ 5);
        }
        else
        {
            StartTrace = Instigator.Location + Instigator.EyePosition();
        }
	}

    Aim = AdjustAim(StartTrace, AimError);
    R = rotator(vector(Aim) + VRand()*FRand()*Spread);
}

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

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'BMTCustomMut.WTFPerksSupportSpec')
			ProjectileClass=Class'BMTCustomMut.LilithBullet';

		else
			ProjectileClass=Class'BMTCustomMut.LilithBullet';
	}
	else
		ProjectileClass=Class'BMTCustomMut.LilithBullet';
		
	return Super.SpawnProjectile(Start,Dir);
}

defaultproperties
{
     FireAnim2="FireLeft"
     FireAimedAnim2="FireLeft"
     KickMomentum=(X=-35.000000,Z=5.000000)
     maxVerticalRecoilAngle=500
     maxHorizontalRecoilAngle=50
     FireAimedAnim="FireRight"
     FireSoundRef="LilithKiss_S.lilith_fire_m"
     StereoFireSoundRef="LilithKiss_S.lilith_fire"
     ProjPerFire=5
     bWaitForRelease=True
     bAttachSmokeEmitter=True
     TransientSoundVolume=2.000000
     TransientSoundRadius=500.000000
     FireAnim="FireRight"
     NoAmmoSound=Sound'KF_9MMSnd.9mm_DryFire'
     FireRate=0.075000
     AmmoClass=Class'BMTCustomMut.LilithAmmo'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=250.000000)
     ShakeRotRate=(X=12500.000000,Y=12500.000000,Z=12500.000000)
     ShakeRotTime=3.000000
     ShakeOffsetMag=(X=6.000000,Y=2.000000,Z=6.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     ProjectileClass=Class'BMTCustomMut.LilithBullet'
     BotRefireRate=0.250000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stMP'
     aimerror=1.000000
     Spread=500.000000
}
