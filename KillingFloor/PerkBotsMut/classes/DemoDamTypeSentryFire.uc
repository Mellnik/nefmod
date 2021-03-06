class DemoDamTypeSentryFire extends KFProjectileWeaponDamageType
	abstract;
	
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
	 bIsExplosive=True
     bCheckForHeadShots=False   
     DeathString="%o was gunned down by %s."
     bRagdollBullet=True
     bLocationalHit=False
     bThrowRagdoll=True
     bExtraMomentumZ=true
     DamageThreshold=1
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=6500.000000
     KDeathVel=250.000000
     KDeathUpKick=80.000000
     HumanObliterationThreshhold=150
}
