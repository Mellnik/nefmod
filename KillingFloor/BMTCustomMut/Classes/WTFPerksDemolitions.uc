class WTFPerksDemolitions extends SRVeterancyTypes
	abstract;

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
	return Min(StatOther.RExplosivesDamageStat,FinalInt);
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'FragAmmo' )
		// Up to 6 extra Grenades
//		return 1.0 + (0.12 * float(KFPRI.ClientVeteranSkillLevel));
	{
	if ( KFPRI.ClientVeteranSkillLevel > 0 )
		{
			if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return 1.20; //+1
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			return 1.40; //+2
		else if ( KFPRI.ClientVeteranSkillLevel == 3 )
			return 1.60; //+3
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
			return 1.80; //+4
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
			return 2.00; //+5
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			return 2.20; //+6
		else if ( KFPRI.ClientVeteranSkillLevel == 7 )
			return 2.40; //+7
		else if ( KFPRI.ClientVeteranSkillLevel == 8 )
			return 2.60; //+8
		else if ( KFPRI.ClientVeteranSkillLevel == 9 )
			return 2.80; //+9
		else if ( KFPRI.ClientVeteranSkillLevel == 10 )
			return 3.00; //+10
		else if ( KFPRI.ClientVeteranSkillLevel == 11 )
			return 3.20; //+11
		else if ( KFPRI.ClientVeteranSkillLevel == 12 )
			return 3.40; //+12
		else if ( KFPRI.ClientVeteranSkillLevel == 13 )
			return 3.60; //+13
		else if ( KFPRI.ClientVeteranSkillLevel == 14 )
			return 3.80; //+14
		else if ( KFPRI.ClientVeteranSkillLevel == 15 )
			return 4.00; //+15
		else if ( KFPRI.ClientVeteranSkillLevel == 16 )
			return 4.20; //+16
		else if ( KFPRI.ClientVeteranSkillLevel == 17 )
			return 4.40; //+17
		else if ( KFPRI.ClientVeteranSkillLevel == 18 )
			return 4.60; //+18
		else if ( KFPRI.ClientVeteranSkillLevel == 19 )
			return 4.80; //+19
		else if ( KFPRI.ClientVeteranSkillLevel == 20 )
			return 5.00; //+20
		else if ( KFPRI.ClientVeteranSkillLevel == 21 )
			return 5.20; //+21
		else if ( KFPRI.ClientVeteranSkillLevel == 22 )
			return 5.40; //+22
		else if ( KFPRI.ClientVeteranSkillLevel == 23 )
			return 5.60; //+23
		else if ( KFPRI.ClientVeteranSkillLevel == 24 )
			return 5.80; //+24
		else if ( KFPRI.ClientVeteranSkillLevel >= 25 )
			return 6.00; //+25
		}
	}
			
	else if ( AmmoType == class'PipeBombAmmo' || AmmoType == class'PipeBomb2Ammo' )
		// Up to 6 extra for a total of 8 Remote Explosive Devices
