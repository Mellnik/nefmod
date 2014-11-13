class WTFPerksLoser extends SRVeterancyTypes
	abstract;

static final function string GetLevelReq( byte L )
{
	local string S;

	S = Default.Requirements[0];
	ReplaceText(S,"%x",string(L));
	return S;
}
static function string GetVetInfoText( byte Level, byte Type, optional byte RequirementNum )
{
	switch( Type )
	{
	case 0:
		return Default.LevelNames[Min(Level,ArrayCount(Default.LevelNames))];
	case 1:
		if( Level>=ArrayCount(Default.LevelEffects) )
			return Default.CustomLevelInfo;
		return Default.LevelEffects[Level];
	case 2:
		return GetLevelReq(Level);
	default:
		return Default.VeterancyName;
	}
}
static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	FinalInt = 3600*CurLevel;
	return Min(StatOther.TotalPlayTime,FinalInt);
}
static function bool LevelIsFinished( ClientPerkRepLink StatOther, byte CurLevel )
{
	local byte i,rc;
	local int R,V;

	if( CurLevel==StatOther.MaximumLevel )
		return false;
	rc = GetRequirementCount(StatOther,CurLevel);
	for( i=0; i<rc; i++ )
	{
		V = GetPerkProgressInt(StatOther,R,CurLevel,i);
		if( R>V )
			return false;
	}
	return true;
}
static function float GetPerkProgress( ClientPerkRepLink StatOther, byte CurLevel, byte ReqNum, out int Numerator, out int Denominator )
{
	if( CurLevel==StatOther.MaximumLevel )
	{
		Denominator = 1;
		Numerator = 1;
		return 1.f;
	}
	Numerator = GetPerkProgressInt(StatOther,Denominator,CurLevel,ReqNum);
	return FMin(float(Numerator)/float(Denominator),1.f);
}

// Modify movement speed
static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI, KFGameReplicationInfo KFGRI)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 6 )
		return 1.0;
	return 1.40 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // starts at +40% and decreases 10 each level untill 7 then does no bonus.
}

// Reduce damage zombies can deal to you
//static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, KFMonster DamageTaker, int InDamage, class<DamageType> DmgType)
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeVomit' )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
		case 1:
		return float(InDamage) * 0.58;
		case 2:
		return float(InDamage) * 0.66;
		case 3:
		return float(InDamage) * 0.74;
		case 4:
		return float(InDamage) * 0.82;
		case 5:
		return float(InDamage) * 0.90;
		case 6:
		return float(InDamage) * 0.98;
		}
	}
		switch ( KFPRI.ClientVeteranSkillLevel )
	{
		case 1:
		return float(InDamage) * 0.58;
		case 2:
		return float(InDamage) * 0.66;
		case 3:
		return float(InDamage) * 0.74;
		case 4:
		return float(InDamage) * 0.82;
		case 5:
		return float(InDamage) * 0.90;
		case 6:
		return float(InDamage) * 0.98;
	}

	return InDamage;
}
		
// Add damage you deal to zombies
static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 1 && KFPRI.ClientVeteranSkillLevel <= 6 )
		return InDamage * (2.85 - (0.15 * float(KFPRI.ClientVeteranSkillLevel)));
		
	return InDamage;
}

// Modify the spear/recoil for a weapon fire.
static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 1 )
		Recoil = 0.80;
	else if ( KFPRI.ClientVeteranSkillLevel == 2 )
		Recoil = 0.85;
	else if ( KFPRI.ClientVeteranSkillLevel == 3 )
		Recoil = 0.90;
	else if ( KFPRI.ClientVeteranSkillLevel == 4 )
		Recoil = 0.95;
	else if ( KFPRI.ClientVeteranSkillLevel == 5 )
		Recoil = 1.00;
	else if ( KFPRI.ClientVeteranSkillLevel == 6 )
		Recoil = 1.00;
	else if ( KFPRi.ClientVeteranSkillLevel >= 7 )
		Recoil = 10.0;
	return Recoil - (1-super.ModifyRecoilSpread(KFPRI, Other, Recoil));
}

// Can Clots grab me?
static function bool CanBeGrabbed(KFPlayerReplicationInfo KFPRI, KFMonster Other)
{
	return (KFPRI.ClientVeteranSkillLevel>=3);
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if( KFPRI.ClientVeteranSkillLevel>=7 )
		return 1.f;
	return FMin(0.5f+(0.05f*KFPRI.ClientVeteranSkillLevel),1.f);
}

// Change the cost of particular ammo
static function float GetAmmoCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if( KFPRI.ClientVeteranSkillLevel>=7 )
		return 1.f;
	return FMin(0.5f+(0.05f*KFPRI.ClientVeteranSkillLevel),1.f);
}

