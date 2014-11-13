Class ArmSentryController extends AIController;

var ArmSentry Sentry;
var bool bLostContactToPL;
//var int MyHealDamage;
var transient float NextShotTime;
//var float FireRateTime;
var bool Oo;

function Restart()
{
	Enemy = None;
	Sentry = ArmSentry(Pawn);
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

function ChangeEnemy( Pawn Other )
{
	if( (!Oo && Other==None || Oo && Other!=Sentry.OwnerPawn) || Other.ShieldStrength>=100 || Other.Controller==None || Other==Enemy )
		return;
	if( Sentry.OwnerPawn==None && KFPawn(Other)!=None )
	{
		Sentry.SetOwningPlayer(Other,None);
		return;
	}
	if( KFHumanPawn(Other)==None )
		return;

	if( Enemy!=None && Enemy.ShieldStrength>=100 )
		Enemy = None;

	// Current enemy is visible, new one is not or current enemy is closer, then ignore new one.
	if( Enemy!=None && ((LineOfSightTo(Enemy) && !LineOfSightTo(Other)) || VSizeSquared(Other.Location-Pawn.Location)>VSizeSquared(Enemy.Location-Pawn.Location)) )
		return;
		
	if (!Oo && Other==None || Oo && Other!=Sentry.OwnerPawn)
		return;

	Enemy = Other;
	EnemyChanged();
}
function EnemyChanged();

final function GoNextOrders()
{
	bIsPlayer = true; // Make sure it is set so zeds fight me.

	if( Sentry.OwnerPawn==None || Sentry.OwnerPawn.Health<=0 )
	{
		Sentry.OwnerPawn = None;
		Sentry.PlayerReplicationInfo = None;
	}
	if( (!Oo && Enemy!=None || Oo && Enemy==Sentry.OwnerPawn) && Enemy.ShieldStrength<=100 && (Sentry.OwnerPawn==None || LineOfSightTo(Sentry.OwnerPawn)) )
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
	Sentry.SetAnimationNum(1);
	WaitForLanding();
	Sentry.SetAnimationNum(0);
	Sleep(1.f);
	GoNextOrders();
}
State FightEnemy
{
	function EnemyChanged()
	{
		Sentry.Speech(2);
		if( Sentry.RepAnimationAction!=0 )
			Sentry.SetAnimationNum(0);
		GoToState(,'Begin');
	}
	function BeginState()
	{
		Sentry.Speech(2);
	}
	function EndState()
	{
		if( Sentry.RepAnimationAction!=0 )
			Sentry.SetAnimationNum(0);
		Sentry.Speech(3);
	}
Begin:
	if( (!Oo && Enemy==None || Oo && Enemy!=Sentry.OwnerPawn) || Enemy.ShieldStrength>=100 )
	{
BadEnemy:
		Enemy = None;
		GoNextOrders();
	}
	if( LineOfSightTo(Enemy) )
		GoTo 'ShootEnemy';
	MoveTarget = FindPathToward(Enemy);
	if( MoveTarget==None || (Sentry.OwnerPawn!=None && !LineOfSightTo(Sentry.OwnerPawn)) )
		GoTo'BadEnemy';
	MoveToward(MoveTarget);
	GoTo'Begin';
ShootEnemy:
	if( Sentry.OwnerPawn!=None && !LineOfSightTo(Sentry.OwnerPawn) )
	{
		MoveTarget = FindPathToward(Sentry.OwnerPawn);
		if( MoveTarget==None )
			GoTo'BadEnemy';
		MoveToward(MoveTarget);
		GoTo'Begin';
	}
	Focus = Enemy;
	
	Pawn.Acceleration = vect(0,0,0);
	FinishRotation();
	
	while( NextShotTime<=Level.TimeSeconds && Enemy!=None && Enemy.ShieldStrength<100 && LineOfSightTo(Enemy) && (Sentry.OwnerPawn==None || LineOfSightTo(Sentry.OwnerPawn)) )
	{
		Sentry.SetAnimationNum(2);
		NextShotTime = Level.TimeSeconds+Sentry.FireRateTime;
		Pawn.Acceleration = vect(0,0,0);
		if( Enemy.Controller!=None && (!Oo && Enemy!=None || Oo && Enemy==Sentry.OwnerPawn))
		{
			//Enemy.Controller.damageAttitudeTo(Pawn,5);
			Enemy.ShieldStrength+=Sentry.MyHealDamage;
			if (Enemy.ShieldStrength>100)
			{
				Enemy.ShieldStrength=100;
				Enemy=None;
			}
			//if (Sentry.OwnerPawn != none && (KFPlayerReplicationInfo(Sentry.OwnerPawn.PlayerReplicationInfo)).ClientVeteranSkill.default.PerkIndex == 0)
				(KFSteamStatsAndAchievements((KFPlayerReplicationInfo(Sentry.OwnerPawn.PlayerReplicationInfo)).SteamStatsAndAchievements)).AddDamageHealed(Sentry.MyHealDamage);							
		}
		Sleep(0.36f);		
	}
	Sentry.SetAnimationNum(0);
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
	if( Sentry.OwnerPawn==None || (VSizeSquared(Sentry.OwnerPawn.Location-Pawn.Location)<160000.f && LineOfSightTo(Sentry.OwnerPawn)) )
	{
		if( bLostContactToPL )
		{
			Sentry.Speech(6);
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
	else if( ActorReachable(Sentry.OwnerPawn) )
	{
		Enable('NotifyBump');
		MoveTo(Sentry.OwnerPawn.Location+VRand()*(Sentry.OwnerPawn.CollisionRadius+80.f));
	}
	else
	{
		if( !bLostContactToPL )
		{
			Sentry.Speech(7);
			bLostContactToPL = true;
		}
		MoveTarget = FindPathToward(Sentry.OwnerPawn);
		if( MoveTarget!=None )
			MoveToward(MoveTarget);
		else
		{
			Sentry.Speech(1);
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
     bHunting=false
	 // скорость стрельбы
	 //FireRateTime=1;
	 // величина восстанавливаемого здоровья
	 //MyHealDamage=2
	 // лечить только владельца
	 Oo=false
}
