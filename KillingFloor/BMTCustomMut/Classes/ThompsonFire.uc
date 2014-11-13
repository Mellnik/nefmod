class ThompsonFire extends KFFire;

defaultproperties
{
     FireAimedAnim="Fire"
     RecoilRate=0.010000
     maxVerticalRecoilAngle=50
     maxHorizontalRecoilAngle=20
     ShellEjectClass=Class'ROEffects.KFShellEjectMP5SMG'
     ShellEjectBoneName="Shell_eject"
     StereoFireSound=Sound'Thompson_Snd.thompson_shoot_stereo'
     bRandomPitchFireSound=False
     DamageType=Class'BMTCustomMut.DamTypeThompson'
     DamageMin=30
     DamageMax=40
     Momentum=7500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireSound=Sound'Thompson_Snd.thompson_shoot_mono'
     NoAmmoSound=Sound'Thompson_Snd.thompson_empty'
     FireForce="AssaultRifleFire"
     FireRate=0.079000
     AmmoClass=Class'BMTCustomMut.ThompsonAmmo'
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
