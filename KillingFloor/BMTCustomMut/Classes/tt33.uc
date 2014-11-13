//=============================================================================
// TT33 Inventory class
//=============================================================================
class TT33 extends KFWeapon
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
     MagCapacity=8
     ReloadRate=2.200000
     ReloadAnim="Reload_empty"
     ReloadAnimRate=1.000000
     FlashBoneName="Muzzle"
     WeaponReloadAnim="Reload_AK47"
     HudImage=Texture'KF1945Tex.HUD.H_tt33'
     SelectedHudImage=Texture'KF1945Tex.HUD.H_tt33H'
     Weight=3.000000
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=60.000000
     bModeZeroCanDryFire=True
     SleeveNum=9
     TraderInfoTexture=Texture'KF1945Tex.HUD.H_tt33'
     PlayerIronSightFOV=90.000000
     ZoomedDisplayFOV=40.000000
     FireModeClass(0)=Class'BMTCustomMut.TT33Fire'
     FireModeClass(1)=Class'BMTCustomMut.BashFirePistol'
     SelectAnim="Draw"
     PutDownAnim="Put_away"
     SelectSound=Sound'KF_AK47Snd.AK47_Select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description=" A Soviet pistol produced in large numbers from 1930 onward. "
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=60.000000
     Priority=5
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=2
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.TT33Pickup'
     PlayerViewOffset=(Z=1.500000)
     BobDamping=1.500000
     AttachmentClass=Class'BMTCustomMut.TT33Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="TT33"
     Mesh=SkeletalMesh'KF1945Anim3.TT-33-Mesh'
     DrawScale=2.000000
     Skins(0)=Texture'KF1945Tex.ArmsSleeves.hands'
     Skins(1)=Texture'KF1945Tex.ArmsSleeves.GermanCoatSleeves'
     TransientSoundVolume=1.250000
}
