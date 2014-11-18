class WTFPerksOutLaw extends SRVeterancyTypes
	abstract;

var array<int> progressArray;

static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'OutLawProgress');
	Class'OutlawDeagleFire'.Default.DamageType = Class'DamTypeOutlawDeagle';
	Class'OutlawDualDeagleFire'.Default.DamageType = Class'DamTypeOutlawDualDeagle';
	Class'OutlawDualiesFire'.Default.DamageType = Class'DamTypeOutlawDualies';
	Class'OutlawWinchesterFire'.Default.DamageType = Class'DamTypeOutlawWinchester';
	Class'WColtFire'.Default.DamageType = Class'WColtDamType';
}

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 1;
		break;
	case 1:
		FinalInt = 10000;
		break;
	case 2:
		FinalInt = 50000;
		break;
	case 3:
		FinalInt = 150000;
		break;
	case 4:
		FinalInt = 280000;
		break;
	case 5:
		FinalInt = 400000;
		break;
	case 6:
		FinalInt = 655000;
		break;
	case 7:
		FinalInt = 950000;
		break;
	case 8:
		FinalInt = 1450000;
		break;
	case 9:
		FinalInt = 1780000;
		break;
	case 10:
		FinalInt = 2200000;
		break;
	case 11:
		FinalInt = 2850000;
		break;
	case 12:
		FinalInt = 3800000;
		break;
	case 13:
		FinalInt = 4950000;
		break;
	case 14:
		FinalInt = 5560000;
		break;
	case 15:
		FinalInt = 6950000;
		break;
	case 16:
		FinalInt = 8400000;
		break;
	case 17:
		FinalInt = 10000000;
		break;
	case 18:
		FinalInt = 11900000;
		break;
	case 19:
		FinalInt = 13050000;
		break;
	case 20:
		FinalInt = 15000000;
		break;
	case 21:
		FinalInt = 16500000;
		break;
	case 22:
		FinalInt = 18000000;
		break;
	case 23:
		FinalInt = 19500000;
		break;
	case 24:
		FinalInt = 21000000;
		break;
	case 25:
		FinalInt = 22500000;
		break;
	case 26:
		FinalInt = 24100000;
		break;
	case 27:
		FinalInt = 25600000;
		break;
	case 28:
		FinalInt = 28000000;
		break;
	case 29:
		FinalInt = 30000000;
		break;
	case 30:
		FinalInt = 32000000;
		break;
	case 31:
		FinalInt = 34000000;
		break;
	case 32:
		FinalInt = 36400000;
		break;
	case 33:
		FinalInt = 38200000;
		break;
	case 34:
		FinalInt = 41000000;
		break;
	case 35:
		FinalInt = 43800000;
		break;
	case 36:
		FinalInt = 46200000;
		break;
	case 37:
		FinalInt = 49300000;
		break;
	case 38:
		FinalInt = 53000000;
		break;
	case 39:
		FinalInt = 56500000;
		break;
	case 40:
		FinalInt = 62000000;
		break;
	case 41:
		FinalInt = 66000000;
		break;
	case 42:
		FinalInt = 70500000;
		break;
	case 43:
		FinalInt = 74200000;
		break;
	case 44:
		FinalInt = 78800000;
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
    return Min(StatOther.GetCustomValueInt(Class'OutlawProgress'),FinalInt);
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if(KFPRI.ClientVeteranSkillLevel > 0 )
	
		if ( OutlawSingle(Other) != none || OutlawDualies(Other) != none || OutlawDeagle(Other) != none || OutlawDeagle(Other) != none || OutlawWinchester(Other) != none )
{
		if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 3 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 7 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 8 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 9 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 10 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 11 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 12 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 13 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 14 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 15 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 16 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 17 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 18 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 19 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 20 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 21 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 22 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 23 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 24 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 25 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 26 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 27 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 28 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 29 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 30 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 31 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 32 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 33 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 34 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 35 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 36 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 37 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 38 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 39 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 40 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 41 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 42 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 43 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 44 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 45 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 46 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 47 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 48 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 49 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 50 )
			return 1.30; // 30% increase in assault rifle ammo carry
	}
		return 1.00;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'WinchesterAmmo' || AmmoType == class'DeagleAmmo' || AmmoType == class'ACPAmmo' || AmmoType == class'SingleAmmo' || AmmoType == class'WColtAmmo' || AmmoType == class'Magnum44Ammo' )
{
		if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 3 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 7 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 8 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 9 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 10 )
			return 1.05; // 5% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 11 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 12 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 13 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 14 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 15 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 16 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 17 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 18 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 19 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 20 )
			return 1.10; // 10% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 21 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 22 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 23 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 24 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 25 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 26 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 27 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 28 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 29 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 30 )
			return 1.15; // 15% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 31 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 32 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 33 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 34 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 35 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 36 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 37 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 38 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 39 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 40 )
			return 1.20; // 20% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 41 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 42 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 43 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 44 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 45 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 46 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 47 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 48 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 49 )
			return 1.25; // 25% increase in assault rifle ammo carry
		else if ( KFPRI.ClientVeteranSkillLevel == 50 )
			return 1.30; // 30% increase in assault rifle ammo carry
	}
		return 1.00;
}

