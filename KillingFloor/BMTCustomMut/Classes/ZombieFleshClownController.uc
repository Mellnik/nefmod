class ZombieFleshClownController extends FleshpoundZombieController;

/**
 *  bFindNewEnemy       true if the flehspound is searching for a new target
 *  bSmashDoor          true if the fleshpound smashed a door
 *  bStartled           true if the fleshpound tried to avoid a grenade
 *  bAttackedTarget     true if the fleshpound tried to attack 
 *  bMissTarget         true if any of the fleshpound's attacks missed
 */
var bool bFindNewEnemy, bSmashDoor, bStartled, bAttackedTarget, bMissTarget;

/**
 *  prevRageTimer       stores the time when the zombie exits the ZombieCharge state
 *  prevRageThreshold   stores the original rage threshold when the timer was reset
 */
var float prevRageTimer,prevRageThreshold;

function PostBeginPlay() {
    super.PostBeginPlay();
    bFindNewEnemy= false;
    bSmashDoor= false;
    bStartled= false;
    bAttackedTarget= false;
    bMissTarget= false;
    prevRageTimer= 0;
    prevRageThreshold= default.RageFrustrationThreshhold + (Frand() * 5); 
}

function bool FindNewEnemy() {
    bFindNewEnemy= true;
    return super.FindNewEnemy();
}

function BreakUpDoor(KFDoorMover Other, bool bTryDistanceAttack) {
    bSmashDoor= true;
    super.BreakUpDoor(Other,bTryDistanceAttack);
}

function Startle(Actor Feared) {
    bStartled= True;
    super.Startle(Feared);
}

/**
 *  Overwrite the default ZombieCharge state so it pauses the rage timer 
 *  under cetain conditions
 */
state ZombieCharge {
    function Tick( float Delta ) {
        super.Tick(Delta);
    }

    function bool StrafeFromDamage(float Damage, class<DamageType> DamageType, bool bFindDest) {
        return super.StrafeFromDamage(Damage, DamageType, bFindDest);
    }

    function bool TryStrafe(vector sideDir) {
        return super.TryStrafe(sideDir);
    }

    function Timer() {
        super.Timer();
    }

    function BeginState() {
        super.BeginState();
        /**
         *  Do not reset the timer if the fleshpound did not smash a door, 
         *  attacked and "missed" the target, was searching for a new target, 
         *  or tried to avoid a grenade
         */
        if (!bSmashDoor && ((bAttackedTarget && bMissTarget) 
            || bFindNewEnemy || bStartled)) {
            RageFrustrationTimer= prevRageTimer;
            RageFrustrationThreshhold= prevRageThreshold;
        }
        bFindNewEnemy= false;
        bSmashDoor= false;
        bStartled= false;
        bAttackedTarget= false;
        bMissTarget= false;
    }

    function EndState() {
        prevRageTimer= RageFrustrationTimer;
        prevRageThreshold= RageFrustrationThreshhold;
    }

WaitForAnim:

    if ( Monster(Pawn).bShotAnim ) {
        Goto('Moving');
    }
    if ( !FindBestPathToward(Enemy, false,true) )
        GotoState('ZombieRestFormation');
Moving:
    MoveToward(Enemy);
    WhatToDoNext(17);
    if ( bSoaking )
        SoakStop("STUCK IN CHARGING!");
}

defaultproperties
{
}
