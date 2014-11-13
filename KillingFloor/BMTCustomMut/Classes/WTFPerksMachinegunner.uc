class WTFPerksMachinegunner extends SRVeterancyTypes
	abstract;

var array<int> progressArray;

static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'MachineGunnerProgress');
	Class'M249Fire'.Default.DamageType = Class'DamTypeM249';
	Class'ThompsonFire'.Default.DamageType = Class'DamTypeThompson';
	Class'PPDFire'.Default.DamageType = Class'DamTypePPD';
	Class'MP40Fire'.Default.DamageType = Class'DamTypeMP40';
	Class'M44Fire'.Default.DamageType = Class'DamTypeM44';
	Class'XMV850Fire'.Default.DamageType = Class'DamTypeXMV850';

}

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 1;
		break;
	case 1:
		FinalInt = 350000;
		break;
	case 2:
		FinalInt = 700000;
		break;
	case 3:
		FinalInt = 1050000;
		break;
	case 4:
		FinalInt = 1400000;
		break;
	case 5:
		FinalInt = 1750000;
		break;
	case 6:
		FinalInt = 2100000;
		break;
	case 7:
		FinalInt = 2450000;
		break;
	case 8:
		FinalInt = 2800000;
		break;
	case 9:
		FinalInt = 3150000;
		break;
	case 10:
		FinalInt = 3500000;
		break;
	case 11:
		FinalInt = 4650000;
		break;
	case 12:
		FinalInt = 5800000;
		break;
	case 13:
		FinalInt = 6950000;
		break;
	case 14:
		FinalInt = 8100000;
		break;
	case 15:
		FinalInt = 9250000;
		break;
	case 16:
		FinalInt = 10400000;
		break;
	case 17:
		FinalInt = 11550000;
		break;
	case 18:
		FinalInt = 12700000;
		break;
	case 19:
		FinalInt = 13850000;
		break;
	case 20:
		FinalInt = 15000000;
		break;
	case 21:
		FinalInt = 17000000;
		break;
	case 22:
		FinalInt = 19000000;
		break;
	case 23:
		FinalInt = 21000000;
		break;
	case 24:
		FinalInt = 23000000;
		break;
	case 25:
		FinalInt = 25000000;
		break;
	case 26:
		FinalInt = 27000000;
		break;
	case 27:
		FinalInt = 29000000;
		break;
	case 28:
		FinalInt = 31000000;
		break;
	case 29:
		FinalInt = 33000000;
		break;
	case 30:
		FinalInt = 35000000;
		break;
	case 31:
		FinalInt = 38000000;
		break;
	case 32:
		FinalInt = 41000000;
		break;
	case 33:
		FinalInt = 44000000;
		break;
	case 34:
		FinalInt = 47000000;
		break;
	case 35:
		FinalInt = 50000000;
		break;
	case 36:
		FinalInt = 53000000;
		break;
	case 37:
		FinalInt = 56000000;
		break;
	case 38:
		FinalInt = 59000000;
		break;
	case 39:
		FinalInt = 62000000;
		break;
	case 40:
		FinalInt = 65000000;
		break;
	case 41:
		FinalInt = 68500000;
		break;
	case 42:
		FinalInt = 72000000;
		break;
	case 43:
		FinalInt = 75500000;
		break;
	case 44:
		FinalInt = 79000000;
		break;
	case 45:
		FinalInt = 82500000;
		break;
	case 46:
		FinalInt = 86000000;
		break;
	case 47:
		FinalInt = 89500000;
		break;
	case 48:
		FinalInt = 93000000;
		break;
	case 49:
		FinalInt = 96500000;
		break;
	case 50:
		FinalInt = 100000000;
		break;
	default:
		FinalInt = 100000000+GetDoubleScaling(CurLevel,0);
		break;
	}
    return Min(StatOther.GetCustomValueInt(Class'MachineGunnerProgress'),FinalInt);
}

