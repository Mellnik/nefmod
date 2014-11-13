class ZombieKamikazeClotProj extends Nade;
var bool bDoneHale;

simulated function Explode(vector HitLocation, vector HitNormal)
{
    Local Actor A;
    
    if(bHasExploded)
        return;
        
    bHasExploded=True;

    PlaySound(ExplodeSounds[rand(ExplodeSounds.length)],,2.0);
    Spawn(Class'KFMod.KFNadeLExplosion',,, HitLocation, rotator(vect(0,0,1)));
    Spawn(class'KFMod.FlameImpact',,, HitLocation, rotator(vect(0,0,1)));
    
        
    if (ROLE == ROLE_Authority)
    {
        foreach CollidingActors (class 'Actor', A, DamageRadius, HitLocation)
        {
                    A.TakeDamage(Damage,Instigator,A.Location,A.Location,MyDamageType);           
        }
        Instigator.TakeDamage(1000000.0,Instigator,Instigator.Location,Instigator.Location,MyDamageType);
    }
        
    /*
    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(Class'KFMod.KFNadeLExplosion',,, HitLocation, rotator(vect(0,0,1)));
        Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
    }
    */

    Destroy();
}

defaultproperties
{
     ExplodeSounds(0)=SoundGroup'Inf_Weapons.antitankmine.antitankmine_explode01'
     ExplodeSounds(1)=SoundGroup'Inf_Weapons.antitankmine.antitankmine_explode02'
     ExplodeSounds(2)=SoundGroup'Inf_Weapons.antitankmine.antitankmine_explode03'
     ExplodeTimer=0.100000
     Damage=30.000000
     DamageRadius=400.000000
     MyDamageType=Class'KFMod.DamTypePipeBomb'
     DrawScale=0.010000
}
