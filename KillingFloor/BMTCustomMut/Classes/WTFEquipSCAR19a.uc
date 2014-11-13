class WTFEquipSCAR19a extends KFWeapon;

replication
{
	 reliable if(Role < ROLE_Authority)
        ServerSetAutoMode;
}

// Use alt fire to switch fire modes
simulated function AltFire(float F)
{
    if(ReadyToFire(0))
    DoToggle();
}

simulated function DoToggle ()
{
	local PlayerController Player;
	local WTFEquipSCAR19Fire FM;
	local KFPlayerReplicationInfo KFPRI;
	local byte MyAutoMode;
	local bool bIsCommando;
     
        FM = WTFEquipSCAR19Fire(FireMode[0]);
        MyAutoMode = FM.AutoMode;
        KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
        bIsCommando = (KFPRI != none && KFPRI.ClientVeteranSkill == Class'WTFPerksCommando');
        Player = Level.GetLocalPlayerController();
     
        MyAutoMode++;
        if(MyAutoMode >= 3 || (MyAutoMode >=2 && !bIsCommando) )
                MyAutoMode = 0;
     
        if ( Player!=None )
            Player.ReceiveLocalizedMessage(class'BMTCustomMut.WTFEquipBulldogSwitchMessage', MyAutoMode);
            PlayOwnedSound(ToggleSound,SLOT_None,2.0,,,,false);
            FM.SetAutoMode(MyAutoMode);
     
        if( Level.NetMode==NM_Client ) // tell server of firemode change.
            ServerSetAutoMode(MyAutoMode);
}

// Set the new fire mode on the server
function ServerSetAutoMode( byte NewMode )
{
            PlayOwnedSound(ToggleSound,SLOT_None,2.0,,,,false);
            WTFEquipSCAR19Fire(FireMode[0]).SetAutoMode(NewMode);
}

// Set the new fire mode on the server
function ServerChangeFireMode(bool bNewWaitForRelease)
{
    FireMode[0].bWaitForRelease = bNewWaitForRelease;
}

function bool RecommendRangedAttack()
{
	return true;
}

//TODO: LONG ranged?
function bool RecommendLongRangedAttack()
{
	return true;
}

function float SuggestAttackStyle()
{
	return -1.0;
}

exec function SwitchModes()
{
	DoToggle();
}

function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	return AIRating;
}

function byte BestMode()
{
	return 0;
}

simulated function SetZoomBlendColor(Canvas c)
{
	local Byte    val;
	local Color   clr;
	local Color   fog;

	clr.R = 255;
	clr.G = 255;
	clr.B = 255;
	clr.A = 255;

	if( Instigator.Region.Zone.bDistanceFog )
	{
		fog = Instigator.Region.Zone.DistanceFogColor;
		val = 0;
		val = Max( val, fog.R);
		val = Max( val, fog.G);
		val = Max( val, fog.B);
		if( val > 128 )
		{
			val -= 128;
			clr.R -= val;
			clr.G -= val;
			clr.B -= val;
		}
	}
	c.DrawColor = clr;
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
     ReloadRate=2.966000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_SCAR"
     Weight=5.000000
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=55.000000
     bModeZeroCanDryFire=True
     SleeveNum=2
     TraderInfoTexture=Texture'KillingFloor2HUD.Trader_Weapon_Icons.Trader_Scar'
     bIsTier3Weapon=True
     MeshRef="KF_Weapons2_Trip.SCAR_Trip"
     SkinRefs(0)="KF_Weapons2_Trip_T.Rifle.Scar_cmb"
     SkinRefs(1)="KF_Weapons2_Trip_T.Special.Aimpoint_sight_shdr"
     SelectSoundRef="KF_SCARSnd.SCAR_Select"
     HudImageRef="KillingFloor2HUD.WeaponSelect.Scar_unselected"
     SelectedHudImageRef="KillingFloor2HUD.WeaponSelect.Scar"
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=20.000000
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipSCAR19Fire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="An advanced tactical assault rifle. Fires in semi or full auto with great power and accuracy."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=55.000000
     Priority=175
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=4
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.WTFEquipSCAR19Pickup'
     PlayerViewOffset=(X=25.000000,Y=20.000000,Z=-6.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.WTFEquipSCAR19Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="SCAR19 profession"
     TransientSoundVolume=1.250000
}
