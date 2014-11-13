class Tech_MachinePistolFire extends BullpupFire;

var bool bMedicNoWaitForRelease; //used in WTFEquipHCFire

event ModeDoFire()
{
    local float Rec;
    
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

    if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
    {
        Spread *= KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.ModifyRecoilSpread(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo), self, Rec);
    }

    LastFireTime = Level.TimeSeconds;

    

    Super(InstantFire).ModeDoFire();

    // client
    if (Instigator.IsLocallyControlled())
    {
        if( bDoClientRagdollShotFX && Weapon.Level.NetMode == NM_Client )
        {
            DoClientOnlyFireEffect();
        }
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
                
            
            NewRecoilRotation.Pitch += (Instigator.HealthMax / Instigator.Health * 5);
            NewRecoilRotation.Yaw += (Instigator.HealthMax / Instigator.Health * 5);
            NewRecoilRotation *= Rec;

            KFPC.SetRecoil(NewRecoilRotation,RecoilRate / (default.FireRate/FireRate));
        }
    }
}

function float GetFireSpeed()
{
if (KFGameType(Level.Game).bZEDTimeActive)
return 1.5;
else
return 1.0;
}

defaultproperties
{
     ShellEjectClass=Class'ROEffects.KFShellEject9mm'
     ShellEjectBoneName="Shell_eject"
     StereoFireSoundRef="KF_9MMSnd.9mm_FireST"
     DamageType=Class'BMTCustomMut.DamTypeTech_MachinePistol'
     DamageMin=25
     DamageMax=35
     Momentum=10000.000000
     FireSound=SoundGroup'KF_9MMSnd.9mm_Fire'
     FireRate=0.120000
     AmmoClass=Class'BMTCustomMut.Tech_MachinePistolAmmo'
     aimerror=30.000000
     Spread=0.015000
}
