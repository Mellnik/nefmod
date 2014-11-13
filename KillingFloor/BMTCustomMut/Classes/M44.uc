class M44 extends KFWeapon;

#exec OBJ LOAD FILE=KillingFloorWeapons.utx
#exec OBJ LOAD FILE=KillingFloorHUD.utx
#exec OBJ LOAD FILE=Inf_Weapons_Foley.uax

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
			Player.ReceiveLocalizedMessage(class'BMTCustomMut.M44SwitchMessage',0);
		else Player.ReceiveLocalizedMessage(class'BMTCustomMut.M44SwitchMessage',1);
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
     ReloadRate=3.000000
     ReloadAnim="Reload"
     ReloadAnimRate=0.900000
     FlashBoneName="Muzzle"
     WeaponReloadAnim="Reload_M4"
     HudImage=Texture'KF1945Tex.HUD.H_nagantm44'
     SelectedHudImage=Texture'KF1945Tex.HUD.H_nagantm44H'
     Weight=5.000000
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     SleeveNum=0
     TraderInfoTexture=Texture'KF1945Tex.HUD.H_nagantm44'
     PlayerIronSightFOV=32.000000
     ZoomedDisplayFOV=50.000000
     FireModeClass(0)=Class'BMTCustomMut.M44Fire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KF_AK47Snd.AK47_Select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.650000
     CurrentRating=0.650000
     Description="M44 Assault Rifle With Bayonet Attachment."
     DisplayFOV=65.000000
     Priority=100
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=3
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.M44Pickup'
     PlayerViewOffset=(X=14.000000,Y=7.000000,Z=-4.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.M44Attachment'
     IconCoords=(X1=253,Y1=146,X2=333,Y2=181)
     ItemName="M44 Assault Rifle"
     Mesh=SkeletalMesh'KF1945Anim3.Mosin_Nagant_M44'
     DrawScale=2.000000
     Skins(0)=Texture'KF1945Tex.ArmsSleeves.hands_gergloves'
     Skins(1)=Texture'KF1945Tex.ArmsSleeves.german_sleeves'
     Skins(2)=Texture'KF1945Tex.Nagant.nagant9138'
     Skins(3)=Texture'KF1945Tex.Nagant.Stripper_Mesh_MN'
     Skins(4)=Texture'KF1945Tex.Nagant.m44stuff'
}
