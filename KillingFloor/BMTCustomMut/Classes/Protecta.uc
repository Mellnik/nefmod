class Protecta extends KFWeaponShotgun;

#exec OBJ LOAD FILE="Protecta_A.ukx"

  
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
     MagCapacity=12
     ReloadRate=0.910000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Shotgun"
     HudImage=Texture'Protecta_A.Protecta_Unselected'
     SelectedHudImage=Texture'Protecta_A.Protecta_selected'
     Weight=8.000000
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     SleeveNum=3
     TraderInfoTexture=Texture'Protecta_A.Protecta_Trader'
     PlayerIronSightFOV=70.000000
     ZoomedDisplayFOV=40.000000
     FireModeClass(0)=Class'BMTCustomMut.ProtectaFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'Protecta_A.striker_select'
     AIRating=0.600000
     CurrentRating=0.600000
     bShowChargingBar=True
     Description="Protecta - is a revolver 12-gauge shotgun designed for riot control and combat."
     DisplayFOV=65.000000
     Priority=199
     InventoryGroup=4
     GroupOffset=9
     PickupClass=Class'BMTCustomMut.ProtectaPickup'
     PlayerViewOffset=(X=18.000000,Y=9.000000,Z=-5.000000)
     BobDamping=5.000000
     AttachmentClass=Class'BMTCustomMut.ProtectaAttachment'
     IconCoords=(X1=169,Y1=172,X2=245,Y2=208)
     ItemName="Protecta"
     Mesh=SkeletalMesh'Protecta_A.Protecta_mesh'
     Skins(0)=Combiner'Protecta_A.Protecta_tex_1_cmb'
     Skins(1)=Combiner'Protecta_A.Protecta_tex_2_cmb'
     Skins(2)=Combiner'Protecta_A.Protecta_tex_3_cmb'
     Skins(3)=Combiner'KF_Weapons_Trip_T.hands.hands_1stP_military_cmb'
     Skins(4)=Shader'KF_Weapons2_Trip_T.Special.Aimpoint_sight_shdr'
     TransientSoundVolume=1.250000
}
