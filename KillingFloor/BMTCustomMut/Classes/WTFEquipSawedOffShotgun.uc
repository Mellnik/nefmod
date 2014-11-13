class WTFEquipSawedOffShotgun extends WTFEquipBoomStick;

#exec OBJ LOAD FILE=WTFTex2.utx

// can't use slugs with this weapon
function bool AllowReload()
{
	if (super(KFWeapon).AllowReload())
	{
		SetPendingReload();
		return true;
	}
	return false;
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
     Weight=5.000000
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipSawedOffShotgunAltFire'
     FireModeClass(1)=Class'BMTCustomMut.WTFEquipSawedOffShotgunFire'
     AmmoClass(0)=Class'BMTCustomMut.WTFEquipSawedOffShotgunAmmo'
     PickupClass=Class'BMTCustomMut.WTFEquipSawedOffShotgunPickup'
     ItemName="Sawed-Off Shotgun"
     Skins(0)=Texture'WTFTex2.SawedOffShotgun.SawedOffShotgun'
}
