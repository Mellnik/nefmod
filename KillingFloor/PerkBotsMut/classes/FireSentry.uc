class FireSentry extends Sentry
	Config(PerkBots);
	
#exec OBJ LOAD FILE=KF_LAWSnd.uax
	
var FireSentryWeaponFlash FWeaponFlash;
var FireSentryGun WeaponOwner;

final function SSetOwningPlayer( Pawn Other, FireSentryGun W )
{
	OwnerPawn = Other;
	PlayerReplicationInfo = Other.PlayerReplicationInfo;
	WeaponOwner = W;
}

simulated function Destroyed()
{
	if( Controller!=None )
	{
		Controller.bIsPlayer = false;
		Controller.Destroy();
	}
	if( FWeaponFlash!=None )
		FWeaponFlash.Destroy();
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
		if( FWeaponFlash!=None )
		{
			FWeaponFlash.RemoveFX();
			FWeaponFlash = None;
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
			FWeaponFlash = Spawn(Class'FireSentryWeaponFlash',Self);
			AttachToBone(FWeaponFlash, 'Barrel');
		}
		break;
	}
	ClientAnimNum = Num;
	bPhysicsAnimUpdate = false;
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
	if( A!=None && KFPawn(A)==None )
	{
		A.TakeDamage(HitDamage,OwnerPawn,HL,X*1000.f,Class'FireDamTypeSentryFire');
		if (OwnerPawn != none)
		{
			(KFSteamStatsAndAchievements((KFPlayerReplicationInfo(OwnerPawn.PlayerReplicationInfo)).SteamStatsAndAchievements)).AddFlameThrowerDamage(HitDamage);
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
	if( FWeaponFlash!=None )
	{
		FWeaponFlash.RemoveFX();
		FWeaponFlash = None;
	}
}

defaultproperties
{
     hitdamage=7
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
     ControllerClass=Class'FireSentryController'
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
     Skins(2)=Texture'PerkBots_T.SFireSkin'
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
