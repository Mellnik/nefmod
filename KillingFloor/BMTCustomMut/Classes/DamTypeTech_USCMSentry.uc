class DamTypeTech_USCMSentry extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SentryTechPerkProg',Amount);
}

defaultproperties
{
     HeadShotDamageMult=1.500000
     bIsPowerWeapon=True
     WeaponClass=Class'BMTCustomMut.Tech_USCMSentry'
     DeathString="%o was turned into swiss cheese by %k."
     FemaleSuicide="%o was shot and killed by her own turret."
     MaleSuicide="%o was shot and killed by his own turret."
     bRagdollBullet=True
     KDamageImpulse=7500.000000
     KDeathVel=175.000000
     KDeathUpKick=25.000000
}
