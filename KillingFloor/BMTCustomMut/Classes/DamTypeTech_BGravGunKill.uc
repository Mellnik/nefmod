class DamTypeTech_BGravGunKill extends KFProjectileWeaponDamageType
    abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SentryTechPerkProg',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.Tech_HL_BlueGravityGun'
     DeathString="%o had their head ripped off and flushed down toilet by %k's Organic Gravity Gun."
     FemaleSuicide="%o was taken out by her own Organic Gravity Gun."
     MaleSuicide="%o was taken out by his own Organic Gravity Gun."
     KDeathUpKick=100.000000
     HumanObliterationThreshhold=100000
}
