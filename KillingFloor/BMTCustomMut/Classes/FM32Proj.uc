class FM32Proj extends ROBallisticProjectile;

var() class<Projectile> ProjectileClass;

#exec OBJ LOAD FILE=ProjectileSounds.uax

var PanzerfaustTrail SmokeTrail;
var vector Dir;
var bool bRing,bHitWater,bWaterStart;

var()   sound               ExplosionSound;     // The sound of the rocket exploding

var     bool                bDisintegrated;     // This nade has been disintegrated by a siren scream.
var()   sound               DisintegrateSound;  // The sound of this projectile disintegrating
var     bool                bDud;               // This rocket is a dud, it hit too soon
var()   float               ArmDistSquared;     // Distance this rocket arms itself at
var     class<DamageType>	ImpactDamageType;   // Damagetype of this rocket hitting something, but not exploding
var     int                 ImpactDamage;       // How much damage to do if this rocket impacts something without exploding

// Physics
var() 		float 		StraightFlightTime;          // How long the projectile and flies straight
var 		float 		TotalFlightTime;             // How long the rocket has been in flight
var 		bool 		bOutOfPropellant;            // Projectile is out of propellant
// Physics debugging
var 		vector 		OuttaPropLocation;

var         bool        bHasExploded;

replication
{
	reliable if(Role == ROLE_Authority)
		bDud;
}

static function PreloadAssets()
{

}

static function bool UnloadAssets()
{
	default.ExplosionSound = none;
	default.DisintegrateSound = none;

	UpdateDefaultStaticMesh(none);

	return true;
}

simulated function PostNetReceive()
{
    if( bHidden && !bDisintegrated )
    {
        Disintegrate(Location, vect(0,0,1));
    }
}

function Timer()
{
    Destroy();
}


simulated function HitWall(vector HitNormal, actor Wall)
{
    if( Instigator != none )
    {
        OrigLoc = Instigator.Location;
    }
    if( !bDud && ((VSizeSquared(Location - OrigLoc) < ArmDistSquared) || OrigLoc == vect(0,0,0)) )
    {
        bDud = true;
        LifeSpan=1.0;
        Velocity = vect(0,0,0);
        SetPhysics(PHYS_Falling);
    }

    if( !bDud )
    {
        super(Projectile).HitWall(HitNormal,Wall);
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	bHasExploded = True;
	BlowUp(HitLocation);

	Spawn(ProjectileClass, Instigator, 'None', HitLocation + (HitNormal * float(20)), Rotation);

	Destroy();
}

// Make the projectile distintegrate, instead of explode
simulated function Disintegrate(vector HitLocation, vector HitNormal)
{
	bDisintegrated = true;
	bHidden = true;

	if( Role == ROLE_Authority )
	{
	   SetTimer(0.1, false);
	   NetUpdateTime = Level.TimeSeconds - 1;
	}

	PlaySound(DisintegrateSound,,2.0);

	if ( EffectIsRelevant(Location,false) )
	{
		Spawn(Class'KFMod.SirenNadeDeflect',,, HitLocation, rotator(vect(0,0,1)));
	}
}

simulated function PostBeginPlay()
{
    local rotator SmokeRotation;

    BCInverse = 1 / BallisticCoefficient;

    if ( Level.NetMode != NM_DedicatedServer)
    {
        SmokeTrail = Spawn(class'PanzerfaustTrail',self);
        SmokeTrail.SetBase(self);
        SmokeRotation.Pitch = 32768;
        SmokeTrail.SetRelativeRotation(SmokeRotation);
        //Corona = Spawn(class'KFMod.KFLAWCorona',self);
    }

    OrigLoc = Location;

    if( !bDud )
    {
        Dir = vector(Rotation);
        Velocity = speed * Dir;
    }

    if (PhysicsVolume.bWaterVolume)
    {
        bHitWater = True;
        Velocity=0.6*Velocity;
    }
    super(Projectile).PostBeginPlay();
}

function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{
    if( damageType == class'SirenScreamDamage')
    {
        Disintegrate(HitLocation, vect(0,0,1));
    }
    else
    {
        if( !bDud )
        {
            Explode(HitLocation, vect(0,0,0));
        }
    }
}

simulated function Destroyed()
{
	if ( SmokeTrail != None )
	{
		SmokeTrail.HandleOwnerDestroyed();
	}

	if( !bHasExploded && !bHidden && !bDud )
		Explode(Location,vect(0,0,1));
	if( bHidden && !bDisintegrated )
        Disintegrate(Location,vect(0,0,1));

    Super.Destroyed();
}

simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
	
	// Don't let it hit this player, or blow up on another player 
    if ( Other == none || Other == Instigator || Other.Base == Instigator )
	{
		//Explode(HitLocation,Normal(HitLocation-Other.Location));
		return;
	}
    // Don't collide with bullet whip attachments
    if( KFBulletWhipAttachment(Other) != none )
    {
        //Explode(HitLocation,Normal(HitLocation-Other.Location));
		return;
    }

    // Don't allow hits on poeple on the same team
    if( KFHumanPawn(Other) != none && Instigator != none
        && KFHumanPawn(Other).PlayerReplicationInfo.Team.TeamIndex == Instigator.PlayerReplicationInfo.Team.TeamIndex )
    {
        //Explode(HitLocation,Normal(HitLocation-Other.Location));
		return;
    }

    if( Instigator != none )
    {
        OrigLoc = Instigator.Location;
    }

    if( !bDud && ((VSizeSquared(Location - OrigLoc) < ArmDistSquared) || OrigLoc == vect(0,0,0)) )
    {
        if( Role == ROLE_Authority )
        {
            AmbientSound=none;
            PlaySound(Sound'ProjectileSounds.PTRD_deflect04',,2.0);
            Other.TakeDamage( ImpactDamage, Instigator, HitLocation, Normal(Velocity), ImpactDamageType );
        }
        bDud = true;
        Velocity = vect(0,0,0);
        LifeSpan=1.0;
        SetPhysics(PHYS_Falling);
    }

    if( !bDud )
    {
	   Explode(HitLocation,Normal(HitLocation-Other.Location));
	}
	
	//Explode(HitLocation,Normal(HitLocation-Other.Location));
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

    if(  bOutOfPropellant && Physics != PHYS_Falling )
    {
         //log(" Projectile flew "$(VSize(OrigLoc - OuttaPropLocation)/50.0)$" meters before running out of juice");
         SetPhysics(PHYS_Falling);
    }

}

simulated function Landed( vector HitNormal )
{
    SetPhysics(PHYS_None);

    //if( !bDud )
    //{
	//   Explode(Location,HitNormal);
	//}
	//else
	//{
	//   Destroy();
	//}
	Explode(Location,HitNormal);
}

defaultproperties
{
     ProjectileClass=Class'BMTCustomMut.FM32FlameNade'
     ArmDistSquared=90000.000000
     ImpactDamage=100
     StraightFlightTime=0.250000
     AmbientVolumeScale=5.000000
     Speed=8000.000000
     MaxSpeed=8000.000000
     DamageRadius=0.000000
     MomentumTransfer=75000.000000
     MyDamageType=None
     DrawType=DT_StaticMesh
     bUpdateSimulatedPosition=True
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
