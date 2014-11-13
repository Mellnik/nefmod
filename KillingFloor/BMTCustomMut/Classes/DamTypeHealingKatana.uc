class DamTypeHealingKatana extends DamTypeMelee;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MedicProgress',Amount);
}

defaultproperties
{
     HeadShotDamageMult=1.100000
     WeaponClass=Class'BMTCustomMut.HealingKatana'
     PawnDamageSounds(0)=Sound'KFPawnDamageSound.MeleeDamageSounds.axehitflesh'
     VehicleDamageScaling=0.500000
}
