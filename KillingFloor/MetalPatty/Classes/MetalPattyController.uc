class MetalPattyController extends BossZombieController;

var NavigationPoint MidGoals[2];
var byte ReachOffset;
var Actor OldPathsCheck[3];

function bool FindNewEnemy()
{
	local Pawn BestEnemy;
	local bool bSeeNew, bSeeBest;
	local float BestDist, NewDist;
	local Controller PC;
	local KFHumanPawn C;

	if( KFM.bNoAutoHuntEnemies )
		Return False;
	if ( KFM.bCannibal && pawn.Health < (1.0-KFM.FeedThreshold)*pawn.HealthMax || Level.Game.bGameEnded )
	{
		for ( PC=Level.ControllerList; PC!=None; PC=PC.NextController )
		{
			C = KFHumanPawn(PC.Pawn);
			if( C==None || C.Health<=0 )
				Continue;
			if ( BestEnemy == None )
			{
				BestEnemy = C;
				BestDist = VSize(BestEnemy.Location - Pawn.Location);
				bSeeBest = CanSee(C);
			}
			else
			{
				NewDist = VSize(C.Location - Pawn.Location);
				if ( !bSeeBest || (NewDist < BestDist) )
				{
					bSeeNew = CanSee(C);
					if ( NewDist < BestDist)
					{
						BestEnemy = C;
						BestDist = NewDist;
						bSeeBest = bSeeNew;
					}
				}
			}
		}
	}
	else
	{
		for ( PC=Level.ControllerList; PC!=None; PC=PC.NextController )
		{
			if ( PC.bIsPlayer && (PC.Pawn!=None) && PC.Pawn.Health>0 && SVehicle(PC.Pawn)==none && KFMonster(PC.Pawn)==none )
			{
				if ( BestEnemy == None )
				{
					BestEnemy = PC.Pawn;
					if(BestEnemy != none)
					{
						BestDist = VSize(BestEnemy.Location - Pawn.Location);
						bSeeBest = CanSee(BestEnemy);
					}
				}
				else
				{
					NewDist = VSize(PC.Pawn.Location - Pawn.Location);
					if ( !bSeeBest || (NewDist < BestDist) )
					{
						bSeeNew = CanSee(PC.Pawn);
						if ( NewDist < BestDist)
						{
							BestEnemy = PC.Pawn;
							BestDist = NewDist;
							bSeeBest = bSeeNew;
						}
					}
				}
			}
		}
	}

	if ( BestEnemy == Enemy )
		return false;

	if ( BestEnemy != None )
	{
		ChangeEnemy(BestEnemy,CanSee(BestEnemy));
		return true;
	}
	return false;
}

// Overridden to support a quick initial attack to get the boss to the players quickly
function FightEnemy(bool bCanCharge)
{
	if( KFM.bShotAnim )
	{
		GoToState('WaitForAnim');
		Return;
	}
	if (KFM.MeleeRange != KFM.default.MeleeRange)
		KFM.MeleeRange = KFM.default.MeleeRange;
		
	log("ENEMY:"@Enemy);

	if ( Enemy == none || Enemy.Health <= 0 || KFMonster(Enemy)!=none )
		FindNewEnemy();

	if ( (Enemy == FailedHuntEnemy) && (Level.TimeSeconds == FailedHuntTime) )
	{
	
		if ( Enemy == FailedHuntEnemy )
		{
            GoalString = "FAILED HUNT - HANG OUT";
			if ( EnemyVisible() )
				bCanCharge = false;
		}
	}
	if ( !EnemyVisible() )
	{
        // Added sneakcount hack to try and fix the endless loop crash. Try and track down what was causing this later - Ramm
        if( bAlreadyFoundEnemy || ZombieBoss(Pawn).SneakCount > 2 )
        {
            bAlreadyFoundEnemy = true;
            GoalString = "Hunt";
            GotoState('ZombieHunt');
        }
        else
        {
            // Added sneakcount hack to try and fix the endless loop crash. Try and track down what was causing this later - Ramm
            ZombieBoss(Pawn).SneakCount++;
            GoalString = "InitialHunt";
            GotoState('InitialHunting');
        }
		return;
	}

	// see enemy - decide whether to charge it or strafe around/stand and fire
	Target = Enemy;
	GoalString = "Charge";
	PathFindState = 2;
	DoCharge();
}