// Modify fire speed
static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other)
{
	if  (OutlawWinchester(Other) != none || OutlawDeagle(Other) != none || OutlawDualDeagle(Other) != none || WColt(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.06 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% faster fire rate with Winchester
	}
	return 1.0;
}

static function float GetHeadShotDamMulti(KFPlayerReplicationInfo KFPRI, KFPawn P, class<DamageType> DmgType)
{
	local float ret;	
	if ( KFPRI.ClientVeteranSkillLevel >= 1 )
	
		if ( DmgType == class'DamTypeOutlawWinchester' || DmgType == class'DamTypeOutlawDualDeagle' || 
			DmgType == class'WColtDamType' || DmgType == class'DamTypeMagnum44Pistol' || DmgType == class'DamTypeDual44Magnum' )
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

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 1 )
	
		if (DmgType == class'DamTypeOutlawDeagle' || DmgType == class'DamTypeOutlawWinchester' || DmgType == class'DamTypeOutlawDualDeagle' ||
			DmgType == class'WColtDamType' || DmgType == class'DamTypeOutlawDualies' || DmgType == class'DamTypeMagnum44Pistol' || DmgType == class'DamTypeDual44Magnum' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.10;
		return InDamage * (1.00 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); // 6% per level cap at 300% at 50
	}
	return InDamage;
}

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( OutlawWinchester(Other) != none || OutlawSingle(Other) != none || OutlawDeagle(Other) != none || Magnum44Pistol(Other) != none || OutlawDualDeagle(Other) != none || WColt(Other) != none || Dual44Magnum(Other) != none || OutlawDualies(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		if ( KFPRI.ClientVeteranSkillLevel >= 1 )
			return 1.0 + FMin(0.10 * (KFPRI.ClientVeteranSkillLevel),2) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 200% faster reload with Winchester/Handcannon/WColt
	}
	return 1.0 + super.GetReloadSpeedModifier(KFPRI, Other);
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'OutlawWinchesterPickup' || Item == class'OutlawDualDeaglePickup' || Item == class'OutlawDeaglePickup' || Item == class'OutlawDualiesPickup' ||
		 Item == class'WColtPickup' || Item == class'Magnum44Pickup' || Item == class'Dual44MagnumPickup' )
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

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( OutlawWinchester(Other.Weapon) != none || OutlawDualDeagle(Other.Weapon) != none || OutlawSingle(Other.Weapon) != none || OutlawDualies(Other.Weapon) != none || 
		 WColt(Other.Weapon) != none || Dual44Magnum(Other.Weapon) != none )
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



// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{	
	 local Inventory I;
	 
	//If level 1, give outlaw single
