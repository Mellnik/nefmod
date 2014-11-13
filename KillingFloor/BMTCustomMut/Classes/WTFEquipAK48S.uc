class WTFEquipAK48S extends KFWeapon;

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

simulated function DoToggle()
{
    local PlayerController Player;
    local WTFEquipAK48SFire FM;
    local KFPlayerReplicationInfo KFPRI;
    local byte MyAutoMode;
    local bool bIsCommando;
     
        FM = WTFEquipAK48SFire(FireMode[0]);
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
function ServerChangeAutoMode(int NewMode, bool bSemiAuto)
{
	WTFEquipAK48SFire(FireMode[0]).AutoMode = NewMode;
	WTFEquipAK48SFire(FireMode[0]).bWaitForRelease = bSemiAuto;
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

// Set the new fire mode on the server
function ServerSetAutoMode( byte NewMode )
{
    PlayOwnedSound(ToggleSound,SLOT_None,2.0,,,,false);
    WTFEquipAK48SFire(FireMode[0]).SetAutoMode(NewMode);
}

defaultproperties
{
     MagCapacity=30
     ReloadRate=3.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_AK47"
     Weight=6.000000
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=60.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'KillingFloor2HUD.Trader_Weapon_Icons.Trader_AK_47'
     bIsTier2Weapon=True
     MeshRef="KF_Weapons2_Trip.AK47_Trip"
     SkinRefs(0)="KF_Weapons2_Trip_T.Rifles.AK47_cmb"
     SelectSoundRef="KF_AK47Snd.AK47_Select"
     HudImageRef="KillingFloor2HUD.WeaponSelect.Ak_47_unselected"
     SelectedHudImageRef="KillingFloor2HUD.WeaponSelect.Ak_47"
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=32.000000
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipAK48SFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="A classic Russian assault rifle. Can be fired in semi or full auto with nice knock down power but not great accuracy."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=60.000000
     Priority=95
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=3
     GroupOffset=7
     PickupClass=Class'BMTCustomMut.WTFEquipAK48SPickup'
     PlayerViewOffset=(X=18.000000,Y=22.000000,Z=-6.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.WTFEquipAK48SAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="AK48S profession"
     TransientSoundVolume=1.250000
}
