class DamTypeOutlawDeagle extends DamTypeDeagle
	abstract;
	
static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
   if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
   SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'OutlawProgress',Amount);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.OutlawDeagle'
     DeathString="%k killed %o with Outlaw Deagle."
}
