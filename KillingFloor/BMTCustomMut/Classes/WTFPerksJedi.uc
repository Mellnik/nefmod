class WTFPerksJedi extends SRVeterancyTypes
	abstract;
	
var array<int> progressArray;

static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'lsprogress');
	Other.AddCustomValue(Class'forcekill');
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
		return Min(StatOther.GetCustomValueInt(Class'lsprogress'),FinalInt);
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeLS' || DmgType == class'DamTypeZEDGunA' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.10;
		return InDamage * (1.00 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); //Up to 500% bonus attack damage at level 50

	}
	return InDamage;
}

static function float GetWeldSpeedModifier(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 1 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel));
	return 5.0; // 500% increase in speed cap at level 50
}

static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other)
{
	if ( LiteSaber(Other) != none || ZEDGunA(Other) != none )
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

//Can't be grabbed by clots!
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
	if ( Item == class'litesaberPickup' || Item == class'ZEDGunPickupA' )
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
	// If level 2+ Give them The force!
	if ( KFPRI.ClientVeteranSkillLevel >= 2 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Force", GetCostScaling(KFPRI, class'ForcePickup'));


	// If Level 0+ Give them litesaber!
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.litesaber", GetCostScaling(KFPRI, class'litesaberPickup'));

	// If Level 6 Give them armor!
	if ( KFPRI.ClientVeteranSkillLevel >= 6 )
		P.ShieldStrength = 100;
		
/*	// If Level 1 Give them Syringe!
	if ( KFPRI.ClientVeteranSkillLevel >= 1 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Syringe", GetCostScaling(KFPRI, class'SyringePickup'));
*/	
	// If level 50 give them Zedgun
	if ( KFPRI.ClientVeteranSkillLevel == 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.ZedGunA", GetCostScaling(KFPRI, class'ZedGunPickupA'));
}


static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.05 * float(Level)-0.05));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	ReplaceText(S,"%r",GetPercentStr(0.7 + 0.05*float(Level)));
	ReplaceText(S,"%l",GetPercentStr(FMin(0.05*float(Level),0.65f)));
	return S;
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="10% Extra Litesaber Damage!|3% Faster Litesaber Attacks!|5% Faster Melee Movement|2% Less Damage From Bloat Bile|5% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Spawn With A Litesaber|1% Discount on Body Armor"
     SRLevelEffects(2)="20% Extra Litesaber Damage!|6% Faster Litesaber Attacks!|5% Faster Melee Movement|4% Less Damage From Bloat Bile|10% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Zed-Time Can Be Extended By Killing An Enemy While In Slow Motion|Spawn With A Litesaber & The Force!|2% Discount on Body Armor"
     SRLevelEffects(3)="30% Extra Litesaber Damage!|9% Faster Litesaber Attacks!|10% Faster Melee Movement|6% Less Damage From Bloat Bile|15% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 2 Zed-Time Extensions|Spawn With A Litesaber & The Force!|3% Discount on Body Armor"
     SRLevelEffects(4)="40% Extra Litesaber Damage!|12% Faster Litesaber Attacks!|10% Faster Melee Movement|8% Less Damage From Bloat Bile|20% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 3 Zed-Time Extensions|Spawn With A Litesaber & The Force!|4% Discount on Body Armor"
     SRLevelEffects(5)="50% Extra Litesaber Damage!|15% Faster Litesaber Attacks!|15% Faster Melee Movement|10% Less Damage From Bloat Bile|25% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With A Litesaber & The Force!|5% Discount on Body Armor"
     SRLevelEffects(6)="60% Extra Litesaber Damage!|18% Faster Litesaber Attacks!|15% Faster Melee Movement|12% Less Damage From Bloat Bile|27% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|6% Discount on Body Armor"
     SRLevelEffects(7)="70% Extra Litesaber Damage!|21% Faster Litesaber Attacks!|20% Faster Melee Movement|14% Less Damage From Bloat Bile|29% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|7% Discount on Body Armor"
     SRLevelEffects(8)="80% Extra Litesaber Damage!|24% Faster Litesaber Attacks!|20% Faster Melee Movement|16% Less Damage From Bloat Bile|31% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|8% Discount on Body Armor"
     SRLevelEffects(9)="90% Extra Litesaber Damage!|27% Faster Litesaber Attacks!|25% Faster Melee Movement|18% Less Damage From Bloat Bile|33% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|9% Discount on Body Armor"
     SRLevelEffects(10)="100% Extra Litesaber Damage!|30% Faster Litesaber Attacks!|25% Faster Melee Movement|20% Less Damage From Bloat Bile|35% Resistance To All Damage|70% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|10% Discount on Body Armor"
     SRLevelEffects(11)="110% Extra Litesaber Damage!|33% Faster Litesaber Attacks!|30% Faster Melee Movement|22% Less Damage From Bloat Bile|37% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|11% Discount on Body Armor"
     SRLevelEffects(12)="120% Extra Litesaber Damage!|36% Faster Litesaber Attacks!|30% Faster Melee Movement|24% Less Damage From Bloat Bile|39% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|12% Discount on Body Armor"
     SRLevelEffects(13)="130% Extra Litesaber Damage!|39% Faster Litesaber Attacks!|30% Faster Melee Movement|26% Less Damage From Bloat Bile|41% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|13% Discount on Body Armor"
     SRLevelEffects(14)="140% Extra Litesaber Damage!|42% Faster Litesaber Attacks!|30% Faster Melee Movement|28% Less Damage From Bloat Bile|43% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|14% Discount on Body Armor"
     SRLevelEffects(15)="150% Extra Litesaber Damage!|45% Faster Litesaber Attacks!|35% Faster Melee Movement|30% Less Damage From Bloat Bile|45% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|15% Discount on Body Armor"
     SRLevelEffects(16)="160% Extra Litesaber Damage!|48% Faster Litesaber Attacks!|35% Faster Melee Movement|32% Less Damage From Bloat Bile|47% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|16% Discount on Body Armor"
     SRLevelEffects(17)="170% Extra Litesaber Damage!|51% Faster Litesaber Attacks!|35% Faster Melee Movement|34% Less Damage From Bloat Bile|49% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|17% Discount on Body Armor"
     SRLevelEffects(18)="180% Extra Litesaber Damage!|54% Faster Litesaber Attacks!|35% Faster Melee Movement|36% Less Damage From Bloat Bile|51% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|18% Discount on Body Armor"
     SRLevelEffects(19)="190% Extra Litesaber Damage!|57% Faster Litesaber Attacks!|35% Faster Melee Movement|38% Less Damage From Bloat Bile|53% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|19% Discount on Body Armor"
     SRLevelEffects(20)="200% Extra Litesaber Damage!|60% Faster Litesaber Attacks!|35% Faster Melee Movement|40% Less Damage From Bloat Bile|55% Resistance To All Damage|75% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|20% Discount on Body Armor"
     SRLevelEffects(21)="210% Extra Litesaber Damage!|63% Faster Litesaber Attacks!|35% Faster Melee Movement|42% Less Damage From Bloat Bile|56% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|21% Discount on Body Armor"
     SRLevelEffects(22)="220% Extra Litesaber Damage!|66% Faster Litesaber Attacks!|35% Faster Melee Movement|44% Less Damage From Bloat Bile|57% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|22% Discount on Body Armor"
     SRLevelEffects(23)="230% Extra Litesaber Damage!|69% Faster Litesaber Attacks!|35% Faster Melee Movement|46% Less Damage From Bloat Bile|58% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|23% Discount on Body Armor"
     SRLevelEffects(24)="240% Extra Litesaber Damage!|72% Faster Litesaber Attacks!|35% Faster Melee Movement|48% Less Damage From Bloat Bile|59% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|24% Discount on Body Armor"
     SRLevelEffects(25)="250% Extra Litesaber Damage!|75% Faster Litesaber Attacks!|35% Faster Melee Movement|50% Less Damage From Bloat Bile|60% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|25% Discount on Body Armor"
     SRLevelEffects(26)="260% Extra Litesaber Damage!|78% Faster Litesaber Attacks!|35% Faster Melee Movement|52% Less Damage From Bloat Bile|61% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|26% Discount on Body Armor"
     SRLevelEffects(27)="270% Extra Litesaber Damage!|81% Faster Litesaber Attacks!|35% Faster Melee Movement|54% Less Damage From Bloat Bile|62% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|27% Discount on Body Armor"
     SRLevelEffects(28)="280% Extra Litesaber Damage!|84% Faster Litesaber Attacks!|35% Faster Melee Movement|56% Less Damage From Bloat Bile|63% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|28% Discount on Body Armor"
     SRLevelEffects(29)="290% Extra Litesaber Damage!|87% Faster Litesaber Attacks!|35% Faster Melee Movement|58% Less Damage From Bloat Bile|64% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|29% Discount on Body Armor"
     SRLevelEffects(30)="300% Extra Litesaber Damage!|90% Faster Litesaber Attacks!|35% Faster Melee Movement|60% Less Damage From Bloat Bile|65% Resistance To All Damage|80% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|30% Discount on Body Armor"
     SRLevelEffects(31)="310% Extra Litesaber Damage!|93% Faster Litesaber Attacks!|35% Faster Melee Movement|62% Less Damage From Bloat Bile|66% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|31% Discount on Body Armor"
     SRLevelEffects(32)="320% Extra Litesaber Damage!|96% Faster Litesaber Attacks!|35% Faster Melee Movement|64% Less Damage From Bloat Bile|67% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|32% Discount on Body Armor"
     SRLevelEffects(33)="330% Extra Litesaber Damage!|99% Faster Litesaber Attacks!|35% Faster Melee Movement|66% Less Damage From Bloat Bile|68% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|33% Discount on Body Armor"
     SRLevelEffects(34)="340% Extra Litesaber Damage!|102% Faster Litesaber Attacks!|35% Faster Melee Movement|68% Less Damage From Bloat Bile|69% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|34% Discount on Body Armor"
     SRLevelEffects(35)="350% Extra Litesaber Damage!|105% Faster Litesaber Attacks!|35% Faster Melee Movement|70% Less Damage From Bloat Bile|70% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|35% Discount on Body Armor"
     SRLevelEffects(36)="360% Extra Litesaber Damage!|108% Faster Litesaber Attacks!|35% Faster Melee Movement|72% Less Damage From Bloat Bile|71% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|36% Discount on Body Armor"
     SRLevelEffects(37)="370% Extra Litesaber Damage!|111% Faster Litesaber Attacks!|35% Faster Melee Movement|74% Less Damage From Bloat Bile|72% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|37% Discount on Body Armor"
     SRLevelEffects(38)="380% Extra Litesaber Damage!|114% Faster Litesaber Attacks!|35% Faster Melee Movement|76% Less Damage From Bloat Bile|73% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|38% Discount on Body Armor"
     SRLevelEffects(39)="390% Extra Litesaber Damage!|117% Faster Litesaber Attacks!|35% Faster Melee Movement|78% Less Damage From Bloat Bile|74% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|39% Discount on Body Armor"
     SRLevelEffects(40)="400% Extra Litesaber Damage!|120% Faster Litesaber Attacks!|35% Faster Melee Movement|80% Less Damage From Bloat Bile|75% Resistance To All Damage|85% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|40% Discount on Body Armor"
     SRLevelEffects(41)="410% Extra Litesaber Damage!|123% Faster Litesaber Attacks!|35% Faster Melee Movement|82% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|41% Discount on Body Armor"
     SRLevelEffects(42)="420% Extra Litesaber Damage!|126% Faster Litesaber Attacks!|35% Faster Melee Movement|84% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|42% Discount on Body Armor"
     SRLevelEffects(43)="430% Extra Litesaber Damage!|129% Faster Litesaber Attacks!|35% Faster Melee Movement|86% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|43% Discount on Body Armor"
     SRLevelEffects(44)="440% Extra Litesaber Damage!|132% Faster Litesaber Attacks!|35% Faster Melee Movement|88% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|44% Discount on Body Armor"
     SRLevelEffects(45)="450% Extra Litesaber Damage!|135% Faster Litesaber Attacks!|35% Faster Melee Movement|90% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|45% Discount on Body Armor"
     SRLevelEffects(46)="460% Extra Litesaber Damage!|138% Faster Litesaber Attacks!|35% Faster Melee Movement|92% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|46% Discount on Body Armor"
     SRLevelEffects(47)="470% Extra Litesaber Damage!|141% Faster Litesaber Attacks!|35% Faster Melee Movement|94% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|47% Discount on Body Armor"
     SRLevelEffects(48)="480% Extra Litesaber Damage!|144% Faster Litesaber Attacks!|35% Faster Melee Movement|96% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|48% Discount on Body Armor"
     SRLevelEffects(49)="490% Extra Litesaber Damage!|147% Faster Litesaber Attacks!|35% Faster Melee Movement|98% Less Damage From Bloat Bile|75% Resistance To All Damage|90% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, Armor, & The Force!|49% Discount on Body Armor"
     SRLevelEffects(50)="500% Extra Litesaber Damage!|150% Faster Litesaber Attacks!|35% Faster Melee Movement|100% Less Damage From Bloat Bile|80% Resistance To All Damage|95% Discount on Litesaber/Force!|Can't Be Grabbed By Clots|Up To 4 Zed-Time Extensions|Spawn With An Litesaber, ZedGun, Armor, & The Force!|50% Discount on Body Armor"
     PerkIndex=11
     OnHUDIcon=Texture'NetskyT3.Perk_Jedi'
     OnHUDGoldIcon=Texture'NetskyT3.Perk_Jedi_Gold'
     VeterancyName="Jedi"
     Requirements(0)="Deal %x Damage with Jedi weapons"
}
