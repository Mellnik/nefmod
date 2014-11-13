class GLDamTypeSentryFire extends KFProjectileWeaponDamageType
	abstract;

/*static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	local SRStatsBase stats;
	
	stats = SRStatsBase(KFStatsAndAchievements);
	if( stats !=None && stats.Rep!=None )
		stats.Rep.ProgressCustomValue(Class'ScrnBalanceSrv.ScrnPistolKillProgress',1);
}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	local SRStatsBase stats;
	
	stats = SRStatsBase(KFStatsAndAchievements);
	if( stats !=None && stats.Rep!=None )
		stats.Rep.ProgressCustomValue(Class'ScrnBalanceSrv.ScrnPistolDamageProgress',Amount);
}*/
	
defaultproperties
{
	DeathString="%o was turned into swiss cheese by %k."
	FemaleSuicide="%o was shot and killed by her own turret."
	MaleSuicide="%o was shot and killed by his own turret."

	bRagdollBullet=true
	KDeathVel=175.000000
	KDamageImpulse=7500
	KDeathUpKick=25
	bSniperWeapon=True
	HeadShotDamageMult=2.000000
}
