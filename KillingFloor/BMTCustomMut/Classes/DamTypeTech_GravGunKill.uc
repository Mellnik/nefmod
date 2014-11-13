class DamTypeTech_GravGunKill extends KFProjectileWeaponDamageType
    abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SentryTechPerkProg',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.Tech_HL_GravityGun'
     DeathString="%o was pushed around by %k's Gravity Gun."
     KDeathUpKick=100.000000
     HumanObliterationThreshhold=100000
}
