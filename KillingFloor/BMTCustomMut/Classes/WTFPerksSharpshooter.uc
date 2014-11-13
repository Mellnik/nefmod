class WTFPerksSharpshooter extends SRVeterancyTypes
	abstract;

var array<int> progressArray;

static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'SharpShooterProgress');
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
	return Min(StatOther.GetCustomValueInt(Class'SharpShooterProgress'),FinalInt);
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeWTFCrossbow' || DmgType == class'DamTypeWTFCrossbowHeadShot' || DmgType == class'DamTypeMagnum44Pistol' || DmgType == class'DamTypeDual44Magnum' || 
		 DmgType == class'DamTypeWinchester2' || DmgType == class'DamTypeDeagleExt' || DmgType == class'DamTypeDualDeagleExt' || DmgType == class'DamTypeSA80' ||
		 DmgType == class'DamTypeMKExt' || DmgType == class'DamTypeMK23Ext' || DmgType == class'DamTypeDualMKExt' || DmgType == class'DamTypeB94' ||
		 DmgType == class'DamTypeDualies' || DmgType == class'DamTypeSharpShooterProgress' || DmgType == class'DamTypeCrossbow' || DmgType == class'DamTypeCrossbowHeadshot' ||
		 DmgType == class'DamTypeM14EBR' )
	{
			if ( KFPRI.ClientVeteranSkillLevel == 1 )
				return float(InDamage) * 1.05;
			else if ( KFPRI.ClientVeteranSkillLevel == 2 )
				return float(InDamage) * 1.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 3 )
				return float(InDamage) * 1.25;
			else if ( KFPRI.ClientVeteranSkillLevel == 4 )
				return float(InDamage) * 1.40;
			else if ( KFPRI.ClientVeteranSkillLevel == 5 )
				return float(InDamage) * 1.55;
			else if ( KFPRI.ClientVeteranSkillLevel == 6 )
				return float(InDamage) * 1.70;
			else if ( KFPRI.ClientVeteranSkillLevel == 7 )
				return float(InDamage) * 1.85;
			else if ( KFPRI.ClientVeteranSkillLevel == 8 )
				return float(InDamage) * 2.00;
			else if ( KFPRI.ClientVeteranSkillLevel == 9 )
				return float(InDamage) * 2.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 10 )
				return float(InDamage) * 2.35;
			else if ( KFPRI.ClientVeteranSkillLevel == 11 )
				return float(InDamage) * 2.55;
			else if ( KFPRI.ClientVeteranSkillLevel == 12 )
				return float(InDamage) * 2.61;
			else if ( KFPRI.ClientVeteranSkillLevel == 13 )
				return float(InDamage) * 2.67;
			else if ( KFPRI.ClientVeteranSkillLevel == 14 )
				return float(InDamage) * 2.73;
			else if ( KFPRI.ClientVeteranSkillLevel == 15 )
				return float(InDamage) * 2.79;
			else if ( KFPRI.ClientVeteranSkillLevel == 16 )
				return float(InDamage) * 2.85;
			else if ( KFPRI.ClientVeteranSkillLevel == 17 )
				return float(InDamage) * 2.91;
			else if ( KFPRI.ClientVeteranSkillLevel == 18 )
				return float(InDamage) * 2.97;
			else if ( KFPRI.ClientVeteranSkillLevel == 19 )
				return float(InDamage) * 3.03;
			else if ( KFPRI.ClientVeteranSkillLevel == 20 )
				return float(InDamage) * 3.09;
			else if ( KFPRI.ClientVeteranSkillLevel == 21 )
				return float(InDamage) * 3.15;
			else if ( KFPRI.ClientVeteranSkillLevel == 22 )
				return float(InDamage) * 3.21;
			else if ( KFPRI.ClientVeteranSkillLevel == 23 )
				return float(InDamage) * 3.27;
			else if ( KFPRI.ClientVeteranSkillLevel == 24 )
				return float(InDamage) * 3.33;
			else if ( KFPRI.ClientVeteranSkillLevel == 25 )
				return float(InDamage) * 3.39;
			else if ( KFPRI.ClientVeteranSkillLevel == 26 )
				return float(InDamage) * 3.45;
			else if ( KFPRI.ClientVeteranSkillLevel == 27 )
				return float(InDamage) * 3.51;
			else if ( KFPRI.ClientVeteranSkillLevel == 28 )
				return float(InDamage) * 3.57;
			else if ( KFPRI.ClientVeteranSkillLevel == 29 )
				return float(InDamage) * 3.63;
			else if ( KFPRI.ClientVeteranSkillLevel == 30 )
				return float(InDamage) * 3.69;
			else if ( KFPRI.ClientVeteranSkillLevel == 31 )
				return float(InDamage) * 3.75;
			else if ( KFPRI.ClientVeteranSkillLevel == 32 )
				return float(InDamage) * 3.81;
			else if ( KFPRI.ClientVeteranSkillLevel == 33 )
				return float(InDamage) * 3.87;
			else if ( KFPRI.ClientVeteranSkillLevel == 34 )
				return float(InDamage) * 3.93;
			else if ( KFPRI.ClientVeteranSkillLevel == 35 )
				return float(InDamage) * 3.99;
			else if ( KFPRI.ClientVeteranSkillLevel == 36 )
				return float(InDamage) * 4.05;
			else if ( KFPRI.ClientVeteranSkillLevel == 37 )
				return float(InDamage) * 4.11;
			else if ( KFPRI.ClientVeteranSkillLevel == 38 )
				return float(InDamage) * 4.17;
			else if ( KFPRI.ClientVeteranSkillLevel == 39 )
				return float(InDamage) * 4.23;
			else if ( KFPRI.ClientVeteranSkillLevel == 40 )
				return float(InDamage) * 4.29;
			else if ( KFPRI.ClientVeteranSkillLevel == 41 )
				return float(InDamage) * 4.35;
			else if ( KFPRI.ClientVeteranSkillLevel == 42 )
				return float(InDamage) * 4.41;
			else if ( KFPRI.ClientVeteranSkillLevel == 43 )
				return float(InDamage) * 4.47;
			else if ( KFPRI.ClientVeteranSkillLevel == 44 )
				return float(InDamage) * 4.53;
			else if ( KFPRI.ClientVeteranSkillLevel == 45 )
				return float(InDamage) * 4.59;
			else if ( KFPRI.ClientVeteranSkillLevel == 46 )
				return float(InDamage) * 4.65;
			else if ( KFPRI.ClientVeteranSkillLevel == 47 )
				return float(InDamage) * 4.71;
			else if ( KFPRI.ClientVeteranSkillLevel == 48 )
				return float(InDamage) * 4.77;
			else if ( KFPRI.ClientVeteranSkillLevel == 49 )
				return float(InDamage) * 4.83;
			else if ( KFPRI.ClientVeteranSkillLevel == 50 )
				return float(InDamage) * 5.00;
		return float(InDamage) * (1.00 + (0.13 * float(KFPRI.ClientVeteranSkillLevel)));
	}
	return InDamage;
}


