class P90DTFire extends KFFire;

//0 = auto
//1 = semi auto
//2 = super auto
var byte AutoMode;

var bool bRamboNoWaitForRelease; // used in WTFEquipHCFire

function SetAutoMode( byte NewMode ) // interface for changing modes in uBullpup
{
    AutoMode = NewMode;
    bWaitForRelease = (NewMode==1);
}

function float GetFireSpeed()
{
    switch( AutoMode )
        {
            case 0: // regular automatic
                    if( Level.TimeDilation<0.6 )
                            return 1.5;
                    return 1.0; // normal default FireRate
            case 2: // super automatic available to commandos
                    if( Level.TimeDilation<0.6 )
                            return 4.5;
                    return 3.0; // Shoot 3x as fast; default FireRate is divided by this number
            default: // AutoMode is invalid or 1, so Semi Automatic Mode
                    return 1.0; // normal FireRate
        }
}
     
event ModeDoFire()
{
    local float Rec;
    local KFPlayerReplicationInfo KFPRI;
     
        if (!AllowFire())
            return;
     
        if( Instigator==None || Instigator.Controller==none )
            return;
     
        Spread = GetSpread();
     
        Rec = GetFireSpeed();
        FireRate = default.FireRate/Rec;
        FireAnimRate = default.FireAnimRate*Rec;
        ReloadAnimRate = default.ReloadAnimRate*Rec;
        Rec = 1;
     
        KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
        if ( KFPRI != none && KFPRI.ClientVeteranSkill!=none )
            Spread *= KFPRI.ClientVeteranSkill.Static.ModifyRecoilSpread( KFPRI, self, Rec);
     
            LastFireTime = Level.TimeSeconds;
     
        if (Weapon.Owner != none && AllowFire() && !bFiringDoesntAffectMovement)
        {
            if (bRamboNoWaitForRelease)
                bWaitForRelease=False;
        // medics are not slowed down by firing this weapon, or dualies, which extends this class of firemode
        if (KFPRI == None || KFPRI.ClientVeteranSkill != Class'WTFPerksCommando')
        {
            bWaitForRelease = Default.bWaitForRelease;
            Weapon.Owner.Velocity.x *= 0.5;
            Weapon.Owner.Velocity.y *= 0.5;
        }
}
     
        Super(InstantFire).ModeDoFire();
     
        // client
        if (Instigator.IsLocallyControlled())
        {
            if( bDoClientRagdollShotFX && Weapon.Level.NetMode == NM_Client )
                DoClientOnlyFireEffect();
                HandleRecoil(Rec);
        }
}
     
// Handle setting the recoil amount
simulated function HandleRecoil(float Rec)
{
    local rotator NewRecoilRotation;
    local KFPlayerController KFPC;
    local KFPawn KFPwn;
    local KFPlayerReplicationInfo KFPRI;
     
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
     
                            KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
     
                        //movement does not factor into recoil on this weapon for medics
                        if (KFPRI == None || KFPRI.ClientVeteranSkill != Class'WTFPerksCommando')
                        {
                            NewRecoilRotation.Pitch += (VSize(Weapon.Owner.Velocity)* 3);
                            NewRecoilRotation.Yaw += (VSize(Weapon.Owner.Velocity)* 3);
                        }
                            NewRecoilRotation.Pitch += (Instigator.HealthMax / Instigator.Health * 5);
                            NewRecoilRotation.Yaw += (Instigator.HealthMax / Instigator.Health * 5);
                            NewRecoilRotation *= Rec;
     
                            KFPC.SetRecoil(NewRecoilRotation,RecoilRate / (default.FireRate/FireRate));
                }
        }
}

defaultproperties
{
     FireAimedAnim="Fire_Iron"
     RecoilRate=0.065000
     maxVerticalRecoilAngle=300
     maxHorizontalRecoilAngle=130
     bRecoilRightOnly=True
     ShellEjectClass=Class'ROEffects.KFShellEjectMP'
     ShellEjectBoneName="Shell_eject"
     bAccuracyBonusForSemiAuto=True
     StereoFireSound=Sound'P90DT_A.p90_shot'
     bRandomPitchFireSound=False
     DamageType=Class'BMTCustomMut.DamTypeP90DT'
     DamageMin=35
     DamageMax=40
     Momentum=10500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireSound=Sound'P90DT_A.p90_shot'
     NoAmmoSound=Sound'P90DT_A.P90DT_SND.p90_empty'
     FireForce="AssaultRifleFire"
     FireRate=0.085000
     AmmoClass=Class'BMTCustomMut.P90DTAmmo'
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
     Spread=0.005500
     SpreadStyle=SS_Random
}
