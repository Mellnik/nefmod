class DamTypeDualMK23Ext extends DamTypeMK23Ext
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.DualMK23Ext'
     DeathString="%k killed %o (Dual MK23)."
}
