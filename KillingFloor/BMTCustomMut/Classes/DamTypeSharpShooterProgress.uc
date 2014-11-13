class DamTypeSharpShooterProgress extends KFProjectileWeaponDamageType
    abstract;
	
static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
}

defaultproperties
{
     HeadShotDamageMult=3.500000
     bSniperWeapon=True
     bThrowRagdoll=True
     bRagdollBullet=True
     DamageThreshold=1
     KDamageImpulse=3000.000000
     KDeathVel=100.000000
     KDeathUpKick=100.000000
}
