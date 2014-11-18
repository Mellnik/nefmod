class WTFPerksBerserker extends SRVeterancyTypes
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
	return Min(StatOther.RMeleeDamageStat,FinalInt);
}

//Melee Damage bonus
static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeKnife' || DmgType == class'DamTypeAxe' || DmgType == class'DamTypeKatana' || DmgType == class'DamTypeChainsaw' || DmgType == class'DamTypeWTFKatana' ||
		 DmgType == class'DamTypeWTFAxe' || DmgType == class'DamTypeWTFEquipChainsaw' || DmgType == class'DamTypeScythea' || DmgType == class'DamTypeMachete' || DmgType == class'DamTypeClaymoreSword' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.10;
		return InDamage * (1.00 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); //Up to 500% bonus attack damage at level 50

	}
	else if ( DmgType == class'DamTypeLS' )
	{
	if ( KFPRI.ClientVeteranSkillLevel >= 1 )
		return float(InDamage) * 0.00;
	}
	return InDamage;
}

//Melee attack speed bonus
static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other)
{
	if ( WTFKnife(Other) != none || Axe(Other) != none || Katana(Other) != none || Chainsaw(Other) != none|| WTFEquipKatana(Other) != none || WTFEquipFireAxe(Other) != none || WTFEquipChainsaw(Other)!= none ||
		 Scythea(Other) != none || Sekira(Other) != none || Machete(Other) != none || ClaymoreSword(Other) != none )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 1:
				return 1.03;
			case 2:
				return 1.06;
			case 3:
				return 1.09;
			case 4:
				return 1.12;
			case 5:
				return 1.15;
			case 6:
				return 1.18;
			case 7:
				return 1.21;
			case 8:
				return 1.24;
			case 9:
				return 1.27;
			case 10:
				return 1.30;
			case 11:
				return 1.33;
			case 12:
				return 1.36;
			case 13:
				return 1.39;
			case 14:
				return 1.42;
			case 15:
				return 1.45;
			case 16:
				return 1.48;
			case 17:
				return 1.51;
			case 18:
				return 1.54;
			case 19:
				return 1.57;
			case 20:
				return 1.60;
			case 21:
				return 1.63;
			case 22:
				return 1.66;
			case 23:
				return 1.69;
			case 24:
				return 1.72;
			case 25:
				return 1.75;
			case 26:
				return 1.78;
			case 27:
				return 1.81;
			case 28:
				return 1.84;
			case 29:
				return 1.87;
			case 30:
				return 1.90;
			case 31:
				return 1.93;
			case 32:
				return 1.96;
			case 33:
				return 1.99;
			case 34:
				return 2.02;
			case 35:
				return 2.05;
			case 36:
				return 2.08;
			case 37:
				return 2.11;
			case 38:
				return 2.14;
			case 39:
				return 2.17;
			case 40:
				return 2.20;
			case 41:
				return 2.23;
			case 42:
				return 2.26;
			case 43:
				return 2.29;
			case 44:
				return 2.32;
			case 45:
				return 2.35;
			case 46:
				return 2.38;
			case 47:
				return 2.41;
			case 48:
				return 2.44;
			case 49:
				return 2.47;
			case 50:
				return 2.50;
				
//			default:
//				return 0.95+0.03*float(KFPRI.ClientVeteranSkillLevel);
		}
	}
	
	else if ( litesaber(Other) != none )
	{
	if ( KFPRI.ClientVeteranSkillLevel >= 1 )
		return 0.01;
	}
	
	return 1.0;
}

//Melee movement speed bonus
static function float GetMeleeMovementSpeedModifier(KFPlayerReplicationInfo KFPRI)
{

 	if ( KFPRI.ClientVeteranSkillLevel == 1 )
		return 0.05;
	else if ( KFPRI.ClientVeteranSkillLevel == 3 )
		return 0.10;
	else if ( KFPRI.ClientVeteranSkillLevel == 5 )
		return 0.15;
	else if ( KFPRI.ClientVeteranSkillLevel == 7 )
		return 0.20;
	else if ( KFPRI.ClientVeteranSkillLevel >= 9 )
		return 0.25;
	else if ( KFPRI.ClientVeteranSkillLevel >= 11 )
		return 0.30;
	else if ( KFPRI.ClientVeteranSkillLevel >= 15 )
		return 0.35;

	return 0.15;
}

