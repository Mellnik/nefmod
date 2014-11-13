Class Tech_DoomSentryBotController extends AIController;

var Tech_DoomSentry Tech_DoomSentry;
var float MaxDistanceFromOwnerSq;
var bool bLostContactToPL;

function Restart()
{
    Enemy = None;
    Tech_DoomSentry = Tech_DoomSentry(Pawn);
    GoToState('WakeUp');
}

function SeeMonster( Pawn Seen )
{
    ChangeEnemy(Seen);
}

function HearNoise( float Loudness, Actor NoiseMaker)
{
    if( NoiseMaker!=None && NoiseMaker.Instigator!=None && FastTrace(NoiseMaker.Location,Pawn.Location) )
        ChangeEnemy(NoiseMaker.Instigator);
}

function SeePlayer( Pawn Seen )
{
    ChangeEnemy(Seen);
}

function damageAttitudeTo(pawn Other, float Damage)
{
    ChangeEnemy(Other);
}

function bool MustReturnToOwner()
{
    if (Tech_DoomSentry == none || Tech_DoomSentry.OwnerPawn == none)
        return false; // no owner; roam free!

    return !LineOfSightTo(Tech_DoomSentry.OwnerPawn) || VSizeSquared(Tech_DoomSentry.Location - Tech_DoomSentry.OwnerPawn.Location) >= MaxDistanceFromOwnerSq;
}

function ChangeEnemy( Pawn Other )
{
    if( Other==None || Other.Health<=0 || Other.Controller==None || Other==Enemy )
        return;
    if( Tech_DoomSentry.OwnerPawn==None && KFPawn(Other)!=None )
    {
        Tech_DoomSentry.SetOwningPlayer(Other,None);
        return;
    }
    if( Monster(Other)==None )
        return;

    if( Enemy!=None && Enemy.Health<=0 )
        Enemy = None;

    // Current enemy is visible, new one is not or current enemy is closer, then ignore new one.
    if( Enemy!=None && ((LineOfSightTo(Enemy) && !LineOfSightTo(Other)) || VSizeSquared(Other.Location-Pawn.Location)>VSizeSquared(Enemy.Location-Pawn.Location)) )
        return;

    Enemy = Other;
    EnemyChanged();
}

function EnemyChanged();

final function GoNextOrders()
{
    bIsPlayer = true; // Make sure it is set so zeds fight me.

    if( Tech_DoomSentry.OwnerPawn==None || Tech_DoomSentry.OwnerPawn.Health<=0 )
    {
        Tech_DoomSentry.OwnerPawn = None;
        Tech_DoomSentry.PlayerReplicationInfo = None;
    }

    
    if( Enemy!=None && Enemy.Health>=0 && !MustReturnToOwner())
    {
        GoToState('FightEnemy','Begin');
        return;
    }
    else Enemy = None;
    GoToState('FollowOwner','Begin');
}

function PawnDied(Pawn P)
{
    if ( Pawn==P )
        Destroy();
}

State WakeUp
{
Ignores SeePlayer,HearNoise,SeeMonster;

Begin:
    Tech_DoomSentry.SetAnimationNum(1);
    WaitForLanding();
    Tech_DoomSentry.SetAnimationNum(0);
    Sleep(1.f);
    GoNextOrders();
}

State FightEnemy
{
    function EnemyChanged()
    {
        Tech_DoomSentry.Speech(2);
        if( Tech_DoomSentry.RepAnimationAction!=0 )
            Tech_DoomSentry.SetAnimationNum(0);
        GoToState(,'Begin');
    }

    function BeginState()
    {
        Tech_DoomSentry.Speech(2);
    }

    function EndState()
    {
        if( Tech_DoomSentry.RepAnimationAction!=0 )
            Tech_DoomSentry.SetAnimationNum(0);
        Tech_DoomSentry.Speech(3);
    }

Begin:
    if( Enemy==None || Enemy.Health<=0 )
    {
BadEnemy:
        Enemy = None;
        GoNextOrders();
    }

    if( LineOfSightTo(Enemy) )
        GoTo 'ShootEnemy';
        
    MoveTarget = FindPathToward(Enemy);
    if( MoveTarget==None || MustReturnToOwner())
        GoTo'BadEnemy';
    MoveToward(MoveTarget);
    GoTo'Begin';

ShootEnemy:
    if( MustReturnToOwner() )
    {
        MoveTarget = FindPathToward(Tech_DoomSentry.OwnerPawn);
        if( MoveTarget==None )
            GoTo'BadEnemy';
        MoveToward(MoveTarget);
        GoTo'Begin';
    }
    Focus = Enemy;
    Pawn.Acceleration = vect(0,0,0);
    FinishRotation();
    Tech_DoomSentry.SetAnimationNum(2);
    while( Enemy!=None && Enemy.Health>0 && LineOfSightTo(Enemy) && !MustReturnToOwner() )
    {
        Pawn.Acceleration = vect(0,0,0);
        if( Enemy.Controller!=None )
            Enemy.Controller.damageAttitudeTo(Pawn,5);
        Sleep(0.35f);
    }
    Tech_DoomSentry.SetAnimationNum(0);
    Sleep(0.45f);
    GoTo'Begin';
}

State FollowOwner
{
    function bool NotifyBump(Actor Other)
    {
        if( KFPawn(Other)!=None ) // Step aside from a player.
        {
            Destination = (Normal(Pawn.Location-Other.Location)+VRand()*0.35)*(Other.CollisionRadius+30.f+FRand()*50.f)+Pawn.Location;
            GoToState(,'StepAside');
        }
        return false;
    }
    final function CheckShopTeleport()
    {
        local ShopVolume S;

        foreach Pawn.TouchingActors(Class'ShopVolume',S)
        {
            if( !S.bCurrentlyOpen && S.TelList.Length>0 )
                S.TelList[Rand(S.TelList.Length)].Accept( Pawn, S );
            return;
        }
    }
Begin:
    CheckShopTeleport(); // Make sure not stuck inside trader.
    Disable('NotifyBump');
    if( !MustReturnToOwner() )
    {
        if( bLostContactToPL )
        {
            Tech_DoomSentry.Speech(6);
            bLostContactToPL = false;
        }
Idle:
        Enable('NotifyBump');
        Focus = None;
        FocalPoint = VRand()*20000.f+Pawn.Location;
        FocalPoint.Z = Pawn.Location.Z;
        Pawn.Acceleration = vect(0,0,0);
        Sleep(0.4f+FRand());
    }
    else if( ActorReachable(Tech_DoomSentry.OwnerPawn) )
    {
        Enable('NotifyBump');
        MoveTo(Tech_DoomSentry.OwnerPawn.Location+VRand()*(Tech_DoomSentry.OwnerPawn.CollisionRadius+80.f));
    }
    else
    {
        if( !bLostContactToPL )
        {
            Tech_DoomSentry.Speech(7);
            bLostContactToPL = true;
        }
        MoveTarget = FindPathToward(Tech_DoomSentry.OwnerPawn);
        if( MoveTarget!=None )
            MoveToward(MoveTarget);
        else
        {
            Tech_DoomSentry.Speech(1);
            GoTo'Idle';
        }
    }
    GoNextOrders();
StepAside:
    MoveTo(Destination);
    GoNextOrders();
}

defaultproperties
{
     MaxDistanceFromOwnerSq=8333.000000
     bHunting=True
}
