//=============================================================================
// AK47 Inventory class
//=============================================================================
class STG44 extends KFWeapon
	config(user);


var name ReloadHalfAnim;

#exec OBJ LOAD FILE=KillingFloorWeapons.utx
#exec OBJ LOAD FILE=KillingFloorHUD.utx
#exec OBJ LOAD FILE=Inf_Weapons_Foley.uax


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


function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	return AIRating;
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

simulated function bool CanZoomNow()
{
	Return (!FireMode[0].bIsFiring && Instigator!=None && Instigator.Physics!=PHYS_Falling);
}
simulated function ClientReload()
{

if ( bHasAimingMode && bAimingRifle )
{
FireMode[1].bIsFiring = False;

ZoomOut(false);
if( Role < ROLE_Authority)
ServerZoomOut(false);
}

bIsReloading = true;
if ( MagAmmoRemaining > 0 )
{
PlayAnim(ReloadHalfAnim, ReloadAnimRate, 0.1);
}
else
{
PlayAnim(ReloadAnim, ReloadAnimRate, 0.1);
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
     ReloadHalfAnim="Reload_half"
     MagCapacity=30
     ReloadRate=3.750000
     ReloadAnim="Reload_half"
     ReloadAnimRate=0.900000
     FlashBoneName="Muzzle"
     WeaponReloadAnim="Reload_AK47"
     HudImage=Texture'KF1945Tex.HUD.H_stg44'
     SelectedHudImage=Texture'KF1945Tex.HUD.H_stg44H'
     Weight=6.000000
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=60.000000
     bModeZeroCanDryFire=True
     SleeveNum=5
     TraderInfoTexture=Texture'KF1945Tex.HUD.H_stg44'
     PlayerIronSightFOV=90.000000
     ZoomedDisplayFOV=25.000000
     FireModeClass(0)=Class'BMTCustomMut.STG44Fire'
     FireModeClass(1)=Class'BMTCustomMut.BashFireRifle'
     SelectAnim="Draw"
     PutDownAnim="Put_away"
     SelectSound=Sound'KF_AK47Snd.AK47_Select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="A German made Assault Rifle. The Worlds first Assault Rifle. Offers good stopping power with a high rate of fire."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=60.000000
     Priority=5
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=3
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.STG44Pickup'
     PlayerViewOffset=(X=12.000000,Z=7.000000)
     BobDamping=0.800000
     AttachmentClass=Class'BMTCustomMut.STG44Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="STG44"
     Mesh=SkeletalMesh'KF1945Anim3.STG44-Mesh'
     DrawScale=1.500000
     Skins(0)=Texture'KF1945Tex.ArmsSleeves.hands'
     Skins(1)=Texture'KF1945Tex.ArmsSleeves.GermanCoatSleeves'
     Skins(2)=Texture'KF1945Tex.stg44.stg44'
     TransientSoundVolume=1.250000
}
