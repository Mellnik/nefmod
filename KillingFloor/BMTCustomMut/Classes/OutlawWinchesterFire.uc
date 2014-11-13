//=============================================================================
// Winchester Fire
//=============================================================================
class OutlawWinchesterFire extends KFFire;

// Overridden to support interrupting the reload
simulated function bool AllowFire()
{
	if( KFWeapon(Weapon).bIsReloading && KFWeapon(Weapon).MagAmmoRemaining < 2)
		return false;

	if(KFPawn(Instigator).SecondaryItem!=none)
		return false;
	if( KFPawn(Instigator).bThrowingNade )
		return false;

	if( Level.TimeSeconds - LastClickTime>FireRate )
	{
		LastClickTime = Level.TimeSeconds;
	}

	if( KFWeaponShotgun(Weapon).MagAmmoRemaining<1 )
	{
    	return false;
	}

	return super(WeaponFire).AllowFire();
}

event ModeDoFire()
{
	local float Rec;

	if (!AllowFire())
		return;

	if( Instigator==None || Instigator.Controller==none )
		return;

	Rec = GetFireSpeed();

    	FireRate = default.FireRate/Rec;
    	FireAnimRate = default.FireAnimRate;
    	ReloadAnimRate = default.ReloadAnimRate*Rec;

	Rec = 1;

	LastFireTime = Level.TimeSeconds;

	if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
	{
		Spread *= KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.ModifyRecoilSpread(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo), self, Rec);
	}


	if (MaxHoldTime > 0.0)
		HoldTime = FMin(HoldTime, MaxHoldTime);

	// server
	if (Weapon.Role == ROLE_Authority)
	{
		Weapon.ConsumeAmmo(ThisModeNum, Load);
		DoFireEffect();
		HoldTime = 0;   // if bot decides to stop firing, HoldTime must be reset first
		if ( (Instigator == None) || (Instigator.Controller == None) )
			return;

		if ( AIController(Instigator.Controller) != None )
			AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);

		Instigator.DeactivateSpawnProtection();
	}

	// client
	if (Instigator.IsLocallyControlled())
	{
		ShakeView();
		PlayFiring();
		FlashMuzzleFlash();
		StartMuzzleSmoke();
	}
	else // server
	{
		ServerPlayFiring();
	}

	Weapon.IncrementFlashCount(ThisModeNum);

	// set the next firing time. must be careful here so client and server do not get out of sync
	if (bFireOnRelease)
	{
		if (bIsFiring)
			NextFireTime += MaxHoldTime + FireRate;
		else NextFireTime = Level.TimeSeconds + FireRate;
	}
	else
	{
		NextFireTime += FireRate;
		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
	}

	Load = AmmoPerFire;
	HoldTime = 0;

	if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
	{
		bIsFiring = false;
		Weapon.PutDown();
	}

	if (Weapon.Owner != none && AllowFire())
	{
		if (FireRate > 0.25)
			Weapon.Owner.Velocity *= 0.1;
		else Weapon.Owner.Velocity *= 0.5;
	}

    // client
    if (Instigator.IsLocallyControlled())
    {
        if( bDoClientRagdollShotFX && Weapon.Level.NetMode == NM_Client &&
            Weapon.Level.TimeDilation != Weapon.Level.default.TimeDilation )
        {
            DoClientOnlyFireEffect();
        }
        HandleRecoil(1.0);
    }

    // KFTODO - Slomo compensation R&D, finish later if I have time - Ramm
    //SetTimer(0.2,False);
}

defaultproperties
{
     FireAimedAnim="AimFire"
     RecoilRate=0.100000
     maxVerticalRecoilAngle=800
     maxHorizontalRecoilAngle=250
     DamageType=Class'BMTCustomMut.DamTypeOutlawWinchester'
     DamageMin=90
     DamageMax=120
     Momentum=18000.000000
     bPawnRapidFireAnim=True
     bModeExclusive=False
     bAttachSmokeEmitter=True
     TransientSoundVolume=1.800000
     FireSound=SoundGroup'KF_RifleSnd.Rifle_Fire'
     NoAmmoSound=Sound'KF_RifleSnd.Rifle_DryFire'
     FireForce="ShockRifleFire"
     FireRate=0.900000
     AmmoClass=Class'KFMod.WinchesterAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=100.000000,Y=100.000000,Z=500.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=10.000000,Y=3.000000,Z=12.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.650000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stKar'
     aimerror=0.000000
     Spread=0.007000
}
