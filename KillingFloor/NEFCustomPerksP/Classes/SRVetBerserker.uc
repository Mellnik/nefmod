class SRVetBerserker extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 10;
		break;
	case 1:
		FinalInt = 1000;
		break;
	case 2:
		FinalInt = 5000;
		break;
	case 3:
		FinalInt = 10000;
		break;
	case 4:
		FinalInt = 20000;
		break;
	case 5:
		FinalInt = 32000;
		break;
	case 6:
		FinalInt = 48000;
		break;
	default:
		FinalInt = 48000 + GetDoubleScaling(CurLevel,500000);
	}
	return Min(StatOther.RMeleeDamageStat,FinalInt);
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if( class<KFWeaponDamageType>(DmgType) != none && class<KFWeaponDamageType>(DmgType).default.bIsMeleeDamage )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.10;
		if( KFPRI.ClientVeteranSkillLevel>6 )
			return float(InDamage) * (1.7 + (0.05 * KFPRI.ClientVeteranSkillLevel));

		// Up to 100% increase in Melee Damage
		return float(InDamage) * (1.0 + (0.20 * float(Min(KFPRI.ClientVeteranSkillLevel, 5))));
	}
	return InDamage;
}

static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other)
{
	if ( KFMeleeGun(Other) != none || Crossbuzzsaw(Other) != none )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 1:
				return 1.05;
			case 2:
			case 3:
				return 1.10;
			case 4:
				return 1.15;
			case 5:
				return 1.20;
			case 6:
				return 1.25; // 25% increase in wielding Melee Weapon
			default:
				return 0.95+0.05*float(KFPRI.ClientVeteranSkillLevel);
		}
	}

	return 1.0;
}

static function float GetMeleeMovementSpeedModifier(KFPlayerReplicationInfo KFPRI)
{
	switch( KFPRI.ClientVeteranSkillLevel )
	{
	case 0:
		return 0.05; // Was 0.10 in Balance Round 1
	case 1:
		return 0.10; // Was 0.15 in Balance Round 1
	case 2:
		return 0.15; // Was 0.20 in Balance Round 1
	case 3:
	case 4:
	case 5:
		return 0.20; // Was 0.25 in Balance Round 1
	default:
		return 0.30; // Was 0.35 in Balance Round 1
	}
}

static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeVomit' )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 0:
				return float(InDamage) * 0.90;
			case 1:
				return float(InDamage) * 0.75;
			case 2:
				return float(InDamage) * 0.65;
			case 3:
				return float(InDamage) * 0.50;
			case 4:
				return float(InDamage) * 0.35;
			case 5:
				return float(InDamage) * 0.25;
			default:
				return float(InDamage) * 0.20; // 80% reduced Bloat Bile damage
		}
	}

	switch ( KFPRI.ClientVeteranSkillLevel )
	{
//		This did exist in Balance Round 1, but was removed for Balance Round 2
		case 0:
			return InDamage;
		case 1:
			return float(InDamage) * 0.95; // was 0.90 in Balance Round 1
		case 2:
			return float(InDamage) * 0.90; // was 0.85 in Balance Round 1
		case 3:
			return float(InDamage) * 0.85; // was 0.80 in Balance Round 1
		case 4:
			return float(InDamage) * 0.80; // was 0.70 in Balance Round 1
		case 5:
			return float(InDamage) * 0.70; // was 0.60 in Balance Round 1
		case 6:
			return float(InDamage) * 0.60; // 40% reduced Damage(was 50% in Balance Round 1)
	}

	return float(InDamage) * 1.f - FMin(float(KFPRI.ClientVeteranSkillLevel)*0.05f,0.65f);
}

