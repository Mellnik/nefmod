class Force extends KFWeapon;

var () float AmmoRegenRate;
var () int HealBoostAmount;
Const MaxAmmoCount=500;
var float RegenTimer;

simulated function MaxOutAmmo()
{
	AmmoCharge[0] = MaxAmmoCount;
}
simulated function int MaxAmmo(int mode)
{
	Return MaxAmmoCount;
}
simulated function FillToInitialAmmo()
{
	AmmoCharge[0] = MaxAmmoCount;
}
simulated function int AmmoAmount(int mode)
{
	Return AmmoCharge[0];
}
simulated function bool AmmoMaxed(int mode)
{
	Return AmmoCharge[0]>=MaxAmmoCount;
}
simulated function GetAmmoCount(out float MaxAmmoPrimary, out float CurAmmoPrimary)
{
	MaxAmmoPrimary = MaxAmmoCount;
	CurAmmoPrimary = AmmoCharge[0];
}
simulated function float AmmoStatus(optional int Mode) // returns float value for ammo amount
{
	Return float(AmmoCharge[0])/float(MaxAmmoCount);
}
simulated function bool ConsumeAmmo(int Mode, float load, optional bool bAmountNeededIsMax)
{
	if( Load>AmmoCharge[0] )
		Return False;
	AmmoCharge[0]-=Load;
	Return True;
}
function bool AddAmmo(int AmmoToAdd, int Mode)
{
	if( AmmoCharge[0]<MaxAmmoCount )
	{
		AmmoCharge[0]+=AmmoToAdd;
		if( AmmoCharge[0]>MaxAmmoCount )
			AmmoCharge[0] = MaxAmmoCount;
	}
	Return False;
}
simulated function bool HasAmmo()
{
	Return (AmmoCharge[0]>0);
}
simulated function CheckOutOfAmmo()
{
	if( AmmoCharge[0]<=0 )
		OutOfAmmo();
}

simulated function float RateSelf()
{
	return -100;
}

simulated function Tick(float dt)
{
	if ( Level.NetMode!=NM_Client && AmmoCharge[0]<MaxAmmoCount && RegenTimer<Level.TimeSeconds )
	{
		RegenTimer = Level.TimeSeconds + AmmoRegenRate;
		AmmoCharge[0] += 10;
		

		if ( AmmoCharge[0] > MaxAmmoCount )
		{
			AmmoCharge[0] = MaxAmmoCount;
		}
	}
}

simulated function bool HackClientStartFire()
{
	if( StartFire(1) )
	{
		if( Role<ROLE_Authority )
			ServerStartFire(1);
		FireMode[1].ModeDoFire(); // Force to start animating.
		return true;
	}
	return false;
}
simulated function float ChargeBar()
{
	return FClamp(float(AmmoCharge[0])/float(MaxAmmoCount),0,1);
}

defaultproperties
{
     AmmoRegenRate=0.100000
     bSpeedMeUp=True
     bAmmoHUDAsBar=True
     IdleAimAnim="Idle"
     StandardDisplayFOV=65.000000
     SleeveNum=0
     PlayerIronSightFOV=70.000000
     ZoomedDisplayFOV=40.000000
     FireModeClass(0)=Class'BMTCustomMut.ForceFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     AIRating=0.600000
     CurrentRating=0.600000
     bMeleeWeapon=True
     bShowChargingBar=True
     Description="The Force."
     DisplayFOV=65.000000
     Priority=135
     InventoryGroup=3
     PickupClass=Class'BMTCustomMut.ForcePickup'
     PlayerViewOffset=(X=10.000000,Y=-5.750000,Z=2.500000)
     BobDamping=7.000000
     AttachmentClass=Class'BMTCustomMut.ForceAttachment'
     IconCoords=(Y1=172,X2=245,Y2=208)
     ItemName="The Force"
     LightType=LT_None
     LightBrightness=0.000000
     LightRadius=0.000000
     TransientSoundVolume=1.000000
}
