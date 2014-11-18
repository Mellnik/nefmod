class WTFPerksSentryTechPerk extends SRVeterancyTypes
	abstract;
	
#exec obj load file="SentryTechTex1.utx"

var array<int> progressArray;
	
static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'SentryTechPerkProg');
	Class'Tech_DoomSentry'.Default.HitDamageType = Class'DamTypeTech_DoomSentryFire';
	Class'Tech_BioLauncherProj'.Default.MyDamageType = Class'DamTypeTech_BioLauncher';
	Class'Tech_ShockRifleBullet'.Default.MyDamageType = Class'DamTypeTech_ShockRifle';
	Class'Tech_IncendiaryPipeBombProjectile'.Default.MyDamageType = Class'DamTypeTech_IncendiaryPipeBomb';
	Class'Tech_IncendiaryPipeBombProjectile'.Default.BurnDamageType = Class'DamTypeTech_IncendiaryPipeBomb';
	Class'Tech_MachinePistolFire'.Default.DamageType = Class'DamTypeTech_MachinePistol';
	Class'Tech_MachineDualiesFire'.Default.DamageType = Class'DamTypeTech_MachineDualies';
	Class'Tech_USCMSentryGun'.Default.HitDamageType = Class'DamTypeTech_USCMSentry';
	Class'Tech_M7A3MFire'.Default.DamageType = Class'DamTypeTech_M7A3M';
	Class'Tech_PipeBombProjectile'.Default.MyDamageType = Class'DamTypeTech_PipeBomb';
	Class'Tech_PipeBombShrapnel'.Default.MyDamageType = Class'DamTypeTech_PipeBomb';
	Class'Tech_PlasmaCutterBullet'.Default.MyDamageType = Class'DamTypeTech_PlasmaCutter';
	Class'Tech_GravityGunFire'.Default.DamageType = Class'DamTypeTech_BGravGunKill';
	Class'Tech_GravityGunFire'.Default.DamageType = Class'DamTypeTech_GravGunKill';
	Class'Tech_RPGProjectile'.Default.MyDamageType = Class'DamTypeTech_RPG';
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
	if( ReqNum==0 )
    return Min(StatOther.GetCustomValueInt(Class'SentryTechPerkProg'),FinalInt);
}
	
	
	
//static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI)
static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI, KFGameReplicationInfo KFGRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 1 )
		return 1.0;
	return 1.0 + (0.04 * float(KFPRI.ClientVeteranSkillLevel)); // Moves up to 120% faster
}

static function float GetWeldSpeedModifier(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 1 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel));
	return 3.0; // 500% increase in speed cap at level 50
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

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeTech_BioLauncher' || DmgType == class'DamTypeTech_MachineDualies' ||
        DmgType == class'DamTypeTech_MachinePistol' || DmgType == class'DamTypeTech_M7A3M' || 
		DmgType == class'DamTypeTech_ShockRifle' || DmgType == class'DamTypeTech_RPG' ||
		DmgType == class'DamTypeTech_GravGunKill' ||
		DmgType == class'DamTypeTech_BGravGunKill' || DmgType == class'DamTypeTech_PlasmaCutter' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.00 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); // 10% per level cap at 500% at level 50
	}
	return InDamage;
}
	
