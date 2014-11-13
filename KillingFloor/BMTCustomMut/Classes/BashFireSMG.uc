//-----------------------------------------------------------
//
//-----------------------------------------------------------
class BashFireSMG extends KFMeleeFire;

defaultproperties
{
     MeleeDamage=25
     ProxySize=0.150000
     weaponRange=75.000000
     DamagedelayMin=0.150000
     DamagedelayMax=0.150000
     hitDamageClass=Class'KFMod.DamTypeKatana'
     MeleeHitSounds(0)=SoundGroup'Inf_Weapons_Foley.melee.pistol_hit'
     MeleeHitVolume=255.000000
     HitEffectClass=Class'BMTCustomMut.BashHitEffectMet'
     bWaitForRelease=True
     TransientSoundVolume=255.000000
     FireAnim="bash"
     FireRate=1.200000
     BotRefireRate=0.850000
}
