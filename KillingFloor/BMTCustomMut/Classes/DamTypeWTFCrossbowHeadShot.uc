class DamTypeWTFCrossbowHeadShot extends DamTypeCrossbow
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
}

defaultproperties
{
     DeathString="%k put an arrow %o's head."
     FemaleSuicide="%o shot herself in the head."
     MaleSuicide="%o shot himself in the head."
     KDeathVel=115.000000
     VehicleDamageScaling=0.700000
}
