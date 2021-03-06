class DamTypeB94 extends KFProjectileWeaponDamageType;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
	HitEffects[0] = class'HitSmoke';
	if( VictimHealth <= 0 )
		HitEffects[1] = class'KFHitFlame';
	else if ( FRand() < 0.8 )
		HitEffects[1] = class'KFHitFlame';
}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
}

defaultproperties
{
     HeadShotDamageMult=3.500000
     bSniperWeapon=True
     WeaponClass=Class'BMTCustomMut.B94'
     DeathString="%k killed %o (В-94)."
     bThrowRagdoll=True
     bRagdollBullet=True
     DamageThreshold=1
     KDamageImpulse=3000.000000
     KDeathVel=1100.000000
     KDeathUpKick=200.000000
}
