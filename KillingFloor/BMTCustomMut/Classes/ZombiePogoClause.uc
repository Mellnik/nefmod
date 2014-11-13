//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombiePogoClause extends ZombieStalker_XMas2;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax
//#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

var float           DodgeJumpGroundSpeedMult;
var float           DodgeJumpForwardMomentum;
var float           DodgeJumpUpwardMomentum;
//var float           DodgeJumpMaxAngle;

var float           DodgeJumpMinRangeSq;
var float           DodgeJumpBaseDelay;
var float           DodgeJumpMaxExtraDelay;
var float           NextDodgeJumpTime;


function bool DoJump(bool bUpdating)
{
    local bool jumpSucceeded;
    jumpSucceeded = super.DoJump(bUpdating);
    if (jumpSucceeded)
        NextDodgeJumpTime = Level.TimeSeconds + DodgeJumpBaseDelay + FRand() * DodgeJumpMaxExtraDelay;
    return jumpSucceeded;
}

simulated function PerformDodgeJump()
{
    local float currentYawRadians;
    local float newYawRadians;
    local float dodgeAngle;

    if (!bIsCrouched && !bWantsToCrouch && Physics == PHYS_Walking)
    {
        if (Role == ROLE_Authority)
        {
            if (Level.Game != None && Level.Game.GameDifficulty > 2)
                MakeNoise(0.1 * Level.Game.GameDifficulty);
            if (bCountJumps && Inventory != None)
                Inventory.OwnerEvent('Jumped');
        }

        dodgeAngle = pi * 0.5 * (FRand() - 0.5);
        currentYawRadians = float(Rotation.Yaw & 0xFFFF) / 32768.0 * pi;
        newYawRadians = currentYawRadians + dodgeAngle;

        // Rotate current velocity in the dodge direction, and add a small boost forwards
        Velocity.X = DodgeJumpForwardMomentum * Cos(currentYawRadians) + OriginalGroundSpeed * DodgeJumpGroundSpeedMult * Cos(newYawRadians);
        Velocity.Y = DodgeJumpForwardMomentum * Sin(currentYawRadians) + OriginalGroundSpeed * DodgeJumpGroundSpeedMult * Sin(newYawRadians);
        Velocity.Z = DodgeJumpUpwardMomentum;

        if (Base != None && !Base.bWorldGeometry)
            Velocity += Base.Velocity;

        SetPhysics(PHYS_Falling);
        NextDodgeJumpTime = Level.TimeSeconds + DodgeJumpBaseDelay + FRand() * DodgeJumpMaxExtraDelay;
    }
}

// Mostly a copy of ZombieGorefast.RunningState.RangedAttack(Actor) with the charge chance and state change timer removed.
// Overridden because the default implementation kills acceleration, stopping movement.
function RangedAttack(Actor TargetActor)
{
    // The Gorefast version also prevents attacks while swimming, but I'll leave that out
    // unless we find a compelling reason to put it in.
    if (!bShotAnim && CanAttack(TargetActor))
    {
        bShotAnim = true;
        SetAnimAction('Claw');
    }
}

simulated event SetAnimAction(name NewAction)
{
    local int meleeAnimIndex;

    // Generic "attack" AnimAction; replace with a specific one here because
    // the superclass code that normally does it won't be called
    if (NewAction == 'Claw')
    {
        meleeAnimIndex = Rand(3);
        NewAction = meleeAnims[meleeAnimIndex];
        CurrentDamType = ZombieDamType[meleeAnimIndex];
    }

    if (NewAction == meleeAnims[0] || NewAction == meleeAnims[1] || NewAction == meleeAnims[2])
    {
        UncloakStalker();

        // Running attack - animate upper body only
        AnimBlendParams(1, 1.0, 0.0,, FireRootBone);
        PlayAnim(NewAction,, 0.1, 1);
        ExpectingChannel = 1; // apparently this channel is always used for attacks

        // More housekeeping usually done in superclass code
        // (Why the Gorefast code excludes client-side execution of this stuff, I don't know,
        // but I can't be bothered finding out the hard way... replication response issue?)
        if (Level.NetMode != NM_Client)
        {
            AnimAction = NewAction;
            bResetAnimAct = true;
            ResetAnimActTime = Level.TimeSeconds + GetAnimDuration(NewAction, 1.0);
        }
    }
    else
        super.SetAnimAction(NewAction);
}

defaultproperties
{
     DodgeJumpGroundSpeedMult=1.000000
     DodgeJumpForwardMomentum=75.000000
     DodgeJumpUpwardMomentum=280.000000
     DodgeJumpMinRangeSq=10000.000000
     DodgeJumpBaseDelay=1.200000
     DodgeJumpMaxExtraDelay=0.600000
     GroundSpeed=250.000000
     WaterSpeed=210.000000
     MenuName="Pogo Clause"
}
