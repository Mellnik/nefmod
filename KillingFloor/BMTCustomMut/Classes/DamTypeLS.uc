class DamTypeLS extends DamTypeMelee;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount) 
{
	if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
	SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'LSProgress',Amount);
}

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
	HitEffects[0] = class'HitSmoke';
	if( VictimHealth <= 0 )
		HitEffects[1] = class'KFHitFlame';
	else if ( FRand() < 0.8 )
		HitEffects[1] = class'KFHitFlame';
}

defaultproperties
{
	 HeadShotDamageMult=1.100000
     WeaponClass=Class'BMTCustomMut.litesaber'
     DeathString="%o melted %k's body with the muthafuckin' force."
     FemaleSuicide="The Force was not with %o."
     MaleSuicide="The Force was not with %o."
     bLocationalHit=False
     bThrowRagdoll=True
     bExtraMomentumZ=True
     PawnDamageEmitter=Class'BMTCustomMut.LShitFX'
     PawnDamageSounds(0)=SoundGroup'NetskyT3.LSwall'
     DamageThreshold=1
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=4000.000000
     KDeathVel=300.000000
     KDeathUpKick=800.000000
     HumanObliterationThreshhold=2
	 VehicleDamageScaling=0.500000
}
