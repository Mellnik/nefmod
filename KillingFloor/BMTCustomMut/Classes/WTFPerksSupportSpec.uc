class WTFPerksSupportSpec extends SRVeterancyTypes
	abstract;

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
		return Min(StatOther.RShotgunDamageStat,FinalInt);
}

static function int AddCarryMaxWeight(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return 0;
	else if ( KFPRI.ClientVeteranSkillLevel <= 4 )
		return 1 + KFPRI.ClientVeteranSkillLevel;
	else if ( KFPRI.ClientVeteranSkillLevel == 5 )
		return 8; // 8 more carry slots
	return 3+KFPRI.ClientVeteranSkillLevel; // 9 more carry slots
}

static function float GetWeldSpeedModifier(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 3 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel));
	return 3.0; // 200% increase in speed cap at level 20
}


static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'FragAmmo' )
	{
	if ( KFPRI.ClientVeteranSkillLevel > 0 )
		{
		if ( KFPRI.ClientVeteranSkillLevel == 5 )
			return 1.20; //+1
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			return 1.40; //+2
		else if ( KFPRI.ClientVeteranSkillLevel == 7 )
			return 1.60; //+3
		else if ( KFPRI.ClientVeteranSkillLevel == 8 )
			return 1.80; //+4
		else if ( KFPRI.ClientVeteranSkillLevel == 9 )
			return 2.00; //+5
		else if ( KFPRI.ClientVeteranSkillLevel == 10 )
			return 2.20; //+6
		else if ( KFPRI.ClientVeteranSkillLevel == 11 )
			return 2.40; //+7
		else if ( KFPRI.ClientVeteranSkillLevel == 12 )
			return 2.60; //+8
		else if ( KFPRI.ClientVeteranSkillLevel == 13 )
			return 2.80; //+9
		else if ( KFPRI.ClientVeteranSkillLevel == 14 )
			return 3.00; //+10
		else if ( KFPRI.ClientVeteranSkillLevel == 15 )
			return 3.20; //+11
		else if ( KFPRI.ClientVeteranSkillLevel == 16 )
			return 3.40; //+12
		else if ( KFPRI.ClientVeteranSkillLevel == 17 )
			return 3.60; //+13
		else if ( KFPRI.ClientVeteranSkillLevel == 18 )
			return 3.80; //+14
		else if ( KFPRI.ClientVeteranSkillLevel == 19 )
			return 4.00; //+15
		else if ( KFPRI.ClientVeteranSkillLevel == 20 )
			return 4.20; //+16
		else if ( KFPRI.ClientVeteranSkillLevel == 21 )
			return 4.40; //+17
		else if ( KFPRI.ClientVeteranSkillLevel == 22 )
			return 4.60; //+18
		else if ( KFPRI.ClientVeteranSkillLevel == 23 )
			return 4.80; //+19
		else if ( KFPRI.ClientVeteranSkillLevel == 24 )
			return 5.00; //+20
		else if ( KFPRI.ClientVeteranSkillLevel >= 25 )
			return 5.20; //+21
		}
	}
		
	else if ( AmmoType == class'WTFEquipSawedOffShotgun' || AmmoType == class'ShotgunAmmo' || AmmoType ==class'WTFEquipShotgunAmmo' || AmmoType == class'DBShotgunAmmo' || AmmoType == class'WTFEquipAFS12Ammo' || AmmoType == class'WTFEquipBoomStickAmmo' || AmmoType == class'AA12Ammo' || AmmoType == class'KSGAmmo' || AmmoType == class'LilithAmmo' || AmmoType == class'BenelliAmmo' || AmmoType == class'LAWAmmo' )
	{
		if ( KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.01 * float(KFPRI.ClientVeteranSkillLevel)); // 50% increase in shotgun ammo
	return 1.0;
	}
	return 1.0;
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeShotgun' || DmgType == class'DamTypeWTFShotgun' || DmgType == class'DamTypeDBShotgun' || DmgType == class'DamTypeWTFBoomStick' || DmgType == class'DamTypeBenelli' || DmgType == class'DamTypeKSGShotgun' || DmgType == class'DamTypeAA12Shotgun' || DmgType == class'DamTypeLilith' || DmgType == class'DamTypeAFS12Bullet' || DmgType == class'DamTypeAFS12Demo' || DmgType == class'DamTypeAFS12Headshot' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.10;
		return InDamage * (1.00 + (0.06 * float(KFPRI.ClientVeteranSkillLevel))); // 6% per level cap at 300% at 50
	}
	else if ( DmgType == class'DamTypeFrag' && KFPRI.ClientVeteranSkillLevel > 0 )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.00 + (0.06 * float(KFPRI.ClientVeteranSkillLevel))); //  6% per level cap at 300% at 50
	}
	return InDamage;
}


