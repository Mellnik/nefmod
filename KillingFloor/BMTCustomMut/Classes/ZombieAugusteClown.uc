class ZombieAugusteClown extends ZombieBloat;

/**
 *  bAmIBarfing     true if the bloat is in the barf animation
 */
var bool bAmIBarfing;

/**
 *  bileCoolDownTimer   timer that counts to when the bloat will spawn another set of pile pellets
 *  bileCoolDownMax     max time in between pellet spawns
 */
var float bileCoolDownTimer,bileCoolDownMax;

simulated function BeginPlay()
{
	LinkSkelAnim(MeshAnimation'Bloat_Anim');
	Super.BeginPlay();
}

simulated function PostBeginPlay() {
    super.PostBeginPlay();
    bAmIBarfing= false;
    bileCoolDownTimer= 0.0;
}

/**
 *  Spawn extra sets of bile pellets here once the bile cool down timer
 *  has reached the max limit
 */
simulated function Tick(float DeltaTime) {
    super.Tick(DeltaTime);
    if(!bDecapitated && bAmIBarfing) {
        bileCoolDownTimer+= DeltaTime;
        if(bileCoolDownTimer >= bileCoolDownMax) {
            SpawnTwoShots();
            bileCoolDownTimer= 0.0;
        }
    }
}

function RangedAttack(Actor A) {
    local int LastFireTime;

    if ( bShotAnim )
        return;

    if ( Physics == PHYS_Swimming ) {
        SetAnimAction('Claw');
        bShotAnim = true;
        LastFireTime = Level.TimeSeconds;
    }
    else if ( VSize(A.Location - Location) < MeleeRange + CollisionRadius + A.CollisionRadius ) {
        bShotAnim = true;
        LastFireTime = Level.TimeSeconds;
        SetAnimAction('Claw');
        //PlaySound(sound'Claw2s', SLOT_Interact); KFTODO: Replace this
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
    }
    else if ( (KFDoorMover(A) != none || VSize(A.Location-Location) <= 250) && !bDecapitated ) {
        bShotAnim = true;
        SetAnimAction('ZombieBarfMoving');
        RunAttackTimeout = GetAnimDuration('ZombieBarf', 1.0);
        bMovingPukeAttack=true;

        // Randomly send out a message about Bloat Vomit burning(3% chance)
        if ( FRand() < 0.03 && KFHumanPawn(A) != none && PlayerController(KFHumanPawn(A).Controller) != none ) {
            PlayerController(KFHumanPawn(A).Controller).Speech('AUTO', 7, "");
        }
    }
}

//ZombieBarf animation triggers this
function SpawnTwoShots() {
    super.SpawnTwoShots();
    bAmIBarfing= true;
}

simulated function AnimEnd(int Channel) {
    local name  Sequence;
    local float Frame, Rate;


    GetAnimParams( ExpectingChannel, Sequence, Frame, Rate );

    super.AnimEnd(Channel);
    
    if(Sequence == 'ZombieBarf')
        bAmIBarfing= false;
}

defaultproperties
{
     bileCoolDownMax=0.750000
     MenuName="Auguste The Clown"
     Mesh=SkeletalMesh'KF_Freaks_Trip_CIRCUS.bloat_CIRCUS'
     Skins(0)=Combiner'KF_Specimens_Trip_CIRCUS_T.bloat_CIRCUS.bloat_clown_cmb'
}
