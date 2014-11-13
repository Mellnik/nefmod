//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieFleshCracker extends ZombieFleshPound_XMas2;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax
//#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

var     KFPawn  DisabledPawn;           // The pawn that has been disabled by this zombie's grapple
var     bool    bGrappling;             // This zombie is grappling someone
var     float   GrappleEndTime;         // When the current grapple should be over
var()   float   GrappleDuration;        // How long a grapple by this zombie should last

var float   ClotGrabMessageDelay;   // Amount of time between a player saying "I've been grabbed" message

replication
{
    reliable if(bNetDirty && Role == ROLE_Authority)
        bGrappling;
}
// changes colors on Device (notified in anim)
simulated function DeviceGoRed()
{
    Skins[2]=Shader'KFCharacters.FPRedBloomShader';
}

simulated function DeviceGoNormal()
{
    Skins[2] = Shader'KFCharacters.FPAmberBloomShader';
}
function ClawDamageTarget()
{
    local vector PushDir;
    local KFPawn KFP;
    local float UsedMeleeDamage;


    if( MeleeDamage > 1 )
    {
       UsedMeleeDamage = (MeleeDamage - (MeleeDamage * 0.05)) + (MeleeDamage * (FRand() * 0.1));
    }
    else
    {
       UsedMeleeDamage = MeleeDamage;
    }

    // If zombie has latched onto us...
    if ( MeleeDamageTarget( UsedMeleeDamage, PushDir))
    {
        KFP = KFPawn(Controller.Target);

        PlaySound(MeleeAttackHitSound, SLOT_Interact, 1.25);

        if( !bDecapitated && KFP != none )
        {
            if ( KFPlayerReplicationInfo(KFP.PlayerReplicationInfo) == none ||
                 KFP.GetVeteran().static.CanBeGrabbed(KFPlayerReplicationInfo(KFP.PlayerReplicationInfo), self))
            {
                if( DisabledPawn != none )
                {
                     DisabledPawn.bMovementDisabled = false;
                }

                KFP.DisableMovement(GrappleDuration);
                DisabledPawn = KFP;
            }
        }
    }
}
simulated function int DoAnimAction( name AnimName )
{


    if( AnimName=='PoundAttack1' || AnimName=='PoundAttack2' || AnimName=='PoundAttack3')
    {
        AnimBlendParams(1, 1.0, 0.1,, FireRootBone);
        PlayAnim(AnimName,, 0.1, 1);

        // Randomly send out a message about Clot grabbing you(10% chance)
        if ( FRand() < 0.10 && LookTarget != none && KFPlayerController(LookTarget.Controller) != none &&
             VSizeSquared(Location - LookTarget.Location) < 2500 /* (MeleeRange + 20)^2 */ &&
             Level.TimeSeconds - KFPlayerController(LookTarget.Controller).LastClotGrabMessageTime > ClotGrabMessageDelay &&
             KFPlayerController(LookTarget.Controller).SelectedVeterancy != class'KFVetBerserker' )
        {
            PlayerController(LookTarget.Controller).Speech('AUTO', 11, "");
            KFPlayerController(LookTarget.Controller).LastClotGrabMessageTime = Level.TimeSeconds;
        }

        bGrappling = true;
        GrappleEndTime = Level.TimeSeconds + GrappleDuration;

        return 1;
    }

    return super.DoAnimAction( AnimName );
}

simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);

    // Keep the flesh pound moving toward its target when attacking
    if( Role == ROLE_Authority && bShotAnim)
    {
        if( LookTarget!=None )
        {
            Acceleration = AccelRate * Normal(LookTarget.Location - Location);
        }
    }
    if( Role == ROLE_Authority && bGrappling )
    {
        if( Level.TimeSeconds > GrappleEndTime )
        {
            bGrappling = false;
        }
    }
    
    if( bGrappling && LookTarget != none )
    {
        if( VSize(LookTarget.Location - Location) > MeleeRange + CollisionRadius + LookTarget.CollisionRadius )
        {
            bGrappling = false;
        }
    }
}

function RemoveHead()
{
    Super.RemoveHead();

    MeleeDamage *= 2;
    MeleeRange *= 2;

    if( DisabledPawn != none )
    {
         DisabledPawn.bMovementDisabled = false;
         DisabledPawn = none;
    }
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
    if( DisabledPawn != none )
    {
         DisabledPawn.bMovementDisabled = false;
         DisabledPawn = none;
    }

    super.Died(Killer, damageType, HitLocation);

}

simulated function Destroyed()
{
    if( AvoidArea!=None )
        AvoidArea.Destroy();

    super.Destroyed();

    if( DisabledPawn != none )
    {
         DisabledPawn.bMovementDisabled = false;
         DisabledPawn = none;
    }
}

defaultproperties
{
     GrappleDuration=1.500000
     ClotGrabMessageDelay=12.000000
     MeleeDamage=18
     SpinDamConst=10.000000
     SpinDamRand=10.000000
     PlayerCountHealthScale=0.200000
     PlayerNumHeadHealthScale=0.250000
     ScoringValue=350
     MenuName="Flesh Cracker"
}
