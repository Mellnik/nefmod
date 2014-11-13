class ZombieTankFleshpound extends ZombieFleshpoundBase;



//----------------------------------------------------------------------------
// NOTE: All Variables are declared in the base class to eliminate hitching
//----------------------------------------------------------------------------

simulated function PostNetBeginPlay()
{
    if (AvoidArea == None)
        AvoidArea = Spawn(class'FleshPoundAvoidArea',self);
    if (AvoidArea != None)
        AvoidArea.InitFor(Self);

    EnableChannelNotify ( 1,1);
    AnimBlendParams(1, 1.0, 0.0,, SpineBone1);
    super.PostNetBeginPlay();
	
    super.PostNetBeginPlay();
	SetHeadScale(1.1);
    SetBoneScale(1,1.2,'rarm'); //let's put some big beefy arms on there...
	SetBoneScale(2,1.2,'larm');
	SetBoneScale(5,1.5,'righthand');
	SetBoneScale(6,1.5,'lefthand');
	SetBoneScale(7,1.5,'rshoulder');
	SetBoneScale(8,1.5,'lshoulder');
	SetBoneScale(12,1.5,'rfarm');
	SetBoneScale(13,1.5,'lfarm');
	SetBoneScale(14,1.5,'lthigh');
	SetBoneScale(15,1.5,'rthigh');
	SetBoneScale(3,1.3,'rleg');
	SetBoneScale(4,1.3,'lleg');
}

// This zed has been taken control of. Boost its health and speed
function SetMindControlled(bool bNewMindControlled)
{
    if( bNewMindControlled )
    {
        NumZCDHits++;

        // if we hit him a couple of times, make him rage!
        if( NumZCDHits > 1 )
        {
            if( !IsInState('ChargeToMarker') )
            {
                GotoState('ChargeToMarker');
            }
            else
            {
                NumZCDHits = 1;
                if( IsInState('ChargeToMarker') )
                {
                    GotoState('');
                }
            }
        }
        else
        {
            if( IsInState('ChargeToMarker') )
            {
                GotoState('');
            }
        }

        if( bNewMindControlled != bZedUnderControl )
        {
            GroundSpeed = OriginalGroundSpeed * 1.35;
            Health *= 1.25;
            HealthMax *= 1.25;
        }
    }
    else
    {
        NumZCDHits=0;
    }

    bZedUnderControl = bNewMindControlled;
}

// Handle the zed being commanded to move to a new location
function GivenNewMarker()
{
    if( bChargingPlayer && NumZCDHits > 1  )
    {
        GotoState('ChargeToMarker');
    }
    else
    {
        GotoState('');
    }
}

// Important Block of code controlling how the Zombies (excluding the Bloat and Fleshpound who cannot be stunned, respond to damage from the
// various weapons in the game. The basic rule is that any damage amount equal to or greater than 40 points will cause a stun.
// There are exceptions with the fists however, which are substantially under the damage quota but can still cause stuns 50% of the time.
// Why? Cus if they didn't at least have that functionality, they would be fundamentally useless. And anyone willing to take on a hoarde of zombies
// with only the gloves on his hands, deserves more respect than that!
function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
    if( Level.TimeSeconds - LastPainAnim < MinTimeBetweenPainAnims )
        return;

    // Don't interrupt the controller if its waiting for an animation to end
    if( !Controller.IsInState('WaitForAnim') && Damage >= 10 )
        PlayDirectionalHit(HitLocation);

    LastPainAnim = Level.TimeSeconds;

    if( Level.TimeSeconds - LastPainSound < MinTimeBetweenPainSounds )
        return;

    LastPainSound = Level.TimeSeconds;
    PlaySound(HitSound[0], SLOT_Pain,1.25,,400);
}

// changes colors on Device (notified in anim)
simulated function DeviceGoRed()
{
    Skins[1]=Shader'KFCharacters.FPRedBloomShader';
}

simulated function DeviceGoNormal()
{
    Skins[1] = Shader'KFCharacters.FPAmberBloomShader';
}

function RangedAttack(Actor A)
{
    if ( bShotAnim || Physics == PHYS_Swimming)
        return;
    else if ( CanAttack(A) )
    {
        bShotAnim = true;
        SetAnimAction('Claw');
        //PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
        return;
    }
}