// Display enemy health bars
static function SpecialHUDInfo(KFPlayerReplicationInfo KFPRI, Canvas C)
{
	local KFMonster KFEnemy;
	local HUDKillingFloor HKF;
	local float MaxDistanceSquared;

	if ( KFPRI.ClientVeteranSkillLevel > 0 )
	{
		HKF = HUDKillingFloor(C.ViewPort.Actor.myHUD);
		if ( HKF == none || C.ViewPort.Actor.Pawn == none )
			return;

		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 1:
				MaxDistanceSquared = 25600; // 20% (160 units)
				break;
			case 2:
				MaxDistanceSquared = 102400; // 40% (320 units)
				break;
			case 3:
				MaxDistanceSquared = 230400; // 60% (480 units)
				break;
			case 4:
				MaxDistanceSquared = 409600; // 80% (640 units)
				break;
			case 5:
			case 6:
				MaxDistanceSquared = 640000; // 100% (800 units)
				break;
			default:
				MaxDistanceSquared = 1562500; //(1250 units) 25 meters
				break;
		}

		foreach C.ViewPort.Actor.DynamicActors(class'KFMonster',KFEnemy)
		{
			if ( KFEnemy.Health > 0 && !KFEnemy.Cloaked() && VSizeSquared(KFEnemy.Location - C.ViewPort.Actor.Pawn.Location) < MaxDistanceSquared )
				HKF.DrawHealthBar(C, KFEnemy, KFEnemy.Health, KFEnemy.HealthMax , 50.0);
		}
	}
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( M249(Other) != none || MKb42aAssaultRifle(Other) != none || ThompsonSubmachineGun(other) != none || PPD(Other) != none || MP40(Other) != none || M44(Other) != none || 
		XMV850(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel >= 1 )
			return 1.50; // 50% increase in assault rifle ammo carry
	}
		return 1.00;
}

static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( M249Ammo(Other) != none || MKb42aAmmo(Other) != none || ThompsonAmmo(Other) != none || PPDAmmo(Other) != none || MP40Ammo(Other) != none || M44Ammo(Other) != none ||
		XMV850Ammo(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel >= 1 )
			return 1.50; // 50% increase in assault rifle ammo carry

	}
		return 1.00;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'M249Ammo' || AmmoType == class'MKb42aAmmo' || AmmoType == class'ThompsonAmmo' || AmmoType == class'PPDAmmo' || AmmoType == class'MP40Ammo' || AmmoType == class'M44Ammo' 
		|| AmmoType == class'XMV850Ammo' )
	{
		if ( KFPRI.ClientVeteranSkillLevel >= 1 )
			return 1.50; // 50% increase in assault rifle ammo carry

	}
		return 1.00;
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeM249' || DmgType == class'DamTypeMKb42aAssaultRifle' || DmgType == class'DamTypeThompson' || 
		DmgType == class'DamTypePPD' || DmgType == class'DamTypeMP40' || DmgType == class'DamTypeM44' || DmgType == class'DamTypeXMV850' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.00 + (0.16 * float(KFPRI.ClientVeteranSkillLevel))); // 10% per level cap at 500% at level 50
	}
	return InDamage;
}

static function int AddCarryMaxWeight(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return 0;
	else if ( KFPRI.ClientVeteranSkillLevel <= 4 )
		return 1 + KFPRI.ClientVeteranSkillLevel;
	else if ( KFPRI.ClientVeteranSkillLevel >= 5 )
		return 8; // 8 more carry slots
}

//recoil LVP
static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( M249(Other.Weapon) != none || MKb42aAssaultRifle(Other.Weapon) != none || ThompsonSubmachineGun(Other.Weapon) != none || PPD(Other.Weapon) != none || MP40(Other.Weapon) != none || M44(Other.Weapon) != none 
		|| XMV850(Other.Weapon) != none )
{
		if ( KFPRI.ClientVeteranSkillLevel == 11 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 12 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 13 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 14 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 15 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 16 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 17 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 18 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 19 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 20 )
			Recoil = 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 21 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 22 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 23 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 24 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 25 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 26 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 27 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 28 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 29 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 30 )
			Recoil = 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 31 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 36 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 33 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 34 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 35 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 36 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 37 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 38 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 39 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 40 )
			Recoil = 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 41 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 42 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 43 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 44 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 45 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 46 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 47 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 48 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 49 )
			Recoil = 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 50 )
			Recoil = 0.00; // Level 50 100% recoil reduction
	}
		return Recoil - (1-super.ModifyRecoilSpread(KFPRI, Other, Recoil));
}

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( M249(Other) != none || MKb42aAssaultRifle(Other) != none || ThompsonSubmachineGun(Other) != none || PPD(Other) != none || MP40(Other) != none || M44(Other) != none 
		|| XMV850(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.04 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 200% faster reload with Machine Gunner Weapons
	}
	return 1.0 + super.GetReloadSpeedModifier(KFPRI, Other);
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'M249Pickup' || Item == class'MKb42aPickup' || Item == class'ThompsonPickup' || Item == class'PPDPickup' || Item == class'MP40Pickup' || Item == class'M44Pickup' 
		|| Item == class'XMV850Pickup' )
