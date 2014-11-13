//--------------------------------------//
//Weapon Import to kf by Exod (erick610)//
//--------------------------------------//
class Stinger extends KFWeapon
	config(user);

#exec OBJ LOAD FILE=Stinger_A.ukx
#exec OBJ LOAD FILE=Stinger_Snd.uax
#exec OBJ LOAD FILE=Stinger_SM.usx
#exec OBJ LOAD FILE=Stinger_T.utx

simulated function HandleSleeveSwapping();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    
}
    
simulated function bool StartFire(int Mode)
{
    if( !super.StartFire(Mode) )  // returns false when mag is empty
       return false;

    if( AmmoAmount(Mode) <= 0 )
        return false;

    AnimStopLooping();

    if( !FireMode[Mode].IsInState('FireLoop') ) {
        FireMode[Mode].StartFiring();
        return true;
    }
    return false;            
}




simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

	if( !FireMode[0].IsInState('FireLoop') && !FireMode[1].IsInState('FireLoop') )
	{
        GetAnimParams(0, anim, frame, rate);

        if (ClientState == WS_ReadyToFire)
        {
             if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))
            {
                PlayIdle();
            }
        }
	}
}


simulated function bool ConsumeAmmo( int Mode, float Load, optional bool bAmountNeededIsMax )
{
	local Inventory Inv;
	local bool bOutOfAmmo;
	local KFWeapon KFWeap;

	if ( Super(Weapon).ConsumeAmmo(Mode, Load, bAmountNeededIsMax) )
	{
		if ( Load > 0 && (Mode == 0 || bReduceMagAmmoOnSecondaryFire) ) {
			MagAmmoRemaining -= Load; // Changed from "MagAmmoRemaining--"  -- PooSH
            if ( MagAmmoRemaining < 0 )
                MagAmmoRemaining = 0;
        }

		NetUpdateTime = Level.TimeSeconds - 1;

		if ( FireMode[Mode].AmmoPerFire > 0 && InventoryGroup > 0 && !bMeleeWeapon && bConsumesPhysicalAmmo &&
			 (Ammo[0] == none || FireMode[0] == none || FireMode[0].AmmoPerFire <= 0 || Ammo[0].AmmoAmount < FireMode[0].AmmoPerFire) &&
			 (Ammo[1] == none || FireMode[1] == none || FireMode[1].AmmoPerFire <= 0 || Ammo[1].AmmoAmount < FireMode[1].AmmoPerFire) )
		{
			bOutOfAmmo = true;

			for ( Inv = Instigator.Inventory; Inv != none; Inv = Inv.Inventory )
			{
				KFWeap = KFWeapon(Inv);

				if ( Inv.InventoryGroup > 0 && KFWeap != none && !KFWeap.bMeleeWeapon && KFWeap.bConsumesPhysicalAmmo &&
					 ((KFWeap.Ammo[0] != none && KFWeap.FireMode[0] != none && KFWeap.FireMode[0].AmmoPerFire > 0 &&KFWeap.Ammo[0].AmmoAmount >= KFWeap.FireMode[0].AmmoPerFire) ||
					 (KFWeap.Ammo[1] != none && KFWeap.FireMode[1] != none && KFWeap.FireMode[1].AmmoPerFire > 0 && KFWeap.Ammo[1].AmmoAmount >= KFWeap.FireMode[1].AmmoPerFire)) )
				{
					bOutOfAmmo = false;
					break;
				}
			}

			if ( bOutOfAmmo )
			{
				PlayerController(Instigator.Controller).Speech('AUTO', 3, "");
			}
		}

		return true;
	}
	return false;
}

// since we don't have 'Tip' bone, need this hack
simulated function vector GetEffectStart()
{
    return super(Weapon).GetEffectStart();
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
     MagCapacity=175
     ReloadRate=3.636190
     ReloadAnim="WeaponPutDown"
     ReloadAnimRate=0.250000
     FlashBoneName="Stinger-TurretMini"
     WeaponReloadAnim="Reload_AA12"
     HudImage=Texture'Stinger_T.Stinger.Unselected_Stinger'
     SelectedHudImage=Texture'Stinger_T.Stinger.Selected_Stinger'
     Weight=12.000000
     IdleAimAnim="WeaponIdle"
     StandardDisplayFOV=55.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'Stinger_T.Stinger.Trader_Stinger'
     bIsTier3Weapon=True
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=20.000000
     FireModeClass(0)=Class'BMTCustomMut.StingerFire'
     FireModeClass(1)=Class'BMTCustomMut.StingerAltFire'
     IdleAnim="WeaponIdle"
     PutDownAnim="WeaponPutDown"
     SelectSound=Sound'Stinger_Snd.Stinger.StingerTakeOut'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="Shut up and kill'em."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-5.000000)
     DisplayFOV=55.000000
     Priority=140
     SmallEffectOffset=(X=100.000000,Y=25.000000,Z=-5.000000)
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=4
     GroupOffset=7
     PickupClass=Class'BMTCustomMut.StingerPickup'
     PlayerViewOffset=(X=50.000000,Y=-4.000000,Z=-4.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.StingerAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="Stinger Minigun"
     Mesh=SkeletalMesh'Stinger_A.SK_WP_Stinger_1P'
     Skins(0)=Shader'Stinger_T.Stinger.StingerSkin'
     Skins(1)=Texture'Stinger_T.T_WP_StingerCord_D'
}
