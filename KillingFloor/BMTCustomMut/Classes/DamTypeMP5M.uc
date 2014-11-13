class DamTypeMP5M extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MedicProgress',Amount);
}

defaultproperties
{
     WeaponClass=Class'KFMod.MP5MMedicGun'
     DeathString="%k killed %o (MP5M)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=750.000000
     KDeathVel=100.000000
     KDeathUpKick=1.000000
}
