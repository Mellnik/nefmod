class WTFFlamer extends KFWeapon;

simulated function bool StartFire(int Mode)
{
	if( !super(KFWeapon).StartFire(Mode) )  // returns false when mag is empty
	{
		return false;
	}
	
	if( AmmoAmount(0) <= 0 )
	{
    	return false;
    }

	AnimStopLooping();

	if( !FireMode[Mode].IsInState('FireLoop') && (AmmoAmount(0) > 0) )
	{
		FireMode[Mode].StartFiring();
		return true;
	}
	else
	{
		return false;
	}

	return true;
}

simulated function AnimEnd(int channel)
{
	if(!FireMode[0].IsInState('FireLoop'))
	{
	  	Super.AnimEnd(channel);
	}
}

// Cool Nozzle Illumination (WARNING -  Artist at play) :P
simulated function WeaponTick(float dt)
{
  Super.WeaponTick(dt);

//  if(FireMode[0].bIsFiring)
//    Skins[4] = Shader 'KillingFloorWeapons.FlameThrower.FTFireShader';
//  else
//    Skins[4] = default.Skins[4];
}

function bool RecommendRangedAttack()
{
	return true;
}

function float SuggestAttackStyle()
{
	return -1.0;
}

//TODO: LONG ranged?
function bool RecommendLongRangedAttack()
{
	return true;
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
     MagCapacity=100
     ReloadRate=4.140000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Flamethrower"
     MinimumFireRange=300
     bSteadyAim=True
     Weight=8.000000
     bHasAimingMode=True
     IdleAimAnim="Idle"
     QuickPutDownTime=0.500000
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Flame_Thrower'
     bIsTier2Weapon=True
     MeshRef="KF_Weapons_Trip.Flamethrower_Trip"
     SkinRefs(0)="KF_Weapons_Trip_T.Supers.flamethrower_cmb"
     SkinRefs(2)="KillingFloorWeapons.Welder.FBFlameOrange"
     HudImageRef="KillingFloorHUD.WeaponSelect.FlameThrower_unselected"
     SelectedHudImageRef="KillingFloorHUD.WeaponSelect.FlameThrower"
     ZoomInRotation=(Pitch=-1000,Roll=1500)
     ZoomedDisplayFOV=70.000000
     FireModeClass(0)=Class'BMTCustomMut.WTFFlamerFire'
     FireModeClass(1)=Class'BMTCustomMut.WTFFlamerFireSpray'
     PutDownAnim="PutDown"
     PutDownAnimRate=1.000000
     PutDownTime=1.000000
     AIRating=0.700000
     CurrentRating=0.700000
     AmmoClass(0)=Class'BMTCustomMut.WTFFlamerAmmo'
     Description="Advanced Flamethrower!"
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=70.000000
     Priority=145
     InventoryGroup=4
     GroupOffset=8
     PickupClass=Class'BMTCustomMut.WTFFlamerPickup'
     PlayerViewOffset=(X=5.000000,Y=7.000000,Z=-8.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.WTFFlamerAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="Advanced Flamethrower!"
     DrawScale=0.900000
     TransientSoundVolume=1.250000
}