//		return 1.0 + (0.5 * float(KFPRI.ClientVeteranSkillLevel));
	{
		if ( KFPRI.ClientVeteranSkillLevel > 0 )
		{
			if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return 0.50; //+0
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			return 1.00; //+0
		else if ( KFPRI.ClientVeteranSkillLevel == 3 )
			return 1.50; //+1
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
			return 2.00; //+2
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
			return 2.50; //+3
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			return 3.00; //+4
		else if ( KFPRI.ClientVeteranSkillLevel == 7 )
			return 3.50; //+5
		else if ( KFPRI.ClientVeteranSkillLevel == 8 )
			return 4.00; //+6
		else if ( KFPRI.ClientVeteranSkillLevel == 9 )
			return 4.50; //+7
		else if ( KFPRI.ClientVeteranSkillLevel == 10 )
			return 5.00; //+8
		else if ( KFPRI.ClientVeteranSkillLevel == 11 )
			return 5.50; //+9
		else if ( KFPRI.ClientVeteranSkillLevel == 12 )
			return 6.00; //+10
		else if ( KFPRI.ClientVeteranSkillLevel == 13 )
			return 6.50; //+11
		else if ( KFPRI.ClientVeteranSkillLevel == 14 )
			return 7.00; //+12
		else if ( KFPRI.ClientVeteranSkillLevel == 15 )
			return 7.50; //+13
		else if ( KFPRI.ClientVeteranSkillLevel == 16 )
			return 8.00; //+14
		else if ( KFPRI.ClientVeteranSkillLevel == 17 )
			return 8.50; //+15
		else if ( KFPRI.ClientVeteranSkillLevel == 18 )
			return 9.00; //+16
		else if ( KFPRI.ClientVeteranSkillLevel == 19 )
			return 9.50; //+17
		else if ( KFPRI.ClientVeteranSkillLevel == 20 )
			return 10.00; //+18
		else if ( KFPRI.ClientVeteranSkillLevel == 21 )
			return 10.50; //+19
		else if ( KFPRI.ClientVeteranSkillLevel == 22 )
			return 11.00; //+20
		else if ( KFPRI.ClientVeteranSkillLevel == 23 )
			return 11.50; //+21
		else if ( KFPRI.ClientVeteranSkillLevel == 24 )
			return 12.00; //+22
		else if ( KFPRI.ClientVeteranSkillLevel >= 25 )
			return 12.50; //+23
					 
		}
	}
	else if ( AmmoType == class'LAWAmmo' || AmmoType == class'WTFLawAmmo' )
	{
		if ( KFPRI.ClientVeteranSkillLevel > 0 )
		{
			if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return 1.10; //+1rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			return 1.20; //+2rockets
		else if ( KFPRI.ClientVeteranSkillLevel == 3 )
			return 1.30; //+3rockets
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
			return 1.40; //+4rockets
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
			return 1.50; //+5rockets
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			return 1.60; //+6rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 7 )
			return 1.70; //+7rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 8 )
			return 1.80; //+8rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 9 )
			return 1.90; //+9rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 10 )
			return 2.00; //+10rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 11 )
			return 2.10; //+11rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 12 )
			return 2.20; //+12rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 13 )
			return 2.30; //+13rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 14 )
			return 2.40; //+14rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 15 )
			return 2.50; //+15rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 16 )
			return 2.60; //+16rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 17 )
			return 2.70; //+17 rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 18 )
			return 2.80; //+18 rocket
		else if ( KFPRI.ClientVeteranSkillLevel == 19 )
			return 2.90; //+19 rockets
		else if ( KFPRI.ClientVeteranSkillLevel >= 20 )
			return 3.00; //200% increase in ammo 30 rockets total
		 
		}
	}
	return 1.0;
}


static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeFrag>(DmgType) != none || class<DamTypePipeBomb>(DmgType) != none || class<DamTypeM79Grenade>(DmgType) != none || class<DamTypeM32Grenade>(DmgType) != none || class<DamTypeRocketImpact>(DmgType) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.0 + (0.05 * float(KFPRI.ClientVeteranSkillLevel))); // 5% per level cap 250% at 50
	}
	if ( DmgType == class'DamTypeWTFM79Demo' || DmgType == class'DamTypeWTFLaw' || DmgType == class'DamTypeWTFUM32' || DmgType == class'DamTypeBizon' || DmgType == class'DamTypeDemoProgress' ) 
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.0 + (0.05 * float(KFPRI.ClientVeteranSkillLevel))); // 5% per level cap 250% at 50
	}
	return InDamage;
}

