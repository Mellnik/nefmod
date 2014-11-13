class WTFEquipWelda extends Welder
	dependson(KFVoicePack);

#exec OBJ LOAD FILE=WTFTex.utx
#exec OBJ LOAD FILE=KF_Weapons_Trip_T.utx

simulated function Tick(float dt)
{
	if (FireMode[0].bIsFiring)
		FireModeArray = 0;
	else if (FireMode[1].bIsFiring)
		FireModeArray = 1;
		
	if (WTFEquipWeldaFire(FireMode[FireModeArray]).LHitActor == none)
	{
		WTFEquipWeldaFire(FireMode[FireModeArray]).LastHitActor = none;
		Super.Tick(dt);
	}
	else if ( WTFEquipWeldaFire(FireMode[FireModeArray]).LHitActor.IsA('KFDoorMover') )
	{
		WTFEquipWeldaFire(FireMode[FireModeArray]).LastHitActor = KFDoorMover(WTFEquipWeldaFire(FireMode[FireModeArray]).LHitActor);
		Super.Tick(dt);	
	}
	else if ( AmmoAmount(0) < FireMode[0].AmmoClass.Default.MaxAmmo)
	{
		AmmoRegenCount += (dT * AmmoRegenRate );
		ConsumeAmmo(0, -1*(int(AmmoRegenCount)));
		AmmoRegenCount -= int(AmmoRegenCount);
	}
	
	Super(KFMeleeGun).Tick(dt);
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
     SkinRefs(0)="WTFTex.Welda.Welda"
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipWeldaFire'
     FireModeClass(1)=Class'BMTCustomMut.WTFEquipWeldaFireB'
     AmmoClass(0)=Class'BMTCustomMut.WTFEquipWeldaAmmo'
     Description="A deadly weapon"
     PickupClass=Class'BMTCustomMut.WTFEquipWeldaPickup'
     AttachmentClass=Class'BMTCustomMut.WTFEquipWeldaAttachment'
     ItemName="Welda profession"
}
