class DamTypeM249 extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MachineGunnerProgress',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.M249'
     DeathString="%k killed %o (M249 SAW)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=12500.000000
     KDeathVel=450.000000
     KDeathUpKick=80.000000
}