//damage resistance
//static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, KFMonster DamageTaker, int InDamage, class<DamageType> DmgType)
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeVomit' )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 1:
				return float(InDamage) * 0.98;
			case 2:
				return float(InDamage) * 0.96;
			case 3:
				return float(InDamage) * 0.94;
			case 4:
				return float(InDamage) * 0.92;
			case 5:
				return float(InDamage) * 0.90;
			case 6:
				return float(InDamage) * 0.88;
			case 7:
				return float(InDamage) * 0.86;
			case 8:
				return float(InDamage) * 0.84;
			case 9:
				return float(InDamage) * 0.82;
			case 10:
				return float(InDamage) * 0.80;
			case 11:
				return float(InDamage) * 0.78;
			case 12:
				return float(InDamage) * 0.76;
			case 13:
				return float(InDamage) * 0.74;
			case 14:
				return float(InDamage) * 0.72;
			case 15:
				return float(InDamage) * 0.70;
			case 16:
				return float(InDamage) * 0.68;
			case 17:
				return float(InDamage) * 0.66;
			case 18:
				return float(InDamage) * 0.64;
			case 19:
				return float(InDamage) * 0.62;
			case 20:
				return float(InDamage) * 0.60;
			case 21:
				return float(InDamage) * 0.58;
			case 22:
				return float(InDamage) * 0.56;
			case 23:
				return float(InDamage) * 0.54;
			case 24:
				return float(InDamage) * 0.52;
			case 25:
				return float(InDamage) * 0.50;
			case 26:
				return float(InDamage) * 0.48;
			case 27:
				return float(InDamage) * 0.46;
			case 28:
				return float(InDamage) * 0.44;
			case 29:
				return float(InDamage) * 0.42;
			case 30:
				return float(InDamage) * 0.40;
			case 31:
				return float(InDamage) * 0.38;
			case 32:
				return float(InDamage) * 0.36;
			case 33:
				return float(InDamage) * 0.34;
			case 34:
				return float(InDamage) * 0.32;
			case 35:
				return float(InDamage) * 0.30;
			case 36:
				return float(InDamage) * 0.28;
			case 37:
				return float(InDamage) * 0.26;
			case 38:
				return float(InDamage) * 0.24;
			case 39:
				return float(InDamage) * 0.22;
			case 40:
				return float(InDamage) * 0.20;
			case 41:
				return float(InDamage) * 0.18;
			case 42:
				return float(InDamage) * 0.16;
			case 43:
				return float(InDamage) * 0.14;
			case 44:
				return float(InDamage) * 0.12;
			case 45:
				return float(InDamage) * 0.10;
			case 46:
				return float(InDamage) * 0.08;
			case 47:
				return float(InDamage) * 0.06;
			case 48:
				return float(InDamage) * 0.04;
			case 49:
				return float(InDamage) * 0.02;
			case 50:
				return float(InDamage) * 0.00;
		}
	}
	switch ( KFPRI.ClientVeteranSkillLevel )
	{
		case 1:
			return float(InDamage) * 0.95; //Reduce damage 5%
		case 2:
			return float(InDamage) * 0.90; //Reduce damage 10%
		case 3:
			return float(InDamage) * 0.85; //Reduce damage 15%
		case 4:
			return float(InDamage) * 0.80; //Reduce damage 20%
		case 5:
			return float(InDamage) * 0.75; //Reduce damage 25%
		case 6:
			return float(InDamage) * 0.73; //Reduce damage 27%
		case 7:
			return float(InDamage) * 0.71; //Reduce damage 29%
		case 8:
			return float(InDamage) * 0.69; //Reduce damage 31%
		case 9:
			return float(InDamage) * 0.67; //Reduce damage 33%
		case 10:
			return float(InDamage) * 0.65; //Reduce damage 35% 
		case 11:
			return float(InDamage) * 0.63; //Reudce damage 37%
		case 12:
			return float(InDamage) * 0.61; //Reudce damage 39%
		case 13:
			return float(InDamage) * 0.59; //Reudce damage 41%
		case 14:
			return float(InDamage) * 0.57; //Reudce damage 43%
		case 15:
			return float(InDamage) * 0.55; //Reudce damage 45%
		case 16:
			return float(InDamage) * 0.53; //Reudce damage 47%
		case 17:
			return float(InDamage) * 0.51; //Reudce damage 49%
		case 18:
			return float(InDamage) * 0.49; //Reudce damage 51%
		case 19:
			return float(InDamage) * 0.47; //Reudce damage 53%
		case 20:
			return float(InDamage) * 0.45; //Reudce damage 55%
		case 21:
			return float(InDamage) * 0.44; //Reudce damage 56%
		case 22:
			return float(InDamage) * 0.43; //Reudce damage 57%
		case 23:
			return float(InDamage) * 0.42; //Reudce damage 58%
		case 24:
			return float(InDamage) * 0.41; //Reudce damage 59%
		case 25:
			return float(InDamage) * 0.40; //Reudce damage 60%
		case 26:
			return float(InDamage) * 0.39; //Reudce damage 61%
		case 27:
			return float(InDamage) * 0.38; //Reudce damage 62%
		case 28:
			return float(InDamage) * 0.37; //Reudce damage 63%
		case 29:
			return float(InDamage) * 0.36; //Reudce damage 64%
		case 30:
			return float(InDamage) * 0.35; //Reudce damage 65%
		case 31:
			return float(InDamage) * 0.34; //Reudce damage 66%
		case 32:
			return float(InDamage) * 0.33; //Reudce damage 67%
		case 33:
			return float(InDamage) * 0.32; //Reudce damage 68%
		case 34:
			return float(InDamage) * 0.31; //Reudce damage 69%
		case 35:
			return float(InDamage) * 0.30; //Reudce damage 70%
		case 36:
			return float(InDamage) * 0.29; //Reudce damage 71%
		case 37:
			return float(InDamage) * 0.28; //Reudce damage 72%
		case 38:
			return float(InDamage) * 0.27; //Reudce damage 73%
		case 39:
			return float(InDamage) * 0.26; //Reudce damage 74%
		case 40:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 41:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 42:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 43:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 44:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 45:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 46:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 47:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 48:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 49:
			return float(InDamage) * 0.25; //Reudce damage 75%
		case 50:
			return float(InDamage) * 0.20; //Reudce damage 80%

	}

	return InDamage;
}

