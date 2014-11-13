class Tech_ShockRifleBullet extends ROBallisticProjectile;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechStatics.usx"



var PanzerfaustTrail SmokeTrail;
var vector Dir;
var bool bRing,bHitWater,bWaterStart;

var     xEmitter    Trail;


var()   sound   ExplosionSound; // The sound of the rocket exploding

var     bool                bHasExploded;

var   class<DamageType>	   ImpactDamageType; // Damagetype of this rocket hitting something, but not exploding
var     int     ImpactDamage;   // How much damage to do if this rocket impacts something without exploding

// Physics
var() 		float 		StraightFlightTime;          // How long the projectile and flies straight
var 		float 		TotalFlightTime;             // How long the rocket has been in flight
var 		bool 		bOutOfPropellant;            // Projectile is out of propellant
// Physics debugging
var 		vector 		OuttaPropLocation;

var		string	StaticMeshRef;
var		string	ExplosionSoundRef;

static function PreloadAssets()
{
	default.ExplosionSound = sound(DynamicLoadObject(default.ExplosionSoundRef, class'Sound', true));

	UpdateDefaultStaticMesh(StaticMesh(DynamicLoadObject(default.StaticMeshRef, class'StaticMesh', true)));
}

simulated function PostBeginPlay()
{
    OrigLoc = Location;

    Trail = Spawn(class'Tech_ShockRifleTracer',self);
    Trail.Lifespan = Lifespan;

    Dir = vector(Rotation);
    Velocity = speed * Dir;
    if (PhysicsVolume.bWaterVolume)
    {
        bHitWater = True;
        Velocity=0.6*Velocity;
    }
    Super.PostBeginPlay();
}



simulated function Tick( float DeltaTime )
{
    SetRotation(Rotator(Normal(Velocity)));

    if( !bOutOfPropellant )
    {
        if ( TotalFlightTime <= StraightFlightTime )
        {
            TotalFlightTime += DeltaTime;
        }
        else
        {
            OuttaPropLocation = Location;
            bOutOfPropellant = true;
        }
    }

    if(  bOutOfPropellant && bTrueBallistics )
    {
         //log(" Projectile flew "$(VSize(OrigLoc - OuttaPropLocation)/50.0)$" meters before running out of juice");
         bTrueBallistics = false;
    }
}

function Timer()
{
    Destroy();
}


simulated function HitWall(vector HitNormal, actor Wall)
{
    super(Projectile).HitWall(HitNormal,Wall);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	bHasExploded = True;

	//PlaySound(ExplodeSounds[rand(ExplodeSounds.length)],,2.0);
	PlaySound(ExplosionSound,,2.0);
	if ( EffectIsRelevant(Location,false) )
	{
		Spawn(class'BMTCustomMut.Tech_ShockRifleSpark',,,HitLocation + HitNormal*20,rotator(HitNormal));
	}

	BlowUp(HitLocation);
	Destroy();
}

function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{
    Explode(HitLocation, vect(0,0,0));
}

simulated function Destroyed()
{
	if ( SmokeTrail != None )
	{
		SmokeTrail.HandleOwnerDestroyed();
	}

	if( !bHasExploded && !bHidden )
		Explode(Location,vect(0,0,1));

	Super.Destroyed();
}

simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dirs;
	local int NumKilled;
	local KFMonster KFMonsterVictim;
	local Pawn P;
	local KFPawn KFP;
	local array<Pawn> CheckedPawns;
	local int i;
	local bool bAlreadyChecked;


	if ( bHurtEntry )
		return;

	bHurtEntry = true;

	foreach CollidingActors (class 'Actor', Victims, DamageRadius, HitLocation)
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo')
		 && ExtendedZCollision(Victims)==None )
		{
			dirs = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dirs));
			dirs = dirs/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			if ( Victims == LastTouched )
				LastTouched = None;

			P = Pawn(Victims);

			if( P != none )
			{
		        for (i = 0; i < CheckedPawns.Length; i++)
				{
		        	if (CheckedPawns[i] == P)
					{
						bAlreadyChecked = true;
						break;
					}
				}

				if( bAlreadyChecked )
				{
					bAlreadyChecked = false;
					P = none;
					continue;
				}

				KFMonsterVictim = KFMonster(Victims);

				if( KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
				{
					KFMonsterVictim = none;
				}

				KFP = KFPawn(Victims);

				if( KFMonsterVictim != none )
				{
					damageScale *= KFMonsterVictim.GetExposureTo(HitLocation/*Location + 15 * -Normal(PhysicsVolume.Gravity)*/);
				}
				else if( KFP != none )
				{
				    damageScale *= KFP.GetExposureTo(HitLocation/*Location + 15 * -Normal(PhysicsVolume.Gravity)*/);
				}

				CheckedPawns[CheckedPawns.Length] = P;

				if ( damageScale <= 0)
				{
					P = none;
					continue;
				}
				else
				{
					//Victims = P;
					P = none;
				}
			}


			Victims.TakeDamage
			(
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dirs,
				(damageScale * Momentum * dirs),
				DamageType
			);
			if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);

			if( Role == ROLE_Authority && KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
			{
				NumKilled++;
			}
		}
	}
	if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
	{
		Victims = LastTouched;
		LastTouched = None;
		dirs = Victims.Location - HitLocation;
		dist = FMax(1,VSize(dirs));
		dirs = dirs/dist;
		damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));
		if ( Instigator == None || Instigator.Controller == None )
			Victims.SetDelayedDamageInstigatorController(InstigatorController);
		Victims.TakeDamage
		(
			damageScale * DamageAmount,
			Instigator,
			Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dirs,
			(damageScale * Momentum * dirs),
			DamageType
		);
		if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
			Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
	}

	if( Role == ROLE_Authority )
	{
		if( NumKilled >= 4 )
		{
			KFGameType(Level.Game).DramaticEvent(0.05);
		}
		else if( NumKilled >= 2 )
		{
			KFGameType(Level.Game).DramaticEvent(0.03);
		}
	}

	bHurtEntry = false;
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if ( Other != Instigator && !Other.IsA('PhysicsVolume') && (Other.IsA('Pawn') || Other.IsA('ExtendedZCollision')) )
	{
		Other.Velocity.X = Self.Velocity.X * 0.05;
		Other.Velocity.Y = Self.Velocity.Y * 0.05;
		Other.Velocity.Z = Self.Velocity.Z * 0.05;
		Other.Acceleration = vect(0,0,0); //0,0,0
		
	        Explode(HitLocation,Normal(HitLocation-Other.Location));
	}
}

defaultproperties
{
     ImpactDamageType=Class'BMTCustomMut.DamTypeTech_ShockRifle'
     ImpactDamage=200
     StaticMeshRef="SentryTechStatics.Weapon_ShockRifle.ShockRifle_Spark"
     ExplosionSoundRef="ProjectileSounds.Bullets.Impact_Grass05"
     AmbientVolumeScale=2.000000
     bTrueBallistics=False
     Speed=3500.000000
     MaxSpeed=4000.000000
     Damage=350.000000
     DamageRadius=200.000000
     MomentumTransfer=125000.000000
     MyDamageType=Class'BMTCustomMut.DamTypeTech_ShockRifle'
     LightType=LT_Steady
     LightHue=136
     LightBrightness=214.000000
     LightRadius=10.000000
     DrawType=DT_StaticMesh
     bDynamicLight=True
     LifeSpan=10.000000
     bUnlit=False
     SoundVolume=255
     SoundRadius=250.000000
     TransientSoundVolume=2.000000
     TransientSoundRadius=500.000000
     bNetNotify=True
     bBlockHitPointTraces=False
     ForceRadius=300.000000
     ForceScale=10.000000
}