/*	if ( KFPRI.ClientVeteranSkillLevel >= 1 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.OutlawSingle", GetCostScaling(KFPRI, class'OutlawSinglePickup'));
*/
	KFHumanPawn(P).RequiredEquipment[1] = ""; // Remove pistol.
	I = P.FindInventoryType(Class'WTFEquipMachinePistol');
	if( I!=None ) I.Destroy(); // Delete if already given.
	KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.OutlawSingle", GetCostScaling(KFPRI, class'OutlawSinglePickup'));
	Super.AddDefaultInventory(KFPRI,P);
	 
	//If level 11, give Outlaw Dualies
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 20 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.OutlawDualies", GetCostScaling(KFPRI, class'OutlawDualiesPickup'));
	
	//If Level 21, give Outlaw dual deagle
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 30 )		
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.OutlawDualDeagle", GetCostScaling(KFPRI, class'OutlawDualDeaglePickup'));
		
	//If level 31, give Colt Python
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
        KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WColt", GetCostScaling(KFPRI, class'WColtPickup'));	

	//If level 41, give Outlaw Winchester
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.OutlawWinchester", GetCostScaling(KFPRI, class'OutlawWinchesterPickup'));
	
	//If level 50 Give armor
	if ( KFPRI.ClientVeteranSkillLevel >= 50 )
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
     SRLevelEffects(1)="10% More Damage With Outlaw Weapons|10% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|6% Firespeed Bonus With Outlaw Weapons|10% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(2)="20% More Damage With Outlaw Weapons|20% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|12% Firespeed Bonus With Outlaw Weapons|20% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(3)="30% More Damage With Outlaw Weapons|30% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|18% Firespeed Bonus With Outlaw Weapons|30% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(4)="40% More Damage With Outlaw Weapons|40% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|24% Firespeed Bonus With Outlaw Weapons|40% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(5)="50% More Damage With Outlaw Weapons|50% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|30% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(6)="60% More Damage With Outlaw Weapons|60% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|36% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(7)="70% More Damage With Outlaw Weapons|70% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|42% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(8)="80% More Damage With Outlaw Weapons|80% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|48% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(9)="90% More Damage With Outlaw Weapons|90% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|54% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(10)="100% More Damage With Outlaw Weapons|100% Faster Reload With Outlaw Weapons|5% Larger Clipsize With Outlaw Weapons|60% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|70% Discount On Outlaw Weapons|Spawn With A Outlaw 9mm"
     SRLevelEffects(11)="110% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|110% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|66% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(12)="120% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|120% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|72% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(13)="130% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|130% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|78% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(14)="140% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|140% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|84% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(15)="150% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|150% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|90% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(16)="160% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|160% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|96% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(17)="170% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|170% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|102% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(18)="180% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|180% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|108% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(19)="190% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|190% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|114% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(20)="200% More Damage With Outlaw Weapons|20% Less Recoil With Outlaw Weapons|200% Faster Reload With Outlaw Weapons|10% Larger Clipsize With Outlaw Weapons|120% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|75% Discount On Outlaw Weapons|Spawn With Dual Outlaw 9mm's"
     SRLevelEffects(21)="210% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|210% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|126% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(22)="220% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|220% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|132% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(23)="230% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|230% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|138% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(24)="240% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|240% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|144% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(25)="250% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|250% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|150% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(26)="260% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|260% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|156% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(27)="270% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|270% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|162% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(28)="280% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|280% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|168% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(29)="290% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|290% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|174% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(30)="300% More Damage With Outlaw Weapons|40% Less Recoil With Outlaw Weapons|300% Faster Reload With Outlaw Weapons|15% Larger Clipsize With Outlaw Weapons|180% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|80% Discount On Outlaw Weapons|Spawn With Dual Outlaw Deagles"
     SRLevelEffects(31)="310% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|310% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|186% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(32)="320% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|320% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|192% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(33)="330% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|330% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|198% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(34)="340% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|340% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|204% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(35)="350% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|350% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|210% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(36)="360% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|360% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|216% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(37)="370% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|370% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|222% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(38)="380% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|380% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|228% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(39)="390% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|390% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|234% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(40)="400% More Damage With Outlaw Weapons|60% Less Recoil With Outlaw Weapons|400% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|240% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|85% Discount On Outlaw Weapons|Spawn With A Outlaw Winchester"
     SRLevelEffects(41)="410% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|410% Faster Reload With Outlaw Weapons|20% Larger Clipsize With Outlaw Weapons|246% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(42)="420% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|420% Faster Reload With Outlaw Weapons|25% Larger Clipsize With Outlaw Weapons|252% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(43)="430% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|430% Faster Reload With Outlaw Weapons|25% Larger Clipsize With Outlaw Weapons|258% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(44)="440% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|440% Faster Reload With Outlaw Weapons|25% Larger Clipsize With Outlaw Weapons|264% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(45)="450% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|450% Faster Reload With Outlaw Weapons|25% Larger Clipsize With Outlaw Weapons|270% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(46)="460% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|460% Faster Reload With Outlaw Weapons|25% Larger Clipsize With Outlaw Weapons|276% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(47)="470% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|470% Faster Reload With Outlaw Weapons|25% Larger Clipsize With Outlaw Weapons|282% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(48)="480% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|480% Faster Reload With Outlaw Weapons|25% Larger Clipsize With Outlaw Weapons|288% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(49)="490% More Damage With Outlaw Weapons|80% Less Recoil With Outlaw Weapons|490% Faster Reload With Outlaw Weapons|25% Larger Clipsize With Outlaw Weapons|294% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|90% Discount On Outlaw Weapons|Spawn With A Colt Python"
     SRLevelEffects(50)="500% More Damage With Outlaw Weapons|100% Less Recoil With Outlaw Weapons|500% Faster Reload With Outlaw Weapons|30% Larger Clipsize With Outlaw Weapons|300% Firespeed Bonus With Outlaw Weapons|50% Bonus Headshot Damage With Outlaw Weapons|95% Discount On Outlaw Weapons|Spawn With A Colt Python & Body Armor"
     PerkIndex=9
     OnHUDIcon=Texture'NetskyT.Perk_Outlaw_Red'
     OnHUDGoldIcon=Texture'NetskyT.Perk_Outlaw_Gold'
     VeterancyName="Outlaw"
     Requirements(0)="Deal %x Damage with Outlaw Weapons"
}