final function Debugf( string S )
{
	Level.GetLocalPlayerController().ClientMessage(S);
	Log(S);
}
final function FindPathAround()
{
	local Actor Res;
	local NavigationPoint N;
	local NavigationPoint OldPts[12];
	local byte i;
	local bool bResult;

	if( Enemy==None || VSizeSquared(Enemy.Location-Pawn.Location)<360000 )
		return; // No can do this.

	// Attempt to find an alternative path to enemy.
	/* This works by:
		- finding shortest path to enemy
		- block middle path point
		- if the path is still about same to enemy, try block the new path and repeat up to 6 times.
	*/
	for( i=0; i<ArrayCount(OldPts); ++i )
	{
		Res = FindPathToward(Enemy);
		if( Res==None )
			break;
		if( i>0 && CompareOldPaths() )
		{
			bResult = true;
			break;
		}
		N = GetMidPoint();
		if( N==None )
			break;
		N.bBlocked = true;
		OldPts[i] = N;
		if( i==0 )
			SetOldPaths();
	}

	// Unblock temp blocked paths.
	for( i=0; i<ArrayCount(OldPts); ++i )
		if( OldPts[i]!=None )
			OldPts[i].bBlocked = false;
	if( !bResult )
		return;

	// Fetch results and switch state.
	GetMidGoals();
	if( ReachOffset<2 )
		GoToState('PatFindWay');
}

final function NavigationPoint GetMidPoint()
{
	local byte n;

	for( n=0; n<ArrayCount(RouteCache); ++n )
		if( RouteCache[n]==None )
			break;
	if( n==0 )
		return None;
	return NavigationPoint(RouteCache[(n-1)*0.5]);
}
final function bool CompareOldPaths()
{
	local byte n,i;

	for( i=0; i<6; ++i )
	{
		if( RouteCache[i]==None )
			break;
		for( n=0; n<ArrayCount(OldPathsCheck); ++n )
			if( RouteCache[i]==OldPathsCheck[n] )
				return false;
	}
	return true;
}
final function SetOldPaths()
{
	local byte n;

	for( n=0; n<ArrayCount(OldPathsCheck); ++n )
		OldPathsCheck[n] = RouteCache[n+1];
	if( RouteCache[1]==None )
		OldPathsCheck[0] = RouteCache[0];
}
final function GetMidGoals()
{
	local byte n;

	for( n=0; n<ArrayCount(RouteCache); ++n )
		if( RouteCache[n]==None )
			break;
	if( n==0 )
	{
		ReachOffset = 2;
		return;
	}
	--n;
	MidGoals[0] = NavigationPoint(RouteCache[n*0.5]);
	MidGoals[1] = NavigationPoint(RouteCache[n]);
	if( MidGoals[0]==MidGoals[1] )
		ReachOffset = 1;
	else ReachOffset = 0;
}

state PatFindWay
{
Ignores Timer,SeePlayer,HearNoise,DamageAttitudeTo,EnemyChanged,Startle,Tick;

	final function PickDestination()
	{
		if( ReachOffset>=2 )
		{
			GotoState('ZombieHunt');
			return;
		}
		if( ActorReachable(MidGoals[ReachOffset]) )
		{
			MoveTarget = MidGoals[ReachOffset];
			++ReachOffset;
		}
		else
		{
			MoveTarget = FindPathToward(MidGoals[ReachOffset]);
			if( MoveTarget==None )
				++ReachOffset;
		}
	}
	function BreakUpDoor( KFDoorMover Other, bool bTryDistanceAttack )
	{
		Global.BreakUpDoor(Other,bTryDistanceAttack);
		Pawn.GoToState('');
	}
Begin:
	PickDestination();
	if( MoveTarget==None )
		Sleep(0.5f);
	else MoveToward(MoveTarget,MoveTarget,,False);
	GoTo'Begin';
}

defaultproperties
{
}
