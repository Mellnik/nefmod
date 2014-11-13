class DamTypeCrawlerPoison extends DamTypeZombieAttack;

defaultproperties
{
     DeathString="%o was poisoned by %k."
     FemaleSuicide="%o Raped herself."
     MaleSuicide="%o Raped himself."
     PawnDamageEmitter=Class'ROEffects.ROBloodPuff'
     LowGoreDamageEmitter=Class'ROEffects.ROBloodPuffNoGore'
     LowDetailEmitter=Class'ROEffects.ROBloodPuffSmall'
}
