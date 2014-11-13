class DamTypeTech_IncendiaryPipeBomb extends DamTypeBurned
    abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SentryTechPerkProg',Amount);
}

defaultproperties
{
     bCheckForHeadShots=False
     WeaponClass=Class'BMTCustomMut.Tech_IncendiaryPipeBomb'
     DeathString="%o filled %k's body with flame."
     FemaleSuicide="%o blew up."
     MaleSuicide="%o blew up."
     bThrowRagdoll=True
     bExtraMomentumZ=True
     DamageThreshold=1
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=4000.000000
     KDeathVel=300.000000
     KDeathUpKick=800.000000
     HumanObliterationThreshhold=600
}
