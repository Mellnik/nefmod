// Zombie Monster for KF Invasion gametype
class ZombieKamikazeClot extends ZombieClot;

#exec OBJ LOAD FILE=PlayerSounds.uax
#exec OBJ LOAD FILE=KF_Freaks_Trip.ukx
#exec OBJ LOAD FILE=KF_Specimens_Trip_T.utx

var     KFPawn  DisabledPawn;           // The pawn that has been disabled by this zombie's grapple
var     bool    bGrappling;             // This zombie is grappling someone
var     bool    bHasBlownwup;             // This zombie is grappling someone
var     float   GrappleEndTime;         // When the current grapple should be over
var()   float   GrappleDuration;        // How long a grapple by this zombie should last

var float   ClotGrabMessageDelay;   // Amount of time between a player saying "I've been grabbed" message

var     ExplosiveXbowEmitter   BombLight;          // Flashing light
var()   vector          BombLightOffset;    // Offset for flashing light


replication
{
    reliable if(bNetDirty && Role == ROLE_Authority)
        bGrappling;
}

event PreBeginPlay()
{
    if ( Level.NetMode != NM_DedicatedServer)
    {
        BombLight = Spawn(class'ExplosiveXbowEmitter',self);
        BombLight.SetBase(self);
    }
    
    Super.PreBeginPlay();

    CalcAmbientRelevancyScale();
}

simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);

    if( bShotAnim && Role == ROLE_Authority )
    {
        if( LookTarget!=None )
        {
            Acceleration = AccelRate * Normal(LookTarget.Location - Location);
            Explode(Location,Location);
        }
    }

    if( Role == ROLE_Authority && bGrappling )
    {
        if( Level.TimeSeconds > GrappleEndTime )
        {
            bGrappling = false;
        }
    }

    // if we move out of melee range, stop doing the grapple animation
    if( bGrappling && LookTarget != none )
    {
        if( VSize(LookTarget.Location - Location) > MeleeRange + CollisionRadius + LookTarget.CollisionRadius )
        {
            bGrappling = false;
            AnimEnd(1);
        }
    }
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
    if( DisabledPawn != none )
    {
         DisabledPawn.bMovementDisabled = false;
         DisabledPawn = none;
    }
    
    Explode(Location,Location);
    if ( BombLight != none )
                BombLight.Destroy();
    super.Died(Killer, damageType, HitLocation);

}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    //bHasBlown=true;
    
    if(!bHasBlownwup)
    {
    Spawn(Class'BMTCustomMut.ZombieKamikazeClotProj',,, HitLocation, rotator(vect(0,0,1)));
    //Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
    bHasBlownwup=true;
    }
    /*
    if ( Role == ROLE_Authority )
    {
        MakeNoise(1.0);
        Spawn(class'KFMod.FlameImpact',,, HitLocation, rotator(vect(0,0,1)));
        TakeDamage( 100000, Self, Location, Velocity, Class'KFMod.DamTypeBleedOut');
        Destroy();
    }
    */
}

//-------------------------------------------------------------------------------
// NOTE: All Code resides in the child class(this class was only created to
//         eliminate hitching caused by loading default properties during play)
//-------------------------------------------------------------------------------

defaultproperties
{
     GrappleDuration=1.500000
     ClotGrabMessageDelay=12.000000
     GroundSpeed=155.000000
     WaterSpeed=155.000000
     MenuName="Kamikaze Clot"
     Mesh=SkeletalMesh'KF_Freaks_Trip_CIRCUS.clot_CIRCUS'
     Skins(0)=Combiner'KF_Specimens_Trip_CIRCUS_T.clot_CIRCUS.clot_CIRCUS_CMB'
}