// Reduce Penetration damage with Shotgun slower
//static function float GetShotgunPenetrationDamageMulti(KFPlayerReplicationInfo KFPRI)
static function float GetShotgunPenetrationDamageMulti(KFPlayerReplicationInfo KFPRI, float DefaultPenDamageReduction)
{
	if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return class'ShotgunBullet'.default.PenDamageReduction + (class'ShotgunBullet'.default.PenDamageReduction / 10.0);
	return class'ShotgunBullet'.default.PenDamageReduction + ((class'ShotgunBullet'.default.PenDamageReduction / 5.5555) * float(Min(KFPRI.ClientVeteranSkillLevel, 6)));
}

// Change the cost of particular ammo
static function float GetAmmoCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'WTFEquipNadePickup' )
		return 1.00 - (0.01 * float(KFPRI.ClientVeteranSkillLevel)); // up to 50% discount on grenades
	return 1.0;
	
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'ShotgunPickup' || Item == class'WTFEquipShotgunPickup' || Item == class'BoomstickPickup' || Item == class'WTFEquipBoomStickPickup' || Item == class'WTFEquipAFS12Pickup' || Item == class'KSGPickup' || Item == class'BenelliPickup' || Item == class'AA12ExtPickup' || Item == class'LilithKissPickup' || Item == class'WTFEquipSawedOffShotgunPickup' )
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

//Reload Speed LVP
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Shotgun(Other) != none || WTFEquipShotgun(Other) != none || BoomStick(Other) != none || WTFEquipBoomStick(Other) != none || AA12AutoShotgun(Other) != none || WTFEquipAFS12a(Other) != none || KSGShotgun(Other) != none ||	BenelliShotgun(Other) != none || LilithKiss(Other) != none || WTFEquipSawedOffShotgun(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel >= 1 )
		return 1.0 + (0.01 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 50% With Shotguns that can get the bonus
	}
	return 1.0 + super.GetReloadSpeedModifier(KFPRI, Other);
}