static function float GetHeadShotDamMulti(KFPlayerReplicationInfo KFPRI, KFPawn P, class<DamageType> DmgType)
{
	local float ret;

	// Removed extra SS Crossbow headshot damage in Round 1(added back in Round 2) and Removed Single/Dualies Damage for Hell on Earth in Round 6
	// Added Dual Deagles back in for Balance Round 7
	if ( DmgType == class'DamTypeWTFCrossbow' || DmgType == class'DamTypeDual44Magnum' ||  DmgType == class'DamTypeMagnum44Pistol' || DmgType == class'DamTypeWTFCrossbowHeadShot' || DmgType == class'DamTypeWinchester' ||
		 DmgType == class'DamTypeDeagleExt' || DmgType == class'DamTypeDualDeagleExt' || DmgType == class'DamTypeB94' || DmgType == class'DamTypeMKExt' || DmgType == class'DamTypeDualMKExt' || DmgType == class'DamTypeSA80' ||
		 DmgType == class'DamTypeDualies' || DmgType == class'DamTypeSharpShooterProgress' || DmgType == class'DamTypeCrossbow' || DmgType == class'DamTypeCrossbowHeadshot' || DmgType == class'DamTypeMK23Ext' ||
		 DmgType == class'DamTypeM14EBR' )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 3 )
		{
			ret = 1.05 + (0.05 * float(KFPRI.ClientVeteranSkillLevel));
		}
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
		{
			ret = 1.30;
		}
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
		{
			ret = 1.50;
		}
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
		{
			ret = 1.60; // 60% increase in Crossbow/Winchester/Handcannon damage
		}
		else
		{
			ret = 1.3 + (0.08 * float(KFPRI.ClientVeteranSkillLevel));
		}
	}
	// Reduced extra headshot damage for Single/Dualies in Hell on Earth difficulty(added in Balance Round 6)
	else if ( DmgType == class'DamTypeDualies' && KFPRI.Level.Game.GameDifficulty >= 7.0 )
	{
		return (1.0 + (0.08 * float(Min(KFPRI.ClientVeteranSkillLevel, 5)))); // 40% increase in Headshot Damage
	}
	else
	{
		ret = 1.0; // Fix for oversight in Balance Round 6(which is the reason for the Round 6 second attempt patch)
	}

	if ( KFPRI.ClientVeteranSkillLevel == 0 )
	{
		return ret * 1.05;
	}

	return ret * (1.0 + (0.10 * float(Min(KFPRI.ClientVeteranSkillLevel, 5)))); // 50% increase in Headshot Damage
}

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( WTFEquipCrossbow(Other.Weapon) != none || Dual44Magnum(Other.Weapon) != none || Magnum44Pistol(Other.Weapon) != none || CrossbowExt(Other.Weapon) != none ||
		 Winchester2(Other.Weapon) != none || DeagleExt(Other.Weapon) != none || DualDeagleExt(Other.Weapon) != none ||
		 B94(Other.Weapon) != none || MK23Ext(Other.Weapon) != none || DualMK23Ext(Other.Weapon) != none ||
		 M14EBRBattleRifle(Other.Weapon) != none || SA80(Other.Weapon) != none || WTFEquipMachinePistol(Other.Weapon) != none || WTFEquipMachineDualies(Other.Weapon) != none || PB(Other.Weapon) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 1)
			Recoil = 0.75;
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			Recoil = 0.50;
		else Recoil = 0.19; // 81% recoil reduction with Crossbow/Winchester/Handcannon
	}
	return Recoil - (1-super.ModifyRecoilSpread(KFPRI, Other, Recoil));
}

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( WTFEquipCrossbow(Other) != none || Winchester2(Other) != none || Dual44Magnum(Other) != none || Magnum44Pistol(Other) != none || CrossbowExt(Other) != none ||
		 MK23Ext(Other) != none|| DualMK23Ext(Other) != none || DeagleExt(Other) != none || B94(Other) != none ||
		 DualDeagleExt(Other) != none || M14EBRBattleRifle(Other) != none || SA80(Other) != none || WTFEquipMachinePistol(Other) != none || WTFEquipMachineDualies(Other) != none || PB(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.05 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 60% faster reload with Crossbow/Winchester/Handcannon
	}
	return 1.0 + super.GetReloadSpeedModifier(KFPRI, Other);
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'DeaglePickupExt' || Item == class'Magnum44Pickup' || Item == class'Dual44MagnumPickup' ||
		 Item == class'DualDeaglePickupExt' || Item == class'DualMK23PickupExt' || Item == class'DualiesPickup' || Item == class'MK23PickupExt' ||
		 Item == class'B94Pickup' || Item == class'M14EBRPickup' || Item == class'WTFEquipCrossbowPickup' ||
		 Item == class'SA80Pickup' || Item == class'WTFEquipMachinePistolPickup' || Item == class'WTFEquipMachineDualiesPickup' || Item == class'CrossbowExtPickup' || Item == class'PBPickup' )
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

