class DamTypeForce extends DamTypeMelee
	abstract;
	
static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'ForceKill',Amount);
}

defaultproperties
{
     bIsPowerWeapon=True
     WeaponClass=Class'BMTCustomMut.Force'
     DeathString="%k killed %o (Force)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bLocationalHit=False
     bRagdollBullet=False
     bBulletHit=False
     KDamageImpulse=800.000000
     KDeathVel=550.000000
     KDeathUpKick=400.000000
     VehicleDamageScaling=0.700000
}