if ( KFPRI.ClientVeteranSkillLevel > 0 )
		{
			if ( KFPRI.ClientVeteranSkillLevel == 1 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 2 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 3 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 4 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 5 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 6 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 7 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 8 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 9 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 10 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 11 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 12 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 13 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 14 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 15 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 16 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 17 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 18 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 19 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 20 )
				return 0.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 21 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 22 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 23 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 24 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 25 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 26 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 27 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 28 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 29 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 30 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 31 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 32 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 33 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 34 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 35 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 36 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 37 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 38 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 39 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 40 )
				return 0.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 41 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 42 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 43 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 44 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 45 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 46 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 47 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 48 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 49 )
				return 0.10;
			else if ( KFPRI.ClientVeteranSkillLevel == 50 )
				return 0.05;
		}		

	return 1.0;
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	//If Level 1-10 Give, PPD
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 10 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.PPD", GetCostScaling(KFPRI, class'PPDPickup'));
		
	//If Level 11-20 Give, M44
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 20 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.M44", GetCostScaling(KFPRI, class'M44Pickup'));
			
	//If Level 21-30 Give MKb42a
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 30 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.MKb42aAssaultRifle", GetCostScaling(KFPRI, class'MKb42aPickup'));
			
	// If level 31-40, give them a thompson
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.ThompsonSubmachineGun", GetCostScaling(KFPRI, class'ThompsonPickup'));
	
	//If level 41-49 Give M249
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 49 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.M249", GetCostScaling(KFPRI, class'M249Pickup'));
		
	// If level 50 Give XMV850
	if ( KFPRI.ClientVeteranSkillLevel == 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.XMV850", GetCostScaling(KFPRI, class'XMV850Pickup'));
		
	//If level 50 Give armor
	if ( KFPRI.ClientVeteranSkillLevel == 50 )
		P.ShieldStrength = 100;
	
	
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(2.4 + (0.1 * float(Level)))); // Syringe recharge
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f))); // Armor discount
	ReplaceText(S,"%m",GetPercentStr(0.15+FMin(0.02 * float(Level),0.83f))); //Medgun discount
	ReplaceText(S,"%r",GetPercentStr(FMin(0.02 * float(Level),0.65f)-0.05)); //Move speed
	ReplaceText(S,"%p",GetPercentStr(0.30 + (0.02 * float(Level)))); //Potency syringe
	ReplaceText(S,"%g",GetPercentStr((0.02 * float(Level)))); // Reload Speed
	ReplaceText(S,"%q",GetPercentStr((0.02 * float(Level)))); // Damage 
	ReplaceText(S,"%b",GetPercentStr((0.02 * float(Level)))); // Bloat bile resistance 
	return S;
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="10% Bonus Damage With Machine Gunner Weapons|10% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|1 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(2)="20% Bonus Damage With Machine Gunner Weapons|20% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|1 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(3)="30% Bonus Damage With Machine Gunner Weapons|30% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|1 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(4)="40% Bonus Damage With Machine Gunner Weapons|40% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|1 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(5)="50% Bonus Damage With Machine Gunner Weapons|50% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(6)="60% Bonus Damage With Machine Gunner Weapons|60% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(7)="70% Bonus Damage With Machine Gunner Weapons|70% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(8)="80% Bonus Damage With Machine Gunner Weapons|80% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(9)="90% Bonus Damage With Machine Gunner Weapons|90% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(10)="100% Bonus Damage With Machine Gunner Weapons|100% Faster Reload Speed With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|70% Discount On Machine Gunner Weapons|Spawn With An PPD"
     SRLevelEffects(11)="110% Bonus Damage With Machine Gunner Weapons|110% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(12)="120% Bonus Damage With Machine Gunner Weapons|120% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(13)="130% Bonus Damage With Machine Gunner Weapons|130% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(14)="140% Bonus Damage With Machine Gunner Weapons|140% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(15)="150% Bonus Damage With Machine Gunner Weapons|150% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(16)="160% Bonus Damage With Machine Gunner Weapons|160% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(17)="170% Bonus Damage With Machine Gunner Weapons|170% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(18)="180% Bonus Damage With Machine Gunner Weapons|180% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(19)="190% Bonus Damage With Machine Gunner Weapons|190% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(20)="200% Bonus Damage With Machine Gunner Weapons|200% Faster Reload Speed With Machine Gunner Weapons|20% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|75% Discount On Machine Gunner Weapons|Spawn With An M44AssaultRifle"
     SRLevelEffects(21)="210% Bonus Damage With Machine Gunner Weapons|210% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(22)="220% Bonus Damage With Machine Gunner Weapons|220% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(23)="230% Bonus Damage With Machine Gunner Weapons|230% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(24)="240% Bonus Damage With Machine Gunner Weapons|240% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(25)="250% Bonus Damage With Machine Gunner Weapons|250% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(26)="260% Bonus Damage With Machine Gunner Weapons|260% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(27)="270% Bonus Damage With Machine Gunner Weapons|270% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(28)="280% Bonus Damage With Machine Gunner Weapons|280% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(29)="290% Bonus Damage With Machine Gunner Weapons|290% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(30)="300% Bonus Damage With Machine Gunner Weapons|300% Faster Reload Speed With Machine Gunner Weapons|40% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|80% Discount On Machine Gunner Weapons|Spawn With An MKb42AssaultRifle"
     SRLevelEffects(31)="310% Bonus Damage With Machine Gunner Weapons|310% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(32)="320% Bonus Damage With Machine Gunner Weapons|320% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(33)="330% Bonus Damage With Machine Gunner Weapons|330% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(34)="340% Bonus Damage With Machine Gunner Weapons|340% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(35)="350% Bonus Damage With Machine Gunner Weapons|350% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(36)="360% Bonus Damage With Machine Gunner Weapons|360% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(37)="370% Bonus Damage With Machine Gunner Weapons|370% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(38)="380% Bonus Damage With Machine Gunner Weapons|380% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(39)="390% Bonus Damage With Machine Gunner Weapons|390% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(40)="400% Bonus Damage With Machine Gunner Weapons|400% Faster Reload Speed With Machine Gunner Weapons|60% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|85% Discount On Machine Gunner Weapons|Spawn With An ThompsonSubmachineGun"
     SRLevelEffects(41)="410% Bonus Damage With Machine Gunner Weapons|410% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(42)="420% Bonus Damage With Machine Gunner Weapons|420% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(43)="430% Bonus Damage With Machine Gunner Weapons|430% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(44)="440% Bonus Damage With Machine Gunner Weapons|440% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(45)="450% Bonus Damage With Machine Gunner Weapons|450% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(46)="460% Bonus Damage With Machine Gunner Weapons|460% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(47)="470% Bonus Damage With Machine Gunner Weapons|470% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(48)="480% Bonus Damage With Machine Gunner Weapons|480% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(49)="490% Bonus Damage With Machine Gunner Weapons|490% Faster Reload Speed With Machine Gunner Weapons|80% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|90% Discount On Machine Gunner Weapons|Spawn With An M249"
     SRLevelEffects(50)="500% Bonus Damage With Machine Gunner Weapons|500% Faster Reload Speed With Machine Gunner Weapons|100% Less Recoil With Machine Gunner Weapons|50% Larger Clipsize With Machine Gunner Weapons|Can See Enemy Health From 9m|8 Extra Carry Weight|95% Discount On Machine Gunner Weapons|Spawn With An XMV850 Saw & Body Armor"
     PerkIndex=10
     OnHUDIcon=Texture'NetskyT.Perk_MachineGunner_RED'
     OnHUDGoldIcon=Texture'NetskyT.Perk_MachineGunner_GOLD'
     VeterancyName="Machine Gunner"
     Requirements(0)="Deal %x Damage with Machine Gunner Weapons"
}
