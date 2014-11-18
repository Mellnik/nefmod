class WTFPerksFieldMedic extends SRVeterancyTypes
	abstract;

var array<int> progressArray;

static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'MedicProgress');
	Class'MP5MFire'.Default.DamageType = Class'DamTypeMP5M';
	Class'MP7MFireExt'.Default.DamageType = Class'DamTypeMP7MExt';
	Class'KrissMFireA'.Default.DamageType = Class'DamTypeKrissMA';
	Class'M7A3MFireExt'.Default.DamageType = Class'DamTypeM7A3MExt';
	Class'XMk5Fire'.Default.DamageType = Class'DamTypeMedicProgress';
}

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 1;
		break;
	case 1:
		FinalInt = 100000;
		break;
	case 2:
		FinalInt = 200000;
		break;
	case 3:
		FinalInt = 300000;
		break;
	case 4:
		FinalInt = 400000;
		break;
	case 5:
		FinalInt = 500000;
		break;
	case 6:
		FinalInt = 600000;
		break;
	case 7:
		FinalInt = 700000;
		break;
	case 8:
		FinalInt = 800000;
		break;
	case 9:
		FinalInt = 900000;
		break;
	case 10:
		FinalInt = 1000000;
		break;
	case 11:
		FinalInt = 1100000;
		break;
	case 12:
		FinalInt = 1200000;
		break;
	case 13:
		FinalInt = 1300000;
		break;
	case 14:
		FinalInt = 1400000;
		break;
	case 15:
		FinalInt = 1500000;
		break;
	case 16:
		FinalInt = 1600000;
		break;
	case 17:
		FinalInt = 1700000;
		break;
	case 18:
		FinalInt = 1800000;
		break;
	case 19:
		FinalInt = 1900000;
		break;
	case 20:
		FinalInt = 2000000;
		break;
	case 21:
		FinalInt = 2100000;
		break;
	case 22:
		FinalInt = 2200000;
		break;
	case 23:
		FinalInt = 2300000;
		break;
	case 24:
		FinalInt = 2400000;
		break;
	case 25:
		FinalInt = 2500000;
		break;
	case 26:
		FinalInt = 2600000;
		break;
	case 27:
		FinalInt = 2700000;
		break;
	case 28:
		FinalInt = 2800000;
		break;
	case 29:
		FinalInt = 2900000;
		break;
	case 30:
		FinalInt = 3000000;
		break;
	case 31:
		FinalInt = 3100000;
		break;
	case 32:
		FinalInt = 3200000;
		break;
	case 33:
		FinalInt = 3300000;
		break;
	case 34:
		FinalInt = 3400000;
		break;
	case 35:
		FinalInt = 3500000;
		break;
	case 36:
		FinalInt = 3600000;
		break;
	case 37:
		FinalInt = 3700000;
		break;
	case 38:
		FinalInt = 3800000;
		break;
	case 39:
		FinalInt = 3900000;
		break;
	case 40:
		FinalInt = 4000000;
		break;
	case 41:
		FinalInt = 4100000;
		break;
	case 42:
		FinalInt = 4200000;
		break;
	case 43:
		FinalInt = 4300000;
		break;
	case 44:
		FinalInt = 4400000;
		break;
	case 45:
		FinalInt = 4500000;
		break;
	case 46:
		FinalInt = 4600000;
		break;
	case 47:
		FinalInt = 4700000;
		break;
	case 48:
		FinalInt = 4800000;
		break;
	case 49:
		FinalInt = 4900000;
		break;
	case 50:
		FinalInt = 5000000;
		break;
	default:
		FinalInt = 5000000+GetDoubleScaling(CurLevel,0);
	}
	return Min(StatOther.GetCustomValueInt(Class'MedicProgress'),FinalInt);
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeMP7MExt' || DmgType == class'DamTypeMP5M' || DmgType == class'DamTypeHealingKatana' || DmgType == class'DamTypeMedSentryFire' || 
		 DmgType == class'DamTypeKrissMA' || DmgType == class'DamTypeMedicNade' || DmgType == class'DamTypeM7A3MExt' || DmgType == class'DamTypeMedicProgress' ) 
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

