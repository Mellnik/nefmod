class WTFPerksCommando extends SRVeterancyTypes
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
	return Min(StatOther.RBullpupDamageStat,FinalInt);
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
				MaxDistanceSquared = 62500; //(250 units) 5 meters
				break;
			case 11:
				MaxDistanceSquared = 202500; //(450 units) 9 meters
				break;
			case 21:
				MaxDistanceSquared = 422500; //(650 units) 13 meters
				break;
			case 31:
				MaxDistanceSquared = 722500; //(850 units) 17 meters
				break;
			case 41:
				MaxDistanceSquared = 1102500; //(1050 units) 21 meters
				break;
			case 50:
				MaxDistanceSquared = 1562500; //(1250 units) 25 meters
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

static function bool ShowStalkers(KFPlayerReplicationInfo KFPRI)
{
	return true;
}

static function float GetStalkerViewDistanceMulti(KFPlayerReplicationInfo KFPRI)
{
	switch ( KFPRI.ClientVeteranSkillLevel )
	{
		case 1:
			return 0.31; // 250 units 5 meters
		case 11:
			return 0.56; // 450 units 9 meters
		case 21:
			return 0.81; // 650 units 13 meters
		case 31:
			return 1.06; // 850 units 17 meters
		case 41:
			return 1.31; // 1050 units 21 meters
		case 50:
			return 1.56; // 1250 units 25 meters
	}

	return 1.56; // 1250 units 25 meters  (50 units = 1 meter(s)) 8 units = .01
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Bullpup(Other) != none || WTFEquipBulldog(Other) != none || HK417(Other) != none || M4AssaultRifle(Other) != none || P90(Other) != none || AK47AssaultRifle(Other) != none || WTFEquipAK48S(Other) != none || SCARMK17AssaultRifle(Other) != none || WTFEquipSCAR19a(Other) != none || FnFalAAssaultRifle2(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
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
	if ( BullpupAmmo(Other) != none || WTFEquipBulldogAmmo(Other) != none || HK417Ammo(Other) != none || M4Ammo(Other) != none || P90Ammo(Other) != none || AK47Ammo(Other) != none || WTFEquipAK48SAmmo(Other) != none || SCARMK17Ammo(Other) != none || WTFEquipSCAR19Ammo(Other) != none || FnFalAmmo2(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
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
	if ( AmmoType == class'SCARMK17Ammo' && KFPRI.ClientVeteranSkillLevel > 0 )
	{
		if ( KFPRI.ClientVeteranSkillLevel >= 1 )
			return 1.40; // 40% increase in ammo per clip for scar
	}
	if ( AmmoType == class'BullpupAmmo' || AmmoType == class'WTFEquipBulldogAmmo' || AmmoType == class'HK417Ammo' || AmmoType == class'M4Ammo' || AmmoType == class'P90Ammo' || AmmoType == class'AK47Ammo' || AmmoType == class'WTFEquipAK48SAmmo' || AmmoType == class'WTFEquipSCAR19Ammo' || AmmoType == class'FnFalAmmo2' && KFPRI.ClientVeteranSkillLevel > 0 )
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
	if ( DmgType == class'DamTypeBullpup' || DmgType == class'DamTypeWTFBulldog' || DmgType == class'DamTypeHK417' || DmgType == class'DamTypeM4AssaultRifle' || DmgType == class'DamTypeP90' || DmgType == class'DamTypeAK47AssaultRifle' || DmgType == class'DamTypeWTFAK48S' || DmgType == class'DamTypeSCARMK17AssaultRifle' || DmgType == class'DamTypeWTFScar' || DmgType == class'DamTypeFnFalAssaultRifle2' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.00 + (0.16 * float(KFPRI.ClientVeteranSkillLevel))); // 10% per level cap at 500% at level 50
	}
	return InDamage;
}

//Recoil LVP
static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( Bullpup(Other.Weapon) != none || WTFEquipBulldog(Other.Weapon) != none || HK417(Other.Weapon) != none || M4AssaultRifle(Other.Weapon) != none || P90(Other.Weapon) != none || AK47AssaultRifle(Other.Weapon) != none || WTFEquipAK48S(Other.Weapon) != none || SCARMK17AssaultRifle(Other.Weapon) != none || WTFEquipSCAR19a(Other.Weapon) != none || FnFalAAssaultRifle2(Other.Weapon) != none )
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

//Reload speed boost for all weapons LVP
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	return (0.03 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // 3% reload speed per level cap at 150% at level 50
}

// Set number times Zed Time can be extended
static function int ZedTimeExtensions(KFPlayerReplicationInfo KFPRI)
{
	return Min(KFPRI.ClientVeteranSkillLevel, 6);
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'BullpupPickup' || Item == class'HK417Pickup' || Item == class'M4Pickup' || Item == class'WTFEquipAK48SPickup' || Item == class'WTFEquipScar19Pickup' || Item == class'WTFEquipBulldogPickup' || Item == class'FnFalAPickup2' || Item == class'P90Pickup' || Item == class'FnFalPickup2' || Item == class'AK47Pickup' || Item == class'SCARMK17Pickup' )
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
	// If level 1-5 give them Bullpup
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 5 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Bullpup", GetCostScaling(KFPRI, class'BullpupPickup'));
		
	// If level 6-10 give them WTF Bulldog
	if ( KFPRI.ClientVeteranSkillLevel >= 6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipBulldog", GetCostScaling(KFPRI, class'WTFEquipBulldogPickup'));
		
	// If level 11-15 give them AK47
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 15 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.AK47AssaultRifle", GetCostScaling(KFPRI, class'AK47Pickup'));
		
	// If level 16-20 give them WTF AK48S
	if ( KFPRI.ClientVeteranSkillLevel >= 16 && KFPRI.ClientVeteranSkillLevel <= 20 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipAK48S", GetCostScaling(KFPRI, class'WTFEquipAK48SPickup'));
	
	// If level 21-25 give them M4
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 25 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.M4AssaultRifle", GetCostScaling(KFPRI, class'M4Pickup'));
	
	// If level 26-30 give them P90
	if ( KFPRI.ClientVeteranSkillLevel >= 26 && KFPRI.ClientVeteranSkillLevel <= 30 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.P90", GetCostScaling(KFPRI, class'P90Pickup'));
		
	// If level 31-35 give them HK417
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.HK417", GetCostScaling(KFPRI, class'HK417Pickup'));
		
	// If level 36-40 give them FNFAL
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 40 )
		KFHumanpawn(P).CreateInventoryVeterancy("BMTCustomMut.FnFalAAssaultRifle2", GetCostScaling(KFPRI, class'FnFalAPickup2'));
		
	// If level 41-45 give them ScarMk17
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 45 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.SCARMK17AssaultRifle", GetCostScaling(KFPRI, class'SCARMK17Pickup'));
		
	// If level 46-50 give them WTF Scar19
	if ( KFPRI.ClientVeteranSkillLevel >= 46 && KFPRI.ClientVeteranSkillLevel <= 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipSCAR19a", GetCostScaling(KFPRI, class'WTFEquipSCAR19Pickup'));
		
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		P.ShieldStrength = 100;
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.03 * float(Level))); // Reload Speed
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f))); // Discount on weapons
	ReplaceText(S,"%z",string(Level-2)); //Zed Extensions
	ReplaceText(S,"%r",GetPercentStr(FMin(0.04 * float(Level)+0.1,0.9f))); // Recoil
	ReplaceText(S,"%g",GetPercentStr((0.08 * float(Level)))); // Damage 
	return S;
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="8% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|3% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Zed-Time Can Be Extended By Killing An Enemy While In Slow Motion|Spawn With A Bullpup"
     SRLevelEffects(2)="16% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|6% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 2 Zed-Time Extensions|Spawn With An Bullpup"
     SRLevelEffects(3)="24% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|9% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 3 Zed-Time Extensions|Spawn With An Bullpup"
     SRLevelEffects(4)="32% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|12% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 4 Zed-Time Extensions|Spawn With A Bullpup"
     SRLevelEffects(5)="40% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|15% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 5 Zed-Time Extensions|Spawn With An Bullpup"
     SRLevelEffects(6)="48% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|18% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 6 Zed-Time Extensions|Spawn With An WTFBulldog"
     SRLevelEffects(7)="56% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|21% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 6 Zed-Time Extensions|Spawn With An WTFBulldog"
     SRLevelEffects(8)="64% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|24% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 6 Zed-Time Extensions|Spawn With An WTFBulldog"
     SRLevelEffects(9)="72% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|27% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 6 Zed-Time Extensions|Spawn With An WTFBulldog"
     SRLevelEffects(10)="80% More Damage With Commando Weapons|5% Larger Clipsize With Command Weapons|30% Faster Reload With All Weapons|70% Discount On Commando Weapons|Can See Cloaked Stalkers From 5m|Can See Enemy Health From 5m|Up To 6 Zed-Time Extensions|Spawn With An WTFBulldog"
     SRLevelEffects(11)="88% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|33% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An AK47"
     SRLevelEffects(12)="96% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|36% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An AK47"
     SRLevelEffects(13)="104% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|39% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An AK47"
     SRLevelEffects(14)="112% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|42% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An AK47"
     SRLevelEffects(15)="120% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|45% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An AK47"
     SRLevelEffects(16)="128% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|48% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An WTFAK48"
     SRLevelEffects(17)="136% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|51% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An WTFAK48"
     SRLevelEffects(18)="144% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|54% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An WTFAK48"
     SRLevelEffects(19)="152% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|57% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 9m|Can See Enemy Health From 9m|Up To 6 Zed-Time Extensions|Spawn With An WTFAK48"
     SRLevelEffects(20)="160% More Damage With Commando Weapons|20% Less Recoil With Commando Weapons|10% Larger Clipsize With Command Weapons|60% Faster Reload With All Weapons|75% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An WTFAK48"
     SRLevelEffects(21)="168% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|63% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An M4AssaultRifle"
     SRLevelEffects(22)="176% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|66% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An M4AssaultRifle"
     SRLevelEffects(23)="184% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|69% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An M4AssaultRifle"
     SRLevelEffects(24)="192% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|72% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An M4AssaultRifle"
     SRLevelEffects(25)="200% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|75% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An M4AssaultRifle"
     SRLevelEffects(26)="208% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|78% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An P90"
     SRLevelEffects(27)="216% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|81% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An P90"
     SRLevelEffects(28)="224% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|84% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An P90"
     SRLevelEffects(29)="232% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|87% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An P90"
     SRLevelEffects(30)="240% More Damage With Commando Weapons|40% Less Recoil With Commando Weapons|15% Larger Clipsize With Command Weapons|90% Faster Reload With All Weapons|80% Discount On Commando Weapons|Can See Cloaked Stalkers From 13m|Can See Enemy Health From 13m|Up To 6 Zed-Time Extensions|Spawn With An P90"
     SRLevelEffects(31)="248% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|93% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An HK417"
     SRLevelEffects(32)="256% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|96% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An HK417"
     SRLevelEffects(33)="264% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|99% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An HK417"
     SRLevelEffects(34)="272% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|102% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An HK417"
     SRLevelEffects(35)="280% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|105% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An HK417"
     SRLevelEffects(36)="288% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|108% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An FNFAL"
     SRLevelEffects(37)="296% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|111% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An FNFAL"
     SRLevelEffects(38)="304% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|114% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An FNFAL"
     SRLevelEffects(39)="312% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|117% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An FNFAL"
     SRLevelEffects(40)="320% More Damage With Commando Weapons|60% Less Recoil With Commando Weapons|20% Larger Clipsize With Command Weapons|120% Faster Reload With All Weapons|85% Discount On Commando Weapons|Can See Cloaked Stalkers From 17m|Can See Enemy Health From 17m|Up To 6 Zed-Time Extensions|Spawn With An FNFAL"
     SRLevelEffects(41)="328% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|123% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An ScarMK17 & Body Armor"
     SRLevelEffects(42)="336% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|126% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An ScarMK17 & Body Armor"
     SRLevelEffects(43)="344% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|129% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An ScarMK17 & Body Armor"
     SRLevelEffects(44)="352% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|132% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An ScarMK17 & Body Armor"
     SRLevelEffects(45)="360% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|135% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An ScarMK17 & Body Armor"
     SRLevelEffects(46)="368% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|138% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An WTFScar19 & Body Armor"
     SRLevelEffects(47)="376% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|141% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An WTFScar19 & Body Armor"
     SRLevelEffects(48)="384% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|144% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An WTFScar19 & Body Armor"
     SRLevelEffects(49)="392% More Damage With Commando Weapons|80% Less Recoil With Commando Weapons|25% Larger Clipsize With Command Weapons|147% Faster Reload With All Weapons|90% Discount On Commando Weapons|Can See Cloaked Stalkers From 21m|Can See Enemy Health From 21m|Up To 6 Zed-Time Extensions|Spawn With An WTFScar19 & Body Armor"
     SRLevelEffects(50)="400% More Damage With Commando Weapons|100% Less Recoil With Commando Weapons|30% Larger Clipsize With Command Weapons|150% Faster Reload With All Weapons|95% Discount On Commando Weapons|Can See Cloaked Stalkers From 25m|Can See Enemy Health From 25m|Up To 6 Zed-Time Extensions|Spawn With An WTFScar19 & Body Armor"
     PerkIndex=3
     OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Commando'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Commando_Gold'
     VeterancyName="Commando"
     Requirements(0)="Deal %x Damage With Bullpup/AK47/SCAR"
}