//static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, KFMonster DamageTaker, int InDamage, class<DamageType> DmgType)
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeVomit' )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 0:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 1:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 2:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 3:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 4:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 5:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 6:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 7:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 8:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 9:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 10:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 11:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 12:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 13:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 14:
				return float(InDamage) * 1.80;  // 80% Extra Bloat Vomit Damage
			case 15:
				return float(InDamage) * 1.75;  // 75% Extra Bloat Vomit Damage
			case 16:
				return float(InDamage) * 1.75;  // 75% Extra Bloat Vomit Damage
			case 17:
				return float(InDamage) * 1.75;  // 75% Extra Bloat Vomit Damage
			case 18:
				return float(InDamage) * 1.75;  // 75% Extra Bloat Vomit Damage
			case 19:
				return float(InDamage) * 1.75;  // 75% Extra Bloat Vomit Damage
			case 20:
				return float(InDamage) * 1.70;  // 70% Extra Bloat Vomit Damage
			case 21:
				return float(InDamage) * 1.70;  // 70% Extra Bloat Vomit Damage
			case 22:
				return float(InDamage) * 1.70;  // 70% Extra Bloat Vomit Damage
			case 23:
				return float(InDamage) * 1.70;  // 70% Extra Bloat Vomit Damage
			case 24:
				return float(InDamage) * 1.70;  // 70% Extra Bloat Vomit Damage
			case 25:
				return float(InDamage) * 1.65;  // 65% Extra Bloat Vomit Damage
			case 26:
				return float(InDamage) * 1.65;  // 65% Extra Bloat Vomit Damage
			case 27:
				return float(InDamage) * 1.65;  // 65% Extra Bloat Vomit Damage
			case 28:
				return float(InDamage) * 1.65;  // 65% Extra Bloat Vomit Damage
			case 29:
				return float(InDamage) * 1.65;  // 65% Extra Bloat Vomit Damage
			case 30:
				return float(InDamage) * 1.60;  // 60% Extra Bloat Vomit Damage
			case 31:
				return float(InDamage) * 1.60;  // 60% Extra Bloat Vomit Damage
			case 32:
				return float(InDamage) * 1.60;  // 60% Extra Bloat Vomit Damage
			case 33:
				return float(InDamage) * 1.60;  // 60% Extra Bloat Vomit Damage
			case 34:
				return float(InDamage) * 1.60;  // 60% Extra Bloat Vomit Damage
			case 35:
				return float(InDamage) * 1.55;  // 55% Extra Bloat Vomit Damage
			case 36:
				return float(InDamage) * 1.55;  // 55% Extra Bloat Vomit Damage
			case 37:
				return float(InDamage) * 1.55;  // 55% Extra Bloat Vomit Damage
			case 38:
				return float(InDamage) * 1.55;  // 55% Extra Bloat Vomit Damage
			case 39:
				return float(InDamage) * 1.55;  // 55% Extra Bloat Vomit Damage
			case 40:
				return float(InDamage) * 1.50;  // 50% Extra Bloat Vomit Damage
			case 41:
				return float(InDamage) * 1.50;  // 50% Extra Bloat Vomit Damage
			case 42:
				return float(InDamage) * 1.50;  // 50% Extra Bloat Vomit Damage
			case 43:
				return float(InDamage) * 1.50;  // 50% Extra Bloat Vomit Damage
			case 44:
				return float(InDamage) * 1.50;  // 50% Extra Bloat Vomit Damage
			case 45:
				return float(InDamage) * 1.45;  // 45% Extra Bloat Vomit Damage
			case 46:
				return float(InDamage) * 1.45;  // 45% Extra Bloat Vomit Damage
			case 47:
				return float(InDamage) * 1.45;  // 45% Extra Bloat Vomit Damage
			case 48:
				return float(InDamage) * 1.45;  // 45% Extra Bloat Vomit Damage
			case 49:
				return float(InDamage) * 1.45;  // 45% Extra Bloat Vomit Damage
			case 50:
				return float(InDamage) * 1.40;  // 40% Extra Bloat Vomit Damage
		}
	}
	
	
	switch ( KFPRI.ClientVeteranSkillLevel )
	{
			case 0:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 1:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 2:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 3:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 4:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 5:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 6:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 7:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 8:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 9:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 10:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 11:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 12:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 13:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 14:
				return float(InDamage) * 1.80;  // 80% Extra Damage From All
			case 15:
				return float(InDamage) * 1.75;  // 75% Extra Damage From All
			case 16:
				return float(InDamage) * 1.75;  // 75% Extra Damage From All
			case 17:
				return float(InDamage) * 1.75;  // 75% Extra Damage From All
			case 18:
				return float(InDamage) * 1.75;  // 75% Extra Damage From All
			case 19:
				return float(InDamage) * 1.75;  // 75% Extra Damage From All
			case 20:
				return float(InDamage) * 1.70;  // 70% Extra Damage From All
			case 21:
				return float(InDamage) * 1.70;  // 70% Extra Damage From All
			case 22:
				return float(InDamage) * 1.70;  // 70% Extra Damage From All
			case 23:
				return float(InDamage) * 1.70;  // 70% Extra Damage From All
			case 24:
				return float(InDamage) * 1.70;  // 70% Extra Damage From All
			case 25:
				return float(InDamage) * 1.65;  // 65% Extra Damage From All
			case 26:
				return float(InDamage) * 1.65;  // 65% Extra Damage From All
			case 27:
				return float(InDamage) * 1.65;  // 65% Extra Damage From All
			case 28:
				return float(InDamage) * 1.65;  // 65% Extra Damage From All
			case 29:
				return float(InDamage) * 1.65;  // 65% Extra Damage From All
			case 30:
				return float(InDamage) * 1.60;  // 60% Extra Damage From All
			case 31:
				return float(InDamage) * 1.60;  // 60% Extra Damage From All
			case 32:
				return float(InDamage) * 1.60;  // 60% Extra Damage From All
			case 33:
				return float(InDamage) * 1.60;  // 60% Extra Damage From All
			case 34:
				return float(InDamage) * 1.60;  // 60% Extra Damage From All
			case 35:
				return float(InDamage) * 1.55;  // 55% Extra Damage From All
			case 36:
				return float(InDamage) * 1.55;  // 55% Extra Damage From All
			case 37:
				return float(InDamage) * 1.55;  // 55% Extra Damage From All
			case 38:
				return float(InDamage) * 1.55;  // 55% Extra Damage From All
			case 39:
				return float(InDamage) * 1.55;  // 55% Extra Damage From All
			case 40:
				return float(InDamage) * 1.50;  // 50% Extra Damage From All
			case 41:
				return float(InDamage) * 1.50;  // 50% Extra Damage From All
			case 42:
				return float(InDamage) * 1.50;  // 50% Extra Damage From All
			case 43:
				return float(InDamage) * 1.50;  // 50% Extra Damage From All
			case 44:
				return float(InDamage) * 1.50;  // 50% Extra Damage From All
			case 45:
				return float(InDamage) * 1.45;  // 45% Extra Damage From All
			case 46:
				return float(InDamage) * 1.45;  // 45% Extra Damage From All
			case 47:
				return float(InDamage) * 1.45;  // 45% Extra Damage From All
			case 48:
				return float(InDamage) * 1.45;  // 45% Extra Damage From All
			case 49:
				return float(InDamage) * 1.45;  // 45% Extra Damage From All
			case 50:
				return float(InDamage) * 1.40;  // 40% Extra Damage From All
	}
	
	if ( class<DamTypeBurned>(DmgType) != none || class<DamTypeFlamethrower>(DmgType) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 8 )
		{
			return float(InDamage) * (01.80 - (0.01 * float(Min(KFPRI.ClientVeteranSkillLevel, 40))));
		}

		return 1.40; // 40% extra damage by fire
	}
	
	
	
	
	
	if ( class<DamTypeFrag>(DmgType) != none || class<DamTypePipeBomb>(DmgType) != none ||
		 class<DamTypeM79Grenade>(DmgType) != none || class<DamTypeM32Grenade>(DmgType) != none
         || class<DamTypeM203Grenade>(DmgType) != none || class<DamTypeRocketImpact>(DmgType) != none )
		 {
		 if ( KFPRI.ClientVeteranSkillLevel <= 8 )
		 
	{
		return float(InDamage) * (01.80 - (0.01 * float(Min(KFPRI.ClientVeteranSkillLevel, 40))));
	}
	
	return float(InDamage) * 1.40; // 40% extra damage by fire
	}
	
	
	
	
	return InDamage;
}
	
	// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'Tech_DoomsentryBotPickup' ||	Item == class'Tech_BioLauncherPickup' || Item == class'Tech_ShockRiflePickup' ||
	Item == class'Tech_IncendiaryPipeBombPickup' || Item == class'Tech_MachinePistolPickup' || Item == class'Tech_MachineDualiesPickup' ||
	Item == class'Tech_USCMSentryPickup' || Item == class'Tech_PipeBombPickUp' ||
	Item == class'Tech_PlasmaCutterPickup' || Item == class'Tech_HL_BlueGravityGunPickup' || Item == class'Tech_HL_RPGPickup' ||
	Item == class'Tech_HL_BugBaitPickup' || Item == class'Tech_HL_GravityGunPickup' || 
    Item == class'Tech_AdvancedWelderPickup' || Item == class'Tech_M7A3MPickup' )
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
	
	
	
