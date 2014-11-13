class XMV850Fire extends KFFire;

#exec OBJ LOAD FILE=XMV850_Snd.uax

defaultproperties
{
     FireAimedAnim="Fire_Iron"
     RecoilRate=0.060000
     maxVerticalRecoilAngle=250
     maxHorizontalRecoilAngle=125
     ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
     ShellEjectBoneName="ejector"
     FireSoundRef="XMV850_Snd.XMV-Fire-1"
     StereoFireSoundRef="XMV850_Snd.XMV-Fire-1"
     NoAmmoSoundRef="KF_SCARSnd.SCAR_DryFire"
     DamageType=Class'BMTCustomMut.DamTypeXMV850'
     DamageMin=41
     DamageMax=46
     Momentum=8500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=4.800000
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.100000
     AmmoClass=Class'BMTCustomMut.XMV850Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
     ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
     ShakeRotTime=0.650000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.150000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
     aimerror=42.000000
     Spread=0.227500
     SpreadStyle=SS_Random
}
