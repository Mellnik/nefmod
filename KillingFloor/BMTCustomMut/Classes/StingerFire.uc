class StingerFire extends KFHighROFFire;

//overrided to disable FlashEmitter attaching to Stinger
simulated function InitEffects()
{
    super(InstantFire).InitEffects();

    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
        
    if ( (ShellEjectClass != None) && ((ShellEjectEmitter == None) || ShellEjectEmitter.bDeleteMe) )
    {
        ShellEjectEmitter = Weapon.Spawn(ShellEjectClass);
        Weapon.AttachToBone(ShellEjectEmitter, ShellEjectBoneName);
    }

    // if ( FlashEmitter != None ) {
        // Weapon.AttachToBone(FlashEmitter, KFWeapon(Weapon).FlashBoneName);
    // }
}

defaultproperties
{
     AmbientFireSound=Sound'Stinger_Snd.Stinger.StingerPrimaryAmb'
     RecoilRate=0.025000
     maxVerticalRecoilAngle=250
     maxHorizontalRecoilAngle=125
     ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
     ShellEjectBoneName="Stinger-CordFlap"
     DamageType=Class'BMTCustomMut.DamTypeStinger'
     DamageMin=90
     DamageMax=100
     Momentum=8500.000000
     TransientSoundVolume=10.000000
     PreFireAnim="WeaponFireStart"
     FireLoopAnim="WeaponFire"
     FireEndAnim="WeaponFireEnd"
     FireLoopAnimRate=1.500000
     FireSound=Sound'Stinger_Snd.Stinger.StingerPrimaryAmb'
     NoAmmoSound=Sound'KF_SCARSnd.SCAR_DryFire'
     FireRate=0.050000
     AmmoClass=Class'BMTCustomMut.StingerAmmo'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
     ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
     ShakeRotTime=0.650000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.150000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
     aimerror=42.000000
     Spread=0.217500
     SpreadStyle=SS_Random
}