// Sets the FP in a berserk charge state until he either strikes his target, or hits timeout
function StartCharging()
{
    local float RageAnimDur;

    SetAnimAction('PoundRage');
    Acceleration = vect(0,0,0);
    bShotAnim = true;
    Velocity.X = 0;
    Velocity.Y = 0;
    Controller.GoToState('WaitForAnim');
    KFMonsterController(Controller).bUseFreezeHack = True;
    RageAnimDur = GetAnimDuration('PoundRage');
    FleshpoundZombieController(Controller).SetPoundRageTimout(RageAnimDur);
    GoToState('BeginRaging');
}

state BeginRaging
{
    Ignores StartCharging;

    function bool CanGetOutOfWay()
    {
        return false;
    }

    simulated function bool HitCanInterruptAction()
    {
        return false;
    }

    function Tick( float Delta )
    {
        Acceleration = vect(0,0,0);

        global.Tick(Delta);
    }

Begin:
    Sleep(GetAnimDuration('PoundRage'));
    GotoState('RageCharging');
}


simulated function SetBurningBehavior()
{
    if( bFrustrated || bChargingPlayer )
    {
        return;
    }

    super.SetBurningBehavior();
}

state RageCharging
{
Ignores StartCharging;

    function PlayDirectionalHit(Vector HitLoc)
    {
        if( !bShotAnim )
        {
            super.PlayDirectionalHit(HitLoc);
        }
    }

    function bool CanGetOutOfWay()
    {
        return false;
    }

    // Don't override speed in this state
    function bool CanSpeedAdjust()
    {
        return false;
    }

    function BeginState()
    {

        bChargingPlayer = true;
        if( Level.NetMode!=NM_DedicatedServer )
            ClientChargingAnims();

        RageEndTime = (Level.TimeSeconds + 5 + Rand(5));
        NetUpdateTime = Level.TimeSeconds - 1;
    }

    function EndState()
    {
        bChargingPlayer = False;
        bFrustrated = false;

        FleshPoundZombieController(Controller).RageFrustrationTimer = 0;

        if( Health>0 )
        {
            GroundSpeed = GetOriginalGroundSpeed();
        }

        if( Level.NetMode!=NM_DedicatedServer )
            ClientChargingAnims();

        NetUpdateTime = Level.TimeSeconds - 1;
    }

    function Tick( float Delta )
    {
        if( !bShotAnim )
        {
            GroundSpeed = OriginalGroundSpeed * 10.0;//2.0;
            if( !bFrustrated && !bZedUnderControl && Level.TimeSeconds>RageEndTime )
            {
                GoToState('');
            }
        }

        // Keep the flesh pound moving toward its target when attacking
        if( Role == ROLE_Authority && bShotAnim)
        {
            if( LookTarget!=None )
            {
                Acceleration = AccelRate * Normal(LookTarget.Location - Location);
            }
        }

        global.Tick(Delta);
    }

    function Bump( Actor Other )
    {
        local float RageBumpDamage;
        local KFMonster KFMonst;

        KFMonst = KFMonster(Other);

        // Hurt/Kill enemies that we run into while raging
        if( !bShotAnim && KFMonst!=None && ZombieFleshPound(Other)==None && Pawn(Other).Health>0 )
        {
            // Random chance of doing obliteration damage
            if( FRand() < 0.4 )
            {
                 RageBumpDamage = 501;
            }
            else
            {
                 RageBumpDamage = 450;
            }

            RageBumpDamage *= KFMonst.PoundRageBumpDamScale;

            Other.TakeDamage(RageBumpDamage, self, Other.Location, Velocity * Other.Mass, class'DamTypePoundCrushed');
        }
        else Global.Bump(Other);
    }
    // If fleshie hits his target on a charge, then he should settle down for abit.
    function bool MeleeDamageTarget(int hitdamage, vector pushdir)
    {
        local bool RetVal,bWasEnemy;

        bWasEnemy = (Controller.Target==Controller.Enemy);
        RetVal = Super.MeleeDamageTarget(hitdamage*1.75, pushdir*3);
        if( RetVal && bWasEnemy )
            //GoToState('');
        return RetVal;
    }
}

