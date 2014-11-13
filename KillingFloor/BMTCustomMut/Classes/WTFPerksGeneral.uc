class WTFPerksGeneral extends SRVeterancyTypes
	abstract;
	
var array<int> progressArray;

static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'GeneralProgress');
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
	if( ReqNum==0 )
		return Min(StatOther.GetCustomValueInt(Class'GeneralProgress'),FinalInt);
}

//GIVING HEALTH
static function int GetHM(KFPlayerReplicationInfo KFPRI)
{
	switch (KFPRI.ClientVeteranSkillLevel)
	{
		case -1: return 0;
		case 0: return 0;
		case 1: return 1;
		case 2: return 1;
		case 3: return 1;
		case 4: return 1;
		case 5: return 1;
		case 6: return 1;
		case 7: return 1;
		case 8: return 1;
		case 9: return 1;
		case 10: return 1;
		case 11: return 1;
		case 12: return 1;
		case 13: return 1;
		case 14: return 1;
		case 15: return 1;
		case 16: return 1;
		case 17: return 1;
		case 18: return 1;
		case 19: return 1;
		case 20: return 2;
		case 21: return 2;
		case 22: return 2;
		case 23: return 2;
		case 24: return 2;
		case 25: return 2;
		case 26: return 2;
		case 27: return 2;
		case 28: return 2;
		case 29: return 2;
		case 30: return 2;
		case 31: return 2;
		case 32: return 2;
		case 33: return 2;
		case 34: return 2;
		case 35: return 2;
		case 36: return 2;
		case 37: return 2;
		case 38: return 2;
		case 39: return 2;
		case 40: return 3;
		case 41: return 3;
		case 42: return 3;
		case 43: return 3;
		case 44: return 3;
		case 45: return 3;
		case 46: return 3;
		case 47: return 3;
		case 48: return 3;
		case 49: return 3;
		case 50: return 3;
		//so on
		default: return 3;
	}
}

//GIVING ARMOR
static function int GetSM(KFPlayerReplicationInfo KFPRI)
{
	switch (KFPRI.ClientVeteranSkillLevel)
	{
		case -1: return 0;
		case 0: return 0;
		case 1: return 1;
		case 2: return 1;
		case 3: return 1;
		case 4: return 1;
		case 5: return 1;
		case 6: return 1;
		case 7: return 1;
		case 8: return 1;
		case 9: return 1;
		case 10: return 1;
		case 11: return 1;
		case 12: return 1;
		case 13: return 1;
		case 14: return 1;
		case 15: return 1;
		case 16: return 1;
		case 17: return 1;
		case 18: return 1;
		case 19: return 1;
		case 20: return 2;
		case 21: return 2;
		case 22: return 2;
		case 23: return 2;
		case 24: return 2;
		case 25: return 2;
		case 26: return 2;
		case 27: return 2;
		case 28: return 2;
		case 29: return 2;
		case 30: return 2;
		case 31: return 2;
		case 32: return 2;
		case 33: return 2;
		case 34: return 2;
		case 35: return 2;
		case 36: return 2;
		case 37: return 2;
		case 38: return 2;
		case 39: return 2;
		case 40: return 3;
		case 41: return 3;
		case 42: return 3;
		case 43: return 3;
		case 44: return 3;
		case 45: return 3;
		case 46: return 3;
		case 47: return 3;
		case 48: return 3;
		case 49: return 3;
		case 50: return 3;
		//so on
		default: return 3;
	}
}

