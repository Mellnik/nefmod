class ZombieBabyScrake extends ZombieScrake;

simulated function PostNetBeginPlay()
{
    EnableChannelNotify ( 1,1);
    AnimBlendParams(1, 1.0, 0.0,, SpineBone1);
    super.PostNetBeginPlay();
}

function RangedAttack(Actor A)
{
    if ( bShotAnim || Physics == PHYS_Swimming)
        return;
    else if ( CanAttack(A) )
    {
        bShotAnim = true;
        SetAnimAction(MeleeAnims[Rand(2)]);
        CurrentDamType = ZombieDamType[0];
        //PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
        GoToState('SawingLoop');
    }

    if( !bShotAnim && !bDecapitated )
    {
        if ( Level.Game.GameDifficulty < 2.0 )
        {
            if ( float(Health)/HealthMax < 0.8 )
                GoToState('RunningState');
        }
        else
        {
            if ( float(Health)/HealthMax < 0.8 ) // Changed Rage Point from 0.5 to 0.75 in Balance Round 1(applied to only Suicidal and HoE in Round 7)
                GoToState('RunningState');
        }
    }
}

defaultproperties
{
     MeleeDamage=10
     ColOffset=(Z=25.000000)
     ColRadius=25.000000
     ColHeight=15.000000
     PlayerCountHealthScale=0.400000
     OnlineHeadshotOffset=(X=2.500000,Z=26.500000)
     PlayerNumHeadHealthScale=0.200000
     GroundSpeed=110.000000
     HealthMax=600.000000
     Health=600
     MenuName="Baby Scrake"
     DrawScale=0.600000
     PrePivot=(Z=0.000000)
     CollisionRadius=20.000000
     CollisionHeight=25.000000
}
