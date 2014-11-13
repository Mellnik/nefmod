class ZombieGiantScrake extends ZombieScrake;

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
        if ( Level.Game.GameDifficulty < 5.0 )
        {
            if ( float(Health)/HealthMax < 0.5 )
                GoToState('RunningState');
        }
        else
        {
            if ( float(Health)/HealthMax < 0.75 ) // Changed Rage Point from 0.5 to 0.75 in Balance Round 1(applied to only Suicidal and HoE in Round 7)
                GoToState('RunningState');
        }
    }
}

defaultproperties
{
     ColOffset=(Z=130.000000)
     ColRadius=60.000000
     ColHeight=160.000000
     PlayerCountHealthScale=0.400000
     OnlineHeadshotOffset=(Z=280.000000)
     OnlineHeadshotScale=3.000000
     GroundSpeed=135.000000
     WaterSpeed=125.000000
     HeadHeight=2.250000
     HeadScale=1.500000
     MenuName="Giant Scrake"
     DrawScale=3.000000
     PrePivot=(Z=100.000000)
}
