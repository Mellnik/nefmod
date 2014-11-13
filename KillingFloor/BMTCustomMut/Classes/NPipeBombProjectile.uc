class NPipeBombProjectile extends PipeBombProjectile
	Config(SPerksAddOn);

var float RepPulseTime,ClientPulseTimer;
var() config byte MaxPipebombs;

replication
{
	reliable if(Role == ROLE_Authority)
		RepPulseTime;
}

// cut-n-paste to remove grenade smoke trail
simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
		BombLight = Spawn(class'PipebombLight',self);
		BombLight.SetBase(self);
	}

	if ( Role == ROLE_Authority )
	{
		if( Instigator!=None )
			InstigatorController = Instigator.Controller;
		Velocity = Speed * Vector(Rotation);
		RandSpin(25000);
		bCanHitOwner = false;
		if (Instigator.HeadVolume.bWaterVolume)
		{
			bHitWater = true;
			Velocity = 0.6*Velocity;
		}
	}
}

simulated function PostNetReceive()
{
	if( bHidden && !bDisintegrated )
		Disintegrate(Location, vect(0,0,1));
	else if( bTriggered && !bHasExploded )
		Explode(Location,vect(0,0,1));
	if( RepPulseTime!=ClientPulseTimer )
	{
		ClientPulseTimer = RepPulseTime;
		SetTimer(RepPulseTime,true);
	}
}

final function CheckPipebombLimit()
{
	local NPipeBombProjectile P;
	local int i;

	i = 1;
	foreach DynamicActors(Class'NPipeBombProjectile',P)
		if( P!=Self && !P.bEnemyDetected && P.InstigatorController==InstigatorController )
			++i;

	if( i<MaxPipebombs )
		return;
	foreach DynamicActors(Class'NPipeBombProjectile',P)
		if( P!=Self && !P.bEnemyDetected && P.InstigatorController==InstigatorController )
		{
			P.bEnemyDetected = true;
			P.SetTimer(0.15,True);
			if( --i<MaxPipebombs )
				break;
		}
}

simulated function Timer()
{
	local Pawn CheckPawn;
	local float ThreatLevel;

	if( Level.NetMode==NM_Client )
	{
		if( !bHidden && !bTriggered )
		{
			if( RepPulseTime==0.15f )
				PlaySound(BeepSound,SLOT_Misc,2.0,,150.0);
			else PlaySound(BeepSound,,0.5,,50.0);
		}
		return;
	}
	if( !bHidden && !bTriggered )
	{
		if( ArmingCountDown >= 0 )
		{
			ArmingCountDown -= 0.1;
			if( ArmingCountDown <= 0 )
			{
				PlaySound(BeepSound,,0.5,,50.0);
				SetTimer(1.0,True);
				bSkipActorPropertyReplication = true;
				CheckPipebombLimit();
			}
		}
		else
		{
			// Check for enemies
			if( !bEnemyDetected )
			{
				bAlwaysRelevant=false;
				PlaySound(BeepSound,,0.5,,50.0);

				foreach VisibleCollidingActors( class 'Pawn', CheckPawn, DetectionRadius, Location )
				{
					if( CheckPawn.Health<=0 )
						continue;
					if( KFMonster(CheckPawn)!=none )
					{
						ThreatLevel += KFMonster(CheckPawn).MotionDetectorThreat;
						if( ThreatLevel >= ThreatThreshhold )
							break;
					}
					else if( CheckPawn.Controller!=None )
					{
						// Make the thing beep if someone on our team is within the detection radius
						// This gives them a chance to get out of the way
						ThreatLevel += 0.001;
					}
				}

				if( ThreatLevel >= ThreatThreshhold || InstigatorController==None || InstigatorController.bDeleteMe || Pawn(Base)!=None )
				{
					bEnemyDetected = true;
					SetTimer(0.15,True);
				}
				else if( ThreatLevel > 0 )
					SetTimer(0.5,True);
				else SetTimer(1.0,True);
			}
			else // Play some fast beeps and blow up
			{
				bAlwaysRelevant=true;

				if( --CountDown > 0 )
					PlaySound(BeepSound,SLOT_Misc,2.0,,150.0);
				else Explode(Location, vector(Rotation));
        		}
		}
	}
	else Destroy();
	if( TimerRate!=0.1 )
		RepPulseTime = TimerRate;
}

