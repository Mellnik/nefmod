class DamTypeOutlawDualies extends DamTypeDualies
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'OutlawProgress',Amount);
}	

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.OutlawDualies'
}