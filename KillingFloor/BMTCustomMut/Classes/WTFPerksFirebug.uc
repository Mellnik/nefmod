class WTFPerksFirebug extends SRVeterancyTypes
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
	return Min(StatOther.RFlameThrowerDamageStat,FinalInt);
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Flamethrower(Other) != none || MAC10MP(Other) != none || UMP45SubmachineGun(Other) != none || WTFFlamer(Other) != none || PB(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.06 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
	return 1.0;
}
static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( FlameAmmo(Other) != none || FRevolverAmmo(Other) != none || MAC10Ammo(Other) != none || UMP45Ammo(Other) != none || WTFFlamerAmmo(Other) != none ||
		FM32Ammo(Other) != none || M79CFAmmo(Other) != none || PBAmmo(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.06 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
	return 1.0;
}
static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'FlameAmmo' || AmmoType == class'FRevolverAmmo' || AmmoType == class'UMP45Ammo' || AmmoType == class'MAC10Ammo' || AmmoType == class'WTFFlamerAmmo' ||
		AmmoType == class'FM32Ammo' || AmmoType == class'M79CFAmmo' || AmmoType == class'PBAmmo' && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.06 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister

	return 1.0;
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeBurned>(DmgType) != none || class<DamTypeFlamethrower>(DmgType) != none || class<DamTypeUMP45>(DmgType) != none ||
		class<DamTypeFlameNade>(DmgType) != none || class<DamTypeWTFFlamer>(Dmgtype) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); //  Up to 60% extra damage
	}
	if ( DmgType == class'DamTypeWTFM79Fire' || DmgType == class'DamTypeFirebugProgress' ) 
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); // 5% per level cap 250% at 50
	}
	return InDamage;
}

// Change effective range on FlameThrower
static function int ExtraRange(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 2 )
		return 0;
	else if ( KFPRI.ClientVeteranSkillLevel <= 4 )
		return 1; // 50% Longer Range	
	return 2; // 100% Longer Range	
}

//static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, KFMonster DamageTaker, int InDamage, class<DamageType> DmgType)
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeBurned>(DmgType) != none || class<DamTypeFlamethrower>(DmgType) != none || class<DamTypeHuskGun>(DmgType) != none || class<DamTypeWTFFlamer>(DmgType) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return float(InDamage) * 0.90;
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			return float(InDamage) * 0.80;
		else if ( KFPRI.ClientVeteranSkillLevel == 3 )
			return float(InDamage) * 0.70;
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
			return float(InDamage) * 0.60;
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
			return float(InDamage) * 0.50;
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			return float(InDamage) * 0.40;
		else if ( KFPRI.ClientVeteranSkillLevel == 7 )
			return float(InDamage) * 0.30;
		else if ( KFPRI.ClientVeteranSkillLevel == 8 )
			return float(InDamage) * 0.20;
		else if ( KFPRI.ClientVeteranSkillLevel == 9 )
			return float(InDamage) * 0.10;
		else if ( KFPRI.ClientVeteranSkillLevel >= 10)
			return float(InDamage) * 0.00; //100% resistance to fire damage
	}
	return InDamage;
}

static function class<Grenade> GetNadeType(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 3 )
		return class'FlameNade'; // Grenade detonations cause enemies to catch fire
	return super.GetNadeType(KFPRI);
}

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Flamethrower(Other) != none || WTFFlamer(Other) != none || FM32GrenadeLauncher(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.06 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 60% faster reload with Flamethrower
	}
	if ( MAC10MP(Other) != none || DualFRevolver(Other) != none || FRevolver(Other) != none || UMP45SubmachineGun(Other) != none || PB(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.03 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // Up to 30% faster reload with MAC-10
	}

	return 1.0 + super.GetReloadSpeedModifier(KFPRI, Other);
}
 
//Max carry weight
static function int AddCarryMaxWeight(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		return 1; //+1 extra carry weight
	return 1;
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'FlameThrowerPickup' || Item == class'DualFRevolverPickup' || Item == class'FRevolverPickup' ||
		 Item == class'WTFFlamerPickup' || Item == class'MAC10Pickup' || Item == class 'M79CFPickup' || Item == class'UMP45Pickup' || Item == class'HuskgunPickup' ||
		 Item == class'FM32Pickup' || Item == class'PBPickup' )
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

