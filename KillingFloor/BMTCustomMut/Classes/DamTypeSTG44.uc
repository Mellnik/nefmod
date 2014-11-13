class DamTypeSTG44 extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MarineProgress',Amount);
}

defaultproperties
{
     HeadShotDamageMult=2.250000
     bSniperWeapon=True
     WeaponClass=Class'BMTCustomMut.stg44'
     DeathString="%k killed %o (M14EBR)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=7500.000000
     KDeathVel=175.000000
     KDeathUpKick=25.000000
}