//Clots cant grab me!
static function bool CanBeGrabbed(KFPlayerReplicationInfo KFPRI, KFMonster Other)
{
	return !Other.IsA('ZombieClot');
}

// Set number times Zed Time can be extended
static function int ZedTimeExtensions(KFPlayerReplicationInfo KFPRI)
{
	return Min(KFPRI.ClientVeteranSkillLevel, 4);
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'ChainsawPickup' || Item == class'ScytheaPickup' || Item == class'ClaymoreSwordPickup' || Item == class'WTFEquipChainsawPickup' || Item == class'WTFEquipFireaxePickup' || Item == class'WTFEquipKatanaPickup' || Item == class'KatanaPickup' || Item == class'SekiraPickup' )
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

	if ( Item == class'Vest' )
		return 1.00 - (0.01 * float(KFPRI.ClientVeteranSkillLevel));
	return 1.0;
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If level 1-5 give them Machette
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 5 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Machete", GetCostScaling(KFPRI, class'MachetePickup'));
	
	// If level 6-10 give them Axe
	if ( KFPRI.ClientVeteranSkillLevel >= 6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Axe", GetCostScaling(KFPRI, class'AxePickup'));
	
	// If level 11-15 give them Katana
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 15 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Katana", GetCostScaling(KFPRI, class'KatanaPickup'));
	
	// If level 16-20 give them Chainsaw
	if ( KFPRI.ClientVeteranSkillLevel >= 16 && KFPRI.ClientVeteranSkillLevel <= 20 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Chainsaw", GetCostScaling(KFPRI, class'ChainsawPickup'));
	
	// If level 21-25 give them Claymore
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 30 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.ClaymoreSword", GetCostScaling(KFPRI, class'ClaymoreSwordPickup'));
		
	// If level 31-35 give them ScytheA
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Scythea", GetCostScaling(KFPRI, class'ScytheaPickup'));

	// If level 36-40 give them WTF Axe
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 40 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipFireAxe", GetCostScaling(KFPRI, class'WTFEquipFireAxePickup'));

	// If level 41-45 give them WTF Katana
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 45 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipKatana", GetCostScaling(KFPRI, class'WTFEquipKatanaPickup'));

	// If level 46-49 give them WTF Chainsaw
	if ( KFPRI.ClientVeteranSkillLevel >= 46 && KFPRI.ClientVeteranSkillLevel <= 49 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipChainsaw", GetCostScaling(KFPRI, class'WTFEquipChainsawPickup'));
	
	// If Level 50 give them Sekira
	if ( KFPRI.ClientVeteranSkillLevel == 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.sekira", GetCostScaling(KFPRI, class'sekiraPickup'));

	// If Level 11-50 give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 11 )
		P.ShieldStrength = 100;
			
}	

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr((0.03 * float(Level))));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	ReplaceText(S,"%r",GetPercentStr((0.05 * float(Level))));
	ReplaceText(S,"%l",GetPercentStr((0.21 + (0.02 * float(Level)))));
	ReplaceText(S,"%b",GetPercentStr((0.03 * float(Level)))); //Bloat bile resistance
	ReplaceText(S,"%a",GetPercentStr((0.01 * float(Level)))); //Better body armor
	return S;
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="10% Extra Damage With Berserker Weapons|3% Faster Attacks With Berserker Weapons|5% Faster Movement With Berserker Weapons|2% Less Damage From Bloat Bile|5% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|1% Discount On Body Armor|Spawn With An Machette"
     SRLevelEffects(2)="20% Extra Damage With Berserker Weapons|6% Faster Attacks With Berserker Weapons|5% Faster Movement With Berserker Weapons|4% Less Damage From Bloat Bile|10% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Zed-Time Can Be Extended By Killing An Enemy While In Slow Motion|2% Discount On Body Armor|Spawn With An Machette"
     SRLevelEffects(3)="30% Extra Damage With Berserker Weapons|9% Faster Attacks With Berserker Weapons|10% Faster Movement With Berserker Weapons|6% Less Damage From Bloat Bile|15% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 2 Zed-Time Extensions|3% Discount On Body Armor|Spawn With An Machette"
     SRLevelEffects(4)="40% Extra Damage With Berserker Weapons|12% Faster Attacks With Berserker Weapons|10% Faster Movement With Berserker Weapons|8% Less Damage From Bloat Bile|20% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 3 Zed-Time Extensions|4% Discount On Body Armor|Spawn With An Machette"
     SRLevelEffects(5)="50% Extra Damage With Berserker Weapons|15% Faster Attacks With Berserker Weapons|15% Faster Movement With Berserker Weapons|10% Less Damage From Bloat Bile|25% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|5% Discount On Body Armor|Spawn With An Machette"
     SRLevelEffects(6)="60% Extra Damage With Berserker Weapons|18% Faster Attacks With Berserker Weapons|15% Faster Movement With Berserker Weapons|12% Less Damage From Bloat Bile|27% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|6% Discount On Body Armor|Spawn With An FireAxe"
     SRLevelEffects(7)="70% Extra Damage With Berserker Weapons|21% Faster Attacks With Berserker Weapons|20% Faster Movement With Berserker Weapons|14% Less Damage From Bloat Bile|29% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|7% Discount On Body Armor|Spawn With An FireAxe"
     SRLevelEffects(8)="80% Extra Damage With Berserker Weapons|24% Faster Attacks With Berserker Weapons|20% Faster Movement With Berserker Weapons|16% Less Damage From Bloat Bile|31% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|8% Discount On Body Armor|Spawn With An FireAxe"
     SRLevelEffects(9)="90% Extra Damage With Berserker Weapons|27% Faster Attacks With Berserker Weapons|25% Faster Movement With Berserker Weapons|18% Less Damage From Bloat Bile|33% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|9% Discount On Body Armor|Spawn With An FireAxe"
     SRLevelEffects(10)="100% Extra Damage With Berserker Weapons|30% Faster Attacks With Berserker Weapons|25% Faster Movement With Berserker Weapons|20% Less Damage From Bloat Bile|35% Resistance To All Damage|70% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|10% Discount On Body Armor|Spawn With An FireAxe"
     SRLevelEffects(11)="110% Extra Damage With Berserker Weapons|33% Faster Attacks With Berserker Weapons|30% Faster Movement With Berserker Weapons|22% Less Damage From Bloat Bile|37% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|11% Discount On Body Armor|Spawn With An Katana"
     SRLevelEffects(12)="120% Extra Damage With Berserker Weapons|36% Faster Attacks With Berserker Weapons|30% Faster Movement With Berserker Weapons|24% Less Damage From Bloat Bile|39% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|12% Discount On Body Armor|Spawn With An Katana"
     SRLevelEffects(13)="130% Extra Damage With Berserker Weapons|39% Faster Attacks With Berserker Weapons|30% Faster Movement With Berserker Weapons|26% Less Damage From Bloat Bile|41% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|13% Discount On Body Armor|Spawn With An Katana"
     SRLevelEffects(14)="140% Extra Damage With Berserker Weapons|42% Faster Attacks With Berserker Weapons|30% Faster Movement With Berserker Weapons|28% Less Damage From Bloat Bile|43% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|14% Discount On Body Armor|Spawn With An Katana"
     SRLevelEffects(15)="150% Extra Damage With Berserker Weapons|45% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|30% Less Damage From Bloat Bile|45% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|15% Discount On Body Armor|Spawn With An Katana"
     SRLevelEffects(16)="160% Extra Damage With Berserker Weapons|48% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|32% Less Damage From Bloat Bile|47% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|16% Discount On Body Armor|Spawn With An Chainsaw"
     SRLevelEffects(17)="170% Extra Damage With Berserker Weapons|51% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|34% Less Damage From Bloat Bile|49% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|17% Discount On Body Armor|Spawn With An Chainsaw"
     SRLevelEffects(18)="180% Extra Damage With Berserker Weapons|54% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|36% Less Damage From Bloat Bile|51% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|18% Discount On Body Armor|Spawn With An Chainsaw"
     SRLevelEffects(19)="190% Extra Damage With Berserker Weapons|57% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|38% Less Damage From Bloat Bile|53% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|19% Discount On Body Armor|Spawn With An Chainsaw"
     SRLevelEffects(20)="200% Extra Damage With Berserker Weapons|60% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|40% Less Damage From Bloat Bile|55% Resistance To All Damage|75% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|20% Discount On Body Armor|Spawn With An Chainsaw"
     SRLevelEffects(21)="210% Extra Damage With Berserker Weapons|63% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|42% Less Damage From Bloat Bile|56% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|21% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(22)="220% Extra Damage With Berserker Weapons|66% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|44% Less Damage From Bloat Bile|57% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|22% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(23)="230% Extra Damage With Berserker Weapons|69% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|46% Less Damage From Bloat Bile|58% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|23% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(24)="240% Extra Damage With Berserker Weapons|72% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|48% Less Damage From Bloat Bile|59% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|24% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(25)="250% Extra Damage With Berserker Weapons|75% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|50% Less Damage From Bloat Bile|60% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|25% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(26)="260% Extra Damage With Berserker Weapons|78% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|52% Less Damage From Bloat Bile|61% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|26% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(27)="270% Extra Damage With Berserker Weapons|81% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|54% Less Damage From Bloat Bile|62% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|27% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(28)="280% Extra Damage With Berserker Weapons|84% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|56% Less Damage From Bloat Bile|63% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|28% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(29)="290% Extra Damage With Berserker Weapons|87% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|58% Less Damage From Bloat Bile|64% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|29% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(30)="300% Extra Damage With Berserker Weapons|90% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|60% Less Damage From Bloat Bile|65% Resistance To All Damage|80% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|30% Discount On Body Armor|Spawn With An Claymore"
     SRLevelEffects(31)="310% Extra Damage With Berserker Weapons|93% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|62% Less Damage From Bloat Bile|66% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|31% Discount On Body Armor|Spawn With An Scythe"
     SRLevelEffects(32)="320% Extra Damage With Berserker Weapons|96% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|64% Less Damage From Bloat Bile|67% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|32% Discount On Body Armor|Spawn With An Scythe"
     SRLevelEffects(33)="330% Extra Damage With Berserker Weapons|99% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|66% Less Damage From Bloat Bile|68% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|33% Discount On Body Armor|Spawn With An Scythe"
     SRLevelEffects(34)="340% Extra Damage With Berserker Weapons|102% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|68% Less Damage From Bloat Bile|69% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|34% Discount On Body Armor|Spawn With An Scythe"
     SRLevelEffects(35)="350% Extra Damage With Berserker Weapons|105% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|70% Less Damage From Bloat Bile|70% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|35% Discount On Body Armor|Spawn With An Scythe"
     SRLevelEffects(36)="360% Extra Damage With Berserker Weapons|108% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|72% Less Damage From Bloat Bile|71% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|36% Discount On Body Armor|Spawn With An WTF FireAxe"
     SRLevelEffects(37)="370% Extra Damage With Berserker Weapons|111% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|74% Less Damage From Bloat Bile|72% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|37% Discount On Body Armor|Spawn With An WTF FireAxe"
     SRLevelEffects(38)="380% Extra Damage With Berserker Weapons|114% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|76% Less Damage From Bloat Bile|73% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|38% Discount On Body Armor|Spawn With An WTF FireAxe"
     SRLevelEffects(39)="390% Extra Damage With Berserker Weapons|117% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|78% Less Damage From Bloat Bile|74% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|39% Discount On Body Armor|Spawn With An WTF FireAxe"
     SRLevelEffects(40)="400% Extra Damage With Berserker Weapons|120% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|80% Less Damage From Bloat Bile|75% Resistance To All Damage|85% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|40% Discount On Body Armor|Spawn With An WTF FireAxe"
     SRLevelEffects(41)="410% Extra Damage With Berserker Weapons|123% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|82% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|41% Discount On Body Armor|Spawn With An WTF Katana"
     SRLevelEffects(42)="420% Extra Damage With Berserker Weapons|126% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|84% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|42% Discount On Body Armor|Spawn With An WTF Katana"
     SRLevelEffects(43)="430% Extra Damage With Berserker Weapons|129% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|86% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|43% Discount On Body Armor|Spawn With An WTF Katana"
     SRLevelEffects(44)="440% Extra Damage With Berserker Weapons|132% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|88% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|44% Discount On Body Armor|Spawn With An WTF Katana"
     SRLevelEffects(45)="450% Extra Damage With Berserker Weapons|135% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|90% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|45% Discount On Body Armor|Spawn With An WTF Katana"
     SRLevelEffects(46)="460% Extra Damage With Berserker Weapons|138% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|92% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|46% Discount On Body Armor|Spawn With An WTF Chainsaw"
     SRLevelEffects(47)="470% Extra Damage With Berserker Weapons|141% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|94% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|47% Discount On Body Armor|Spawn With An WTF Chainsaw"
     SRLevelEffects(48)="480% Extra Damage With Berserker Weapons|144% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|96% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|48% Discount On Body Armor|Spawn With An WTF Chainsaw"
     SRLevelEffects(49)="490% Extra Damage With Berserker Weapons|147% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|98% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|49% Discount On Body Armor|Spawn With An WTF Chainsaw"
     SRLevelEffects(50)="500% Extra Damage With Berserker Weapons|150% Faster Attacks With Berserker Weapons|35% Faster Movement With Berserker Weapons|100% Less Damage From Bloat Bile|80% Resistance To All Damage|95% Discount On Berserker Weapons|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|50% Discount On Body Armor|Spawn With An Sekira"
     PerkIndex=4
     OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Berserker'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Berserker_Gold'
     VeterancyName="Berserker"
     Requirements(0)="Deal %x Damage with melee weapons"
}
