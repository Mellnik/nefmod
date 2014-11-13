class MedSentryController extends AIController;

var MedSentry MedSentry;
var bool bLostContactToPL;
var int HealDamage;

function Restart ()
{
  Enemy = None;
  MedSentry = MedSentry(Pawn);
  GotoState('WakeUp');
}

function SeeMonster (Pawn Seen)
{
  ChangeEnemy(Seen);
}

function HearNoise (float Loudness, Actor NoiseMaker)
{
  if ( (NoiseMaker != None) && (NoiseMaker.Instigator != None) && FastTrace(NoiseMaker.Location,Pawn.Location) )
  {
    ChangeEnemy(NoiseMaker.Instigator);
  }
}

function SeePlayer (Pawn Seen)
{
  ChangeEnemy(Seen);
}

function damageAttitudeTo (Pawn Other, float Damage)
{
  ChangeEnemy(Other);
}

function ChangeEnemy (Pawn Other)
{
	if (KFPlayerReplicationInfo(Other.PlayerReplicationInfo)==none)	return;
	if (Other==None) return;
	if((Other.Health >= KFPlayerReplicationInfo(Other.PlayerReplicationInfo).default.PlayerHealth)
	|| (Other.Controller == None)
	|| (Other == Enemy) )
	{
		return;
	}
  if ( (MedSentry.OwnerPawn == None) && (KFPawn(Other) != None) )
  {
    MedSentry.SetOwningPlayer(Other,None);
    return;
  }
  if ( KFHumanPawn(Other) == None )
  {
    return;
  }
  if ( (Enemy != None) && (Enemy.Health >= KFPlayerReplicationInfo(Enemy.PlayerReplicationInfo).default.PlayerHealth) )
  {
    Enemy = None;
  }
  if ( (Enemy != None) && (LineOfSightTo(Enemy) &&  !LineOfSightTo(Other) || (VSizeSquared(Other.Location - Pawn.Location) > VSizeSquared(Enemy.Location - Pawn.Location))) )
  {
    return;
  }
  Enemy = Other;
  EnemyChanged();
}

function EnemyChanged ();

final function GoNextOrders ()
{
  bIsPlayer = True;
  if ( (MedSentry.OwnerPawn == None) || (MedSentry.OwnerPawn.Health <= 0) )
  {
    MedSentry.OwnerPawn = None;
    MedSentry.PlayerReplicationInfo = None;
  }
  if ( (Enemy != None) && (Enemy.Health <= KFPlayerReplicationInfo(Enemy.PlayerReplicationInfo).default.PlayerHealth) && ((MedSentry.OwnerPawn == None) || LineOfSightTo(MedSentry.OwnerPawn)) )
  {
    GotoState('FightEnemy','Begin');
    return;
  } else {
    Enemy = None;
  }
  GotoState('FollowOwner','Begin');
}

function PawnDied (Pawn P)
{
  if ( Pawn == P )
  {
    Destroy();
  }
}

state WakeUp
{
Ignores SeePlayer,HearNoise,SeeMonster;
Begin:
  MedSentry.SetAnimationNum(1);
  WaitForLanding();
  MedSentry.SetAnimationNum(0);
  Sleep(1.0);
  GoNextOrders();
}