// State where the zed is charging to a marked location.
// Not sure if we need this since its just like RageCharging,
// but keeping it here for now in case we need to implement some
// custom behavior for this state
state ChargeToMarker extends RageCharging
{
Ignores StartCharging;

    function Tick( float Delta )
    {
        if( !bShotAnim )
        {
            GroundSpeed = OriginalGroundSpeed * 2.3;
            if( !bFrustrated && !bZedUnderControl && Level.TimeSeconds>RageEndTime )
            {
                GoToState('');
            }
        }

        // Keep the flesh pound moving toward its target when attacking
        if( Role == ROLE_Authority && bShotAnim)
        {
            if( LookTarget!=None )
            {
                Acceleration = AccelRate * Normal(LookTarget.Location - Location);
            }
        }

        global.Tick(Delta);
    }
}

simulated function PostNetReceive()
{
    if( bClientCharge!=bChargingPlayer )
    {
        bClientCharge = bChargingPlayer;
        if (bChargingPlayer)
        {
            MovementAnims[0]=ChargingAnim;
            MeleeAnims[0]='FPRageAttack';
            MeleeAnims[1]='FPRageAttack';
            MeleeAnims[2]='FPRageAttack';
            DeviceGoRed();
        }
        else
        {
            MovementAnims[0]=default.MovementAnims[0];
            MeleeAnims[0]=default.MeleeAnims[0];
            MeleeAnims[1]=default.MeleeAnims[1];
            MeleeAnims[2]=default.MeleeAnims[2];
            DeviceGoNormal();
        }
    }
}

simulated function PlayDyingAnimation(class<DamageType> DamageType, vector HitLoc)
{
    Super.PlayDyingAnimation(DamageType,HitLoc);
    if( Level.NetMode!=NM_DedicatedServer )
        DeviceGoNormal();
}

simulated function ClientChargingAnims()
{
    PostNetReceive();
}

function ClawDamageTarget()
{
    local vector PushDir;
    local KFHumanPawn HumanTarget;
    local KFPlayerController HumanTargetController;
    local float UsedMeleeDamage;
    local name  Sequence;
    local float Frame, Rate;

    GetAnimParams( ExpectingChannel, Sequence, Frame, Rate );

    if( MeleeDamage > 1 )
    {
       UsedMeleeDamage = (MeleeDamage - (MeleeDamage * 0.05)) + (MeleeDamage * (FRand() * 0.1));
    }
    else
    {
       UsedMeleeDamage = MeleeDamage;
    }

    // Reduce the melee damage for anims with repeated attacks, since it does repeated damage over time
    if( Sequence == 'PoundAttack1' )
    {
        UsedMeleeDamage *= 0.5;
    }
    else if( Sequence == 'PoundAttack2' )
    {
        UsedMeleeDamage *= 0.25;
    }

    if(Controller!=none && Controller.Target!=none)
    {
        //calculate based on relative positions
        PushDir = (damageForce * Normal(Controller.Target.Location - Location));
    }
    else
    {
        //calculate based on way Monster is facing
        PushDir = damageForce * vector(Rotation);
    }
    if ( MeleeDamageTarget( UsedMeleeDamage, PushDir))
    {
        HumanTarget = KFHumanPawn(Controller.Target);
        if( HumanTarget!=None )
            HumanTargetController = KFPlayerController(HumanTarget.Controller);
        if( HumanTargetController!=None )
            HumanTargetController.ShakeView(RotMag, RotRate, RotTime, OffsetMag, OffsetRate, OffsetTime);
        PlaySound(MeleeAttackHitSound, SLOT_Interact, 1.25);
    }
}

