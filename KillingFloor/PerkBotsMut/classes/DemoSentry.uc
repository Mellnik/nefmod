class DemoSentry extends Sentry
	Config(PerkBots);
	
#exec OBJ LOAD FILE=KF_LAWSnd.uax
#exec OBJ LOAD FILE=PerkBots_T.utx
	
var DemoSentryWeaponFlash WeaponFlash;
var DemoSentryGun WeaponOwner;

final function SSetOwningPlayer( Pawn Other, DemoSentryGun W )
{
	OwnerPawn = Other;
	PlayerReplicationInfo = Other.PlayerReplicationInfo;
	WeaponOwner = W;
}

event PostBeginPlay()
{
	Super.PostBeginPlay();

	TweenAnim(IdleRestAnim,0.01f);
	if ( (ControllerClass != None) && (Controller == None) )
		Controller = spawn(ControllerClass);
	if ( Controller != None )
		Controller.Possess(self);
	Health = SentryHealth;
}
simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	RepHitLocation = vect(0,0,0);
	if( Level.NetMode==NM_Client )
	{
		bNetNotify = true;
		PostNetReceive();
		if( RepAnimationAction==0 )
			TweenAnim(IdleRestAnim,0.01f);
	}
}
simulated function PostNetReceive()
{
	if( ClientAnimNum!=RepAnimationAction )
		SetAnimationNum(RepAnimationAction);
	if( RepHitLocation!=vect(0,0,0) )
	{
		ClientTraceFX();
		RepHitLocation = vect(0,0,0);
	}
}

simulated function Destroyed()
{
	if( Controller!=None )
	{
		Controller.bIsPlayer = false;
		Controller.Destroy();
	}
	if( WeaponFlash!=None )
		WeaponFlash.Destroy();
	if( mTracer!=None )
		mTracer.Destroy();
}
simulated function SetAnimationNum( byte Num )
{
	RepAnimationAction = Num;
	switch( Num )
	{
	case 0:
		if( ClientAnimNum==1 )
		{
			if( Level.NetMode!=NM_Client )
				Speech(0);
			PlayAnim('Un_Fold');
		}
		else PlayAnim('Ranged_Attack_End');
		if( Level.NetMode!=NM_Client )
			SetTimer(0,false);
		if( WeaponFlash!=None )
		{
			WeaponFlash.RemoveFX();
			WeaponFlash = None;
		}
		break;
	case 1:
		PlayAnim('Folded');
		break;
	case 2:
		LoopAnim('Ranged_Attack1',1.6f);
		if( Level.NetMode!=NM_Client )
			SetTimer(0.06,true);
		if( Level.NetMode!=NM_DedicatedServer )
		{
			WeaponFlash = Spawn(Class'DemoSentryWeaponFlash',Self);
			AttachToBone(WeaponFlash, 'Barrel');
		}
		break;
	}
	ClientAnimNum = Num;
	bPhysicsAnimUpdate = false;
}
simulated function AnimEnd( int Channel )
{
	if( RepAnimationAction!=0 || bPhysicsAnimUpdate )
		return;
	bPhysicsAnimUpdate = true;
	if( Controller!=None )
		Controller.AnimEnd(Channel);
}
simulated function RunStep()
{
	PlaySound(Footstep[Rand(Footstep.Length)],SLOT_Misc,1.5f,,350.f);
}
function Timer()
{
	local vector X,HL,HN;
	local Actor A,Res;

	if( Controller==None )
		return;
	if( Controller.Enemy!=None )
		X = Normal(Controller.Enemy.Location-Location);
	else X = vector(Rotation);
	X = Normal(X+VRand()*0.04f);

	foreach TraceActors(Class'Actor',Res,HL,HN,Location+X*8000.f,Location)
	{
		if( Res!=Self && (Res==Level || Res.bBlockActors || Res.bProjTarget || Res.bWorldGeometry) && KFPawn(Res)==None
			 && KFBulletWhipAttachment(Res)==None && Sentry(Res)==None )
		{
			A = Res;
			break;
		}
	}
	if( A!=None && KFHumanPawn(A)==None )
	{
		A.TakeDamage(HitDamage,OwnerPawn,HL,X*1000.f,Class'DemoDamTypeSentryFire');
		if (OwnerPawn != none)
		{
			(KFSteamStatsAndAchievements((KFPlayerReplicationInfo(OwnerPawn.PlayerReplicationInfo)).SteamStatsAndAchievements)).AddExplosivesDamage(HitDamage);
		}
	}
	else if( A==None )
		HL = Location+X*8000.f;

	if( Level.NetMode!=NM_StandAlone )
	{
		if( VSize(RepHitLocation-HL)<2.f )
			RepHitLocation+=VRand()*2.f;
		else RepHitLocation = HL;
	}
	if( Level.NetMode!=NM_DedicatedServer )
		TraceFX(A,HL,HN);
}

