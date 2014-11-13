//=============================================================================
 //SCARMK17 Fire
//=============================================================================
class M41AFire extends KFFire;



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
//simulated function HandleRecoil(float Rec)
//{
//	local rotator NewRecoilRotation;
//	local KFPlayerController KFPC;
//	local KFPawn KFPwn;
//
//    if( Instigator != none )
//    {
//		KFPC = KFPlayerController(Instigator.Controller);
//		KFPwn = KFPawn(Instigator);
//	}
//
//    if( KFPC == none || KFPwn == none )
//    	return;
//
//	if( !KFPC.bFreeCamera )
//	{
//    	if( Weapon.GetFireMode(0).bIsFiring || (DeagleAltFire(Weapon.GetFireMode(1))!=none
//    	 && DeagleAltFire(Weapon.GetFireMode(1)).bIsFiring) )
//    	{
//          	NewRecoilRotation.Pitch = RandRange( maxVerticalRecoilAngle * 0.5, maxVerticalRecoilAngle );
//         	NewRecoilRotation.Yaw = RandRange( maxHorizontalRecoilAngle * 0.5, maxHorizontalRecoilAngle );
//
//    	    NewRecoilRotation.Pitch += (VSize(Weapon.Owner.Velocity)* 3);
//    	    NewRecoilRotation.Yaw += (VSize(Weapon.Owner.Velocity)* 3);
//    	    NewRecoilRotation.Pitch += (Instigator.HealthMax / Instigator.Health * 5);
//    	    NewRecoilRotation.Yaw += (Instigator.HealthMax / Instigator.Health * 5);
//    	    NewRecoilRotation *= Rec;
//
// 		    KFPC.SetRecoil(NewRecoilRotation,RecoilRate / (default.FireRate/FireRate));
//    	}
// 	}
//}

defaultproperties
{
     FireAimedAnim="Fire_Iron"
     RecoilRate=0.020000
     maxVerticalRecoilAngle=50
     maxHorizontalRecoilAngle=80
     ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
     ShellEjectBoneName="Shell Feeder"
     StereoFireSound=SoundGroup'M41ASnd.M41AFire'
     DamageType=Class'BMTCustomMut.DamTypeM41AAssaultRifle'
     DamageMin=65
     DamageMax=80
     Momentum=6500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=5.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireSound=SoundGroup'M41ASnd.M41AFireMono'
     NoAmmoSound=Sound'M41ASnd.DryFire'
     FireForce="AssaultRifleFire"
     FireRate=0.070000
     AmmoClass=Class'BMTCustomMut.M41AAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
     ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
     ShakeRotTime=0.650000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.150000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'BMTCustomMut.MuzzleFlashM41A'
     aimerror=42.000000
     Spread=0.007500
     SpreadStyle=SS_Random
}
