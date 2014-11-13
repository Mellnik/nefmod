//=============================================================================
// MP7M Standard Fire
//=============================================================================
class MP40Fire extends KFFire;

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

// Handle setting the recoil amount
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

          	if( Rand( 2 ) == 1 )
             	NewRecoilRotation.Yaw *= -1;

    	    NewRecoilRotation.Pitch += (Instigator.HealthMax / Instigator.Health * 5);
    	    NewRecoilRotation.Yaw += (Instigator.HealthMax / Instigator.Health * 5);
    	    NewRecoilRotation *= Rec;

 		    KFPC.SetRecoil(NewRecoilRotation,RecoilRate / (default.FireRate/FireRate));
    	}
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

defaultproperties
{
     FireEndSound=Sound'KF1945WepSnd.ModWeaponSounds.mp40_end'
     FireEndStereoSound=Sound'KF1945WepSnd.ModWeaponSounds.mp40_end'
     AmbientFireSoundRadius=500.000000
     AmbientFireSound=Sound'KF1945WepSnd.ModWeaponSounds.mp40_firefast'
     AmbientFireVolume=255
     FireAimedAnim="Iron_Shoot_Loop"
     FireEndAimedAnim="Iron_Shoot_End"
     FireLoopAimedAnim="Iron_Shoot_Loop"
     RecoilRate=0.050000
     maxVerticalRecoilAngle=100
     maxHorizontalRecoilAngle=75
     ShellEjectClass=Class'ROEffects.KFShellEjectMP'
     ShellEjectBoneName="ejector"
     DamageType=Class'BMTCustomMut.DamTypeMP40'
     DamageMin=25
     DamageMax=30
     Momentum=5500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireLoopAnim="Shoot_Loop"
     FireEndAnim="Shoot_End"
     TweenTime=0.025000
     NoAmmoSound=Sound'KF_MP7Snd.MP7_DryFire'
     FireForce="AssaultRifleFire"
     FireRate=0.100000
     AmmoClass=Class'BMTCustomMut.MP40Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=25.000000,Y=25.000000,Z=125.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=3.000000
     ShakeOffsetMag=(X=4.000000,Y=2.500000,Z=5.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     BotRefireRate=0.100000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stMP'
     aimerror=20.000000
     Spread=0.009000
     SpreadStyle=SS_Random
}