simulated function TraceFX(Actor A , vector HL, vector HN )
{
	local vector SpawnLoc, SpawnDir, SpawnVel;
	local float hitDist;
	//local DTBulletEmitter dtbe;

	PlaySound(Sound'PerkBots_T.DTShoot',SLOT_Pain,2.f,,800.f);
	
	if( A!=None && Pawn(A)==None && ExtendedZCollision(A)==None )
		Spawn(class'ROBulletHitEffect',,, HL, Rotator(-HN));

	if (mTracer == None)
		mTracer = Spawn(Class'KFNewTracer');

	if( mTracer != None )
	{
		SpawnLoc = GetBoneCoords('Barrel').Origin;
		mTracer.SetLocation(SpawnLoc);

		hitDist = VSize(HL - SpawnLoc) - 50.f;

		SpawnDir = Normal(HL - SpawnLoc);

		if( hitDist > 100.f )
		{
			SpawnVel = SpawnDir * 7500.f;
			mTracer.Emitters[0].StartVelocityRange.X.Min = SpawnVel.X;
			mTracer.Emitters[0].StartVelocityRange.X.Max = SpawnVel.X;
			mTracer.Emitters[0].StartVelocityRange.Y.Min = SpawnVel.Y;
			mTracer.Emitters[0].StartVelocityRange.Y.Max = SpawnVel.Y;
			mTracer.Emitters[0].StartVelocityRange.Z.Min = SpawnVel.Z;
			mTracer.Emitters[0].StartVelocityRange.Z.Max = SpawnVel.Z;

			mTracer.Emitters[0].LifetimeRange.Min = hitDist / 7500.f;
			mTracer.Emitters[0].LifetimeRange.Max = mTracer.Emitters[0].LifetimeRange.Min;

			mTracer.SpawnParticle(1);
		}
	}
	
	/*dtbe = Spawn(class'DTBulletEmitter',,, HL, Rotator(-HN));
	dtbe.Emitters[0].LifetimeRange.Min = 1.5;
	dtbe.Emitters[0].LifetimeRange.Max = 1.5;
	dtbe.Emitters[1].LifetimeRange.Min = 0.5;
	dtbe.Emitters[1].LifetimeRange.Max = 0.5;*/
	PewPew(HL, HN);
}

function PewPew(vector HL, vector HN)
{
	Spawn(class'DTBullet',,, HL, Rotator(-HN));
}

function TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
{
	if( KFHumanPawn(InstigatedBy)!=None )
		return;
	Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType,HitIndex);
	Speech(4);
}
function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	PlayerReplicationInfo = None;
	if( WeaponOwner!=None )
	{
		if( OwnerPawn!=None && PlayerController(OwnerPawn.Controller)!=None )
			PlayerController(OwnerPawn.Controller).ReceiveLocalizedMessage(Class'BaseSentryMessage',2);
		WeaponOwner.CurrentSentry = None;
		WeaponOwner.Destroy();
		WeaponOwner = None;
	}
	if( Controller!=None )
		Controller.bIsPlayer = false;
	PlaySound(VoicesList[3],SLOT_Talk,2.5f,,450.f);
	Super.Died(Killer,damageType,HitLocation);
}
simulated event PlayDying(class<DamageType> DamageType, vector HitLoc)
{
	AmbientSound = None;
	GotoState('Dying');
	bReplicateMovement = false;
	bTearOff = true;
	Velocity += TearOffMomentum;
	SetPhysics(PHYS_Falling);
	bPlayedDeath = true;
	PlayAnim('Fold');
	if( WeaponFlash!=None )
	{
		WeaponFlash.RemoveFX();
		WeaponFlash = None;
	}
}

simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local int NumKilled;
	local KFMonster KFMonsterVictim;
	local Pawn P;

	if ( bHurtEntry )
		return;

	bHurtEntry = true;
	if( OwnerPawn!=None )
		P = OwnerPawn;
	else P = Self;

	foreach CollidingActors (class 'Actor', Victims, DamageRadius, HitLocation)
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo')
		 && ExtendedZCollision(Victims)==None && KFPawn(Victims)==None && Sentry(Victims)==None )
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);

			KFMonsterVictim = KFMonster(Victims);

    			if( KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
				KFMonsterVictim = none;

			if( KFMonsterVictim != none )
				damageScale *= KFMonsterVictim.GetExposureTo(HitLocation);

			if ( damageScale <= 0)
				continue;

			Victims.TakeDamage(damageScale * DamageAmount,P,Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius)
			 * dir,(damageScale * Momentum * dir),DamageType);

			if( Role == ROLE_Authority && KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
				NumKilled++;
		}
	}

	if( Role == ROLE_Authority )
	{
		if ( NumKilled >= 4 )
			KFGameType(Level.Game).DramaticEvent(0.05);
		else if ( NumKilled >= 2 )
			KFGameType(Level.Game).DramaticEvent(0.03);
	}
	bHurtEntry = false;
}

State Dying
{
ignores Trigger, Bump, HitWall, HeadVolumeChange, PhysicsVolumeChange, Falling, BreathTimer, TakeDamage, Landed, SetAnimationNum, Timer;

	simulated function EndState()
	{
		local Emitter E;

		if( Level.NetMode!=NM_DedicatedServer )
		{
			E = Spawn(Class'PanzerfaustHitConcrete_simple');
			if( E!=None ) E.RemoteRole = ROLE_None;
			PlaySound(Sound'KF_LAWSnd.Rocket_Explode',SLOT_Pain,2.5f,,800.f);
		}
		HurtRadius(400,500,Class'DamTypeFrag',100000.f,Location);
	}

	function Landed(vector HitNormal);
	function LandThump();
	event AnimEnd(int Channel);
	function LieStill();
	function BaseChange();

	simulated function BeginState()
	{
		local int i;

		LifeSpan = 1.75f;
		SetPhysics(PHYS_Falling);
		SetCollision(false);
		if ( Controller != None )
			Controller.Destroy();
		for (i = 0; i < Attached.length; i++)
			if (Attached[i] != None)
				Attached[i].PawnBaseDied();
	}
Begin:
}