//static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, KFMonster DamageTaker, int InDamage, class<DamageType> DmgType)
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeFrag>(DmgType) != none || class<DamTypePipeBomb>(DmgType) != none || class<DamTypeM79Grenade>(DmgType) != none || class<DamTypeM32Grenade>(DmgType) != none || class<DamTypeRocketImpact>(DmgType) != none )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 1:
				return float(InDamage) * 0.91;
			case 2:
				return float(InDamage) * 0.82;
			case 3:
				return float(InDamage) * 0.73;
			case 4:
				return float(InDamage) * 0.64;
			case 5:
				return float(InDamage) * 0.55;
			case 6:
				return float(InDamage) * 0.46;
			case 7:
				return float(InDamage) * 0.45;
			case 8:
				return float(InDamage) * 0.44;
			case 9:
				return float(InDamage) * 0.43;
			case 10:
				return float(InDamage) * 0.42;
			case 11:
				return float(InDamage) * 0.41;
			case 12:
				return float(InDamage) * 0.40;
			case 13:
				return float(InDamage) * 0.39;
			case 14:
				return float(InDamage) * 0.38;
			case 15:
				return float(InDamage) * 0.37;
			case 16:
				return float(InDamage) * 0.36;
			case 17:
				return float(InDamage) * 0.35;
			case 18:
				return float(InDamage) * 0.34;
			case 19:
				return float(InDamage) * 0.33;
			case 20:
				return float(InDamage) * 0.32;
			case 21:
				return float(InDamage) * 0.31;
			case 22:
				return float(InDamage) * 0.30;
			case 23:
				return float(InDamage) * 0.29;
			case 24:
				return float(InDamage) * 0.28;
			case 25:
				return float(InDamage) * 0.27;
			case 26:
				return float(InDamage) * 0.26;
			case 27:
				return float(InDamage) * 0.25;
			case 28:
				return float(InDamage) * 0.24;
			case 29:
				return float(InDamage) * 0.23;
			case 30:
				return float(InDamage) * 0.22;
			case 31:
				return float(InDamage) * 0.21;
			case 32:
				return float(InDamage) * 0.20;
			case 33:
				return float(InDamage) * 0.19;
			case 34:
				return float(InDamage) * 0.18;
			case 35:
				return float(InDamage) * 0.17;
			case 36:
				return float(InDamage) * 0.16;
			case 37:
				return float(InDamage) * 0.15;
			case 38:
				return float(InDamage) * 0.14;
			case 39:
				return float(InDamage) * 0.13;
			case 40:
				return float(InDamage) * 0.12;
			case 41:
				return float(InDamage) * 0.11;
			case 42:
				return float(InDamage) * 0.10;
			case 43:
				return float(InDamage) * 0.09;
			case 44:
				return float(InDamage) * 0.08;
			case 45:
				return float(InDamage) * 0.07;
			case 46:
				return float(InDamage) * 0.06;
			case 47:
				return float(InDamage) * 0.05;
			case 48:
				return float(InDamage) * 0.04;
			case 49:
				return float(InDamage) * 0.03;
			case 50:
				return float(InDamage) * 0.02;
		}		
	return InDamage;
	}
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'PipeBombPickup' || Item == class'PipeBomb2Pickup' )
	{
		if ( KFPRI.ClientVeteranSkillLevel > 0 )
		{
			if ( KFPRI.ClientVeteranSkillLevel == 1 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 2 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 3 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 4 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 5 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 6 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 7 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 8 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 9 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 10 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 11 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 12 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 13 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 14 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 15 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 16 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 17 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 18 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 19 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 20 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 21 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 22 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 23 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 24 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 25 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 26 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 27 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 28 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 29 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 30 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 31 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 32 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 33 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 34 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 35 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 36 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 37 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 38 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 39 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 40 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 41 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 42 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 43 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 44 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 45 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 46 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 47 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 48 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 49 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 50 )
				return 0.04;
		}		

	}
		
	if ( Item == class'M79Pickup' || Item == class'M32Pickup' || Item == class'WTFEquipUM32Pickup' || Item == class'WTFEquipBanHammerPickup' || Item == class'BizonPickup' || Item == class 'LawPickup' || Item == class 'WTFLawPickup' || Item == class 'M79CFPickup' || Item == class'WTFEquipAFS12Pickup' )
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


