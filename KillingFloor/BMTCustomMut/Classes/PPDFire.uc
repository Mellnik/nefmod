//=============================================================================
 //AK47 Fire
//=============================================================================
class PPDFire extends KFFire;


// sound
var 	sound   				FireEndSound;				// The sound to play at the end of the ambient fire sound
var 	sound   				FireEndStereoSound;    		// The sound to play at the end of the ambient fire sound in first person stereo
var 	float   				AmbientFireSoundRadius;		// The sound radius for the ambient fire sound
var		sound					AmbientFireSound;           // How loud to play the looping ambient fire sound
var		byte					AmbientFireVolume;          // The ambient fire sound

// Sends the fire class to the looping state
function StartFiring()
{
   GotoState('FireLoop');
}

// Handles toggling the weapon attachment's ambient sound on and off
function PlayAmbientSound(Sound aSound)
{
	local WeaponAttachment WA;

	WA = WeaponAttachment(Weapon.ThirdPersonActor);

    if ( Weapon == none || (WA == none))
        return;

	if(aSound == None)
	{
		WA.SoundVolume = WA.default.SoundVolume;
		WA.SoundRadius = WA.default.SoundRadius;
	}
	else
	{
		WA.SoundVolume = AmbientFireVolume;
		WA.SoundRadius = AmbientFireSoundRadius;
	}

    WA.AmbientSound = aSound;
}

// Make sure we are in the fire looping state when we fire
event ModeDoFire()
{
	if( AllowFire() && IsInState('FireLoop'))
	{
	    Super.ModeDoFire();
	}
}
/* =================================================================================== *
* FireLoop
* 	This state handles looping the firing animations and ambient fire sounds as well
*	as firing rounds.
*
* modified by: Ramm 1/17/05
* =================================================================================== */
state FireLoop
{
    function BeginState()
    {
		NextFireTime = Level.TimeSeconds - 0.1; //fire now!

        if( KFWeap.bAimingRifle )
		{
            Weapon.LoopAnim(FireLoopAimedAnim, FireLoopAnimRate, TweenTime);
		}
		else
		{
            Weapon.LoopAnim(FireLoopAnim, FireLoopAnimRate, TweenTime);
		}

		PlayAmbientSound(AmbientFireSound);
    }

	// Overriden because we play an anbient fire sound
    function PlayFiring() {}
	function ServerPlayFiring() {}

    function EndState()
    {
        Weapon.AnimStopLooping();
        PlayAmbientSound(none);
    	if( Weapon.Instigator != none && Weapon.Instigator.IsLocallyControlled() &&
    	   Weapon.Instigator.IsFirstPerson() && StereoFireSound != none )
    	{
            Weapon.PlayOwnedSound(FireEndStereoSound,SLOT_None,AmbientFireVolume/127,,AmbientFireSoundRadius,,false);
        }
        else
        {
            Weapon.PlayOwnedSound(FireEndSound,SLOT_None,AmbientFireVolume/127,,AmbientFireSoundRadius);
        }
        Weapon.StopFire(ThisModeNum);
    }

    function StopFiring()
    {
        GotoState('');
    }

    function ModeTick(float dt)
    {
	    Super.ModeTick(dt);

		if ( !bIsFiring ||  !AllowFire()  )  // stopped firing, magazine empty
        {
			GotoState('');
			return;
		}
    }
}

// Calculate modifications to spread
simulated function float GetSpread()
{
    local float NewSpread;
    local float AccuracyMod;

    AccuracyMod = 1.0;

    // Spread bonus for firing aiming
    if( KFWeap.bAimingRifle )
    {
        AccuracyMod *= 0.5;
    }

    // Small spread bonus for firing crouched
    if( Instigator != none && Instigator.bIsCrouched )
    {
        AccuracyMod *= 0.85;
    }

    // Small spread bonus for firing in semi auto mode
    if( bWaitForRelease )
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
        // Decrease accuracy up to MaxSpread by the number of recent shots up to a max of six
        NewSpread = FMin(Default.Spread + (NumShotsInBurst * (MaxSpread/6.0)),MaxSpread);
    }

    NewSpread *= AccuracyMod;

    return NewSpread;
}

// Handle setting the recoil amount
// Overriden to force the gun to only recoil to the right like a real AK
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

    	    NewRecoilRotation.Pitch += (VSize(Weapon.Owner.Velocity)* 3);
    	    NewRecoilRotation.Yaw += (VSize(Weapon.Owner.Velocity)* 3);
    	    NewRecoilRotation.Pitch += (Instigator.HealthMax / Instigator.Health * 5);
    	    NewRecoilRotation.Yaw += (Instigator.HealthMax / Instigator.Health * 5);
    	    NewRecoilRotation *= Rec;

 		    KFPC.SetRecoil(NewRecoilRotation,RecoilRate / (default.FireRate/FireRate));
    	}
 	}
}

defaultproperties
{
     FireEndSound=Sound'KF1945WepSnd.ppd40_fire_endb'
     FireEndStereoSound=Sound'KF1945WepSnd.ppd40_fire_endb'
     AmbientFireSoundRadius=500.000000
     AmbientFireSound=Sound'KF1945WepSnd.ppd40_fire_loopb'
     AmbientFireVolume=255
     FireAimedAnim="Iron_Shoot_Loop"
     FireEndAimedAnim="Iron_Shoot_End"
     FireLoopAimedAnim="Iron_Shoot_Loop"
     RecoilRate=0.050000
     maxVerticalRecoilAngle=500
     maxHorizontalRecoilAngle=250
     ShellEjectClass=Class'ROEffects.KFShellEjectAK'
     ShellEjectBoneName="ejector"
     StereoFireSound=Sound'KF1945WepSnd.ppd40_fire_loopb'
     bRandomPitchFireSound=False
     DamageType=Class'BMTCustomMut.DamTypePPD'
     DamageMin=15
     DamageMax=22
     Momentum=8500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireLoopAnim="Shoot_Loop"
     FireEndAnim="Shoot_End"
     TweenTime=0.025000
     FireSound=Sound'KF1945WepSnd.ppd40_fire_endb'
     NoAmmoSound=Sound'KF_AK47Snd.AK47_DryFire'
     FireForce="AssaultRifleFire"
     FireRate=0.085000
     AmmoClass=Class'BMTCustomMut.PPDAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=350.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.750000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stMP'
     aimerror=42.000000
     Spread=0.015000
     SpreadStyle=SS_Random
}
