//=============================================================================
//  MP40 Inventory class
//=============================================================================
class MP40 extends KFWeapon;

var name ReloadHalfAnim;


simulated function bool StartFire(int Mode)
{
	if( Mode == 1 )
		return super.StartFire(Mode);

	if( !super.StartFire(Mode) )  // returns false when mag is empty
	   return false;

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
    local name anim;
    local float frame, rate;

	if(!FireMode[0].IsInState('FireLoop'))
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
     MagCapacity=32
     ReloadRate=3.166000
     ReloadAnim="Reload_half"
     ReloadAnimRate=1.000000
     FlashBoneName="Muzzle"
     WeaponReloadAnim="Reload_MP7"
     HudImage=Texture'KF1945Tex.HUD.H_mp40'
     SelectedHudImage=Texture'KF1945Tex.HUD.H_mp40H'
     Weight=4.000000
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=60.000000
     bModeZeroCanDryFire=True
     SleeveNum=3
     TraderInfoTexture=Texture'KF1945Tex.HUD.H_mp40'
     PlayerIronSightFOV=90.000000
     ZoomedDisplayFOV=35.000000
     FireModeClass(0)=Class'BMTCustomMut.MP40Fire'
     FireModeClass(1)=Class'BMTCustomMut.BashFireSMG'
     PutDownAnim="Putaway"
     SelectSound=Sound'KF_MP7Snd.MP7_Select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="A German Submachine gun with a 30 round magazine chambered for 9mm parabellum. Compact and easy to wield."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=55.000000
     Priority=10
     InventoryGroup=4
     GroupOffset=8
     PickupClass=Class'BMTCustomMut.MP40Pickup'
     PlayerViewOffset=(X=12.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BMTCustomMut.MP40Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="MP40"
     Mesh=SkeletalMesh'KF1945Anim3.mp40-mesh'
     Skins(0)=Texture'KF1945Tex.ArmsSleeves.hands'
     Skins(1)=Texture'KF1945Tex.ArmsSleeves.german_sleeves'
     Skins(2)=Shader'KF1945Tex.mp40.MP40Final'
     TransientSoundVolume=1.250000
}
