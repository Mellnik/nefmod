class Tech_PlasmaCutter extends KFWeapon;

static function PreloadAssets(Inventory Inv, optional bool bSkipRefCount)
{
    local int i;

    if ( !bSkipRefCount )
    {
        default.ReferenceCount++;
    }

    UpdateDefaultMesh(SkeletalMesh(DynamicLoadObject(default.MeshRef, class'SkeletalMesh')));
    default.HudImage = texture(DynamicLoadObject(default.HudImageRef, class'texture'));
    default.SelectedHudImage = texture(DynamicLoadObject(default.SelectedHudImageRef, class'texture'));
    default.SelectSound = sound(DynamicLoadObject(default.SelectSoundRef, class'sound'));

    for ( i = 0; i < default.SkinRefs.Length; i++ )
    {
        default.Skins[i] = Material(DynamicLoadObject(default.SkinRefs[i], class'Material'));
    }

    if ( KFWeapon(Inv) != none )
    {
        Inv.LinkMesh(default.Mesh);
        KFWeapon(Inv).HudImage = default.HudImage;
        KFWeapon(Inv).SelectedHudImage = default.SelectedHudImage;
        KFWeapon(Inv).SelectSound = default.SelectSound;

        for ( i = 0; i < default.SkinRefs.Length; i++ )
        {
            Inv.Skins[i] = default.Skins[i];
        }
    }
}

static function bool UnloadAssets()
{
    local int i;

    default.ReferenceCount--;
    log("UnloadAssets RefCount after: " @ default.ReferenceCount);

    UpdateDefaultMesh(none);
    default.HudImage = none;
    default.SelectedHudImage = none;

    for ( i = 0; i < default.SkinRefs.Length; i++ )
    {
        default.Skins[i] = none;
    }

    return default.ReferenceCount == 0;
}


simulated function WeaponTick(float dt)
{
	local float LastSeenSeconds,ReloadMulti;

//	if( bHasAimingMode && Instigator != none && Instigator.IsLocallyControlled() )
//	{
//		if ( bAimingRifle && Instigator!=None && Instigator.Physics==PHYS_Falling )
//		{
//			IronSightZoomOut();
//		}
//	}

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

defaultproperties
{
     MagCapacity=20
     ReloadRate=2.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     FlashBoneName="MainTip"
     WeaponReloadAnim="Reload_Single9mm"
     HudImage=Texture'SentryTechTex1.Trader_PlasmaCutter_unselected'
     SelectedHudImage=Texture'SentryTechTex1.Trader_PlasmaCutter_selected'
     Weight=3.000000
     bHasAimingMode=True
     IdleAimAnim="Idle"
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'SentryTechTex1.Trader_PlasmaCutter'
     bIsTier2Weapon=True
     MeshRef="SentryTechAnim1.PlasmaCutter"
     HudImageRef="SentryTechTex1.Trader_PlasmaCutter_unselected"
     SelectedHudImageRef="SentryTechTex1.Trader_PlasmaCutter_selected"
     ZoomedDisplayFOV=92.000000
     FireModeClass(0)=Class'BMTCustomMut.Tech_PlasmaCutterFireVert'
     FireModeClass(1)=Class'BMTCustomMut.Tech_PlasmaCutterFireHorz'
     PutDownAnim="PutDown"
     SelectSound=Sound'KF_HandcannonSnd.50AE_Select'
     AIRating=0.450000
     CurrentRating=0.450000
     bShowChargingBar=True
     Description="Isaac Clarke's weapon of choice in the Dead Space series."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-5.000000)
     DisplayFOV=60.000000
     Priority=100
     InventoryGroup=2
     GroupOffset=3
     PickupClass=Class'BMTCustomMut.Tech_PlasmaCutterPickup'
     PlayerViewOffset=(X=20.000000,Y=25.000000,Z=-10.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.Tech_PlasmaCutterAttachment'
     IconCoords=(X1=250,Y1=110,X2=330,Y2=145)
     ItemName="Plasma Cutter"
     bUseDynamicLights=True
     Mesh=SkeletalMesh'SentryTechAnim1.PlasmaCutter'
     Skins(0)=Combiner'SentryTechTex1.PlasmaCutter_cmb'
     Skins(2)=FinalBlend'SentryTechTex1.LaserFX.Laser3Final'
     TransientSoundVolume=1.000000
}
