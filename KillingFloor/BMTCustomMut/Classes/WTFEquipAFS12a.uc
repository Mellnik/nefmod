class WTFEquipAFS12a extends KFWeapon;
  
// Use alt fire to switch fire modes
simulated function AltFire(float F)
{
    if(ReadyToFire(0))
    {
        DoToggle();
    }
}

exec function SwitchModes()
{
	DoToggle();
}

simulated function WeaponTick(float dt)
{
	local float LastSeenSeconds,ReloadMulti;

    if( bForceLeaveIronsights )
    {
    	ZoomOut(true);

    	if( Role < ROLE_Authority)
			ServerZoomOut(false);

        bForceLeaveIronsights = false;
    }

    if( ForceZoomOutTime > 0 )
    {
        if( bAimingRifle )
        {
    	    if( Level.TimeSeconds - ForceZoomOutTime > 0 )
    	    {
                ForceZoomOutTime = 0;

            	ZoomOut(true);

            	if( Role < ROLE_Authority)
        			ServerZoomOut(false);
    		}
		}
		else
		{
            ForceZoomOutTime = 0;
		}
	}

	 if ( (Level.NetMode == NM_Client) || Instigator == None || KFFriendlyAI(Instigator.Controller) == none && Instigator.PlayerReplicationInfo == None)
		return;

	// Turn it off on death  / battery expenditure
	if (FlashLight != none)
	{
		// Keep the 1Pweapon client beam up to date.
		AdjustLightGraphic();
		if (FlashLight.bHasLight)
		{
			if (Instigator.Health <= 0 || KFHumanPawn(Instigator).TorchBatteryLife <= 0 || Instigator.PendingWeapon != none )
			{
				//Log("Killing Light...you're out of batteries, or switched / dropped weapons");
				KFHumanPawn(Instigator).bTorchOn = false;
				ServerSpawnLight();
			}
		}
	}

	UpdateMagCapacity(Instigator.PlayerReplicationInfo);

	if(!bIsReloading)
	{
		if(!Instigator.IsHumanControlled())
		{
			LastSeenSeconds = Level.TimeSeconds - Instigator.Controller.LastSeenTime;
			if(MagAmmoRemaining == 0 || ((LastSeenSeconds >= 5 || LastSeenSeconds > MagAmmoRemaining) && MagAmmoRemaining < MagCapacity))
				ReloadMeNow();
		}
	}
	else
	{
		if((Level.TimeSeconds - ReloadTimer) >= ReloadRate)
		{
			if(AmmoAmount(0) <= MagCapacity && !bHoldToReload)
			{
				MagAmmoRemaining = AmmoAmount(0);
				ActuallyFinishReloading();
			}
			else
			{
				if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
				{
					ReloadMulti = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.GetReloadSpeedModifier(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo), self);
				}
				else
				{
					ReloadMulti = 1.0;
				}

				AddReloadedAmmo();

				if( bHoldToReload )
                {
                    NumLoadedThisReload++;
                }

				if(MagAmmoRemaining < MagCapacity && MagAmmoRemaining < AmmoAmount(0) && bHoldToReload)
					ReloadTimer = Level.TimeSeconds;
				if(MagAmmoRemaining >= MagCapacity || MagAmmoRemaining >= AmmoAmount(0) || !bHoldToReload || bDoSingleReload)
					ActuallyFinishReloading();
				else if( Level.NetMode!=NM_Client )
					Instigator.SetAnimAction(WeaponReloadAnim);
			}
		}
		else if(bIsReloading && !bReloadEffectDone && Level.TimeSeconds - ReloadTimer >= ReloadRate / 2)
		{
			bReloadEffectDone = true;
			ClientReloadEffects();
		}
	}
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
     MagCapacity=20
     ReloadRate=3.133000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_AA12"
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'KillingFloor2HUD.Trader_Weapon_Icons.Trader_AA12'
     bIsTier3Weapon=True
     MeshRef="KF_Weapons2_Trip.AA12_Trip"
     SkinRefs(0)="WTFTex.AFS12"
     SelectSoundRef="KF_AA12Snd.AA12_Select"
     HudImageRef="KillingFloor2HUD.WeaponSelect.AA12_unselected"
     SelectedHudImageRef="KillingFloor2HUD.WeaponSelect.AA12"
     PlayerIronSightFOV=80.000000
     ZoomedDisplayFOV=45.000000
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipAFS12Fire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="An advanced automatic shotgun. Fires Shotgun Shells Or Explosive Rounds."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=65.000000
     Priority=200
     InventoryGroup=4
     GroupOffset=10
     PickupClass=Class'BMTCustomMut.WTFEquipAFS12Pickup'
     PlayerViewOffset=(X=25.000000,Y=20.000000,Z=-2.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.WTFEquipAFS12Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="AFS12 profession"
     AmbientGlow=25
     TransientSoundVolume=1.250000
}