// Change the cost of particular ammo
static function float GetAmmoCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'PipeBombPickup' || Item == class'PipeBomb2Pickup' )
	{
		if ( KFPRI.ClientVeteranSkillLevel > 0 )
		{
			if ( KFPRI.ClientVeteranSkillLevel == 1 )
				return 0.20;
			else if ( KFPRI.ClientVeteranSkillLevel == 2 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 3 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 4 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 5 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 6 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 7 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 8 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 9 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 10 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 11 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 12 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 13 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 14 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 15 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 16 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 17 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 18 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 19 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 20 )
				return 0.16;
			else if ( KFPRI.ClientVeteranSkillLevel == 21 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 22 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 23 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 24 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 25 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 26 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 27 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 28 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 29 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 30 )
				return 0.12;
			else if ( KFPRI.ClientVeteranSkillLevel == 31 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 32 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 33 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 34 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 35 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 36 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 37 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 38 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 39 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 40 )
				return 0.08;
			else if ( KFPRI.ClientVeteranSkillLevel == 41 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 42 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 43 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 44 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 45 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 46 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 47 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 48 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 49 )
				return 0.04;
			else if ( KFPRI.ClientVeteranSkillLevel == 50 )
				return 0.04;
		}		

	}
		
	if ( Item == class'WTFEquipNadePickup' )
		{
		if ( KFPRI.ClientVeteranSkillLevel > 0 )
		{
			if ( KFPRI.ClientVeteranSkillLevel == 1 )
				return 0.99;
			else if ( KFPRI.ClientVeteranSkillLevel == 2 )
				return 0.97;
			else if ( KFPRI.ClientVeteranSkillLevel == 3 )
				return 0.96;
			else if ( KFPRI.ClientVeteranSkillLevel == 4 )
				return 0.94;
			else if ( KFPRI.ClientVeteranSkillLevel == 5 )
				return 0.93;
			else if ( KFPRI.ClientVeteranSkillLevel == 6 )
				return 0.91;
			else if ( KFPRI.ClientVeteranSkillLevel == 7 )
				return 0.90;
			else if ( KFPRI.ClientVeteranSkillLevel == 8 )
				return 0.88;
			else if ( KFPRI.ClientVeteranSkillLevel == 9 )
				return 0.87;
			else if ( KFPRI.ClientVeteranSkillLevel == 10 )
				return 0.85;
			else if ( KFPRI.ClientVeteranSkillLevel == 11 )
				return 0.84;
			else if ( KFPRI.ClientVeteranSkillLevel == 12 )
				return 0.82;
			else if ( KFPRI.ClientVeteranSkillLevel == 13 )
				return 0.81;
			else if ( KFPRI.ClientVeteranSkillLevel == 14 )
				return 0.79;
			else if ( KFPRI.ClientVeteranSkillLevel == 15 )
				return 0.78;
			else if ( KFPRI.ClientVeteranSkillLevel == 16 )
				return 0.76;
			else if ( KFPRI.ClientVeteranSkillLevel == 17 )
				return 0.75;
			else if ( KFPRI.ClientVeteranSkillLevel == 18 )
				return 0.73;
			else if ( KFPRI.ClientVeteranSkillLevel == 19 )
				return 0.72;
			else if ( KFPRI.ClientVeteranSkillLevel == 20 )
				return 0.70;
			else if ( KFPRI.ClientVeteranSkillLevel == 21 )
				return 0.69;
			else if ( KFPRI.ClientVeteranSkillLevel == 22 )
				return 0.67;
			else if ( KFPRI.ClientVeteranSkillLevel == 23 )
				return 0.66;
			else if ( KFPRI.ClientVeteranSkillLevel == 24 )
				return 0.64;
			else if ( KFPRI.ClientVeteranSkillLevel == 25 )
				return 0.63;
			else if ( KFPRI.ClientVeteranSkillLevel == 26 )
				return 0.61;
			else if ( KFPRI.ClientVeteranSkillLevel == 27 )
				return 0.60;
			else if ( KFPRI.ClientVeteranSkillLevel == 28 )
				return 0.58;
			else if ( KFPRI.ClientVeteranSkillLevel == 29 )
				return 0.57;
			else if ( KFPRI.ClientVeteranSkillLevel == 30 )
				return 0.55;
			else if ( KFPRI.ClientVeteranSkillLevel == 31 )
				return 0.54;
			else if ( KFPRI.ClientVeteranSkillLevel == 32 )
				return 0.52;
			else if ( KFPRI.ClientVeteranSkillLevel == 33 )
				return 0.51;
			else if ( KFPRI.ClientVeteranSkillLevel == 34 )
				return 0.49;
			else if ( KFPRI.ClientVeteranSkillLevel == 35 )
				return 0.48;
			else if ( KFPRI.ClientVeteranSkillLevel == 36 )
				return 0.46;
			else if ( KFPRI.ClientVeteranSkillLevel == 37 )
				return 0.45;
			else if ( KFPRI.ClientVeteranSkillLevel == 38 )
				return 0.43;
			else if ( KFPRI.ClientVeteranSkillLevel == 39 )
				return 0.42;
			else if ( KFPRI.ClientVeteranSkillLevel == 40 )
				return 0.40;
			else if ( KFPRI.ClientVeteranSkillLevel == 41 )
				return 0.39;
			else if ( KFPRI.ClientVeteranSkillLevel == 42 )
				return 0.37;
			else if ( KFPRI.ClientVeteranSkillLevel == 43 )
				return 0.36;
			else if ( KFPRI.ClientVeteranSkillLevel == 44 )
				return 0.34;
			else if ( KFPRI.ClientVeteranSkillLevel == 45 )
				return 0.33;
			else if ( KFPRI.ClientVeteranSkillLevel == 46 )
				return 0.31;
			else if ( KFPRI.ClientVeteranSkillLevel == 47 )
				return 0.30;
			else if ( KFPRI.ClientVeteranSkillLevel == 48 )
				return 0.28;
			else if ( KFPRI.ClientVeteranSkillLevel == 49 )
				return 0.27;
			else if ( KFPRI.ClientVeteranSkillLevel == 50 )
				return 0.25;
		}		

	}
	return 1.0;
}

