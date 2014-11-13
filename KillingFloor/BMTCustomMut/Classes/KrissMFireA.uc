//=============================================================================
// KrissMFire
//=============================================================================
// Kriss Medic Gun primary fire class
//=============================================================================
// Killing Floor Source
// Copyright (C) 2012 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class KrissMFireA extends KFHighROFFire;

defaultproperties
{
     FireEndSoundRef="KF_KrissSND.Kriss_Fire_End"
     FireEndStereoSoundRef="KF_KrissSND.KF_WEP_KRISS_END_S"
     AmbientFireSoundRef="KF_KrissSND.Kriss_Fire_Loop"
     RecoilRate=0.060000
     maxVerticalRecoilAngle=75
     maxHorizontalRecoilAngle=55
     RecoilVelocityScale=0.000000
     ShellEjectClass=Class'BMTCustomMut.ShellEjectKrissA'
     ShellEjectBoneName="Shell_eject"
     NoAmmoSoundRef="KF_MP7Snd.MP7_DryFire"
     DamageType=Class'BMTCustomMut.DamTypeKrissMA'
     DamageMin=35
     DamageMax=40
     Momentum=12500.000000
     FireRate=0.063000
     AmmoClass=Class'BMTCustomMut.KrissMAmmoA'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=350.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.750000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stMP'
     Spread=0.012500
     SpreadStyle=SS_Random
}
