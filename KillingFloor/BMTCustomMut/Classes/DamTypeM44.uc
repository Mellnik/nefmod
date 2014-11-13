class DamTypeM44 extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MachineGunnerProgress',Amount);
}

defaultproperties
{
     HeadShotDamageMult=3.200000
     WeaponClass=Class'BMTCustomMut.M44'
     DeathString="%k killed %o (M44)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
}