//Reload speed boost for all weapons LVP
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	return (0.00 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // 0% placeholder
}

//Recoil LVP
static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
		return Recoil - (1-super.ModifyRecoilSpread(KFPRI, Other, Recoil));
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If level 1-10 give them M79
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 10 )
			KFHumanPawn(P).CreateInventoryVeterancy("KFMod.M79GrenadeLauncher", GetCostScaling(KFPRI, class'M79Pickup'));
			
	// If level 11-20 give them M32
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 20 )
			KFHumanPawn(P).CreateInventoryVeterancy("KFMod.M32GrenadeLauncher", GetCostScaling(KFPRI, class'M32Pickup'));
			
	// If level 21-30 give them M79CF
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 30 )
			KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.M79CF", GetCostScaling(KFPRI, class'M79CFPickup'));
			
	// If level 31-40 give them UM32
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40 )
			KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipUM32a", GetCostScaling(KFPRI, class'WTFEquipUM32Pickup'));
			
	// If level 41-50 give them WTFLaw
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 50 )
			KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFLaw", GetCostScaling(KFPRI, class'WTFLawPickup'));
	
	// If level 41-50 give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		P.ShieldStrength = 100;
	


}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.05 * float(Level))); //Explosive Damage
	ReplaceText(S,"%r",GetPercentStr(0.02 * float(Level))); //Explosive Resist
	ReplaceText(S,"%d",GetPercentStr(0.75+FMin(0.03 * float(Level),0.24f))); //Discount for Pipebombs
	ReplaceText(S,"%x",string(2+Level)); //Pipebomb Carry Ammount
	ReplaceText(S,"%y",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f))); //Discount for Explosives
	ReplaceText(S,"%a",GetPercentStr(0.1 * float(Level))); //??
	return S;
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="5% Extra Damage Demolitions Weapons|9% Resistance To Demoltions Weapons Explosives|Can Carry 6 Grenades|Can Carry 1 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|1.5% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(2)="10% Extra Damage Demolitions Weapons|18% Resistance To Demoltions Weapons Explosives|Can Carry 7 Grenades|Can Carry 2 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|3% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(3)="15% Extra Damage Demolitions Weapons|27% Resistance To Demoltions Weapons Explosives|Can Carry 8 Grenades|Can Carry 3 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|4.5% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(4)="20% Extra Damage Demolitions Weapons|36% Resistance To Demoltions Weapons Explosives|Can Carry 9 Grenades|Can Carry 4 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|6% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(5)="25% Extra Damage Demolitions Weapons|45% Resistance To Demoltions Weapons Explosives|Can Carry 10 Grenades|Can Carry 5 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|7.5% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(6)="30% Extra Damage Demolitions Weapons|54% Resistance To Demoltions Weapons Explosives|Can Carry 11 Grenades|Can Carry 6 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|9% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(7)="35% Extra Damage Demolitions Weapons|55% Resistance To Demoltions Weapons Explosives|Can Carry 12 Grenades|Can Carry 7 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|10.5% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(8)="40% Extra Damage Demolitions Weapons|56% Resistance To Demoltions Weapons Explosives|Can Carry 13 Grenades|Can Carry 8 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|12% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(9)="45% Extra Damage Demolitions Weapons|57% Resistance To Demoltions Weapons Explosives|Can Carry 14 Grenades|Can Carry 9 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|13.5% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(10)="50% Extra Damage Demolitions Weapons|58% Resistance To Demoltions Weapons Explosives|Can Carry 15 Grenades|Can Carry 10 Remote Explosives|70% Discount On Demolitions Weapons|80% Off Remote Explosives|15% Discount On Hand Grenades|Spawn With An M79 Grenade launcher"
     SRLevelEffects(11)="55% Extra Damage Demolitions Weapons|59% Resistance To Demoltions Weapons Explosives|Can Carry 16 Grenades|Can Carry 11 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|16.5% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(12)="60% Extra Damage Demolitions Weapons|60% Resistance To Demoltions Weapons Explosives|Can Carry 17 Grenades|Can Carry 12 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|18% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(13)="65% Extra Damage Demolitions Weapons|61% Resistance To Demoltions Weapons Explosives|Can Carry 18 Grenades|Can Carry 13 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|19.5% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(14)="70% Extra Damage Demolitions Weapons|62% Resistance To Demoltions Weapons Explosives|Can Carry 19 Grenades|Can Carry 14 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|21% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(15)="75% Extra Damage Demolitions Weapons|63% Resistance To Demoltions Weapons Explosives|Can Carry 20 Grenades|Can Carry 15 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|22.5% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(16)="80% Extra Damage Demolitions Weapons|64% Resistance To Demoltions Weapons Explosives|Can Carry 21 Grenades|Can Carry 16 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|24% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(17)="85% Extra Damage Demolitions Weapons|65% Resistance To Demoltions Weapons Explosives|Can Carry 22 Grenades|Can Carry 17 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|25.5% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(18)="90% Extra Damage Demolitions Weapons|66% Resistance To Demoltions Weapons Explosives|Can Carry 23 Grenades|Can Carry 18 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|27% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(19)="95% Extra Damage Demolitions Weapons|67% Resistance To Demoltions Weapons Explosives|Can Carry 24 Grenades|Can Carry 19 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|28.5% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(20)="100% Extra Damage Demolitions Weapons|68% Resistance To Demoltions Weapons Explosives|Can Carry 25 Grenades|Can Carry 20 Remote Explosives|75% Discount On Demolitions Weapons|84% Off Remote Explosives|30% Discount On Hand Grenades|Spawn With An M32 Grenade Launcher"
     SRLevelEffects(21)="105% Extra Damage Demolitions Weapons|69% Resistance To Demoltions Weapons Explosives|Can Carry 26 Grenades|Can Carry 21 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|31.5% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(22)="110% Extra Damage Demolitions Weapons|70% Resistance To Demoltions Weapons Explosives|Can Carry 27 Grenades|Can Carry 22 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|33% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(23)="115% Extra Damage Demolitions Weapons|71% Resistance To Demoltions Weapons Explosives|Can Carry 28 Grenades|Can Carry 23 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|34.5% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(24)="120% Extra Damage Demolitions Weapons|72% Resistance To Demoltions Weapons Explosives|Can Carry 29 Grenades|Can Carry 24 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|36% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(25)="125% Extra Damage Demolitions Weapons|73% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|37.5% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(26)="130% Extra Damage Demolitions Weapons|74% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|39% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(27)="135% Extra Damage Demolitions Weapons|75% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|40.5% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(28)="140% Extra Damage Demolitions Weapons|76% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|42% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(29)="145% Extra Damage Demolitions Weapons|77% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|43.5% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(30)="150% Extra Damage Demolitions Weapons|78% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|80% Discount On Demolitions Weapons|88% Off Remote Explosives|45% Discount On Hand Grenades|Spawn With An WTF M79CF Grenade Launcher"
     SRLevelEffects(31)="155% Extra Damage Demolitions Weapons|79% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|46.5% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(32)="160% Extra Damage Demolitions Weapons|80% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|48% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(33)="165% Extra Damage Demolitions Weapons|81% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|49.5% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(34)="170% Extra Damage Demolitions Weapons|82% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|51% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(35)="175% Extra Damage Demolitions Weapons|83% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|52.5% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(36)="180% Extra Damage Demolitions Weapons|84% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|54% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(37)="185% Extra Damage Demolitions Weapons|85% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|55.5% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(38)="190% Extra Damage Demolitions Weapons|86% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|57% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(39)="195% Extra Damage Demolitions Weapons|87% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|58.5% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(40)="200% Extra Damage Demolitions Weapons|88% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|85% Discount On Demolitions Weapons|92% Off Remote Explosives|60% Discount On Hand Grenades|Spawn With An WTF UM32 Grenade Launcher"
     SRLevelEffects(41)="205% Extra Damage Demolitions Weapons|89% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|61.5% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(42)="210% Extra Damage Demolitions Weapons|90% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|63% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(43)="215% Extra Damage Demolitions Weapons|91% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|64.5% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(44)="220% Extra Damage Demolitions Weapons|92% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|66% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(45)="225% Extra Damage Demolitions Weapons|93% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|67.5% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(46)="230% Extra Damage Demolitions Weapons|94% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|69% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(47)="235% Extra Damage Demolitions Weapons|95% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|70.5% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(48)="240% Extra Damage Demolitions Weapons|96% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|72% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(49)="245% Extra Damage Demolitions Weapons|97% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|90% Discount On Demolitions Weapons|96% Off Remote Explosives|73.5% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     SRLevelEffects(50)="250% Extra Damage Demolitions Weapons|98% Resistance To Demoltions Weapons Explosives|Can Carry 30 Grenades|Can Carry 25 Remote Explosives|95% Discount On Demolitions Weapons|96% Off Remote Explosives|75% Discount On Hand Grenades|Spawn With An WTF Law Rocket launcher & Body Armor"
     PerkIndex=6
     OnHUDIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Demolition'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Demolition_Gold'
     VeterancyName="Demolitions"
     Requirements(0)="Deal %x Damage with the Explosives"
}