//GIVING AMMO
static function int GetAM(KFPlayerReplicationInfo KFPRI)
{
	switch (KFPRI.ClientVeteranSkillLevel)
	{
		case -1: return 0;
		case 0: return 0;
		case 1: return 1;
		case 2: return 1;
		case 3: return 1;
		case 4: return 1;
		case 5: return 1;
		case 6: return 1;
		case 7: return 1;
		case 8: return 1;
		case 9: return 1;
		case 10: return 1;
		case 11: return 1;
		case 12: return 1;
		case 13: return 1;
		case 14: return 1;
		case 15: return 1;
		case 16: return 1;
		case 17: return 1;
		case 18: return 1;
		case 19: return 1;
		case 20: return 2;
		case 21: return 2;
		case 22: return 2;
		case 23: return 2;
		case 24: return 2;
		case 25: return 2;
		case 26: return 2;
		case 27: return 2;
		case 28: return 2;
		case 29: return 2;
		case 30: return 2;
		case 31: return 2;
		case 32: return 2;
		case 33: return 2;
		case 34: return 2;
		case 35: return 2;
		case 36: return 2;
		case 37: return 2;
		case 38: return 2;
		case 39: return 2;
		case 40: return 3;
		case 41: return 3;
		case 42: return 3;
		case 43: return 3;
		case 44: return 3;
		case 45: return 3;
		case 46: return 3;
		case 47: return 3;
		case 48: return 3;
		case 49: return 3;
		case 50: return 3;
		//so on
		default: return 3;
	}
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Protecta(Other) != none || Stinger(Other) != none || Glock18(Other) != none || P90DT(Other) != none || P57LLI(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 500% extra ammo
	return 1.0;
}

static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( ProtectaAmmo(Other) != none || StingerAmmo(Other) != none || Glock18Ammo(Other) != none || P90DTAmmo(Other) != none || P57LLIAmmo(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 500% extra ammo
	return 1.0;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'ProtectaAmmo' || AmmoType == class'StingerAmmo' || AmmoType == class'Glock18Ammo' || AmmoType == class'P90DTAmmo' || AmmoType == class'P57LLIAmmo' && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 500% extra ammo

	return 1.0;
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeStinger' || DmgType == class'DamTypeP90DT' || DmgType == class'DamTypeGlock18' || DmgType == class'DamTypeProtecta' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return float(InDamage) * (1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); //  Up to 500% extra damage
	}
	return InDamage;
}

//static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI)
static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI, KFGameReplicationInfo KFGRI)
{
	//if level 1-30 half move speed
	if ( KFPRI.ClientVeteranSkillLevel == 1 && KFPRI.ClientVeteranSkillLevel <= 30)
		return 0.75;
	// if level 31-40 3/4 move speed
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40)
		return 0.90;
	// if level 41-50 +20% move speed
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 50)
		return 1.2;
	return 1.2 ; //+20% normal move speed
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'ProtectaPickup' || Item == class'StingerPickup' || Item == class'Glock18Pickup' || Item == class'P90DTPickup' || Item == class'P57LLIPickup' )
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

//Reload speed bonus for general guns
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Protecta(Other) != none || Stinger(Other) != none || Glock18(Other) != none || P90DT(Other) != none || P57LLI(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.02 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 100% faster reload at level 50
	return 1.0 + super.GetReloadSpeedModifier(KFPRI, Other);
}

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( Stinger(Other.Weapon) != none || Protecta(Other.Weapon) != none || P90DT(Other.Weapon) != none || Glock18(Other.Weapon) != none )
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

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	local InvPS ips;
	local Inventory I;
	
	ips = KFHumanPawn(P).spawn(class'InvPS', P,,,rot(0,0,0));
	ips.GiveTo(KFHumanPawn(P));
    ips.InitTimer();
	
	// If Level 50 Give them
	if ( KFPRI.ClientVeteranSkillLevel == 50 )
		P.ShieldStrength = 100;
	
	// If Level 1-50 they get Glock
	 KFHumanPawn(P).RequiredEquipment[1] = ""; // Remove pistol.
	 I = P.FindInventoryType(Class'WTFEquipMachinePistol');
	 if( I!=None ) I.Destroy(); // Delete if already given.
	 KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Glock18", GetCostScaling(KFPRI, class'Glock18Pickup'));
	 Super.AddDefaultInventory(KFPRI,P);
	
	// If Level 11-20 they get custom p90
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 25 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.P90DT", GetCostScaling(KFPRI, class'P90DTPickup'));
		
	// If Level 21-30 they get Protecta
	if ( KFPRI.ClientVeteranSkillLevel >= 26 && KFPRI.ClientVeteranSkillLevel <= 35 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Protecta", GetCostScaling(KFPRI, class'ProtectaPickup'));
		
	// If Level 41-50 they get Stinger
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Stinger", GetCostScaling(KFPRI, class'StingerPickup'));
		
	
}


