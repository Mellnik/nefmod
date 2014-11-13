class DamTypeWTFBulldog extends KFProjectileWeaponDamageType
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( Killed.IsA('ZombieStalker') )
		KFStatsAndAchievements.AddStalkerKill();
}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddBullpupDamage(Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.WTFEquipBulldog'
     DeathString="%k killed %o (WTFBulldog)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=1500.000000
     KDeathVel=110.000000
     KDeathUpKick=2.000000
}
