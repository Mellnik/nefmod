//-----------------------------------------------------------
//
//-----------------------------------------------------------
class BashFirePistol extends KFMeleeFire;

defaultproperties
{
     MeleeDamage=15
     ProxySize=0.150000
     DamagedelayMin=0.400000
     hitDamageClass=Class'KFMod.DamTypeKatana'
     MeleeHitSounds(0)=SoundGroup'Inf_Weapons_Foley.melee.pistol_hit'
     MeleeHitVolume=255.000000
     HitEffectClass=Class'BMTCustomMut.BashHitEffectMet'
     bWaitForRelease=True
     TransientSoundVolume=255.000000
     FireAnim="bash"
     FireRate=0.850000
     BotRefireRate=0.850000
}