static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%r",GetPercentStr(0.0 + 0.00*float(Level)));
	return S;
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="10% Extra Damage With General Weapons|10% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|2% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(2)="20% Extra Damage With General Weapons|20% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|4% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(3)="30% Extra Damage With General Weapons|30% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|6% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(4)="40% Extra Damage With General Weapons|40% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|8% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(5)="50% Extra Damage With General Weapons|50% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|10% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(6)="60% Extra Damage With General Weapons|60% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|12% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(7)="70% Extra Damage With General Weapons|70% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|14% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(8)="80% Extra Damage With General Weapons|80% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|16% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(9)="90% Extra Damage With General Weapons|90% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|18% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(10)="100% Extra Damage With General Weapons|100% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|70% Discount On General Weapons|20% Faster Reload Speed With General Weapons|Spawn With A Glock18"
     SRLevelEffects(11)="110% Extra Damage With General Weapons|20% Less Recoil With General Weapons|110% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|22% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(12)="120% Extra Damage With General Weapons|20% Less Recoil With General Weapons|120% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|24% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(13)="130% Extra Damage With General Weapons|20% Less Recoil With General Weapons|130% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|26% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(14)="140% Extra Damage With General Weapons|20% Less Recoil With General Weapons|140% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|28% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(15)="150% Extra Damage With General Weapons|20% Less Recoil With General Weapons|150% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|30% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(16)="160% Extra Damage With General Weapons|20% Less Recoil With General Weapons|160% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|32% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(17)="170% Extra Damage With General Weapons|20% Less Recoil With General Weapons|170% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|34% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(18)="180% Extra Damage With General Weapons|20% Less Recoil With General Weapons|180% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|36% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(19)="190% Extra Damage With General Weapons|20% Less Recoil With General Weapons|190% Extra Ammo With General Weapons|Regen 1 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|38% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(20)="200% Extra Damage With General Weapons|20% Less Recoil With General Weapons|200% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|75% Discount On General Weapons|40% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(21)="210% Extra Damage With General Weapons|40% Less Recoil With General Weapons|210% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|42% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(22)="220% Extra Damage With General Weapons|40% Less Recoil With General Weapons|220% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|44% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(23)="230% Extra Damage With General Weapons|40% Less Recoil With General Weapons|230% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|46% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(24)="240% Extra Damage With General Weapons|40% Less Recoil With General Weapons|240% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|48% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(25)="250% Extra Damage With General Weapons|40% Less Recoil With General Weapons|250% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|50% Faster Reload Speed With General Weapons|Spawn With A Custom P90"
     SRLevelEffects(26)="260% Extra Damage With General Weapons|40% Less Recoil With General Weapons|260% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|52% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(27)="270% Extra Damage With General Weapons|40% Less Recoil With General Weapons|270% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|54% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(28)="280% Extra Damage With General Weapons|40% Less Recoil With General Weapons|280% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|56% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(29)="290% Extra Damage With General Weapons|40% Less Recoil With General Weapons|290% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|58% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(30)="300% Extra Damage With General Weapons|40% Less Recoil With General Weapons|300% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-25% Movement Speed|80% Discount On General Weapons|60% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(31)="310% Extra Damage With General Weapons|60% Less Recoil With General Weapons|310% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|62% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(32)="320% Extra Damage With General Weapons|60% Less Recoil With General Weapons|320% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|64% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(33)="330% Extra Damage With General Weapons|60% Less Recoil With General Weapons|330% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|66% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(34)="340% Extra Damage With General Weapons|60% Less Recoil With General Weapons|340% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|68% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(35)="350% Extra Damage With General Weapons|60% Less Recoil With General Weapons|350% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|70% Faster Reload Speed With General Weapons|Spawn With A Protecta"
     SRLevelEffects(36)="360% Extra Damage With General Weapons|60% Less Recoil With General Weapons|360% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|72% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(37)="370% Extra Damage With General Weapons|60% Less Recoil With General Weapons|370% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|74% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(38)="380% Extra Damage With General Weapons|60% Less Recoil With General Weapons|380% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|76% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(39)="390% Extra Damage With General Weapons|60% Less Recoil With General Weapons|390% Extra Ammo With General Weapons|Regen 2 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|78% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(40)="400% Extra Damage With General Weapons|60% Less Recoil With General Weapons|400% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|-10% Movement Speed|85% Discount On General Weapons|80% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(41)="410% Extra Damage With General Weapons|80% Less Recoil With General Weapons|410% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|82% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(42)="420% Extra Damage With General Weapons|80% Less Recoil With General Weapons|420% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|84% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(43)="430% Extra Damage With General Weapons|80% Less Recoil With General Weapons|430% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|86% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(44)="440% Extra Damage With General Weapons|80% Less Recoil With General Weapons|440% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|88% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(45)="450% Extra Damage With General Weapons|80% Less Recoil With General Weapons|450% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|90% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(46)="460% Extra Damage With General Weapons|80% Less Recoil With General Weapons|460% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|92% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(47)="470% Extra Damage With General Weapons|80% Less Recoil With General Weapons|470% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|94% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(48)="480% Extra Damage With General Weapons|80% Less Recoil With General Weapons|480% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|96% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(49)="490% Extra Damage With General Weapons|80% Less Recoil With General Weapons|490% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|90% Discount On General Weapons|98% Faster Reload Speed With General Weapons|Spawn With A Stinger"
     SRLevelEffects(50)="500% Extra Damage With General Weapons|100% Less Recoil With General Weapons|500% Extra Ammo With General Weapons|Regen 3 Health, Ammo, Armor Of Players Around You Every 3 Seconds|+20% Movement Speed|95% Discount On General Weapons|100% Faster Reload Speed With General Weapons|Spawn With A Stinger & Body Armor"
     PerkIndex=51
     OnHUDIcon=Texture'NetskyT.Perk_General_Red'
     OnHUDGoldIcon=Texture'NetskyT.Perk_General_Gold'
     VeterancyName="The General"
     Requirements(0)="Deal %x Damage with General weapons"
}
