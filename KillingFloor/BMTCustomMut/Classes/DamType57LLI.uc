class DamType57LLI extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'GeneralProgress',Amount);
}

defaultproperties
{
     bSniperWeapon=True
     WeaponClass=Class'BMTCustomMut.P57LLI'
     DeathString="%k killed %o (FN Five-seveN)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     bBulletHit=True
     KDamageImpulse=4500.000000
     KDeathVel=200.000000
     KDeathUpKick=50.000000
}
