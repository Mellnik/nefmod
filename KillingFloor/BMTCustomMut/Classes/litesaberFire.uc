//-----------------------------------------------------------
//
//-----------------------------------------------------------
class litesaberFire extends KatanaFire;
var() array<name> FireAnims;

simulated event ModeDoFire()
{
    local int AnimToPlay;

    if(FireAnims.length > 0)
    {
        AnimToPlay = rand(FireAnims.length);
        FireAnim = FireAnims[AnimToPlay];
    }

    Super.ModeDoFire();

}

defaultproperties
{
     FireAnims(0)="Fire"
     FireAnims(1)="Fire2"
     FireAnims(2)="fire3"
     FireAnims(3)="Fire4"
     FireAnims(4)="Fire5"
     FireAnims(5)="Fire6"
     hitDamageClass=Class'BMTCustomMut.DamTypeLS'
     MeleeHitSounds(0)=Sound'NetskyT3.LSwall011'
     MeleeHitSounds(1)=Sound'NetskyT3.LSwall021'
     MeleeHitVolume=2.000000
     HitEffectClass=Class'BMTCustomMut.LSHitEffect'
     FireSound=SoundGroup'NetskyT3.LSswing'
}