static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( (Tech_BioLauncher(Other) != none || Tech_PlasmaCutter(Other) !=none || Tech_MachinePistol(Other) != none || Tech_MachineDualies(Other) !=none ||
	Tech_M7A3MMedicGun(Other) !=none || Tech_HL_RPG(Other) !=none || Tech_AdvancedWelder(Other) !=none ||  
	Tech_ShockRifle(Other) != none) && KFPRI.ClientVeteranSkillLevel > 0 )
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
	if ( (AmmoType == class'Tech_AdvancedWelderAmmo'|| AmmoType == class'Tech_BioLauncherAmmo'|| 
	AmmoType == class'Tech_HL2Ammo' || AmmoType == class'Tech_HL_BugBaitAmmo' || AmmoType == class'Tech_HL_CrossbowAmmo' ||
	AmmoType == class'Tech_MachineDualiesAmmo' || AmmoType == class'Tech_MachinePistolAmmo' || AmmoType == class'Tech_PlasmaCutterAmmo'||
	AmmoType == class'Tech_ShockRifleAmmo' || AmmoType == class'Tech_M7A3MAmmo'||
	AmmoType == class'Tech_HL_RPGAmmo' ) && KFPRI.ClientVeteranSkillLevel > 0 )
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
	if ( (Tech_BioLauncherAmmo(Other) != none || Tech_PlasmaCutterAmmo(Other) !=none || Tech_MachinePistolAmmo(Other) != none ||
    Tech_MachineDualiesAmmo(Other) !=none || Tech_M7A3MAmmo(Other) !=none || Tech_HL_RPGAmmo(other) !=none ||
	Tech_ShockRifleAmmo(Other) != none) && KFPRI.ClientVeteranSkillLevel > 0 )
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
	if ( KFPRI.ClientVeteranSkilllevel >= 20 )
		return 0.40;  // 60% better armor 20-50 levels
		
}

