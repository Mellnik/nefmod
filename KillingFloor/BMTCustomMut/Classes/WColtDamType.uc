class WColtDamType extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'OutlawProgress',Amount);
}	
	

defaultproperties
{
     bSniperWeapon=True
     WeaponClass=Class'BMTCustomMut.WColt'
     DeathString="%k killed %o Colt."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=1000.000000
     KDeathVel=150.000000
     KDeathUpKick=100.000000
     VehicleDamageScaling=0.700000
}
