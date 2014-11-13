class DamTypeWTFAxe extends DamTypeMelee;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( KFStatsAndAchievements!=None )
		KFStatsAndAchievements.AddFireAxeKill();
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.WTFEquipFireAxe'
     PawnDamageSounds(0)=SoundGroup'KF_AxeSnd.Axe_HitFlesh'
     VehicleDamageScaling=0.700000
}