// Added in Balance Round 1(returned false then, by accident, fixed in Balance Round 2)
static function bool CanMeleeStun()
{
	return true;
}

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
	if ( Item == class'ChainsawPickup' || Item == class'KatanaPickup' || Item == class'ClaymoreSwordPickup'
        || Item == class'CrossbuzzsawPickup' || Item == class'ScythePickup' || Item == class'GoldenKatanaPickup'
        || Item == class'MachetePickup' || Item == class'AxePickup' || Item == class'DwarfAxePickup'
        || Item == class'GoldenChainsawPickup' )
		return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1); // Up to 70% discount on Melee Weapons
	return 1.0;
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	P.GiveWeapon("KnifeShadowBladeMut.MutKnifeShadowBlade");
	P.GiveWeapon("Pistol9mmNinemmMut.Mut9mmNinemm");

	// If Level 5, give them Machete
	if ( KFPRI.ClientVeteranSkillLevel == 5 )
		AddPerkedWeapon(class'Machete',KFPRI,P);

	// If Level 6, give them an Axe
	else if ( KFPRI.ClientVeteranSkillLevel >= 6 )
		AddPerkedWeapon(class'Axe',KFPRI,P);

	// If Level 6, give them Body Armor(Removed from Suicidal and HoE in Balance Round 7)
	if(KFPRI.ClientVeteranSkillLevel > 3 && KFPRI.ClientVeteranSkillLevel <= 6)
	{
		P.ShieldStrength = 10;
	}
	else if(KFPRI.ClientVeteranSkillLevel <= 15 && KFPRI.ClientVeteranSkillLevel > 6)
	{
		P.ShieldStrength = 25;
	}
	else if(KFPRI.ClientVeteranSkillLevel <= 20 && KFPRI.ClientVeteranSkillLevel > 15)
	{
		P.ShieldStrength = 50;
	}
	else if(KFPRI.ClientVeteranSkillLevel <= 35 && KFPRI.ClientVeteranSkillLevel > 20)
	{
		P.ShieldStrength = 75;
	}
	else if(KFPRI.ClientVeteranSkillLevel <= 50 && KFPRI.ClientVeteranSkillLevel > 35)
	{
		P.ShieldStrength = 100;
	}
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
	PerkIndex=4

	OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Berserker'
	OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Berserker_Gold'
	VeterancyName="Berserker"
	Requirements(0)="Deal %x damage with melee weapons"

	SRLevelEffects(0)="10% extra melee damage|5% faster melee movement|10% less damage from Bloat Bile|10% discount on melee weapons|Can't be grabbed by Clots"
	SRLevelEffects(1)="20% extra melee damage|5% faster melee attacks|10% faster melee movement|25% less damage from Bloat Bile|5% resistance to all damage|20% discount on melee weapons|Can't be grabbed by Clots"
	SRLevelEffects(2)="40% extra melee damage|10% faster melee attacks|15% faster melee movement|35% less damage from Bloat Bile|10% resistance to all damage|30% discount on melee weapons|Can't be grabbed by Clots|Zed-Time can be extended by killing an enemy while in slow motion"
	SRLevelEffects(3)="60% extra melee damage|10% faster melee attacks|20% faster melee movement|50% less damage from Bloat Bile|15% resistance to all damage|40% discount on melee weapons|Can't be grabbed by Clots|Up to 2 Zed-Time Extensions"
	SRLevelEffects(4)="80% extra melee damage|15% faster melee attacks|20% faster melee movement|65% less damage from Bloat Bile|20% resistance to all damage|50% discount on melee weapons|Can't be grabbed by Clots|Up to 3 Zed-Time Extensions"
	SRLevelEffects(5)="100% extra melee damage|20% faster melee attacks|20% faster melee movement|75% less damage from Bloat Bile|30% resistance to all damage|60% discount on melee weapons|Spawn with a Machete|Can't be grabbed by Clots|Up to 4 Zed-Time Extensions"
	SRLevelEffects(6)="100% extra melee damage|25% faster melee attacks|30% faster melee movement|80% less damage from Bloat Bile|40% resistance to all damage|70% discount on melee weapons|Spawn with an Axe and Body Armor|Can't be grabbed by Clots|Up to 4 Zed-Time Extensions"
	CustomLevelInfo="%r extra melee damage|%s faster melee attacks|30% faster melee movement|80% less damage from Bloat Bile|%l resistance to all damage|%d discount on melee weapons|Spawn with a Axe and Body Armor|Can't be grabbed by Clots|Up to 4 Zed-Time Extensions"
}