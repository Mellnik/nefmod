class DamTypeMag44 extends DamTypeMagnum44Pistol
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
}

defaultproperties
{
}