function SpinDamage(actor Target)
{
    local vector HitLocation;
    local Name TearBone;
    local Float dummy;
    local float DamageAmount;
    local vector PushDir;
    local KFHumanPawn HumanTarget;

    if(target==none)
        return;

    PushDir = (damageForce * Normal(Target.Location - Location));
    damageamount = (SpinDamConst + rand(SpinDamRand) );

    // FLING DEM DEAD BODIEZ!
    if (Target.IsA('KFHumanPawn') && Pawn(Target).Health <= DamageAmount)
    {
        KFHumanPawn(Target).RagDeathVel *= 3;
        KFHumanPawn(Target).RagDeathUpKick *= 1.5;
    }

    if (Target !=none && Target.IsA('KFDoorMover'))
    {
        Target.TakeDamage(DamageAmount , self ,HitLocation,pushdir, class 'KFmod.ZombieMeleeDamage');
        PlaySound(MeleeAttackHitSound, SLOT_Interact, 1.25);
    }

    if (KFHumanPawn(Target)!=none)
    {
        HumanTarget = KFHumanPawn(Target);
        if (HumanTarget.Controller != none)
            HumanTarget.Controller.ShakeView(RotMag, RotRate, RotTime, OffsetMag, OffsetRate, OffsetTime);

        //TODO - line below was KFPawn. Does this whole block need to be KFPawn, or is it OK as KFHumanPawn?
        KFHumanPawn(Target).TakeDamage(DamageAmount, self ,HitLocation,pushdir, class 'KFmod.ZombieMeleeDamage');

        if (KFHumanPawn(Target).Health <=0)
        {
            KFHumanPawn(Target).SpawnGibs(rotator(pushdir), 1);
            TearBone=KFPawn(Target).GetClosestBone(HitLocation,Velocity,dummy);
            KFHumanPawn(Controller.Target).HideBone(TearBone);
        }
    }
}

simulated function int DoAnimAction( name AnimName )
{
    if( AnimName=='PoundAttack1' || AnimName=='PoundAttack2' || AnimName=='PoundAttack3'
        ||AnimName=='FPRageAttack' || AnimName=='ZombieFireGun' )
    {
        AnimBlendParams(1, 1.0, 0.0,, FireRootBone);
        PlayAnim(AnimName,, 0.1, 1);
        Return 1;
    }
    Return Super.DoAnimAction(AnimName);
}

simulated event SetAnimAction(name NewAction)
{
    local int meleeAnimIndex;

    if( NewAction=='' )
        Return;
    if(NewAction == 'Claw')
    {
        meleeAnimIndex = Rand(3);
        NewAction = meleeAnims[meleeAnimIndex];
        CurrentDamtype = ZombieDamType[meleeAnimIndex];
    }
    else if( NewAction == 'DoorBash' )
    {
       CurrentDamtype = ZombieDamType[Rand(3)];
    }
    ExpectingChannel = DoAnimAction(NewAction);

    if( AnimNeedsWait(NewAction) )
    {
        bWaitForAnim = true;
    }

    if( Level.NetMode!=NM_Client )
    {
        AnimAction = NewAction;
        bResetAnimAct = True;
        ResetAnimActTime = Level.TimeSeconds+0.3;
    }
}

// The animation is full body and should set the bWaitForAnim flag
simulated function bool AnimNeedsWait(name TestAnim)
{
    if( TestAnim == 'PoundRage' || TestAnim == 'DoorBash' )
    {
        return true;
    }

    return false;
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
}


function bool FlipOver()
{
    Return False;
}

function bool SameSpeciesAs(Pawn P)
{
    return (ZombieFleshPound(P)!=None);
}

simulated function Destroyed()
{
    if( AvoidArea!=None )
        AvoidArea.Destroy();

    Super.Destroyed();
}

defaultproperties
{
     RageDamageThreshold=1500
     BleedOutDuration=14.000000
     damageForce=100000
     SpinDamConst=10.000000
     SpinDamRand=15.000000
     ColOffset=(Z=70.000000)
     ColRadius=35.000000
     ColHeight=120.000000
     PlayerCountHealthScale=0.300000
     OnlineHeadshotOffset=(Z=180.000000)
     OnlineHeadshotScale=2.000000
     HeadHealth=6000.000000
     ScoringValue=400
     MeleeRange=96.250000
     GroundSpeed=40.000000
     WaterSpeed=35.000000
     HealthMax=10000.000000
     Health=10000
     MenuName="Tank Flesh Pound"
     DrawScale=1.400000
     PrePivot=(Z=80.000000)
}
