class DamTypeWTFM79Fire extends KFWeaponDamageType
	abstract;
	
	
static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
}

defaultproperties
{
     bDealBurningDamage=True
     bCheckForHeadShots=False
     WeaponClass=Class'BMTCustomMut.M79CF'
     DeathString="%k incinerated %o (Flamethrower)."
     FemaleSuicide="%o roasted herself alive."
     MaleSuicide="%o roasted himself alive."
}