static function float GetSyringeChargeRate(KFPlayerReplicationInfo KFPRI)
{

	return 1.0 + (0.20 * float(KFPRI.ClientVeteranSkillLevel)); // Recharges 500% faster at lv50
}

//static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI)
static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI, KFGameReplicationInfo KFGRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 1 )
		return 1.0;
	return 1.0 + (0.02 * float(KFPRI.ClientVeteranSkillLevel)); // Moves up to 60% faster
}

static function float GetHealPotency(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return 1.00;
	else if ( KFPRI.ClientVeteranSkillLevel == 1 )
		return 1.04;
	else if ( KFPRI.ClientVeteranSkillLevel == 2 )
		return 1.08;
	else if ( KFPRI.ClientVeteranSkillLevel == 3 )
		return 1.12;
	else if ( KFPRI.ClientVeteranSkillLevel == 4 )
		return 1.16;
	else if ( KFPRI.ClientVeteranSkillLevel == 5 )
		return 1.20;
	else if ( KFPRI.ClientVeteranSkillLevel == 6 )
		return 1.24; // Heals 42% more
	else if ( KFPRI.ClientVeteranSkillLevel == 7 )
		return 1.28;
	else if ( KFPRI.ClientVeteranSkillLevel == 8 )
		return 1.32;
	else if ( KFPRI.ClientVeteranSkillLevel == 9 )
		return 1.36;
	else if ( KFPRI.ClientVeteranSkillLevel == 10 )
		return 1.40;
	else if ( KFPRI.ClientVeteranSkillLevel == 11 )
		return 1.44;
	else if ( KFPRI.ClientVeteranSkillLevel == 12 )
		return 1.48;
	else if ( KFPRI.ClientVeteranSkillLevel == 13 )
		return 1.52;
	else if ( KFPRI.ClientVeteranSkillLevel == 14 )
		return 1.56;
	else if ( KFPRI.ClientVeteranSkillLevel == 15 )
		return 1.60;
	else if ( KFPRI.ClientVeteranSkillLevel == 16 )
		return 1.64;
	else if ( KFPRI.ClientVeteranSkillLevel == 17 )
		return 1.68;
	else if ( KFPRI.ClientVeteranSkillLevel == 18 )
		return 1.72;
	else if ( KFPRI.ClientVeteranSkillLevel == 19 )
		return 1.76;
	else if ( KFPRI.ClientVeteranSkillLevel == 20 )
		return 1.80;
	else if ( KFPRI.ClientVeteranSkillLevel == 21 )
		return 1.84;
	else if ( KFPRI.ClientVeteranSkillLevel == 22 )
		return 1.88;
	else if ( KFPRI.ClientVeteranSkillLevel == 23 )
		return 1.92;
	else if ( KFPRI.ClientVeteranSkillLevel == 24 )
		return 1.96;
	else if ( KFPRI.ClientVeteranSkillLevel == 25 )
		return 2.00;
	else if ( KFPRI.ClientVeteranSkillLevel == 26 )
		return 2.04;
	else if ( KFPRI.ClientVeteranSkillLevel == 27 )
		return 2.08;
	else if ( KFPRI.ClientVeteranSkillLevel == 28 )
		return 2.12;
	else if ( KFPRI.ClientVeteranSkillLevel == 29 )
		return 2.16;
	else if ( KFPRI.ClientVeteranSkillLevel == 30 )
		return 2.20;
	else if ( KFPRI.ClientVeteranSkillLevel == 31 )
		return 2.24;
	else if ( KFPRI.ClientVeteranSkillLevel == 32 )
		return 2.28;
	else if ( KFPRI.ClientVeteranSkillLevel == 33 )
		return 2.32;
	else if ( KFPRI.ClientVeteranSkillLevel == 34 )
		return 2.36;
	else if ( KFPRI.ClientVeteranSkillLevel == 35 )
		return 2.40;
	else if ( KFPRI.ClientVeteranSkillLevel == 36 )
		return 2.44;
	else if ( KFPRI.ClientVeteranSkillLevel == 37 )
		return 2.48;
	else if ( KFPRI.ClientVeteranSkillLevel == 38 )
		return 2.52;
	else if ( KFPRI.ClientVeteranSkillLevel == 39 )
		return 2.56;
	else if ( KFPRI.ClientVeteranSkillLevel == 40 )
		return 2.60;
	else if ( KFPRI.ClientVeteranSkillLevel == 41 )
		return 2.64;
	else if ( KFPRI.ClientVeteranSkillLevel == 42 )
		return 2.68;
	else if ( KFPRI.ClientVeteranSkillLevel == 43 )
		return 2.72;
	else if ( KFPRI.ClientVeteranSkillLevel == 44 )
		return 2.76;
	else if ( KFPRI.ClientVeteranSkillLevel == 45 )
		return 2.80;
	else if ( KFPRI.ClientVeteranSkillLevel == 46 )
		return 2.84;
	else if ( KFPRI.ClientVeteranSkillLevel == 47 )
		return 2.88;
	else if ( KFPRI.ClientVeteranSkillLevel == 48 )
		return 2.92;
	else if ( KFPRI.ClientVeteranSkillLevel == 49 )
		return 2.96;
	else if ( KFPRI.ClientVeteranSkillLevel == 50 )
		return 3.00; 
		
		

}