simulated function Landed( vector HitNormal )
{
	if( Level.NetMode!=NM_Client )
	{
		RepPulseTime = 1.f;
		SetTimer(1.0,True);
	}
	HitWall( HitNormal, none );
}

simulated function ProcessTouch( actor Other, vector HitLocation );

/* HurtRadius()
 Hurt locally authoritative actors within the radius.
*/
simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local int NumKilled;
	local KFMonster KFMonsterVictim;
	local KFPawn KFP;

	if ( bHurtEntry )
		return;

	bHurtEntry = true;

	foreach CollidingActors (class 'Actor', Victims, DamageRadius, HitLocation)
	{
		if( Level.NetMode!=NM_Client && KFPawn(Victims)!=None && Pawn(Victims).Controller!=InstigatorController )
			continue;

		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo')
		 && ExtendedZCollision(Victims)==None )
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);

			if ( Instigator == None || Instigator.Controller == None )
			{
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			}

			KFMonsterVictim = KFMonster(Victims);
			KFP = KFPawn(Victims);

			if( KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
				KFMonsterVictim = none;

			if( KFMonsterVictim != none )
				damageScale *= KFMonsterVictim.GetExposureTo(Location + 15 * -Normal(PhysicsVolume.Gravity));
			else if( KFP != none )
			{
				damageScale *= KFP.GetExposureTo(Location + 15 * -Normal(PhysicsVolume.Gravity));
				// Reduce damage to people so I can make the damage radius a bit bigger for killing zeds
				damageScale *= 0.5;
			}

			if ( damageScale <= 0)
				continue;

			Victims.TakeDamage(damageScale * DamageAmount,Instigator,Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius)
			 * dir,(damageScale * Momentum * dir),DamageType);

			if( Level.NetMode!=NM_Client && KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
				NumKilled++;
		}
	}

	if( Level.NetMode!=NM_Client )
	{
		if( NumKilled >= 4 )
			KFGameType(Level.Game).DramaticEvent(0.05);
		else if( NumKilled >= 2 )
			KFGameType(Level.Game).DramaticEvent(0.03);
	}
	bHurtEntry = false;
}

simulated function HitWall( vector HitNormal, actor Wall )
{
	local Vector VNorm;
	local PlayerController PC;

	// Reflect off Wall w/damping
	VNorm = (Velocity dot HitNormal) * HitNormal;
	Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	RandSpin(100000);
	DesiredRotation.Roll = 0;
	RotationRate.Roll = 0;
	Speed = VSize(Velocity);

	if ( Speed < 20 )
	{
		bBounce = False;
		PrePivot.Z = 3.5;
		SetPhysics(PHYS_None);
		DesiredRotation = Rotation;
		DesiredRotation.Roll = 0;
		DesiredRotation.Pitch = 0;
		SetRotation(DesiredRotation);
		if( Level.NetMode!=NM_Client )
			SetTimer(0.1,True);
	}
	else
	{
		if ( (Level.NetMode != NM_DedicatedServer) && (Speed > 50) )
			PlaySound(ImpactSound, SLOT_Misc );
		else
		{
			bFixedRotationDir = false;
			bRotateToDesired = true;
			DesiredRotation.Pitch = 0;
			RotationRate.Pitch = 50000;
		}
		if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (Level.TimeSeconds - LastSparkTime > 0.5) && EffectIsRelevant(Location,false) )
		{
			PC = Level.GetLocalPlayerController();
			if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) < 6000 )
				Spawn(HitEffectClass,,, Location, Rotator(HitNormal));
			LastSparkTime = Level.TimeSeconds;
		}
	}
}

defaultproperties
{
     MaxPipebombs=6
}
