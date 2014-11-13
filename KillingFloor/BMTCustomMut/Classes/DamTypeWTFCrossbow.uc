class DamTypeWTFCrossbow extends KFProjectileWeaponDamageType;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
}

defaultproperties
{
     HeadShotDamageMult=1.000000
     bSniperWeapon=True
     WeaponClass=Class'BMTCustomMut.WTFEquipCrossbow'
     bThrowRagdoll=True
     bRagdollBullet=True
     DamageThreshold=1
     KDamageImpulse=2000.000000
     KDeathVel=110.000000
     KDeathUpKick=10.000000
}
