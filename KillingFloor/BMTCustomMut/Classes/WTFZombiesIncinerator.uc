class WTFZombiesIncinerator extends ZombieHusk;

#exec OBJ LOAD FILE=WTFTex.utx
#exec OBJ LOAD FILE=KF_BaseHusk.uax

var bool bKamikazeMode;
var bool bHasBlown;

simulated function PostBeginPlay() //SPAMCANNON
{
	// Difficulty Scaling
	if (Level.Game != none && !bDiffAdjusted)
	{
        if( Level.Game.GameDifficulty < 2.0 )
        {
            ProjectileFireInterval = default.ProjectileFireInterval * 0.75;
            BurnDamageScale = default.BurnDamageScale * 2.0;
        }
        else if( Level.Game.GameDifficulty < 4.0 )
        {
            ProjectileFireInterval = default.ProjectileFireInterval * 0.5;
            BurnDamageScale = default.BurnDamageScale * 1.0;
        }
        else if( Level.Game.GameDifficulty < 7.0 )
        {
            ProjectileFireInterval = default.ProjectileFireInterval * 0.25;
            BurnDamageScale = default.BurnDamageScale * 0.75;
        }
        else // Hardest difficulty
        {
            ProjectileFireInterval = default.ProjectileFireInterval * 0.05;
            BurnDamageScale = default.BurnDamageScale * 0.5;
        }
	}

	super(KFMonster).PostBeginPlay();
}

function RangedAttack(Actor A)
{
	local int LastFireTime;

	if ( bShotAnim )
		return;

	if ( Physics == PHYS_Swimming )
	{
		SetAnimAction('Claw');
		bShotAnim = true;
		LastFireTime = Level.TimeSeconds;
	}
	else if ( VSize(A.Location - Location) < MeleeRange + CollisionRadius + A.CollisionRadius )
	{
		bShotAnim = true;
		LastFireTime = Level.TimeSeconds;
		SetAnimAction('Claw');
		//PlaySound(sound'Claw2s', SLOT_Interact); KFTODO: Replace this
		Controller.bPreparingMove = true;
		Acceleration = vect(0,0,0);
	}
	else if ( !bKamikazeMode ) //DO NOT RANGED ATTACK DURING KAMIKAZE RUSH!!!
	{
		if ( (KFDoorMover(A) != none ||
			(!Region.Zone.bDistanceFog && VSize(A.Location-Location) <= 65535) ||
			(Region.Zone.bDistanceFog && VSizeSquared(A.Location-Location) < (Square(Region.Zone.DistanceFogEnd) * 0.8)))  // Make him come out of the fog a bit
			&& !bDecapitated )
		{
			bShotAnim = true;

			SetAnimAction('ShootBurns');
			Controller.bPreparingMove = true;
			Acceleration = vect(0,0,0);

			NextFireProjectileTime = Level.TimeSeconds + ProjectileFireInterval + (FRand() * 2.0);
		}
	}
}

function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{
	Super.TakeDamage(Damage,instigatedBy,hitlocation,momentum,damageType,HitIndex);
	
	if (!bKamikazeMode && Health <= (HealthMax / 2)) //if we are less than half hitpoints
	{
		bKamikazeMode=true;
		GroundSpeed=Default.GroundSpeed * 2.5; //move 2x as fast
		OriginalGroundSpeed=GroundSpeed;
		HiddenGroundSpeed=GroundSpeed;
		WaterSpeed=GroundSpeed;
		SetTimer(5.0,false);
		AmbientSound=Sound'KF_BaseHusk.Fire.husk_fireball_loop';
		AmbientGlow=254;
	}
}

function Timer()
{
	if (bKamikazeMode && !bHasBlown)
		Explode(Location,Location);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	bHasBlown=true;
	
	Spawn(Class'KFMod.KFNadeLExplosion',,, HitLocation, rotator(vect(0,0,1)));
	Spawn(class'KFMod.FlameImpact',,, HitLocation, rotator(vect(0,0,1)));
	//Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));

	if ( Role == ROLE_Authority )
	{
		MakeNoise(1.0);
		HurtRadius(40,350, Class'DamTypeBurned', 1000, HitLocation );
		TakeDamage( 100000, Self, Location, Velocity, Class'KFMod.DamTypeBleedOut');
		Destroy();
	}
}

function SpawnTwoShots()
{
	local vector X,Y,Z, FireStart;
	local rotator FireRotation;
	local KFMonsterController KFMonstControl;

	if( Controller!=None && KFDoorMover(Controller.Target)!=None )
	{
		Controller.Target.TakeDamage(22,Self,Location,vect(0,0,0),Class'DamTypeVomit');
		return;
	}

	GetAxes(Rotation,X,Y,Z);
	FireStart = GetBoneCoords('Barrel').Origin;
	if ( !SavedFireProperties.bInitialized )
	{
		SavedFireProperties.AmmoClass = Class'SkaarjAmmo';
		SavedFireProperties.ProjectileClass = Class'HuskFireProjectile';
		SavedFireProperties.WarnTargetPct = 1;
		SavedFireProperties.MaxRange = 65535;
		SavedFireProperties.bTossed = False;
		SavedFireProperties.bTrySplash = true;
		SavedFireProperties.bLeadTarget = True;
		SavedFireProperties.bInstantHit = False;
		SavedFireProperties.bInitialized = True;
	}

    // Turn off extra collision before spawning vomit, otherwise spawn fails
    ToggleAuxCollision(false);

	FireRotation = Controller.AdjustAim(SavedFireProperties,FireStart,600);

	foreach DynamicActors(class'KFMonsterController', KFMonstControl)
	{
        if( KFMonstControl != Controller )
        {
            if( PointDistToLine(KFMonstControl.Pawn.Location, vector(FireRotation), FireStart) < 75 )
            {
                KFMonstControl.GetOutOfTheWayOfShot(vector(FireRotation),FireStart);
            }
        }
	}

    Spawn(Class'HuskFireProjectile',,,FireStart,FireRotation);

	// Turn extra collision back on
	ToggleAuxCollision(true);
}

defaultproperties
{
     MeleeDamage=30
     HeadHealth=800.000000
     HealthMax=1200.000000
     Health=1200
     MenuName="Incinerator"
     Skins(1)=Texture'WTFTex.WTFZombies.Incinerator'
     AmbientGlow=127
}
