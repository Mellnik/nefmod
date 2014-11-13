class DamTypeAFS12Demo extends KFWeaponDamageType
	abstract;

defaultproperties
{
     bIsExplosive=True
     bCheckForHeadShots=False
     WeaponClass=Class'BMTCustomMut.WTFEquipAFS12a'
     DeathString="%o filled %k's body with shrapnel."
     FemaleSuicide="%o blew up."
     MaleSuicide="%o blew up."
     bLocationalHit=False
     bThrowRagdoll=True
     bExtraMomentumZ=True
     DamageThreshold=1
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=3000.000000
     KDeathVel=300.000000
     KDeathUpKick=250.000000
     HumanObliterationThreshhold=150
}
