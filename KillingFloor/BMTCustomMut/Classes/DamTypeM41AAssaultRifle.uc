class DamTypeM41AAssaultRifle extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MarineProgress',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.M41AAssaultRifle'
     DeathString="%k killed %o (M41A)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=6500.000000
     KDeathVel=175.000000
     KDeathUpKick=20.000000
}
