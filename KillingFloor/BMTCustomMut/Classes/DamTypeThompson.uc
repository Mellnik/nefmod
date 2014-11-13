class DamTypeThompson extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MachineGunnerProgress',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.ThompsonSubmachineGun'
     DeathString="%k killed %o (Томми-ган)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=6500.000000
     KDeathVel=250.000000
     KDeathUpKick=80.000000
}
