class WTFPerksMarine extends SRVeterancyTypes
	abstract;

var array<int> progressArray;

static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'MarineProgress');
	Class'M41AFire'.Default.DamageType = Class'DamTypeM41AAssaultRifle';
	Class'TT33Fire'.Default.DamageType = Class'DamTypeTT33';
	Class'STG44Fire'.Default.DamageType = Class'DamTypeSTG44';
	Class'G43Fire'.Default.DamageType = Class'DamTypeG43Scoped';
}

//Perk Progression
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
    return Min(StatOther.GetCustomValueInt(Class'MarineProgress'),FinalInt);
}

static function float GetWeldSpeedModifier(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 1 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel));
	return 3.0; // 200% increase in speed cap at level 20
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( M41AAssaultRifle(Other) != none || TT33(Other) != none || STG44(Other) != none || G43Scoped(Other) != none )
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

static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( M41AAmmo(Other) != none || TT33Ammo(Other) != none || STG44Ammo(Other) != none || G43Ammo(Other) != none )
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
	if ( AmmoType == class'M41AAmmo' || AmmoType == class'TT33Ammo' || AmmoType == class'STG44Ammo' || AmmoType == class'G43Ammo' )
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

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeM41AAssaultRifle' || DmgType == class'DamTypeTT33' || DmgType == class'DamTypeSTG44' || DmgType == class'DamTypeG43Scoped' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.00;
		return float(InDamage) * (1.00 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); // 10% per level cap at 500% at level 50
	}
	return InDamage;
}

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( M41AAssaultRifle(Other.Weapon) != none || TT33(Other.Weapon) != none || STG44(Other.Weapon) != none || G43Scoped(Other.Weapon) != none )
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
	if ( M41AAssaultRifle(Other) != none || TT33(Other) != none || STG44(Other) != none || G43Scoped(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.05 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 60% faster reload with Crossbow/Winchester/Handcannon
	}
	return 1.0 + super.GetReloadSpeedModifier(KFPRI, Other);
}