// Modify fire speed
static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other)
{
	if ( Winchester2(Other) != none || SA80(Other) != none || Magnum44Pistol(Other) != none|| Dual44Magnum(Other) != none || Mk23Ext(Other) != none || DualMk23Ext(Other)!= none ||
		 DeagleExt(Other) != none || DualDeagleExt(Other) != none || M14EBRBattleRifle(Other) != none || PB(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.06 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% faster fire rate with Winchester
	}
	return 1.0;
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If level 1-5 give them Magnum44
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 5 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Magnum44Pistol", GetCostScaling(KFPRI, class'Magnum44Pickup'));
	
	// If level 6-10 give them Mk23
	if ( KFPRI.ClientVeteranSkillLevel >= 6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.MK23Ext", GetCostScaling(KFPRI, class'MK23PickupExt'));

	// If level 11-15 give them Deagle
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 15 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.DeagleExt", GetCostScaling(KFPRI, class'DeaglePickupExt'));
		
	// If level 16-20 give them Winchester
	if ( KFPRI.ClientVeteranSkillLevel >= 16 && KFPRI.ClientVeteranSkillLevel <= 20 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Winchester2", GetCostScaling(KFPRI, class'Winchester2Pickup'));

	// If level 21-25 give them M14EBR
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 30 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.M14EBRBattleRifle", GetCostScaling(KFPRI, class'M14EBRPickup'));

	// If level 31-35 give them WTF Crossbow
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipCrossbow", GetCostScaling(KFPRI, class'WTFEquipCrossbowPickup'));

	// If level 36-45 give them SA80
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 45 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.SA80", GetCostScaling(KFPRI, class'SA80Pickup'));

	// If level 46-50 give them B94
	if ( KFPRI.ClientVeteranSkillLevel >= 46 && KFPRI.ClientVeteranSkillLevel <= 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.B94", GetCostScaling(KFPRI, class'B94Pickup'));

	// If level 41-50 give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		P.ShieldStrength = 100;
}


static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.07 * float(Level))); //Headshot dmg
	ReplaceText(S,"%p",GetPercentStr(0.10 * float(Level))); //Reload speed
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f))); // Discount
	return S;	
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="5% More Headshot Damage With SharpShooter Weapons|25% Less Recoil With SharpShooter Weapons|17% Faster Reload With SharpShooter Weapons|10% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Magnum44"
     SRLevelEffects(2)="15% More Headshot Damage With SharpShooter Weapons|50% Less Recoil With SharpShooter Weapons|34% Faster Reload With SharpShooter Weapons|20% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Magnum44"
     SRLevelEffects(3)="25% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|51% Faster Reload With SharpShooter Weapons|30% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Magnum44"
     SRLevelEffects(4)="40% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|68% Faster Reload With SharpShooter Weapons|40% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Magnum44"
     SRLevelEffects(5)="55% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|85% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Magnum44"
     SRLevelEffects(6)="70% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|102% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Mk23"
     SRLevelEffects(7)="85% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|105% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Mk23"
     SRLevelEffects(8)="100% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|108% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Mk23"
     SRLevelEffects(9)="120% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|111% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Mk23"
     SRLevelEffects(10)="140% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|114% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|70% Discount On SharpShooter Weapons|Spawn With An Mk23"
     SRLevelEffects(11)="146% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|117% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Deagle"
     SRLevelEffects(12)="152% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|120% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Deagle"
     SRLevelEffects(13)="158% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|123% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Deagle"
     SRLevelEffects(14)="164% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|126% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Deagle"
     SRLevelEffects(15)="170% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|129% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Deagle"
     SRLevelEffects(16)="176% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|132% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Winchester"
     SRLevelEffects(17)="182% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|135% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Winchester"
     SRLevelEffects(18)="188% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|138% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Winchester"
     SRLevelEffects(19)="194% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|141% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Winchester"
     SRLevelEffects(20)="200% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|144% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|75% Discount On SharpShooter Weapons|Spawn With An Winchester"
     SRLevelEffects(21)="206% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|147% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(22)="212% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|150% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(23)="218% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|153% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(24)="224% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|156% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(25)="230% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|159% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(26)="236% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|162% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(27)="242% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|165% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(28)="248% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|168% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(29)="254% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|171% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|80% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(30)="260% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|174% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An M14EBR"
     SRLevelEffects(31)="266% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|177% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An WTF Crossbow"
     SRLevelEffects(32)="272% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|180% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An WTF Crossbow"
     SRLevelEffects(33)="278% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|183% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An WTF Crossbow"
     SRLevelEffects(34)="284% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|186% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An WTF Crossbow"
     SRLevelEffects(35)="290% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|189% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An WTF Crossbow"
     SRLevelEffects(36)="296% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|192% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An SA80"
     SRLevelEffects(37)="302% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|195% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An SA80"
     SRLevelEffects(38)="308% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|198% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An SA80"
     SRLevelEffects(39)="314% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|201% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An SA80"
     SRLevelEffects(40)="320% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|204% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|85% Discount On SharpShooter Weapons|Spawn With An SA80"
     SRLevelEffects(41)="326% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|207% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An SA80 & Body Armor"
     SRLevelEffects(42)="332% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|210% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An SA80 & Body Armor"
     SRLevelEffects(43)="338% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|213% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An SA80 & Body Armor"
     SRLevelEffects(44)="344% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|216% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An SA80 & Body Armor"
     SRLevelEffects(45)="350% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|219% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An SA80 & Body Armor"
     SRLevelEffects(46)="356% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|222% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An B94 & Body Armor"
     SRLevelEffects(47)="362% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|225% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An B94 & Body Armor"
     SRLevelEffects(48)="368% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|228% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An B94 & Body Armor"
     SRLevelEffects(49)="374% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|231% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|90% Discount On SharpShooter Weapons|Spawn With An B94 & Body Armor"
     SRLevelEffects(50)="400% More Headshot Damage With SharpShooter Weapons|75% Less Recoil With SharpShooter Weapons|234% Faster Reload With SharpShooter Weapons|50% Extra Headshot Damage With SharpShooter Weapons|95% Discount On SharpShooter Weapons|Spawn With An B94 & Body Armor"
     PerkIndex=2
     OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_SharpShooter'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_SharpShooter_Gold'
     VeterancyName="Sharpshooter"
     Requirements(0)="Deal %x Damage With Sharpshooter Weapons"
}
