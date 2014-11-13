class Bizon extends KFWeapon
	config(user);

#exec OBJ LOAD FILE="..\Animations\Bizon_A.ukx"

// Use alt fire to switch fire modes
simulated function AltFire(float F)
{
    if(ReadyToFire(0))
    {
        DoToggle();
    }
}

// Toggle semi/auto fire
simulated function DoToggle ()
{
	local PlayerController Player;

	Player = Level.GetLocalPlayerController();
	if ( Player!=None )
	{
		//PlayOwnedSound(sound'Inf_Weapons_Foley.stg44_firemodeswitch01',SLOT_None,2.0,,,,false);
		FireMode[0].bWaitForRelease = !FireMode[0].bWaitForRelease;
		if ( FireMode[0].bWaitForRelease )
			Player.ReceiveLocalizedMessage(class'KFmod.BullpupSwitchMessage',0);
		else Player.ReceiveLocalizedMessage(class'KFmod.BullpupSwitchMessage',1);
	}
	Super.DoToggle();

	ServerChangeFireMode(FireMode[0].bWaitForRelease);
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

defaultproperties
{
     MagCapacity=53
     ReloadRate=3.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_AK47"
     HudImage=Texture'Bizon_A.Bizon_Unselected'
     SelectedHudImage=Texture'Bizon_A.Bizon_selected'
     Weight=5.000000
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     SleeveNum=2
     TraderInfoTexture=Texture'Bizon_A.Bizon_Trader'
     bIsTier2Weapon=True
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=32.000000
     FireModeClass(0)=Class'BMTCustomMut.BizonFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectAnimRate=1.000000
     BringUpTime=0.930000
     SelectSound=Sound'Bizon_A.Bizon_select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="A Light Machine Gun With Explosive Rounds."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=65.000000
     Priority=100
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=3
     GroupOffset=7
     PickupClass=Class'BMTCustomMut.BizonPickup'
     PlayerViewOffset=(X=14.000000,Y=10.000000,Z=-4.000000)
     BobDamping=5.000000
     AttachmentClass=Class'BMTCustomMut.BizonAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="Bizon"
     Mesh=SkeletalMesh'Bizon_A.Bizonmesh'
     Skins(0)=Texture'Bizon_A.wpn_bizon_mag'
     Skins(1)=Texture'Bizon_A.wpn_bizon_rec'
     Skins(2)=Combiner'KF_Weapons_Trip_T.hands.hands_1stP_military_cmb'
     TransientSoundVolume=1.250000
}
