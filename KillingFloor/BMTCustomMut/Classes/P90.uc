class P90 extends KFWeapon;

#exec OBJ LOAD FILE=..\Textures\P90_T.utx
#exec OBJ LOAD FILE=..\Animations\P90_A.ukx
#exec OBJ LOAD FILE=..\StaticMeshes\P90_SM.usx
#exec OBJ LOAD FILE=..\Sounds\P90_Snd.uax

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
     MagCapacity=50
     ReloadRate=3.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     FlashBoneName="pasted__tip"
     WeaponReloadAnim="Reload_BullPup"
     HudImage=Texture'P90_T.Trader_P90_unselected'
     SelectedHudImage=Texture'P90_T.Trader_P90_selected'
     Weight=7.000000
     bHasAimingMode=True
     IdleAimAnim="Idle"
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     SleeveNum=4
     TraderInfoTexture=Texture'P90_T.Trader_P90'
     bIsTier2Weapon=True
     PlayerIronSightFOV=70.000000
     ZoomedDisplayFOV=50.000000
     FireModeClass(0)=Class'BMTCustomMut.P90Fire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="Putaway"
     SelectSound=Sound'P90_Snd.P90Cock'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="A classic millitary sub machine gun that holds a 50 bullet magazine."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=70.000000
     Priority=160
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=4
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.P90Pickup'
     PlayerViewOffset=(X=25.000000,Y=22.000000,Z=-6.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.P90Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="P90"
     Mesh=SkeletalMesh'P90_A.P90'
     Skins(0)=Texture'P90_T.P90Hands'
     Skins(1)=Texture'P90_T.P90'
     TransientSoundVolume=100.250000
}
