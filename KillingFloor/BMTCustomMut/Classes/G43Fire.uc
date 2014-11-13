//=============================================================================
 //AK47 Fire
//=============================================================================
class G43Fire extends KFFire;

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
     FireAimedAnim="iron_shoot"
     RecoilRate=0.050000
     maxVerticalRecoilAngle=600
     maxHorizontalRecoilAngle=300
     ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
     ShellEjectBoneName="ejector"
     StereoFireSound=SoundGroup'KF1945WepSnd.G43Auto'
     bRandomPitchFireSound=False
     DamageType=Class'BMTCustomMut.DamTypeG43Scoped'
     DamageMin=50
     DamageMax=60
     Momentum=8500.000000
     bWaitForRelease=True
     TransientSoundVolume=1.800000
     FireAnim="shoot"
     TweenTime=0.025000
     FireSound=SoundGroup'KF1945WepSnd.G43Auto'
     NoAmmoSound=Sound'KF_AK47Snd.AK47_DryFire'
     FireForce="AssaultRifleFire"
     FireRate=0.300000
     AmmoClass=Class'BMTCustomMut.G43Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=350.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.750000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stKar'
     aimerror=40.000000
     Spread=0.015000
     SpreadStyle=SS_Random
}
