class WTFEquipBoomStick extends BoomStick;

simulated function WeaponTick(float dt)
{
    super(KFWeaponShotgun).WeaponTick(dt);

    if( bWaitingToLoadShotty )
    {
        CurrentReloadCountDown -= dt;

        if( CurrentReloadCountDown <= 0 )
        {
            bWaitingToLoadShotty = false;
			bIsReloading = false; //set this here for the custom reload/shell swap functionality

            if( AmmoAmount(0) > 0 )
            {
                MagAmmoRemaining = Min(AmmoAmount(0), 2);
                SingleShotCount = MagAmmoRemaining;
                ClientSetSingleShotCount(SingleShotCount);
                NetUpdateTime = Level.TimeSeconds - 1;
            }
        }
    }
}

function bool AllowReload()
{
	local KFPlayerReplicationInfo KFPRI;
	local WTFEquipBoomStickAltFire FM0;
	local WTFEquipBoomStickFire FM1;
	
	if (super(KFWeapon).AllowReload())
	{
		SetPendingReload();
		return true;
	}
	else if (!bIsReloading && (MagAmmoRemaining >= MagCapacity) && !IsFiring())
	{
		KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
		if (KFPRI == none || KFPRI.ClientVeteranSkill != Class'BMTCustomMut.WTFPerksSupportSpec')
			return false;
			
		FM0 = WTFEquipBoomStickAltFire(FireMode[0]);
		FM1 = WTFEquipBoomStickFire(FireMode[1]);
		
		if ( FM0.GetShellType() == 1 )
		{
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(class'BMTCustomMut.WTFEquipBoomstickSwitchMessage',0); //loading slugs
			FM0.SetShellType(0);
			FM1.SetShellType(0);
		}
		else
		{
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(class'BMTCustomMut.WTFEquipBoomstickSwitchMessage',1); //loading shot
			FM0.SetShellType(1);
			FM1.SetShellType(1);
		}
		SetPendingReload();
		return true;
	}
	return false;
}

simulated function SuperMaxOutAmmo()
{
	if ( bNoAmmoInstances )
	{
		if ( AmmoClass[0] != None )
			AmmoCharge[0] = 10000;
		if ( (AmmoClass[1] != None) && (AmmoClass[0] != AmmoClass[1]) )
			AmmoCharge[1] = 10000;
		return;
	}
	if ( Ammo[0] != None )
		Ammo[0].AmmoAmount = 10000;
	if ( Ammo[1] != None )
		Ammo[1].AmmoAmount = 10000;
}

defaultproperties
{
     ReloadRate=30.000000
     ReloadAnim="Fire_Last"
     WeaponReloadAnim="Fire_Last"
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipBoomStickAltFire'
     FireModeClass(1)=Class'BMTCustomMut.WTFEquipBoomStickFire'
     PickupClass=Class'BMTCustomMut.WTFEquipBoomStickPickup'
     ItemName="BOOMSTICK profession"
}