static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{	
	if ( Item == class'M41APickup' || Item == class'TT33Pickup' || Item == class'STG44Pickup' || Item == class'G43ScopePickup' )
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


//static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, KFMonster DamageTaker, int InDamage, class<DamageType> DmgType)
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
    return float(InDamage) * 0.85;
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 1-10, give them
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 10 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.TT33", GetCostScaling(KFPRI, class'TT33Pickup'));
		
	// If Level 11-30, give them
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 30 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.STG44", GetCostScaling(KFPRI, class'STG44Pickup'));
		
	// If Level 31-40, give them
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.G43Scoped", GetCostScaling(KFPRI, class'G43ScopePickup'));
		
	// If Level 41-50, give them a M41AAssaultRifle
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.M41AAssaultRifle", GetCostScaling(KFPRI, class'M41APickup'));
		
	
		
	// If Level 41-50, give them a Vest
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 50 )
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
     SRLevelEffects(1)="10% Bonus Damage With Marine Weapons|10% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|10% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(2)="20% Bonus Damage With Marine Weapons|20% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|20% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(3)="30% Bonus Damage With Marine Weapons|30% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|30% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(4)="40% Bonus Damage With Marine Weapons|40% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|40% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(5)="50% Bonus Damage With Marine Weapons|50% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|50% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(6)="60% Bonus Damage With Marine Weapons|60% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|60% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(7)="70% Bonus Damage With Marine Weapons|70% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|70% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(8)="80% Bonus Damage With Marine Weapons|80% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|80% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(9)="90% Bonus Damage With Marine Weapons|90% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|90% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(10)="100% Bonus Damage With Marine Weapons|100% Faster Reload Speed With Marine Weapons|5% Larger Clipsize With Marine Weapons|100% Faster Welding Speed|15% Reduced Damage|70% Discount On Marine Weapons|Spawn With A TT33"
     SRLevelEffects(11)="110% Bonus Damage With Marine Weapons|110% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|110% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(12)="120% Bonus Damage With Marine Weapons|120% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|120% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(13)="130% Bonus Damage With Marine Weapons|130% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|130% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(14)="140% Bonus Damage With Marine Weapons|140% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|140% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(15)="150% Bonus Damage With Marine Weapons|150% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|150% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(16)="160% Bonus Damage With Marine Weapons|160% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|160% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(17)="170% Bonus Damage With Marine Weapons|170% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|170% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(18)="180% Bonus Damage With Marine Weapons|180% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|180% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(19)="190% Bonus Damage With Marine Weapons|190% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|190% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(20)="200% Bonus Damage With Marine Weapons|200% Faster Reload Speed With Marine Weapons|20% Less Recoil With Marine Weapons|10% Larger Clipsize With Marine Weapons|200% Faster Welding Speed|15% Reduced Damage|75% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(21)="210% Bonus Damage With Marine Weapons|210% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|210% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(22)="220% Bonus Damage With Marine Weapons|220% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|220% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(23)="230% Bonus Damage With Marine Weapons|230% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|230% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(24)="240% Bonus Damage With Marine Weapons|240% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|240% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(25)="250% Bonus Damage With Marine Weapons|250% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|250% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(26)="260% Bonus Damage With Marine Weapons|260% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|260% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(27)="270% Bonus Damage With Marine Weapons|270% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|270% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(28)="280% Bonus Damage With Marine Weapons|280% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|280% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(29)="290% Bonus Damage With Marine Weapons|290% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|290% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(30)="300% Bonus Damage With Marine Weapons|300% Faster Reload Speed With Marine Weapons|40% Less Recoil With Marine Weapons|15% Larger Clipsize With Marine Weapons|300% Faster Welding Speed|15% Reduced Damage|80% Discount On Marine Weapons|Spawn With A STG44"
     SRLevelEffects(31)="310% Bonus Damage With Marine Weapons|310% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|310% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(32)="320% Bonus Damage With Marine Weapons|320% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|320% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(33)="330% Bonus Damage With Marine Weapons|330% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|330% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(34)="340% Bonus Damage With Marine Weapons|340% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|340% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(35)="350% Bonus Damage With Marine Weapons|350% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|350% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(36)="360% Bonus Damage With Marine Weapons|360% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|360% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(37)="370% Bonus Damage With Marine Weapons|370% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|370% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(38)="380% Bonus Damage With Marine Weapons|380% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|380% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(39)="390% Bonus Damage With Marine Weapons|390% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|390% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(40)="400% Bonus Damage With Marine Weapons|400% Faster Reload Speed With Marine Weapons|60% Less Recoil With Marine Weapons|20% Larger Clipsize With Marine Weapons|400% Faster Welding Speed|15% Reduced Damage|85% Discount On Marine Weapons|Spawn With A G43Scoped"
     SRLevelEffects(41)="410% Bonus Damage With Marine Weapons|410% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|410% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(42)="420% Bonus Damage With Marine Weapons|420% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|420% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(43)="430% Bonus Damage With Marine Weapons|430% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|430% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(44)="440% Bonus Damage With Marine Weapons|440% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|440% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(45)="450% Bonus Damage With Marine Weapons|450% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|450% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(46)="460% Bonus Damage With Marine Weapons|460% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|460% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(47)="470% Bonus Damage With Marine Weapons|470% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|470% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(48)="480% Bonus Damage With Marine Weapons|480% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|480% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(49)="490% Bonus Damage With Marine Weapons|490% Faster Reload Speed With Marine Weapons|80% Less Recoil With Marine Weapons|25% Larger Clipsize With Marine Weapons|490% Faster Welding Speed|15% Reduced Damage|90% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     SRLevelEffects(50)="500% Bonus Damage With Marine Weapons|500% Faster Reload Speed With Marine Weapons|100% Less Recoil With Marine Weapons|30% Larger Clipsize With Marine Weapons|500% Faster Welding Speed|15% Reduced Damage|95% Discount On Marine Weapons|Spawn With A M41AAssaultRifle & Body Armor"
     PerkIndex=7
     OnHUDIcon=Texture'NetskyT.Perk_Marine_RED'
     OnHUDGoldIcon=Texture'NetskyT.Perk_Marine_Gold'
     VeterancyName="Colonial Marine"
     Requirements(0)="Deal %x Damage with Marine Weapons."
}
