class DamTypeTech_RPG extends DamTypeFrag
    abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SentryTechPerkProg',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.Tech_HL_RPG'
     DeathString="%o was blown up by %k's RPG missile."
     FemaleSuicide="%o blew herself up with a RPG missile."
     MaleSuicide="%o blew himself up with a RPG missile."
     KDeathUpKick=900.000000
     HumanObliterationThreshhold=450
}