//Reduce Vomit damage
//static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, KFMonster DamageTaker, int InDamage, class<DamageType> DmgType)
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeVomit' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return float(InDamage) * 0.98;
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			return float(InDamage) * 0.96;
		else if ( KFPRI.ClientVeteranSkillLevel == 3 )
			return float(InDamage) * 0.94;
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
			return float(InDamage) * 0.92;
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
			return float(InDamage) * 0.90;
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			return float(InDamage) * 0.88;
		else if ( KFPRI.ClientVeteranSkillLevel == 7 )
			return float(InDamage) * 0.86;
		else if ( KFPRI.ClientVeteranSkillLevel == 8 )
			return float(InDamage) * 0.84;
		else if ( KFPRI.ClientVeteranSkillLevel == 9 )
			return float(InDamage) * 0.82;
		else if ( KFPRI.ClientVeteranSkillLevel == 10)
			return float(InDamage) * 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 11 )
			return float(InDamage) * 0.78;
		else if ( KFPRI.ClientVeteranSkillLevel == 12 )
			return float(InDamage) * 0.76;
		else if ( KFPRI.ClientVeteranSkillLevel == 13 )
			return float(InDamage) * 0.74;
		else if ( KFPRI.ClientVeteranSkillLevel == 14 )
			return float(InDamage) * 0.72;
		else if ( KFPRI.ClientVeteranSkillLevel == 15 )
			return float(InDamage) * 0.70;
		else if ( KFPRI.ClientVeteranSkillLevel == 16 )
			return float(InDamage) * 0.68;
		else if ( KFPRI.ClientVeteranSkillLevel == 17 )
			return float(InDamage) * 0.66;
		else if ( KFPRI.ClientVeteranSkillLevel == 18 )
			return float(InDamage) * 0.64;
		else if ( KFPRI.ClientVeteranSkillLevel == 19 )
			return float(InDamage) * 0.62;
		else if ( KFPRI.ClientVeteranSkillLevel == 20 )
			return float(InDamage) * 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 21 )
			return float(InDamage) * 0.58;
		else if ( KFPRI.ClientVeteranSkillLevel == 22 )
			return float(InDamage) * 0.56;
		else if ( KFPRI.ClientVeteranSkillLevel == 23 )
			return float(InDamage) * 0.54;
		else if ( KFPRI.ClientVeteranSkillLevel == 24 )
			return float(InDamage) * 0.52;
		else if ( KFPRI.ClientVeteranSkillLevel == 25 )
			return float(InDamage) * 0.50;
		else if ( KFPRI.ClientVeteranSkillLevel == 26 )
			return float(InDamage) * 0.48;
		else if ( KFPRI.ClientVeteranSkillLevel == 27 )
			return float(InDamage) * 0.46;
		else if ( KFPRI.ClientVeteranSkillLevel == 28 )
			return float(InDamage) * 0.44;
		else if ( KFPRI.ClientVeteranSkillLevel == 29 )
			return float(InDamage) * 0.42;
		else if ( KFPRI.ClientVeteranSkillLevel == 30 )
			return float(InDamage) * 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 31 )
			return float(InDamage) * 0.38;
		else if ( KFPRI.ClientVeteranSkillLevel == 32 )
			return float(InDamage) * 0.36;
		else if ( KFPRI.ClientVeteranSkillLevel == 33 )
			return float(InDamage) * 0.34;
		else if ( KFPRI.ClientVeteranSkillLevel == 34 )
			return float(InDamage) * 0.32;
		else if ( KFPRI.ClientVeteranSkillLevel == 35 )
			return float(InDamage) * 0.30;
		else if ( KFPRI.ClientVeteranSkillLevel == 36 )
			return float(InDamage) * 0.28;
		else if ( KFPRI.ClientVeteranSkillLevel == 37 )
			return float(InDamage) * 0.26;
		else if ( KFPRI.ClientVeteranSkillLevel == 38 )
			return float(InDamage) * 0.24;
		else if ( KFPRI.ClientVeteranSkillLevel == 39 )
			return float(InDamage) * 0.22;
		else if ( KFPRI.ClientVeteranSkillLevel == 40 )
			return float(InDamage) * 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 41 )
			return float(InDamage) * 0.18;
		else if ( KFPRI.ClientVeteranSkillLevel == 42 )
			return float(InDamage) * 0.16;
		else if ( KFPRI.ClientVeteranSkillLevel == 43 )
			return float(InDamage) * 0.14;
		else if ( KFPRI.ClientVeteranSkillLevel == 44 )
			return float(InDamage) * 0.12;
		else if ( KFPRI.ClientVeteranSkillLevel == 45 )
			return float(InDamage) * 0.10;
		else if ( KFPRI.ClientVeteranSkillLevel == 46 )
			return float(InDamage) * 0.08;
		else if ( KFPRI.ClientVeteranSkillLevel == 47 )
			return float(InDamage) * 0.06;
		else if ( KFPRI.ClientVeteranSkillLevel == 48 )
			return float(InDamage) * 0.04;
		else if ( KFPRI.ClientVeteranSkillLevel == 49 )
			return float(InDamage) * 0.02;
		else if ( KFPRI.ClientVeteranSkillLevel == 50 )
			return float(InDamage) * 0.00; //100% resistance to bloat bile
		
	}
	return InDamage;
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
    if ( MP7MMedicGunExt(Other) != none || KrissMMedicGunA(Other) != none || M7A3MMedicGunExt(Other) != none || MP5MMedicGun(Other) != none || XMk5SMG(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.03 * float(KFPRI.ClientVeteranSkillLevel)); // 100% increase in MP7 Medic weapon ammo carry
	return 1.0;
}

