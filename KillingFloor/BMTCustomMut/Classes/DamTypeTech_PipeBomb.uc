class DamTypeTech_PipeBomb extends KFWeaponDamageType
    abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SentryTechPerkProg',Amount);
}

defaultproperties
{
     bIsExplosive=True
     bCheckForHeadShots=False
     WeaponClass=Class'BMTCustomMut.Tech_PipeBombExplosive'
     DeathString="%o filled %k's body with shrapnel."
     FemaleSuicide="%o blew up."
     MaleSuicide="%o blew up."
     bLocationalHit=False
     bThrowRagdoll=True
     bExtraMomentumZ=True
     DamageThreshold=1
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=4000.000000
     KDeathVel=1000.000000
     KDeathUpKick=2000.000000
     HumanObliterationThreshhold=3500
}
