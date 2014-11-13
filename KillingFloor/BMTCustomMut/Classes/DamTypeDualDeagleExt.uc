class DamTypeDualDeagleExt extends DamTypeDeagleExt
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.DualDeagleExt'
     DeathString="%k killed %o (Dual Handcannon)."
}