static function class<DamageType> GetMAC10DamageType(KFPlayerReplicationInfo KFPRI)
{
	return class'DamTypeMAC10MPInc';
}

static function class<DamageType> GetUMP45SubmachineGunDamageType(KFPlayerReplicationInfo KFPRI)
{
	return class'DamTypeUMP45';
}

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if (  MAC10MP(Other.Weapon) != none || DualFRevolver(Other.Weapon) != none || FRevolver(Other.Weapon) != none || UMP45SubmachineGun(Other.Weapon) != none || FM32GrenadeLauncher(Other.Weapon) != none || WTFFlamer(Other.Weapon) != none || Flamethrower(Other.Weapon) != none || PB(Other.Weapon) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel >= 1 )
			Recoil = 0.12;
	}
	return Recoil - (1-super.ModifyRecoilSpread(KFPRI, Other, Recoil));
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If level 1-10 give them mac10
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 10 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Mac10MP", GetCostScaling(KFPRI, class'Mac10Pickup'));
	
	// If level 11-20 give them Ump45
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 20 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.UMP45SubmachineGun", GetCostScaling(KFPRI, class'UMP45Pickup'));
	
	// If level 21-30 give them M79CF
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 30 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.M79CF", GetCostScaling(KFPRI, class'M79CFPickup'));
	
	// If level 31-40 give them Flamethrower
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.FlameThrower", GetCostScaling(KFPRI, class'FlamethrowerPickup'));
	
	// If level 41-49 give them Flamerthrower + mac10
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 49 )
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.FlameThrower", GetCostScaling(KFPRI, class'FlamethrowerPickup'));
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 49 )	
		KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Mac10MP", GetCostScaling(KFPRI, class'Mac10Pickup'));
		
	// If level 50 give them WTF Flamerthrower
	if ( KFPRI.ClientVeteranSkillLevel == 50 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.WTFFlamer", GetCostScaling(KFPRI, class'WTFFlamerPickup'));

	// If Level 21-50 give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 21 )
		P.ShieldStrength = 100;
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.06 * float(Level)));
	ReplaceText(S,"%m",GetPercentStr(0.05 * float(Level)));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
     CustomLevelInfo="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="6% Extra Damage With Firebug Weapons|6% Faster Reload Speed With Firebug Weapons|3% Faster Reload Speed With Firebug SubMachineGuns|6% Larger Clipsize With Firebug Weapons|10% Resistance To Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(2)="12% Extra Damage With Firebug Weapons|12% Faster Reload Speed With Firebug Weapons|6% Faster Reload Speed With Firebug SubMachineGuns|12% Larger Clipsize With Firebug Weapons|20% Resistance To Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(3)="18% Extra Damage With Firebug Weapons|18% Faster Reload Speed With Firebug Weapons|9% Faster Reload Speed With Firebug SubMachineGuns|18% Larger Clipsize With Firebug Weapons|30% Resistance To Fire|50% Extra Flamethrower Range|Grenades Set Enemies On Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(4)="24% Extra Damage With Firebug Weapons|24% Faster Reload Speed With Firebug Weapons|12% Faster Reload Speed With Firebug SubMachineGuns|24% Larger Clipsize With Firebug Weapons|40% Resistance To Fire|50% Extra Flamethrower Range|Grenades Set Enemies On Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(5)="30% Extra Damage With Firebug Weapons|30% Faster Reload Speed With Firebug Weapons|15% Faster Reload Speed With Firebug SubMachineGuns|30% Larger Clipsize With Firebug Weapons|50% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(6)="36% Extra Damage With Firebug Weapons|36% Faster Reload Speed With Firebug Weapons|18% Faster Reload Speed With Firebug SubMachineGuns|36% Larger Clipsize With Firebug Weapons|60% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(7)="42% Extra Damage With Firebug Weapons|42% Faster Reload Speed With Firebug Weapons|21% Faster Reload Speed With Firebug SubMachineGuns|42% Larger Clipsize With Firebug Weapons|70% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(8)="48% Extra Damage With Firebug Weapons|48% Faster Reload Speed With Firebug Weapons|24% Faster Reload Speed With Firebug SubMachineGuns|48% Larger Clipsize With Firebug Weapons|80% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(9)="54% Extra Damage With Firebug Weapons|54% Faster Reload Speed With Firebug Weapons|27% Faster Reload Speed With Firebug SubMachineGuns|54% Larger Clipsize With Firebug Weapons|90% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(10)="60% Extra Damage With Firebug Weapons|60% Faster Reload Speed With Firebug Weapons|30% Faster Reload Speed With Firebug SubMachineGuns|60% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|70% Discount On Firebug Weapons|Spawn With An Mac10"
     SRLevelEffects(11)="66% Extra Damage With Firebug Weapons|66% Faster Reload Speed With Firebug Weapons|33% Faster Reload Speed With Firebug SubMachineGuns|66% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(12)="72% Extra Damage With Firebug Weapons|72% Faster Reload Speed With Firebug Weapons|36% Faster Reload Speed With Firebug SubMachineGuns|72% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(13)="78% Extra Damage With Firebug Weapons|78% Faster Reload Speed With Firebug Weapons|39% Faster Reload Speed With Firebug SubMachineGuns|78% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(14)="84% Extra Damage With Firebug Weapons|84% Faster Reload Speed With Firebug Weapons|42% Faster Reload Speed With Firebug SubMachineGuns|84% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(15)="90% Extra Damage With Firebug Weapons|90% Faster Reload Speed With Firebug Weapons|45% Faster Reload Speed With Firebug SubMachineGuns|90% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(16)="96% Extra Damage With Firebug Weapons|96% Faster Reload Speed With Firebug Weapons|48% Faster Reload Speed With Firebug SubMachineGuns|96% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(17)="102% Extra Damage With Firebug Weapons|102% Faster Reload Speed With Firebug Weapons|51% Faster Reload Speed With Firebug SubMachineGuns|102% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(18)="108% Extra Damage With Firebug Weapons|108% Faster Reload Speed With Firebug Weapons|54% Faster Reload Speed With Firebug SubMachineGuns|108% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(19)="114% Extra Damage With Firebug Weapons|114% Faster Reload Speed With Firebug Weapons|57% Faster Reload Speed With Firebug SubMachineGuns|114% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(20)="120% Extra Damage With Firebug Weapons|120% Faster Reload Speed With Firebug Weapons|60% Faster Reload Speed With Firebug SubMachineGuns|120% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|75% Discount On Firebug Weapons|Spawn With An Ump45"
     SRLevelEffects(21)="126% Extra Damage With Firebug Weapons|126% Faster Reload Speed With Firebug Weapons|63% Faster Reload Speed With Firebug SubMachineGuns|126% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(22)="132% Extra Damage With Firebug Weapons|132% Faster Reload Speed With Firebug Weapons|66% Faster Reload Speed With Firebug SubMachineGuns|132% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(23)="138% Extra Damage With Firebug Weapons|138% Faster Reload Speed With Firebug Weapons|69% Faster Reload Speed With Firebug SubMachineGuns|138% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(24)="144% Extra Damage With Firebug Weapons|144% Faster Reload Speed With Firebug Weapons|72% Faster Reload Speed With Firebug SubMachineGuns|144% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(25)="150% Extra Damage With Firebug Weapons|150% Faster Reload Speed With Firebug Weapons|75% Faster Reload Speed With Firebug SubMachineGuns|150% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(26)="156% Extra Damage With Firebug Weapons|156% Faster Reload Speed With Firebug Weapons|78% Faster Reload Speed With Firebug SubMachineGuns|156% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(27)="162% Extra Damage With Firebug Weapons|162% Faster Reload Speed With Firebug Weapons|81% Faster Reload Speed With Firebug SubMachineGuns|162% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(28)="168% Extra Damage With Firebug Weapons|168% Faster Reload Speed With Firebug Weapons|84% Faster Reload Speed With Firebug SubMachineGuns|168% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(29)="174% Extra Damage With Firebug Weapons|174% Faster Reload Speed With Firebug Weapons|87% Faster Reload Speed With Firebug SubMachineGuns|174% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(30)="180% Extra Damage With Firebug Weapons|180% Faster Reload Speed With Firebug Weapons|90% Faster Reload Speed With Firebug SubMachineGuns|180% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|80% Discount On Firebug Weapons|Spawn With M79CF & Body Armor"
     SRLevelEffects(31)="186% Extra Damage With Firebug Weapons|186% Faster Reload Speed With Firebug Weapons|93% Faster Reload Speed With Firebug SubMachineGuns|186% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(32)="192% Extra Damage With Firebug Weapons|192% Faster Reload Speed With Firebug Weapons|96% Faster Reload Speed With Firebug SubMachineGuns|192% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(33)="198% Extra Damage With Firebug Weapons|198% Faster Reload Speed With Firebug Weapons|99% Faster Reload Speed With Firebug SubMachineGuns|198% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(34)="204% Extra Damage With Firebug Weapons|204% Faster Reload Speed With Firebug Weapons|102% Faster Reload Speed With Firebug SubMachineGuns|204% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(35)="210% Extra Damage With Firebug Weapons|210% Faster Reload Speed With Firebug Weapons|105% Faster Reload Speed With Firebug SubMachineGuns|210% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(36)="216% Extra Damage With Firebug Weapons|216% Faster Reload Speed With Firebug Weapons|108% Faster Reload Speed With Firebug SubMachineGuns|216% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(37)="222% Extra Damage With Firebug Weapons|222% Faster Reload Speed With Firebug Weapons|111% Faster Reload Speed With Firebug SubMachineGuns|222% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(38)="228% Extra Damage With Firebug Weapons|228% Faster Reload Speed With Firebug Weapons|114% Faster Reload Speed With Firebug SubMachineGuns|228% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(39)="234% Extra Damage With Firebug Weapons|234% Faster Reload Speed With Firebug Weapons|117% Faster Reload Speed With Firebug SubMachineGuns|234% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(40)="240% Extra Damage With Firebug Weapons|240% Faster Reload Speed With Firebug Weapons|120% Faster Reload Speed With Firebug SubMachineGuns|240% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|85% Discount On Firebug Weapons|Spawn With Flamethrower & Body Armor"
     SRLevelEffects(41)="246% Extra Damage With Firebug Weapons|246% Faster Reload Speed With Firebug Weapons|123% Faster Reload Speed With Firebug SubMachineGuns|246% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(42)="252% Extra Damage With Firebug Weapons|252% Faster Reload Speed With Firebug Weapons|126% Faster Reload Speed With Firebug SubMachineGuns|252% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(43)="258% Extra Damage With Firebug Weapons|258% Faster Reload Speed With Firebug Weapons|129% Faster Reload Speed With Firebug SubMachineGuns|258% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(44)="264% Extra Damage With Firebug Weapons|264% Faster Reload Speed With Firebug Weapons|132% Faster Reload Speed With Firebug SubMachineGuns|264% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(45)="270% Extra Damage With Firebug Weapons|270% Faster Reload Speed With Firebug Weapons|135% Faster Reload Speed With Firebug SubMachineGuns|270% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(46)="276% Extra Damage With Firebug Weapons|276% Faster Reload Speed With Firebug Weapons|138% Faster Reload Speed With Firebug SubMachineGuns|276% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(47)="282% Extra Damage With Firebug Weapons|282% Faster Reload Speed With Firebug Weapons|141% Faster Reload Speed With Firebug SubMachineGuns|282% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(48)="288% Extra Damage With Firebug Weapons|288% Faster Reload Speed With Firebug Weapons|144% Faster Reload Speed With Firebug SubMachineGuns|288% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(49)="294% Extra Damage With Firebug Weapons|294% Faster Reload Speed With Firebug Weapons|147% Faster Reload Speed With Firebug SubMachineGuns|294% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|90% Discount On Firebug Weapons|Spawn With Flamethrower, Mac-10 & Body Armor|+1 Carry Weight"
     SRLevelEffects(50)="300% Extra Damage With Firebug Weapons|300% Faster Reload Speed With Firebug Weapons|150% Faster Reload Speed With Firebug SubMachineGuns|300% Larger Clipsize With Firebug Weapons|100% Resistance To Fire|100% Extra Flamethrower Range|Grenades Set Enemies On Fire|95% Discount On Firebug Weapons|Spawn With WTF Flamethrower & Body Armor|+1 Carry Weight"
     PerkIndex=5
     OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Firebug'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Firebug_Gold'
     VeterancyName="Firebug"
     Requirements(0)="Deal %x Damage with the Flamethrower"
}