//Recoil LVP
static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
		return Recoil - (1-super.ModifyRecoilSpread(KFPRI, Other, Recoil));
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 1-5, give them Shotgun
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 5 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Shotgun", GetCostScaling(KFPRI, class'ShotgunPickup'));
		
	// If Level 6-10, give them Boomstick
	if ( KFPRI.ClientVeteranSkillLevel >= 6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.BoomStick", GetCostScaling(KFPRI, class'BoomStickPickup'));
	
	// If level 11-15, give them KSG
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 20 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.KSGShotgun", GetCostScaling(KFPRI, class'KSGPickup'));
		
	// If level 21-25, give them AA12
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 25 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.AA12AutoShotgunExt", GetCostScaling(KFPRI, class'AA12ExtPickup'));
		
	// If level 26-30, give them WTF Shotgun
	if ( KFPRI.ClientVeteranSkillLevel >= 26 && KFPRI.ClientVeteranSkillLevel <= 30 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipShotgun", GetCostScaling(KFPRI, class'WTFEquipShotgunPickup'));
		
	// If level 31-35, give them WTF Boomstick
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipBoomStick", GetCostScaling(KFPRI, class'WTFEquipBoomStickPickup'));
		
	// If level 36-40, give them Lilith Kiss
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 40 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.LilithKiss", GetCostScaling(KFPRI, class'LilithKissPickup'));
		
	// IF level 41-50, give them AFS12
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFEquipAFS12a", GetCostScaling(KFPRI, class'WTFEquipAFS12Pickup'));
	
	// If level 1-50, give them a combat shotgun
	if ( KFPRI.ClientVeteranSkillLevel >= 1 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.BenelliShotgun", GetCostScaling(KFPRI, class'BenelliPickup'));
		
	// If level 41 give them armor
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		P.ShieldStrength = 100;

	
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.06 * float(Level)));
	ReplaceText(S,"%g",GetPercentStr(0.06*float(Level)-0.1f));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	ReplaceText(S,"%w",GetPercentStr(0.1 * float(Level)));
	return S;
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="6% More Damage With Support Weapons|1% Faster Reload With Support Weapons|18% Better Shotgun Penetration With Support Weapons|1% Extra Shotgun Ammo With Support Weapons|6% More Damage With Grenades|10% Increased Carry Weight|10% Faster Welding/Unwelding|70% Discount On Support Weapons|1% Discount On Grenades|Can Carry 5 Grenades|Spawn With Shotgun & Combat Shotgun"
     SRLevelEffects(2)="12% More Damage With Support Weapons|2% Faster Reload With Support Weapons|36% Better Shotgun Penetration With Support Weapons|2% Extra Shotgun Ammo With Support Weapons|12% More Damage With Grenades|20% Increased Carry Weight|20% Faster Welding/Unwelding|70% Discount On Support Weapons|2% Discount On Grenades|Can Carry 5 Grenades|Spawn With Shotgun & Combat Shotgun"
     SRLevelEffects(3)="18% More Damage With Support Weapons|3% Faster Reload With Support Weapons|54% Better Shotgun Penetration With Support Weapons|3% Extra Shotgun Ammo With Support Weapons|18% More Damage With Grenades|30% Increased Carry Weight|30% Faster Welding/Unwelding|70% Discount On Support Weapons|3% Discount On Grenades|Can Carry 5 Grenades|Spawn With Shotgun & Combat Shotgun"
     SRLevelEffects(4)="24% More Damage With Support Weapons|4% Faster Reload With Support Weapons|72% Better Shotgun Penetration With Support Weapons|4% Extra Shotgun Ammo With Support Weapons|24% More Damage With Grenades|40% Increased Carry Weight|40% Faster Welding/Unwelding|70% Discount On Support Weapons|4% Discount On Grenades|Can Carry 5 Grenades|Spawn With Shotgun & Combat Shotgun"
     SRLevelEffects(5)="30% More Damage With Support Weapons|5% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|5% Extra Shotgun Ammo With Support Weapons|30% More Damage With Grenades|50% Increased Carry Weight|50% Faster Welding/Unwelding|70% Discount On Support Weapons|5% Discount On Grenades|Can Carry 6 Grenades|Spawn With Shotgun & Combat Shotgun"
     SRLevelEffects(6)="36% More Damage With Support Weapons|6% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|6% Extra Shotgun Ammo With Support Weapons|36% More Damage With Grenades|60% Increased Carry Weight|60% Faster Welding/Unwelding|70% Discount On Support Weapons|6% Discount On Grenades|Can Carry 7 Grenades|Spawn With BoomStick & Combat Shotgun"
     SRLevelEffects(7)="42% More Damage With Support Weapons|7% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|7% Extra Shotgun Ammo With Support Weapons|42% More Damage With Grenades|70% Increased Carry Weight|70% Faster Welding/Unwelding|70% Discount On Support Weapons|7% Discount On Grenades|Can Carry 8 Grenades|Spawn With BoomStick & Combat Shotgun"
     SRLevelEffects(8)="48% More Damage With Support Weapons|8% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|8% Extra Shotgun Ammo With Support Weapons|48% More Damage With Grenades|80% Increased Carry Weight|80% Faster Welding/Unwelding|70% Discount On Support Weapons|8% Discount On Grenades|Can Carry 9 Grenades|Spawn With BoomStick & Combat Shotgun"
     SRLevelEffects(9)="54% More Damage With Support Weapons|9% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|9% Extra Shotgun Ammo With Support Weapons|54% More Damage With Grenades|90% Increased Carry Weight|90% Faster Welding/Unwelding|70% Discount On Support Weapons|9% Discount On Grenades|Can Carry 10 Grenades|Spawn With BoomStick & Combat Shotgun"
     SRLevelEffects(10)="60% More Damage With Support Weapons|10% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|10% Extra Shotgun Ammo With Support Weapons|60% More Damage With Grenades|100% Increased Carry Weight|100% Faster Welding/Unwelding|70% Discount On Support Weapons|10% Discount On Grenades|Can Carry 11 Grenades|Spawn With BoomStick & Combat Shotgun"
     SRLevelEffects(11)="66% More Damage With Support Weapons|11% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|11% Extra Shotgun Ammo With Support Weapons|66% More Damage With Grenades|110% Increased Carry Weight|110% Faster Welding/Unwelding|75% Discount On Support Weapons|11% Discount On Grenades|Can Carry 12 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(12)="72% More Damage With Support Weapons|12% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|12% Extra Shotgun Ammo With Support Weapons|72% More Damage With Grenades|120% Increased Carry Weight|120% Faster Welding/Unwelding|75% Discount On Support Weapons|12% Discount On Grenades|Can Carry 13 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(13)="78% More Damage With Support Weapons|13% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|13% Extra Shotgun Ammo With Support Weapons|78% More Damage With Grenades|130% Increased Carry Weight|130% Faster Welding/Unwelding|75% Discount On Support Weapons|13% Discount On Grenades|Can Carry 14 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(14)="84% More Damage With Support Weapons|14% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|14% Extra Shotgun Ammo With Support Weapons|84% More Damage With Grenades|140% Increased Carry Weight|140% Faster Welding/Unwelding|75% Discount On Support Weapons|14% Discount On Grenades|Can Carry 15 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(15)="90% More Damage With Support Weapons|15% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|15% Extra Shotgun Ammo With Support Weapons|90% More Damage With Grenades|150% Increased Carry Weight|150% Faster Welding/Unwelding|75% Discount On Support Weapons|15% Discount On Grenades|Can Carry 16 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(16)="96% More Damage With Support Weapons|16% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|16% Extra Shotgun Ammo With Support Weapons|96% More Damage With Grenades|160% Increased Carry Weight|160% Faster Welding/Unwelding|75% Discount On Support Weapons|16% Discount On Grenades|Can Carry 17 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(17)="102% More Damage With Support Weapons|17% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|17% Extra Shotgun Ammo With Support Weapons|102% More Damage With Grenades|170% Increased Carry Weight|170% Faster Welding/Unwelding|75% Discount On Support Weapons|17% Discount On Grenades|Can Carry 18 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(18)="108% More Damage With Support Weapons|18% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|18% Extra Shotgun Ammo With Support Weapons|108% More Damage With Grenades|180% Increased Carry Weight|180% Faster Welding/Unwelding|75% Discount On Support Weapons|18% Discount On Grenades|Can Carry 19 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(19)="114% More Damage With Support Weapons|19% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|19% Extra Shotgun Ammo With Support Weapons|114% More Damage With Grenades|190% Increased Carry Weight|190% Faster Welding/Unwelding|75% Discount On Support Weapons|19% Discount On Grenades|Can Carry 20 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(20)="120% More Damage With Support Weapons|20% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|20% Extra Shotgun Ammo With Support Weapons|120% More Damage With Grenades|200% Increased Carry Weight|200% Faster Welding/Unwelding|75% Discount On Support Weapons|20% Discount On Grenades|Can Carry 21 Grenades|Spawn With KSG & Combat Shotgun"
     SRLevelEffects(21)="126% More Damage With Support Weapons|21% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|21% Extra Shotgun Ammo With Support Weapons|126% More Damage With Grenades|210% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|21% Discount On Grenades|Can Carry 22 Grenades|Spawn With AA12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(22)="132% More Damage With Support Weapons|22% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|22% Extra Shotgun Ammo With Support Weapons|132% More Damage With Grenades|220% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|22% Discount On Grenades|Can Carry 23 Grenades|Spawn With AA12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(23)="138% More Damage With Support Weapons|23% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|23% Extra Shotgun Ammo With Support Weapons|138% More Damage With Grenades|230% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|23% Discount On Grenades|Can Carry 24 Grenades|Spawn With AA12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(24)="144% More Damage With Support Weapons|24% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|24% Extra Shotgun Ammo With Support Weapons|144% More Damage With Grenades|240% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|24% Discount On Grenades|Can Carry 25 Grenades|Spawn With AA12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(25)="150% More Damage With Support Weapons|25% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|25% Extra Shotgun Ammo With Support Weapons|150% More Damage With Grenades|250% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|25% Discount On Grenades|Can Carry 26 Grenades|Spawn With AA12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(26)="156% More Damage With Support Weapons|26% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|26% Extra Shotgun Ammo With Support Weapons|156% More Damage With Grenades|260% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|26% Discount On Grenades|Can Carry 26 Grenades|Spawn With WTF Shotgun & Combat Shotgun"
     SRLevelEffects(27)="162% More Damage With Support Weapons|27% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|27% Extra Shotgun Ammo With Support Weapons|162% More Damage With Grenades|Can Carry 26 Grenades|270% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|27% Discount On Grenades|Spawn With WTF Shotgun & Combat Shotgun"
     SRLevelEffects(28)="168% More Damage With Support Weapons|28% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|28% Extra Shotgun Ammo With Support Weapons|168% More Damage With Grenades|Can Carry 26 Grenades|280% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|28% Discount On Grenades|Spawn With WTF Shotgun & Combat Shotgun"
     SRLevelEffects(29)="174% More Damage With Support Weapons|29% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|29% Extra Shotgun Ammo With Support Weapons|174% More Damage With Grenades|Can Carry 26 Grenades|2100% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|29% Discount On Grenades|Spawn With WTF Shotgun & Combat Shotgun"
     SRLevelEffects(30)="180% More Damage With Support Weapons|30% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|30% Extra Shotgun Ammo With Support Weapons|180% More Damage With Grenades|Can Carry 26 Grenades|300% Increased Carry Weight|200% Faster Welding/Unwelding|80% Discount On Support Weapons|30% Discount On Grenades|Spawn With WTF Shotgun & Combat Shotgun"
     SRLevelEffects(31)="186% More Damage With Support Weapons|31% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|31% Extra Shotgun Ammo With Support Weapons|186% More Damage With Grenades|Can Carry 26 Grenades|310% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|31% Discount On Grenades|Spawn With WTF BoomStick & Combat Shotgun"
     SRLevelEffects(32)="192% More Damage With Support Weapons|32% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|32% Extra Shotgun Ammo With Support Weapons|192% More Damage With Grenades|Can Carry 26 Grenades|320% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|32% Discount On Grenades|Spawn With WTF BoomStick & Combat Shotgun"
     SRLevelEffects(33)="198% More Damage With Support Weapons|33% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|33% Extra Shotgun Ammo With Support Weapons|198% More Damage With Grenades|Can Carry 26 Grenades|330% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|33% Discount On Grenades|Spawn With WTF BoomStick & Combat Shotgun"
     SRLevelEffects(34)="204% More Damage With Support Weapons|34% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|34% Extra Shotgun Ammo With Support Weapons|204% More Damage With Grenades|Can Carry 26 Grenades|340% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|34% Discount On Grenades|Spawn With WTF BoomStick & Combat Shotgun"
     SRLevelEffects(35)="210% More Damage With Support Weapons|35% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|35% Extra Shotgun Ammo With Support Weapons|210% More Damage With Grenades|Can Carry 26 Grenades|350% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|35% Discount On Grenades|Spawn With WTF BoomStick & Combat Shotgun"
     SRLevelEffects(36)="216% More Damage With Support Weapons|36% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|36% Extra Shotgun Ammo With Support Weapons|216% More Damage With Grenades|Can Carry 26 Grenades|360% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|36% Discount On Grenades|Spawn With Lilith Kiss & Combat Shotgun"
     SRLevelEffects(37)="222% More Damage With Support Weapons|37% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|37% Extra Shotgun Ammo With Support Weapons|222% More Damage With Grenades|Can Carry 26 Grenades|370% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|37% Discount On Grenades|Spawn With Lilith Kiss & Combat Shotgun"
     SRLevelEffects(38)="228% More Damage With Support Weapons|38% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|38% Extra Shotgun Ammo With Support Weapons|228% More Damage With Grenades|Can Carry 26 Grenades|380% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|38% Discount On Grenades|Spawn With Lilith Kiss & Combat Shotgun"
     SRLevelEffects(39)="234% More Damage With Support Weapons|39% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|39% Extra Shotgun Ammo With Support Weapons|234% More Damage With Grenades|Can Carry 26 Grenades|390% Increased Carry Weight|200% Faster Welding/Unwelding|85% Discount On Support Weapons|39% Discount On Grenades|Spawn With Lilith Kiss & Combat Shotgun"
     SRLevelEffects(40)="240% More Damage With Support Weapons|40% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|40% Extra Shotgun Ammo With Support Weapons|240% More Damage With Grenades|Can Carry 26 Grenades|400% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|40% Discount On Grenades|Spawn With Lilith Kiss & Combat Shotgun"
     SRLevelEffects(41)="246% More Damage With Support Weapons|41% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|41% Extra Shotgun Ammo With Support Weapons|246% More Damage With Grenades|Can Carry 26 Grenades|410% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|41% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(42)="252% More Damage With Support Weapons|42% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|42% Extra Shotgun Ammo With Support Weapons|252% More Damage With Grenades|Can Carry 26 Grenades|420% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|42% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(43)="258% More Damage With Support Weapons|43% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|43% Extra Shotgun Ammo With Support Weapons|258% More Damage With Grenades|Can Carry 26 Grenades|430% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|43% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(44)="264% More Damage With Support Weapons|44% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|44% Extra Shotgun Ammo With Support Weapons|264% More Damage With Grenades|Can Carry 26 Grenades|440% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|44% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(45)="270% More Damage With Support Weapons|45% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|45% Extra Shotgun Ammo With Support Weapons|270% More Damage With Grenades|Can Carry 26 Grenades|450% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|45% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(46)="276% More Damage With Support Weapons|46% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|46% Extra Shotgun Ammo With Support Weapons|276% More Damage With Grenades|Can Carry 26 Grenades|460% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|46% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(47)="282% More Damage With Support Weapons|47% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|47% Extra Shotgun Ammo With Support Weapons|282% More Damage With Grenades|Can Carry 26 Grenades|470% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|47% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(48)="288% More Damage With Support Weapons|48% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|48% Extra Shotgun Ammo With Support Weapons|288% More Damage With Grenades|Can Carry 26 Grenades|480% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|48% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(49)="294% More Damage With Support Weapons|49% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|49% Extra Shotgun Ammo With Support Weapons|294% More Damage With Grenades|Can Carry 26 Grenades|490% Increased Carry Weight|200% Faster Welding/Unwelding|90% Discount On Support Weapons|49% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     SRLevelEffects(50)="300% More Damage With Support Weapons|50% Faster Reload With Support Weapons|100% Better Shotgun Penetration With Support Weapons|50% Extra Shotgun Ammo With Support Weapons|300% More Damage With Grenades|Can Carry 26 Grenades|500% Increased Carry Weight|200% Faster Welding/Unwelding|95% Discount On Support Weapons|50% Discount On Grenades|Spawn With WTF AFS12 Auto Shotgun & Combat Shotgun"
     PerkIndex=1
     OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Support'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Support_Gold'
     VeterancyName="Support Specialist"
     Requirements(0)="Deal %x Damage with shotguns"
}
