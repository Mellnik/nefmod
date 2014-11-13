class P90DT extends KFWeapon
	config(user);

#exec OBJ LOAD FILE="P90DT_A.ukx"

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
    local P90DTFire FM;
    local KFPlayerReplicationInfo KFPRI;
    local byte MyAutoMode;
    local bool bIsCommando;
     
        FM = P90DTFire(FireMode[0]);
        MyAutoMode = FM.AutoMode;
        KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
        bIsCommando = (KFPRI != none && KFPRI.ClientVeteranSkill == Class'WTFPerksLoser');
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
	P90DTFire(FireMode[0]).AutoMode = NewMode;
	P90DTFire(FireMode[0]).bWaitForRelease = bSemiAuto;
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
    P90DTFire(FireMode[0]).SetAutoMode(NewMode);
}

defaultproperties
{
     MagCapacity=50
     ReloadRate=3.700000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Crossbow"
     HudImage=Texture'P90DT_A.P90_T.P90_Unselected'
     SelectedHudImage=Texture'P90DT_A.P90_T.P90_Selected'
     Weight=5.000000
     bHasAimingMode=True
     IdleAimAnim="IronIdle"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     SleeveNum=2
     TraderInfoTexture=Texture'P90DT_A.P90_T.P90_trader'
     bIsTier2Weapon=True
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=32.000000
     FireModeClass(0)=Class'BMTCustomMut.P90DTFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectAnimRate=1.000000
     SelectSound=Sound'P90DT_A.P90DT_SND.p90_select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="The FN P90 is a selective fire personal defense weapon (PDW) designed and manufactured by FN Herstal in Belgium."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=65.000000
     Priority=160
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=4
     GroupOffset=7
     PickupClass=Class'BMTCustomMut.P90DTPickup'
     PlayerViewOffset=(X=25.500000,Y=11.000000)
     BobDamping=5.000000
     AttachmentClass=Class'BMTCustomMut.P90DTAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="FN P90"
     Mesh=SkeletalMesh'P90DT_A.P90DTMesh'
     Skins(0)=Combiner'P90DT_A.P90_T.P90_tex_cmb'
     Skins(1)=Shader'KF_Weapons2_Trip_T.Special.Aimpoint_sight_shdr'
     Skins(2)=Combiner'KF_Weapons_Trip_T.hands.hands_1stP_military_cmb'
     TransientSoundVolume=1.250000
}
