class DamTypeStinger extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'GeneralProgress',Amount);
}

defaultproperties
{
     bCheckForHeadShots=False
     WeaponClass=Class'BMTCustomMut.Stinger'
     DeathString="%k killed %o (Stinger)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=51500.000000
     KDeathVel=700.000000
     KDeathUpKick=90.000000
}
