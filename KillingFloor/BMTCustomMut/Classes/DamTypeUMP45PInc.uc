class DamTypeUMP45PInc extends KFProjectileWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
	KFStatsAndAchievements.AddMac10BurnDamage(Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.UMP45SubmachineGun'
     DeathString="%k killed %o (UMP45)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=1850.000000
     KDeathVel=150.000000
     KDeathUpKick=5.000000
}
