class MachineGunnerProgress extends SRCustomProgressInt;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MachineGunnerProgress',Amount);
}

defaultproperties
{
     ProgressName="MachineGun Damage Amount"
}
