class DamTypeM44Bayo extends DamTypeMelee;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddMeleeDamage(Amount);
}

defaultproperties
{
     HeadShotDamageMult=1.000000
     WeaponClass=Class'BMTCustomMut.M44'
     DeathString="%k impaled %o with a M44 Bayonett."
     bLocationalHit=False
     PawnDamageSounds(0)=Sound'KFPawnDamageSound.MeleeDamageSounds.axehitflesh'
     VehicleDamageScaling=0.500000
}