static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
   	if ( MP7MAmmoExt(Other) != none || KrissMAmmoA(Other) != none || M7A3MAmmoExt(Other) != none || MP5MAmmo(Other) != none || XMk5Ammo(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.03 * float(KFPRI.ClientVeteranSkillLevel)); // 100% increase in MP7 Medic weapon ammo carry
	return 1.0;
}

//Reload speed bonus for medguns
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( MP7MMedicGunExt(Other) != none || KrissMMedicGunA(Other) != none || MP5MMedicGun(Other) != none || M7A3MMedicGunExt(Other) != none || XMk5SMG(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.02 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 60% faster reload with Medguns
	return 1.0 + super.GetReloadSpeedModifier(KFPRI, Other);
}

//Recoil LVP
static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
		return Recoil - (1-super.ModifyRecoilSpread(KFPRI, Other, Recoil));
}


static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
   	if ( Item == class'Vest' || Item == class'KrissMPickupA' || Item == class'HealingKatanaPickup' || Item == class'MP7MPickupExt' || Item == class'M7A3MPickupExt' || Item == class'MP5MPickup' || Item == class'MP5PickupExtend' || Item == class'XMk5Pickup' || Item == class'MP7MPickup' )
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

   	if ( Item == class'MedSentryGunPickup'  )
		if ( KFPRI.ClientVeteranSkillLevel > 0 )		
		{
			if ( KFPRI.ClientVeteranSkillLevel >= 1 )
				return 0.25;
		}
	return 1.0;
}

