class DamTypeMedicNade extends KFWeaponDamageType;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MedicProgress',Amount);
}

defaultproperties
{
     bCheckForHeadShots=False
     DeathString="%k poisoned %o (MedicNade)."
     FemaleSuicide="%o poisoned herself."
     MaleSuicide="%o poisoned himself."
     bLocationalHit=False
}
