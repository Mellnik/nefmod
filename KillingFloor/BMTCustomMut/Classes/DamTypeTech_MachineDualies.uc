class DamTypeTech_MachineDualies extends KFProjectileWeaponDamageType
    abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SentryTechPerkProg',Amount);
}

defaultproperties
{
     bSniperWeapon=True
     WeaponClass=Class'BMTCustomMut.Tech_MachineDualies'
     DeathString="%k killed %o (MachineDualies)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=1500.000000
     KDeathVel=110.000000
     KDeathUpKick=2.000000
}
