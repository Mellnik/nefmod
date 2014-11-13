class DamTypeDualMKExt extends DamTypeMKExt
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.DualMK23Ext'
     DeathString="%o was turned into swiss cheese by %o's Dual MK23."
}