//Reload speed boost for all weapons LVP
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	return (0.00 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // 0% place holder
}

//Recoil LVP
static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
		return Recoil - (1-super.ModifyRecoilSpread(KFPRI, Other, Recoil));
}



// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	 local Inventory I;
	 
	KFHumanPawn(P).RequiredEquipment[1] = ""; // Remove pistol.
	I = P.FindInventoryType(Class'WTFEquipMachinePistol');
	if( I!=None ) I.Destroy(); // Delete if already given.
	KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Tech_PlasmaCutter", GetCostScaling(KFPRI, class'Tech_PlasmaCutterPickup'));
	Super.AddDefaultInventory(KFPRI,P);
	
	// If Level 11-30 give them orange gravity gun
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 30 )
	{
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Tech_HL_GravityGun", GetCostScaling(KFPRI, class'Tech_HL_GravityGunPickup'));
	}
	// If Level 31-40 give them RPG
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40 )
	{
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Tech_HL_RPG", GetCostScaling(KFPRI, class'Tech_HL_RPGPickup'));
	}
	// If Level 41-49 give them Tech_M7A3MMedicGun
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 49 )
	{
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Tech_M7A3MMedicGun", GetCostScaling(KFPRI, class'Tech_M7A3MPickup'));
	}
	
	// If Level 50 give them shock rifle
	if ( KFPRI.ClientVeteranSkillLevel >= 50 )
	{
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.Tech_ShockRifle", GetCostScaling(KFPRI, class'Tech_ShockRiflePickup'));
	}

	// If greater than or equal to level 21, give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 21)
	{
		P.ShieldStrength = 100;
	}
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
     SRLevelEffects(1)="5% Extra Damage With Sentry Tech Weapons|4% Increase In Movement Speed|10% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|3% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(2)="10% Extra Damage With Sentry Tech Weapons|8% Increase In Movement Speed|20% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|6% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(3)="15% Extra Damage With Sentry Tech Weapons|12% Increase In Movement Speed|30% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|9% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(4)="20% Extra Damage With Sentry Tech Weapons|16% Increase In Movement Speed|40% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|12% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(5)="25% Extra Damage With Sentry Tech Weapons|20% Increase In Movement Speed|50% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|15% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(6)="30% Extra Damage With Sentry Tech Weapons|24% Increase In Movement Speed|60% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|18% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(7)="35% Extra Damage With Sentry Tech Weapons|28% Increase In Movement Speed|70% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|21% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(8)="40% Extra Damage With Sentry Tech Weapons|32% Increase In Movement Speed|80% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|24% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(9)="45% Extra Damage With Sentry Tech Weapons|36% Increase In Movement Speed|90% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|5% extra ammo for SentryTech Weapons|27% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(10)="50% Extra Damage With Sentry Tech Weapons|40% Increase In Movement Speed|100% Faster Welding|Can See Enemy Health From 5M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|70% Discount On Sentry Tech Weapons|5% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|30% stronger armor|Spawn With A Plasma Cutter"
     SRLevelEffects(11)="55% Extra Damage With Sentry Tech Weapons|44% Increase In Movement Speed|110% Faster Welding|Can See Enemy Health From 9M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|33% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(12)="60% Extra Damage With Sentry Tech Weapons|48% Increase In Movement Speed|120% Faster Welding|Can See Enemy Health From 9M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|36% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(13)="65% Extra Damage With Sentry Tech Weapons|52% Increase In Movement Speed|130% Faster Welding|Can See Enemy Health From 9M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|39% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(14)="70% Extra Damage With Sentry Tech Weapons|56% Increase In Movement Speed|140% Faster Welding|Can See Enemy Health From 9M|80% Extra Damage From Bloat Vomit|80% Extra Damage From All|80% Extra Damage From Fire|80% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|42% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(15)="75% Extra Damage With Sentry Tech Weapons|60% Increase In Movement Speed|150% Faster Welding|Can See Enemy Health From 9M|75% Extra Damage From Bloat Vomit|75% Extra Damage From All|75% Extra Damage From Fire|75% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|45% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(16)="80% Extra Damage With Sentry Tech Weapons|64% Increase In Movement Speed|160% Faster Welding|Can See Enemy Health From 9M|75% Extra Damage From Bloat Vomit|75% Extra Damage From All|75% Extra Damage From Fire|75% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|48% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(17)="85% Extra Damage With Sentry Tech Weapons|68% Increase In Movement Speed|170% Faster Welding|Can See Enemy Health From 9M|75% Extra Damage From Bloat Vomit|75% Extra Damage From All|75% Extra Damage From Fire|75% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|51% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(18)="90% Extra Damage With Sentry Tech Weapons|72% Increase In Movement Speed|180% Faster Welding|Can See Enemy Health From 9M|75% Extra Damage From Bloat Vomit|75% Extra Damage From All|75% Extra Damage From Fire|75% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|54% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(19)="95% Extra Damage With Sentry Tech Weapons|76% Increase In Movement Speed|190% Faster Welding|Can See Enemy Health From 9M|75% Extra Damage From Bloat Vomit|75% Extra Damage From All|75% Extra Damage From Fire|75% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|57% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(20)="100% Extra Damage With Sentry Tech Weapons|80% Increase In Movement Speed|200% Faster Welding|Can See Enemy Health From 9M|70% Extra Damage From Bloat Vomit|70% Extra Damage From All|70% Extra Damage From Fire|70% Extra Damage From Explosives|75% Discount On Sentry Tech Weapons|10% larger ammo clip for SentryTech Weapons|10% extra ammo for SentryTech Weapons|60% stronger armor|Spawn With A Plasma Cutter & Tech_Gravity Gun"
     SRLevelEffects(21)="105% Extra Damage With Sentry Tech Weapons|84% Increase In Movement Speed|210% Faster Welding|Can See Enemy Health From 13M|70% Extra Damage From Bloat Vomit|70% Extra Damage From All|70% Extra Damage From Fire|70% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|61% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(22)="110% Extra Damage With Sentry Tech Weapons|88% Increase In Movement Speed|220% Faster Welding|Can See Enemy Health From 13M|70% Extra Damage From Bloat Vomit|70% Extra Damage From All|70% Extra Damage From Fire|70% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|62% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(23)="115% Extra Damage With Sentry Tech Weapons|92% Increase In Movement Speed|230% Faster Welding|Can See Enemy Health From 13M|70% Extra Damage From Bloat Vomit|70% Extra Damage From All|70% Extra Damage From Fire|70% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|63% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(24)="120% Extra Damage With Sentry Tech Weapons|96% Increase In Movement Speed|240% Faster Welding|Can See Enemy Health From 13M|70% Extra Damage From Bloat Vomit|70% Extra Damage From All|70% Extra Damage From Fire|70% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|64% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(25)="125% Extra Damage With Sentry Tech Weapons|100% Increase In Movement Speed|250% Faster Welding|Can See Enemy Health From 13M|65% Extra Damage From Bloat Vomit|65% Extra Damage From All|65% Extra Damage From Fire|65% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|65% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(26)="130% Extra Damage With Sentry Tech Weapons|104% Increase In Movement Speed|260% Faster Welding|Can See Enemy Health From 13M|65% Extra Damage From Bloat Vomit|65% Extra Damage From All|65% Extra Damage From Fire|65% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|66% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(27)="135% Extra Damage With Sentry Tech Weapons|108% Increase In Movement Speed|270% Faster Welding|Can See Enemy Health From 13M|65% Extra Damage From Bloat Vomit|65% Extra Damage From All|65% Extra Damage From Fire|65% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|67% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(28)="140% Extra Damage With Sentry Tech Weapons|112% Increase In Movement Speed|280% Faster Welding|Can See Enemy Health From 13M|65% Extra Damage From Bloat Vomit|65% Extra Damage From All|65% Extra Damage From Fire|65% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|68% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(29)="145% Extra Damage With Sentry Tech Weapons|116% Increase In Movement Speed|290% Faster Welding|Can See Enemy Health From 13M|65% Extra Damage From Bloat Vomit|65% Extra Damage From All|65% Extra Damage From Fire|65% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|69% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(30)="150% Extra Damage With Sentry Tech Weapons|120% Increase In Movement Speed|300% Faster Welding|Can See Enemy Health From 13M|60% Extra Damage From Bloat Vomit|60% Extra Damage From All|60% Extra Damage From Fire|60% Extra Damage From Explosives|80% Discount On Sentry Tech Weapons|15% larger ammo clip for SentryTech Weapons|15% extra ammo for SentryTech Weapons|70% stronger armor|Spawn With A Plasma Cutter, Tech_Gravity Gun & Armor"
     SRLevelEffects(31)="155% Extra Damage With Sentry Tech Weapons|124% Increase In Movement Speed|310% Faster Welding|Can See Enemy Health From 17M|60% Extra Damage From Bloat Vomit|60% Extra Damage From All|60% Extra Damage From Fire|60% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|71% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(32)="160% Extra Damage With Sentry Tech Weapons|128% Increase In Movement Speed|320% Faster Welding|Can See Enemy Health From 17M|60% Extra Damage From Bloat Vomit|60% Extra Damage From All|60% Extra Damage From Fire|60% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|72% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(33)="165% Extra Damage With Sentry Tech Weapons|132% Increase In Movement Speed|330% Faster Welding|Can See Enemy Health From 17M|60% Extra Damage From Bloat Vomit|60% Extra Damage From All|60% Extra Damage From Fire|60% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|73% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(34)="170% Extra Damage With Sentry Tech Weapons|136% Increase In Movement Speed|340% Faster Welding|Can See Enemy Health From 17M|60% Extra Damage From Bloat Vomit|60% Extra Damage From All|60% Extra Damage From Fire|60% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|74% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(35)="175% Extra Damage With Sentry Tech Weapons|140% Increase In Movement Speed|350% Faster Welding|Can See Enemy Health From 17M|55% Extra Damage From Bloat Vomit|55% Extra Damage From All|55% Extra Damage From Fire|55% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|75% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(36)="180% Extra Damage With Sentry Tech Weapons|144% Increase In Movement Speed|360% Faster Welding|Can See Enemy Health From 17M|55% Extra Damage From Bloat Vomit|55% Extra Damage From All|55% Extra Damage From Fire|55% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|76% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(37)="185% Extra Damage With Sentry Tech Weapons|148% Increase In Movement Speed|370% Faster Welding|Can See Enemy Health From 17M|55% Extra Damage From Bloat Vomit|55% Extra Damage From All|55% Extra Damage From Fire|55% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|77% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(38)="190% Extra Damage With Sentry Tech Weapons|152% Increase In Movement Speed|380% Faster Welding|Can See Enemy Health From 17M|55% Extra Damage From Bloat Vomit|55% Extra Damage From All|55% Extra Damage From Fire|55% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|78% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(39)="195% Extra Damage With Sentry Tech Weapons|156% Increase In Movement Speed|390% Faster Welding|Can See Enemy Health From 17M|55% Extra Damage From Bloat Vomit|55% Extra Damage From All|55% Extra Damage From Fire|55% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|79% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(40)="200% Extra Damage With Sentry Tech Weapons|160% Increase In Movement Speed|400% Faster Welding|Can See Enemy Health From 17M|50% Extra Damage From Bloat Vomit|50% Extra Damage From All|50% Extra Damage From Fire|50% Extra Damage From Explosives|85% Discount On Sentry Tech Weapons|20% larger ammo clip for SentryTech Weapons|20% extra ammo for SentryTech Weapons|80% stronger armor|Spawn With A Plasma Cutter, Tech_RPG & Armor"
     SRLevelEffects(41)="205% Extra Damage With Sentry Tech Weapons|164% Increase In Movement Speed|410% Faster Welding|Can See Enemy Health From 21M|50% Extra Damage From Bloat Vomit|50% Extra Damage From All|50% Extra Damage From Fire|50% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|81% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(42)="210% Extra Damage With Sentry Tech Weapons|168% Increase In Movement Speed|420% Faster Welding|Can See Enemy Health From 21M|50% Extra Damage From Bloat Vomit|50% Extra Damage From All|50% Extra Damage From Fire|50% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|82% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(43)="215% Extra Damage With Sentry Tech Weapons|172% Increase In Movement Speed|430% Faster Welding|Can See Enemy Health From 21M|50% Extra Damage From Bloat Vomit|50% Extra Damage From All|50% Extra Damage From Fire|50% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|83% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(44)="220% Extra Damage With Sentry Tech Weapons|176% Increase In Movement Speed|440% Faster Welding|Can See Enemy Health From 21M|50% Extra Damage From Bloat Vomit|50% Extra Damage From All|50% Extra Damage From Fire|50% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|84% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(45)="225% Extra Damage With Sentry Tech Weapons|180% Increase In Movement Speed|450% Faster Welding|Can See Enemy Health From 21M|45% Extra Damage From Bloat Vomit|45% Extra Damage From All|45% Extra Damage From Fire|45% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|85% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(46)="230% Extra Damage With Sentry Tech Weapons|184% Increase In Movement Speed|460% Faster Welding|Can See Enemy Health From 21M|45% Extra Damage From Bloat Vomit|45% Extra Damage From All|45% Extra Damage From Fire|45% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|86% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(47)="235% Extra Damage With Sentry Tech Weapons|188% Increase In Movement Speed|470% Faster Welding|Can See Enemy Health From 21M|45% Extra Damage From Bloat Vomit|45% Extra Damage From All|45% Extra Damage From Fire|45% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|87% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(48)="240% Extra Damage With Sentry Tech Weapons|192% Increase In Movement Speed|480% Faster Welding|Can See Enemy Health From 21M|45% Extra Damage From Bloat Vomit|45% Extra Damage From All|45% Extra Damage From Fire|45% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|88% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(49)="245% Extra Damage With Sentry Tech Weapons|196% Increase In Movement Speed|490% Faster Welding|Can See Enemy Health From 21M|45% Extra Damage From Bloat Vomit|45% Extra Damage From All|45% Extra Damage From Fire|45% Extra Damage From Explosives|90% Discount On Sentry Tech Weapons|25% larger ammo clip for SentryTech Weapons|25% extra ammo for SentryTech Weapons|89% stronger armor|Spawn With A Plasma Cutter, Tech_M7A3MMedicGun & Armor"
     SRLevelEffects(50)="250% Extra Damage With Sentry Tech Weapons|200% Increase In Movement Speed|500% Faster Welding|Can See Enemy Health From 25M|40% Extra Damage From Bloat Vomit|40% Extra Damage From All|40% Extra Damage From Fire|40% Extra Damage From Explosives|95% Discount On Sentry Tech Weapons|30% larger ammo clip for SentryTech Weapons|30% extra ammo for SentryTech Weapons|90% stronger armor|Spawn With A Plasma Cutter, Tech_Shock Rifle & Armor"
     PerkIndex=50
     OnHUDIcon=Texture'SentryTechTex1.Perks.SentryTechPerkRed'
     OnHUDGoldIcon=Texture'SentryTechTex1.Perks.SentryTechPerkGold'
     VeterancyName="Sentry Tech"
     Requirements(0)="Deal %x Damage With SentryTech Weapons"
}