static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 1-6, give them a ALLPerkGun + armor
	if ( KFPRI.ClientVeteranSkillLevel == 1 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.ALLPerkGun", GetCostScaling(KFPRI, class'ALLPerkGunPickup'));
	if ( KFPRI.ClientVeteranSkillLevel == 2 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.ALLPerkGun", GetCostScaling(KFPRI, class'ALLPerkGunPickup'));
	if ( KFPRI.ClientVeteranSkillLevel == 3 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.ALLPerkGun", GetCostScaling(KFPRI, class'ALLPerkGunPickup'));
	if ( KFPRI.ClientVeteranSkillLevel == 4 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.ALLPerkGun", GetCostScaling(KFPRI, class'ALLPerkGunPickup'));
	if ( KFPRI.ClientVeteranSkillLevel == 5 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.ALLPerkGun", GetCostScaling(KFPRI, class'ALLPerkGunPickup'));
	if ( KFPRI.ClientVeteranSkillLevel == 1 )
		KFHumanPawn(P).CreateInventoryVeterancy("BMTCustomMut.ALLPerkGun", GetCostScaling(KFPRI, class'ALLPerkGunPickup'));

	// If Level 1-3, give them armor
	if ( KFPRI.ClientVeteranSkillLevel == 1 && KFPRI.ClientVeteranSkillLevel <=3)
		P.ShieldStrength = 100;
}

static function byte PreDrawPerk( Canvas C, byte Level, out Material PerkIcon, out Material StarIcon )
{
	if( Level>=7 )
		C.SetDrawColor(15, 15, 15, C.DrawColor.A);
	PerkIcon = Default.OnHUDIcon;
	StarIcon = Class'HUDKillingFloor'.Default.VetStarMaterial;
	return Max(7-Level,0);
}

//Reload speed boost for all weapons LVP
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	return (0.00 * float(KFPRI.ClientVeteranSkillLevel)) + super.GetReloadSpeedModifier(KFPRI, Other); // 0% place holder
}


defaultproperties
{
     CustomLevelInfo="No effects! Time to use a different perk!! You are No longer a NOOB!!!"
     SRLevelEffects(0)="No Custom Level Info. Please Notify Admin"
     SRLevelEffects(1)="185% Extra Damage For All Weapons|90% Discount For All Weapons|40% Extra Movement Speed|42% Damage Reduction|20% Less Recoil For All Weapons|Can't Be Grabbed By Clots|Spawn With An ALLPerkGun & Body Armor"
     SRLevelEffects(2)="170% Extra Damage For All Weapons|80% Discount For All Weapons|30% Extra Movement Speed|34% Damage Reduction|15% Less Recoil For All Weapons|Can't Be Grabbed By Clots|Spawn With An ALLPerkGun & Body Armor"
     SRLevelEffects(3)="155% Extra Damage For All Weapons|70% Discount For All Weapons|20% Extra Movement Speed|26% Damage Reduction|10% Less Recoil For All Weapons|Spawn With An ALLPerkGun"
     SRLevelEffects(4)="140% Extra Damage For All Weapons|60% Discount For All Weapons|10% Extra Movement Speed|18% Damage Reduction|5% Less Recoil For All Weapons|Spawn With An ALLPerkGun"
     SRLevelEffects(5)="125% Extra Damage For All Weapons|50% Discount For All Weapons|10% Damage Reduction|Spawn With An ALLPerkGun"
     SRLevelEffects(6)="115% Extra Damage For All Weapons|40% Discount For All Weapons|2% Damage Reduction|Spawn With An ALLPerkGun"
     SRLevelEffects(7)="SRLevelEffects(0)="
     SRLevelEffects(8)="SRLevelEffects(0)="
     SRLevelEffects(9)="SRLevelEffects(0)="
     SRLevelEffects(10)="SRLevelEffects(0)="
     SRLevelEffects(11)="SRLevelEffects(0)="
     SRLevelEffects(12)="SRLevelEffects(0)="
     SRLevelEffects(13)="SRLevelEffects(0)="
     SRLevelEffects(14)="SRLevelEffects(0)="
     SRLevelEffects(15)="SRLevelEffects(0)="
     SRLevelEffects(16)="SRLevelEffects(0)="
     SRLevelEffects(17)="SRLevelEffects(0)="
     SRLevelEffects(18)="SRLevelEffects(0)="
     SRLevelEffects(19)="SRLevelEffects(0)="
     SRLevelEffects(20)="SRLevelEffects(0)="
     SRLevelEffects(21)="SRLevelEffects(0)="
     SRLevelEffects(22)="SRLevelEffects(0)="
     SRLevelEffects(23)="SRLevelEffects(0)="
     SRLevelEffects(24)="SRLevelEffects(0)="
     SRLevelEffects(25)="SRLevelEffects(0)="
     SRLevelEffects(26)="SRLevelEffects(0)="
     SRLevelEffects(27)="SRLevelEffects(0)="
     SRLevelEffects(28)="SRLevelEffects(0)="
     SRLevelEffects(29)="SRLevelEffects(0)="
     SRLevelEffects(30)="SRLevelEffects(0)="
     SRLevelEffects(31)="SRLevelEffects(0)="
     SRLevelEffects(32)="SRLevelEffects(0)="
     SRLevelEffects(33)="SRLevelEffects(0)="
     SRLevelEffects(34)="SRLevelEffects(0)="
     SRLevelEffects(35)="SRLevelEffects(0)="
     SRLevelEffects(36)="SRLevelEffects(0)="
     SRLevelEffects(37)="SRLevelEffects(0)="
     SRLevelEffects(38)="SRLevelEffects(0)="
     SRLevelEffects(39)="SRLevelEffects(0)="
     SRLevelEffects(40)="SRLevelEffects(0)="
     SRLevelEffects(41)="SRLevelEffects(0)="
     SRLevelEffects(42)="SRLevelEffects(0)="
     SRLevelEffects(43)="SRLevelEffects(0)="
     SRLevelEffects(44)="SRLevelEffects(0)="
     SRLevelEffects(45)="SRLevelEffects(0)="
     SRLevelEffects(46)="SRLevelEffects(0)="
     SRLevelEffects(47)="SRLevelEffects(0)="
     SRLevelEffects(48)="SRLevelEffects(0)="
     SRLevelEffects(49)="SRLevelEffects(0)="
     SRLevelEffects(50)="SRLevelEffects(0)="
     OnHUDIcon=Texture'KillingFloorHUD.HUD.Hud_Lightning_Bolt'
     VeterancyName="Newbie's choice"
     Requirements(0)="Play %x hour(s) on the server"
}
