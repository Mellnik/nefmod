//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieFleshClown extends ZombieFleshPound;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax
//#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_CIRCUS.uax
#exec OBJ LOAD FILE=KF_Specimens_Trip_CIRCUS_T.utx

//From Scary Ghost's Super Zombie Mut
/**
 *  rageDamage          accumulator that stores how much damage the fleshpound did when enraged
 *  rageDamageLimit     the limit that the accumulator must exceed so the fleshpound will not rage again
 *  rageShield          accumulator that stores how much shield damage the fleshpound did when enraged
 *  rageShieldLimit     the limit the shield accumulator must exceed so the fleshpound will not rage again
 */
var float rageDamage, rageDamageLimit, rageShield, rageShieldLimit;

/**
 *  totalDamageRageThreshold    max damage that the fleshpound can take before raging
 *  totalRageAccumulator        accumulator to store how much damage the fleshpound has taken
 */
var int totalDamageRageThreshold, totalRageAccumulator;

// changes colors on Device (notified in anim)
simulated function DeviceGoRed()
{
	Skins[0]= Shader'KF_Specimens_Trip_CIRCUS_T.pound_CIRCUS.pound_CIRCUS_Red_Shdr';
	Skins[1]= Shader'KFCharacters.FPRedBloomShader';
}

simulated function DeviceGoNormal()
{
	Skins[0] = Shader'KF_Specimens_Trip_CIRCUS_T.pound_CIRCUS.pound_CIRCUS_Amber_Shdr';
	Skins[1] = Shader'KFCharacters.FPAmberBloomShader';
}

//Scary ghost super fleshpound

simulated function PostBeginPlay() {
    super.PostBeginPlay();
    rageDamageLimit= Max(35.0*1.75*DifficultyDamageModifer(),1.0);
    rageShieldLimit= Max(45.0*DifficultyDamageModifer(),1.0);
    rageDamage= 0.0;
    rageShield= 0.0;
}

simulated function Tick(float DeltaTime) {
    super.Tick(DeltaTime);
}

/**
 *  Track if all the "hits" the swing animation made contact.  If not 
 *  bMissTarget will be set to true
 */
function bool MeleeDamageTarget(int hitdamage, vector pushdir) {
    local bool didIHit;
    
    didIHit= super.MeleeDamageTarget(hitdamage, pushdir);
    ZombieFleshClownController(Controller).bMissTarget= 
        ZombieFleshClownController(Controller).bMissTarget || !didIHit;
    return didIHit;
}

/**
 *  Check if the fleshpound was attacking a door or a person
 */
simulated event SetAnimAction(name NewAction) {
    super.SetAnimAction(newAction);
    ZombieFleshClownController(Controller).bAttackedTarget= 
        (NewAction == 'Claw') || (NewAction == 'DoorBash');
}

/**
 *  Overwrite the RageCharging state so the fleshpound will 
 *  rage again if he doesn't deal out enough damage.
 */
state RageCharging {
/**
 *  Not sure why we are Ignoring StartCharging()
 *  but best leave the code as is
 */
Ignores StartCharging;

    function PlayDirectionalHit(Vector HitLoc) {
        super.PlayDirectionalHit(HitLoc);
    }

    function bool CanGetOutOfWay() {
        return super.CanGetOutOfWay();
    }

    function bool CanSpeedAdjust() {
        return super.CanSpeedAdjust();
    }

    function BeginState() {
        super.BeginState();
    }

    function EndState() {
        super.EndState();
    }

    function Tick( float Delta ) {
        super.Tick(Delta);
    }

    function Bump( Actor Other ) {
        super.Bump(Other);
    }

    function bool MeleeDamageTarget(int hitdamage, vector pushdir) {
        local bool RetVal,bWasEnemy;
        local float oldEnemyHealth, oldEnemyShield;
        local bool bAttackingHuman;

        //Only rage again if he was attacking a human
        bAttackingHuman= (KFHumanPawn(Controller.Target) != none);

        if (bAttackingHuman) {
            oldEnemyHealth= KFHumanPawn(Controller.Target).Health;
            oldEnemyShield= KFHumanPawn(Controller.Target).ShieldStrength;
        }

        bWasEnemy = (Controller.Target==Controller.Enemy);
        RetVal = Super(KFMonster).MeleeDamageTarget(hitdamage*1.75, pushdir*3);

        if (bAttackingHuman) {
            rageDamage+= oldEnemyHealth - KFHumanPawn(Controller.Target).Health;
            rageShield+= oldEnemyShield - KFHumanPawn(Controller.Target).ShieldStrength;
        }

       
        if(RetVal && bWasEnemy) {
            /**
             *  If we haven't reached our damage threshold, rage again, 
             *  otherwise reset the accumulators
             */
            if(bAttackingHuman && (oldEnemyShield <= 0.0 && rageDamage < rageDamageLimit || 
                (rageShield < rageShieldLimit && rageDamage < rageDamageLimit * 0.175))) {
                GotoState('RageAgain');
            } else {
                rageDamage= 0.0;
                rageShield= 0.0;
                GoToState('');
            }
        }

        return RetVal;
    }
}


/**
 *  Had to add this temporary state because on local hosts, enraged fp 
 *  attacks call MeleeDamageTarget twice
 */
state RageAgain {
    function BeginState() {
    }

    function EndState() {
    }

    function bool MeleeDamageTarget(int hitdamage, vector pushdir) {
        local bool RetVal,bWasEnemy;
        local float oldEnemyHealth, oldEnemyShield;
        local bool bAttackingHuman;

        bAttackingHuman= (KFHumanPawn(Controller.Target) != none);

        if (bAttackingHuman) {
            oldEnemyHealth= KFHumanPawn(Controller.Target).Health;
            oldEnemyShield= KFHumanPawn(Controller.Target).ShieldStrength;
        }

        bWasEnemy = (Controller.Target==Controller.Enemy);
        RetVal = Super(KFMonster).MeleeDamageTarget(hitdamage, pushdir*3);

        if (bAttackingHuman) {
            rageDamage+= oldEnemyHealth - KFHumanPawn(Controller.Target).Health;
            rageShield+= oldEnemyShield - KFHumanPawn(Controller.Target).ShieldStrength;
        }
       
        if(RetVal && bWasEnemy) {
            if(bAttackingHuman && (oldEnemyShield <= 0.0 && rageDamage < rageDamageLimit || 
                (rageShield < rageShieldLimit && rageDamage < rageDamageLimit * 0.175))) {
                StartCharging();
            } else {
                rageDamage= 0.0;
                rageShield= 0.0;
                GoToState('');
            }
        }

        return RetVal;
    }

Begin:
    if( Level.NetMode ==NM_DedicatedServer ) {
        StartCharging();
    }
}

defaultproperties
{
     totalDamageRageThreshold=1080
     MeleeDamage=15
     damageForce=5000
     SpinDamConst=8.000000
     SpinDamRand=8.000000
     PlayerCountHealthScale=0.200000
     PlayerNumHeadHealthScale=0.250000
     ScoringValue=220
     MenuName="FleshClown"
     ControllerClass=Class'BMTCustomMut.ZombieFleshClownController'
     Mesh=SkeletalMesh'KF_Freaks_Trip_CIRCUS.FleshPound_Circus'
     Skins(0)=Shader'KF_Specimens_Trip_CIRCUS_T.pound_CIRCUS.pound_CIRCUS_Amber_Shdr'
}
