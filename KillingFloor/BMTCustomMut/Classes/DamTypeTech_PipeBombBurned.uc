class DamTypeTech_PipeBombBurned extends KFWeaponDamageType;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
}

defaultproperties
{
     DeathString="%o was sauteed."
     bLocationalHit=False
     FlashFog=(X=800.000000,Y=600.000000,Z=240.000000)
}