state FightEnemy
{
  function EnemyChanged ()
  {
    MedSentry.Speech(2);
    if ( MedSentry.RepAnimationAction != 0 )
    {
      MedSentry.SetAnimationNum(0);
    }
    GotoState(,'Begin');
  }
  
  function BeginState ()
  {
    MedSentry.Speech(2);
  }
  
  function EndState ()
  {
    if ( MedSentry.RepAnimationAction != 0 )
    {
      MedSentry.SetAnimationNum(0);
    }
    MedSentry.Speech(3);
  }
Begin:  
  if ( (Enemy == None) || (Enemy.Health >= KFPlayerReplicationInfo(Enemy.PlayerReplicationInfo).default.PlayerHealth) )
  {
BadEnemy:
    Enemy = None;
    GoNextOrders();
  }
  if ( LineOfSightTo(Enemy) )
  {
    goto ('ShootEnemy');
  }
  MoveTarget = FindPathToward(Enemy);
  if ( (MoveTarget == None) || (MedSentry.OwnerPawn != None) &&  !LineOfSightTo(MedSentry.OwnerPawn) )
  {
    goto ('BadEnemy');
  }
  MoveToward(MoveTarget);
  goto ('Begin');
ShootEnemy:
  if ( (MedSentry.OwnerPawn != None) &&  !LineOfSightTo(MedSentry.OwnerPawn) )
  {
    MoveTarget = FindPathToward(MedSentry.OwnerPawn);
    if ( MoveTarget == None )
    {
      goto ('BadEnemy');
    }
    MoveToward(MoveTarget);
    goto ('Begin');
  }
  Focus = Enemy;
  Pawn.Acceleration = vect(0.00,0.00,0.00);
  FinishRotation();
  MedSentry.SetAnimationNum(2);
  While( (Enemy != None)
		&& (Enemy.Health < KFPlayerReplicationInfo(Enemy.PlayerReplicationInfo).default.PlayerHealth)
		&& LineOfSightTo(Enemy)
		&& ((MedSentry.OwnerPawn == None) || LineOfSightTo(MedSentry.OwnerPawn)) )
  {
    Pawn.Acceleration = vect(0.00,0.00,0.00);
    if ( Enemy.Controller != None )
    {
      Enemy.Health += HealDamage;
      if ( Enemy.Health > KFPlayerReplicationInfo(Enemy.PlayerReplicationInfo).default.PlayerHealth )
      {
        Enemy.Health = KFPlayerReplicationInfo(Enemy.PlayerReplicationInfo).default.PlayerHealth;
      }
      if ( (MedSentry.OwnerPawn != None) && (KFPlayerReplicationInfo(MedSentry.OwnerPawn.PlayerReplicationInfo).ClientVeteranSkill.Default.PerkIndex == 0) )
      {
	KFSteamStatsAndAchievements(KFPlayerReplicationInfo(MedSentry.OwnerPawn.PlayerReplicationInfo).SteamStatsAndAchievements).AddDamageHealed(HealDamage);      }
    }
    Sleep(0.34999999);
	}
	MedSentry.SetAnimationNum(0);
	Sleep(0.44999999);
	goto ('Begin');
}

state FollowOwner
{
  function bool NotifyBump (Actor Other)
  {
    if ( KFPawn(Other) != None )
    {
      Destination = (Normal(Pawn.Location - Other.Location) + VRand() * 0.34999999) * (Other.CollisionRadius + 30.0 + FRand() * 50.0) + Pawn.Location;
      GotoState(,'StepAside');
    }
    return False;
  }
  
  final function CheckShopTeleport ()
  {
    local ShopVolume S;
  
    foreach Pawn.TouchingActors(Class'ShopVolume',S)
    {
      if (  !S.bCurrentlyOpen && (S.TelList.Length > 0) )
      {
        S.TelList[Rand(S.TelList.Length)].Accept(Pawn,S);
      }
      return;
    }
  }
Begin: 
  CheckShopTeleport();
  Disable('NotifyBump');
  if ( (MedSentry.OwnerPawn == None) || (VSizeSquared(MedSentry.OwnerPawn.Location - Pawn.Location) < 160000.0) && LineOfSightTo(MedSentry.OwnerPawn) )
  {
    if ( bLostContactToPL )
    {
      MedSentry.Speech(6);
      bLostContactToPL = False;
    }
Idle:
    Enable('NotifyBump');
    Focus = None;
    FocalPoint = VRand() * 20000.0 + Pawn.Location;
    FocalPoint.Z = Pawn.Location.Z;
    Pawn.Acceleration = vect(0.00,0.00,0.00);
    Sleep(0.41 + FRand());
  } else {
    if ( actorReachable(MedSentry.OwnerPawn) )
    {
      Enable('NotifyBump');
      MoveTo(MedSentry.OwnerPawn.Location + VRand() * (MedSentry.OwnerPawn.CollisionRadius + 80.0));
    } else {
      if (  !bLostContactToPL )
      {
        MedSentry.Speech(7);
        bLostContactToPL = True;
      }
      MoveTarget = FindPathToward(MedSentry.OwnerPawn);
      if ( MoveTarget != None )
      {
        MoveToward(MoveTarget);
      } else {
        MedSentry.Speech(1);
        goto ('Idle');
      }
    }
  }
  GoNextOrders();
StepAside:
  MoveTo(Destination);
  GoNextOrders();
}

defaultproperties
{
     HealDamage=2
     bHunting=True
}
