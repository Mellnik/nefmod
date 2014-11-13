class DamTypeFirebugProgress extends KFProjectileWeaponDamageType
	abstract;
	
static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
}

defaultproperties
{
     bDealBurningDamage=True
     bCheckForHeadShots=False
}
