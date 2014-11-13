class DamTypeALLPerkGun extends KFProjectileWeaponDamageType
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( Killed.IsA('ZombieStalker') )
		KFStatsAndAchievements.AddStalkerKill();
}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	 KFStatsAndAchievements.AddBullpupDamage(Amount);
	 KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
	 KFStatsAndAchievements.AddMac10BurnDamage(Amount);
	 KFStatsAndAchievements.AddShotgunDamage(Amount);
	 KFStatsAndAchievements.AddMeleeDamage(Amount);
	 KFStatsAndAchievements.AddExplosivesDamage(Amount);
     KFStatsAndAchievements.AddDamageHealed(Amount);
	 if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
     SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MarineProgress',Amount);
     if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
     SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'OutlawProgress',Amount);
     if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
     SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MachineGunnerProgress',Amount);
     if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	 SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'LSProgress',Amount);
   	 if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	 SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SharpShooterProgress',Amount);
	 if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	 SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'MedicProgress',Amount);
	 if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	 SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'SentryTechPerkProg',Amount);
	 if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	 SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'GeneralProgress',Amount);
	
	
}

static function ScoredHeadshot(KFSteamStatsAndAchievements KFStatsAndAchievements, class<KFMonster> MonsterClass, bool bLaserSightedM14EBRKill)
{
	if ( KFStatsAndAchievements != none && Default.bSniperWeapon )
		KFStatsAndAchievements.AddHeadshotKill(bLaserSightedM14EBRKill);
}

defaultproperties
{
     WeaponClass=Class'BMTCustomMut.ALLPerkGun'
     DeathString="%k killed %o (ALLPerkGun)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     KDamageImpulse=5500.000000
     KDeathVel=175.000000
     KDeathUpKick=15.000000
}