defaultproperties
{
     hitdamage=10
     SentryHealth=250
     FootStep(0)=Sound'SentryBotSnd.Sentry.Sentry_sstep_01'
     FootStep(1)=Sound'SentryBotSnd.Sentry.Sentry_sstep_02'
     FootStep(2)=Sound'SentryBotSnd.Sentry.Sentry_sstep_03'
     FootStep(3)=Sound'SentryBotSnd.Sentry.Sentry_sstep_04'
     VoicesList(0)=Sound'SentryBotSnd.Sentry.Sentry_activate_01'
     VoicesList(1)=Sound'SentryBotSnd.Sentry.Sentry_cant_reach_player_01'
     VoicesList(2)=Sound'SentryBotSnd.Sentry.Sentry_cant_reach_player_02'
     VoicesList(3)=Sound'SentryBotSnd.Sentry.Sentry_destroyed_01'
     VoicesList(4)=Sound'SentryBotSnd.Sentry.Sentry_fight_enemy_02'
     VoicesList(5)=Sound'SentryBotSnd.Sentry.Sentry_sight_enemy_01'
     VoicesList(6)=Sound'SentryBotSnd.Sentry.Sentry_lost_target_01'
     VoicesList(7)=Sound'SentryBotSnd.Sentry.Sentry_pain_01'
     VoicesList(8)=Sound'SentryBotSnd.Sentry.Sentry_pain_02'
     VoicesList(9)=Sound'SentryBotSnd.Sentry.Sentry_pain_03'
     VoicesList(10)=Sound'SentryBotSnd.Sentry.Sentry_pain_04'
     VoicesList(11)=Sound'SentryBotSnd.Sentry.Sentry_shutdown_01'
     VoicesList(12)=Sound'SentryBotSnd.Sentry.Sentry_sight_friendly_01'
     VoicesList(13)=Sound'SentryBotSnd.Sentry.Sentry_wait_for_player_01'
     VoicesList(14)=Sound'SentryBotSnd.Sentry.Sentry_wait_for_player_02'
     VoicesList(15)=Sound'SentryBotSnd.Sentry.Sentry_wait_for_player_03'
     FiringSounds(0)=Sound'SentryBotSnd.Sentry.Sentry_fire_01'
     FiringSounds(1)=Sound'SentryBotSnd.Sentry.Sentry_fire_02'
     FiringSounds(2)=Sound'SentryBotSnd.Sentry.Sentry_fire_03'
     FiringSounds(3)=Sound'SentryBotSnd.Sentry.Sentry_fire_04'
     FiringSounds(4)=Sound'SentryBotSnd.Sentry.Sentry_fire_05'
     bScriptPostRender=true
     SightRadius=6500.000000
     PeripheralVision=-1.000000
     GroundSpeed=200.000000
     JumpZ=350.000000
     BaseEyeHeight=0.000000
     EyeHeight=0.000000
     Health=250
     ControllerClass=Class'DemoSentryController'
     bPhysicsAnimUpdate=true
     MovementAnims(0)="Walk"
     MovementAnims(1)="Walk"
     MovementAnims(2)="Walk"
     MovementAnims(3)="Walk"
     TurnLeftAnim="TurnL"
     TurnRightAnim="TurnR"
     SwimAnims(0)="Walk"
     SwimAnims(1)="Walk"
     SwimAnims(2)="Walk"
     SwimAnims(3)="Walk"
     CrouchAnims(0)="Walk"
     CrouchAnims(1)="Walk"
     CrouchAnims(2)="Walk"
     CrouchAnims(3)="Walk"
     WalkAnims(0)="Walk"
     WalkAnims(1)="Walk"
     WalkAnims(2)="Walk"
     WalkAnims(3)="Walk"
     AirAnims(0)="Walk"
     AirAnims(1)="Walk"
     AirAnims(2)="Walk"
     AirAnims(3)="Walk"
     TakeoffAnims(0)="Walk"
     TakeoffAnims(1)="Walk"
     TakeoffAnims(2)="Walk"
     TakeoffAnims(3)="Walk"
     LandAnims(0)="Walk"
     LandAnims(1)="Walk"
     LandAnims(2)="Walk"
     LandAnims(3)="Walk"
     DoubleJumpAnims(0)="Walk"
     DoubleJumpAnims(1)="Walk"
     DoubleJumpAnims(2)="Walk"
     DoubleJumpAnims(3)="Walk"
     DodgeAnims(0)="Walk"
     DodgeAnims(1)="Walk"
     DodgeAnims(2)="Walk"
     DodgeAnims(3)="Walk"
     AirStillAnim="Walk"
     TakeoffStillAnim="Walk"
     CrouchTurnRightAnim="Walk"
     CrouchTurnLeftAnim="Walk"
     IdleCrouchAnim="Idle_Stand"
     IdleSwimAnim="Idle_Stand"
     IdleWeaponAnim="Idle_Stand"
     IdleRestAnim="Idle_Stand"
     IdleChatAnim="Idle_Stand"
     bStasis=false
     Physics=PHYS_Falling
     Mesh=SkeletalMesh'sentrybot_turret.SentryMesh'
     PrePivot=(Z=-5.000000)
     Skins(0)=Texture'Sentrybot_T.Sentry.SentrySpistonDiffuse'
     Skins(1)=Texture'Sentrybot_T.Sentry.SentryFlapDiffuse'
     Skins(2)=Texture'PerkBots_T.SDemoSkin'
     Skins(3)=Shader'Sentrybot_T.Sentry.InvisibleWeaponsFlash'
     Skins(4)=Shader'Sentrybot_T.Sentry.InvisibleWeaponsFlash'
     Skins(5)=Shader'Sentrybot_T.Sentry.InvisibleWeaponsFlash'
     Skins(6)=Shader'Sentrybot_T.Sentry.InvisibleWeaponsFlash'
     Skins(7)=Shader'Sentrybot_T.Sentry.InvisibleWeaponsFlash'
     Skins(8)=Shader'Sentrybot_T.Sentry.InvisibleWeaponsFlash'
     CollisionRadius=20.000000
     CollisionHeight=23.000000
     Mass=400.000000
}