// Reduce damage when wearing Armor
static function float GetBodyArmorDamageModifier(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel == 1 )
		return 0.97;  // 3% Better body armor
	if ( KFPRI.ClientVeteranSkillLevel == 2 )
		return 0.94;  // 6% Better body armor
	if ( KFPRI.ClientVeteranSkillLevel == 3 )
		return 0.91;  // 9% Better body armor
	if ( KFPRI.ClientVeteranSkillLevel == 4 )
		return 0.88;  // 12% Better body armor
	if ( KFPRI.ClientVeteranSkillLevel == 5 )
		return 0.85;  // 15% Better body armor	
	if ( KFPRI.ClientVeteranSkillLevel == 6 )
		return 0.82;  // 18% Better body armor
	if ( KFPRI.ClientVeteranSkilllevel == 7 )
		return 0.79;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 8 )
		return 0.76;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 9 )
		return 0.73;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 10 )
		return 0.70;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 11 )
		return 0.67;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 12 )
		return 0.64;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 13 )
		return 0.61;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 14 )
		return 0.58;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 15 )
		return 0.55;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 16 )
		return 0.52;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 17 )
		return 0.49;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 18 )
		return 0.46;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 19 )
		return 0.43;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 20 )
		return 0.40;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 21 )
		return 0.39;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 22 )
		return 0.38;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 23 )
		return 0.37;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 24 )
		return 0.36;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 25 )
		return 0.35;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 26 )
		return 0.34;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 27 )
		return 0.33;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 28 )
		return 0.32;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 29 )
		return 0.31;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 30 )
		return 0.30;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 31 )
		return 0.29;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 32 )
		return 0.28;  //
	if ( KFPRI.ClientVeteranSkilllevel == 33 )
		return 0.27;  // 		
	if ( KFPRI.ClientVeteranSkilllevel == 34 )
		return 0.26;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 35 )
		return 0.25;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 36 )
		return 0.24;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 37 )
		return 0.23;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 38 )
		return 0.22;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 39 )
		return 0.21;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 40 )
		return 0.20;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 41 )
		return 0.19;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 42 )
		return 0.18;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 43 )
		return 0.17;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 44 )
		return 0.16;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 45 )
		return 0.15;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 46 )
		return 0.14;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 47 )
		return 0.13;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 48 )
		return 0.12;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 49 )
		return 0.11;  // 
	if ( KFPRI.ClientVeteranSkilllevel == 50 )
		return 0.10;  // 90% better body armor
		
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If level 1-10 give them Healing Katana
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 10)
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.HealingKatana", GetCostScaling(KFPRI, class'HealingKatanaPickup'));
	
	// If level 11-20 give them MP7
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 20)
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.MP7MMedicGunExt", GetCostScaling(KFPRI, class'MP7MPickupExt'));
	
	// If level 21-30 give them MP5
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 30)
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.MP5MMedicGun", GetCostScaling(KFPRI, class'MP5PickupExtend'));
	
	// If level 31-40 give them Kriss
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40)
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.KrissMMedicGunA", GetCostScaling(KFPRI, class'KrissMPickupA'));
	
	// If level 41-50 give them WTF MP7
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 50)
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.MP7MMedicGunExt", GetCostScaling(KFPRI, class'MP7MPickupExt'));
	
	// If Level 11 or Higher, give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 11 )
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
     SRLevelEffects(1)="10% More Damage With Medic Weapons|10% Faster Syringe Recharge|4% More Potent Medical Injections|2% Less Damage From Bloat Bile|2% Faster Movement Speed|3% Larger Clipsize With Medic Weapons|3% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|2% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(2)="20% More Damage With Medic Weapons|20% Faster Syringe Recharge|8% More Potent Medical Injections|4% Less Damage From Bloat Bile|4% Faster Movement Speed|6% Larger Clipsize With Medic Weapons|6% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|4% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(3)="30% More Damage With Medic Weapons|30% Faster Syringe Recharge|12% More Potent Medical Injections|6% Less Damage From Bloat Bile|6% Faster Movement Speed|9% Larger Clipsize With Medic Weapons|9% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|6% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(4)="40% More Damage With Medic Weapons|40% Faster Syringe Recharge|16% More Potent Medical Injections|8% Less Damage From Bloat Bile|8% Faster Movement Speed|12% Larger Clipsize With Medic Weapons|12% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|8% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(5)="50% More Damage With Medic Weapons|50% Faster Syringe Recharge|20% More Potent Medical Injections|10% Less Damage From Bloat Bile|10% Faster Movement Speed|15% Larger Clipsize With Medic Weapons|15% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|10% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(6)="60% More Damage With Medic Weapons|60% Faster Syringe Recharge|24% More Potent Medical Injections|12% Less Damage From Bloat Bile|12% Faster Movement Speed|18% Larger Clipsize With Medic Weapons|18% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|12% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(7)="70% More Damage With Medic Weapons|70% Faster Syringe Recharge|28% More Potent Medical Injections|14% Less Damage From Bloat Bile|14% Faster Movement Speed|21% Larger Clipsize With Medic Weapons|21% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|14% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(8)="80% More Damage With Medic Weapons|80% Faster Syringe Recharge|32% More Potent Medical Injections|16% Less Damage From Bloat Bile|16% Faster Movement Speed|24% Larger Clipsize With Medic Weapons|24% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|16% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(9)="90% More Damage With Medic Weapons|90% Faster Syringe Recharge|36% More Potent Medical Injections|18% Less Damage From Bloat Bile|18% Faster Movement Speed|27% Larger Clipsize With Medic Weapons|27% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|18% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(10)="100% More Damage With Medic Weapons|100% Faster Syringe Recharge|40% More Potent Medical Injections|20% Less Damage From Bloat Bile|20% Faster Movement Speed|30% Larger Clipsize With Medic Weapons|30% Better Body Armor|70% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|20% Faster Reload With Medic Weapons|Spawn With An Healing Katana"
     SRLevelEffects(11)="110% More Damage With Medic Weapons|110% Faster Syringe Recharge|44% More Potent Medical Injections|22% Less Damage From Bloat Bile|22% Faster Movement Speed|33% Larger Clipsize With Medic Weapons|33% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|22% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(12)="120% More Damage With Medic Weapons|120% Faster Syringe Recharge|48% More Potent Medical Injections|24% Less Damage From Bloat Bile|24% Faster Movement Speed|36% Larger Clipsize With Medic Weapons|36% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|24% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(13)="130% More Damage With Medic Weapons|130% Faster Syringe Recharge|52% More Potent Medical Injections|26% Less Damage From Bloat Bile|26% Faster Movement Speed|39% Larger Clipsize With Medic Weapons|39% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|26% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(14)="140% More Damage With Medic Weapons|140% Faster Syringe Recharge|56% More Potent Medical Injections|28% Less Damage From Bloat Bile|28% Faster Movement Speed|42% Larger Clipsize With Medic Weapons|42% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|28% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(15)="150% More Damage With Medic Weapons|150% Faster Syringe Recharge|60% More Potent Medical Injections|30% Less Damage From Bloat Bile|30% Faster Movement Speed|45% Larger Clipsize With Medic Weapons|45% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|30% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(16)="160% More Damage With Medic Weapons|160% Faster Syringe Recharge|64% More Potent Medical Injections|32% Less Damage From Bloat Bile|32% Faster Movement Speed|48% Larger Clipsize With Medic Weapons|48% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|32% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(17)="170% More Damage With Medic Weapons|170% Faster Syringe Recharge|68% More Potent Medical Injections|34% Less Damage From Bloat Bile|34% Faster Movement Speed|51% Larger Clipsize With Medic Weapons|51% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|34% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(18)="180% More Damage With Medic Weapons|180% Faster Syringe Recharge|72% More Potent Medical Injections|36% Less Damage From Bloat Bile|36% Faster Movement Speed|54% Larger Clipsize With Medic Weapons|54% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|36% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(19)="190% More Damage With Medic Weapons|190% Faster Syringe Recharge|76% More Potent Medical Injections|38% Less Damage From Bloat Bile|38% Faster Movement Speed|57% Larger Clipsize With Medic Weapons|57% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|38% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(20)="200% More Damage With Medic Weapons|200% Faster Syringe Recharge|80% More Potent Medical Injections|40% Less Damage From Bloat Bile|40% Faster Movement Speed|60% Larger Clipsize With Medic Weapons|60% Better Body Armor|75% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|40% Faster Reload With Medic Weapons|Spawn With An MP7 & Armor"
     SRLevelEffects(21)="210% More Damage With Medic Weapons|210% Faster Syringe Recharge|84% More Potent Medical Injections|42% Less Damage From Bloat Bile|42% Faster Movement Speed|63% Larger Clipsize With Medic Weapons|61% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|42% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(22)="220% More Damage With Medic Weapons|220% Faster Syringe Recharge|88% More Potent Medical Injections|44% Less Damage From Bloat Bile|44% Faster Movement Speed|66% Larger Clipsize With Medic Weapons|62% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|44% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(23)="230% More Damage With Medic Weapons|230% Faster Syringe Recharge|92% More Potent Medical Injections|46% Less Damage From Bloat Bile|46% Faster Movement Speed|69% Larger Clipsize With Medic Weapons|63% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|46% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(24)="240% More Damage With Medic Weapons|240% Faster Syringe Recharge|96% More Potent Medical Injections|48% Less Damage From Bloat Bile|48% Faster Movement Speed|72% Larger Clipsize With Medic Weapons|64% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|48% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(25)="250% More Damage With Medic Weapons|250% Faster Syringe Recharge|100% More Potent Medical Injections|50% Less Damage From Bloat Bile|50% Faster Movement Speed|75% Larger Clipsize With Medic Weapons|65% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|50% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(26)="260% More Damage With Medic Weapons|260% Faster Syringe Recharge|104% More Potent Medical Injections|52% Less Damage From Bloat Bile|52% Faster Movement Speed|78% Larger Clipsize With Medic Weapons|66% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|52% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(27)="270% More Damage With Medic Weapons|270% Faster Syringe Recharge|108% More Potent Medical Injections|54% Less Damage From Bloat Bile|54% Faster Movement Speed|81% Larger Clipsize With Medic Weapons|67% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|54% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(28)="280% More Damage With Medic Weapons|280% Faster Syringe Recharge|112% More Potent Medical Injections|56% Less Damage From Bloat Bile|56% Faster Movement Speed|84% Larger Clipsize With Medic Weapons|68% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|56% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(29)="290% More Damage With Medic Weapons|290% Faster Syringe Recharge|116% More Potent Medical Injections|58% Less Damage From Bloat Bile|58% Faster Movement Speed|87% Larger Clipsize With Medic Weapons|69% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|58% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(30)="300% More Damage With Medic Weapons|300% Faster Syringe Recharge|120% More Potent Medical Injections|60% Less Damage From Bloat Bile|60% Faster Movement Speed|90% Larger Clipsize With Medic Weapons|70% Better Body Armor|80% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|60% Faster Reload With Medic Weapons|Spawn With An MP5 & Armor"
     SRLevelEffects(31)="310% More Damage With Medic Weapons|310% Faster Syringe Recharge|124% More Potent Medical Injections|62% Less Damage From Bloat Bile|60% Faster Movement Speed|93% Larger Clipsize With Medic Weapons|71% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|62% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(32)="320% More Damage With Medic Weapons|320% Faster Syringe Recharge|128% More Potent Medical Injections|64% Less Damage From Bloat Bile|60% Faster Movement Speed|96% Larger Clipsize With Medic Weapons|72% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|64% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(33)="330% More Damage With Medic Weapons|330% Faster Syringe Recharge|132% More Potent Medical Injections|66% Less Damage From Bloat Bile|60% Faster Movement Speed|99% Larger Clipsize With Medic Weapons|73% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|66% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(34)="340% More Damage With Medic Weapons|340% Faster Syringe Recharge|136% More Potent Medical Injections|68% Less Damage From Bloat Bile|60% Faster Movement Speed|102% Larger Clipsize With Medic Weapons|74% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|68% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(35)="350% More Damage With Medic Weapons|350% Faster Syringe Recharge|140% More Potent Medical Injections|70% Less Damage From Bloat Bile|60% Faster Movement Speed|105% Larger Clipsize With Medic Weapons|75% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|70% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(36)="360% More Damage With Medic Weapons|360% Faster Syringe Recharge|144% More Potent Medical Injections|72% Less Damage From Bloat Bile|60% Faster Movement Speed|108% Larger Clipsize With Medic Weapons|76% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|72% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(37)="370% More Damage With Medic Weapons|370% Faster Syringe Recharge|148% More Potent Medical Injections|74% Less Damage From Bloat Bile|60% Faster Movement Speed|111% Larger Clipsize With Medic Weapons|77% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|74% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(38)="380% More Damage With Medic Weapons|380% Faster Syringe Recharge|152% More Potent Medical Injections|76% Less Damage From Bloat Bile|60% Faster Movement Speed|114% Larger Clipsize With Medic Weapons|78% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|76% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(39)="390% More Damage With Medic Weapons|390% Faster Syringe Recharge|156% More Potent Medical Injections|78% Less Damage From Bloat Bile|60% Faster Movement Speed|117% Larger Clipsize With Medic Weapons|79% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|78% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(40)="400% More Damage With Medic Weapons|400% Faster Syringe Recharge|160% More Potent Medical Injections|80% Less Damage From Bloat Bile|60% Faster Movement Speed|120% Larger Clipsize With Medic Weapons|80% Better Body Armor|85% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|80% Faster Reload With Medic Weapons|Spawn With An Kriss & Armor"
     SRLevelEffects(41)="410% More Damage With Medic Weapons|410% Faster Syringe Recharge|164% More Potent Medical Injections|82% Less Damage From Bloat Bile|60% Faster Movement Speed|123% Larger Clipsize With Medic Weapons|81% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|82% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(42)="420% More Damage With Medic Weapons|420% Faster Syringe Recharge|168% More Potent Medical Injections|84% Less Damage From Bloat Bile|60% Faster Movement Speed|126% Larger Clipsize With Medic Weapons|82% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|84% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(43)="430% More Damage With Medic Weapons|430% Faster Syringe Recharge|172% More Potent Medical Injections|86% Less Damage From Bloat Bile|60% Faster Movement Speed|129% Larger Clipsize With Medic Weapons|83% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|86% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(44)="440% More Damage With Medic Weapons|440% Faster Syringe Recharge|176% More Potent Medical Injections|88% Less Damage From Bloat Bile|60% Faster Movement Speed|132% Larger Clipsize With Medic Weapons|84% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|88% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(45)="450% More Damage With Medic Weapons|450% Faster Syringe Recharge|180% More Potent Medical Injections|90% Less Damage From Bloat Bile|60% Faster Movement Speed|135% Larger Clipsize With Medic Weapons|85% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|90% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(46)="460% More Damage With Medic Weapons|460% Faster Syringe Recharge|184% More Potent Medical Injections|92% Less Damage From Bloat Bile|60% Faster Movement Speed|138% Larger Clipsize With Medic Weapons|86% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|92% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(47)="470% More Damage With Medic Weapons|470% Faster Syringe Recharge|188% More Potent Medical Injections|94% Less Damage From Bloat Bile|60% Faster Movement Speed|141% Larger Clipsize With Medic Weapons|87% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|94% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(48)="480% More Damage With Medic Weapons|480% Faster Syringe Recharge|192% More Potent Medical Injections|96% Less Damage From Bloat Bile|60% Faster Movement Speed|144% Larger Clipsize With Medic Weapons|88% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|96% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(49)="490% More Damage With Medic Weapons|490% Faster Syringe Recharge|196% More Potent Medical Injections|98% Less Damage From Bloat Bile|60% Faster Movement Speed|147% Larger Clipsize With Medic Weapons|89% Better Body Armor|90% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|98% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     SRLevelEffects(50)="500% More Damage With Medic Weapons|500% Faster Syringe Recharge|200% More Potent Medical Injections|100% Less Damage From Bloat Bile|60% Faster Movement Speed|150% Larger Clipsize With Medic Weapons|90% Better Body Armor|95% Discount On Medic Weapons & Body Armor|75% Discount On Medic Bot|100% Faster Reload With Medic Weapons|Spawn With An WTF MP7M2 & Armor"
     PerkIndex=0
     OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Medic'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Medic_Gold'
     VeterancyName="Field Medic"
     Requirements(0)="Deal %x Damage With Medic Weapons Or Healing"
}
