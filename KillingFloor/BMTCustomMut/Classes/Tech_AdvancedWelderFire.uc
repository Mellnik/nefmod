class Tech_AdvancedWelderFire extends WeldFire;



#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"


var KFHumanPawn     CachedHealee;
var float           FastArmourRepairRate, SlowArmourRepairRate;
var float           ArmourRepairRateThreshold;
var float           MaxArmourRepairThreshold;

var Pawn            OtherTarget;
var float           MachineRepairRate;


simulated function bool AllowFire()
{
    local KFDoorMover WeldTarget;
    WeldTarget = GetDoor();

    // Can't use welder, if no door.
    if ( WeldTarget == none && !CanFindHealee() && !CanFindOtherTarget())
    {
        if ( KFPlayerController(Instigator.Controller) != none )
        {
            KFPlayerController(Instigator.Controller).CheckForHint(54);

            if ( FailTime + 0.5 < Level.TimeSeconds )
            {
                PlayerController(Instigator.Controller).ClientMessage(NoWeldTargetMessage, 'CriticalEvent');
                
                FailTime = Level.TimeSeconds;
            }

        }
        return false;
    }
    if(WeldTarget != none && WeldTarget.bDisallowWeld)
    {
        if( PlayerController(Instigator.controller)!=None )
        {
            PlayerController(Instigator.controller).ClientMessage(CantWeldTargetMessage, 'CriticalEvent');
            
            }

        return false;
    }

    return Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire ;

}

// Can we find someone to heal
function bool CanFindHealee()
{
    local KFHumanPawn Healtarget;

    Healtarget = GetHealee();
    CachedHealee = Healtarget;

    // Can't use syringe if we can't find a target
    if ( Healtarget == none )
    {
        return false;
    }

    // Can't use syringe if our target is already being healed to full health.
    if ( Healtarget.ShieldStrength == 100 )
    {
        return false;
    }

    return true;
}

function KFHumanPawn GetHealee()
{
    local KFHumanPawn KFHP, BestKFHP;
    local vector Dir;
    local float TempDot, BestDot;
    local vector Dummy,End,Start;

    Dir = vector(Instigator.GetViewRotation());

    foreach Instigator.VisibleCollidingActors(class'KFHumanPawn', KFHP, 80.0)
    {
        if ( KFHP.ShieldStrength < 100 )
        {
            TempDot = Dir dot (KFHP.Location - Instigator.Location);
            if ( TempDot > 0.7 && TempDot > BestDot )
            {
                BestKFHP = KFHP;
                BestDot = TempDot;
            }
        }
    }

    Start = Instigator.Location+Instigator.EyePosition();
    End = Start+vector(Instigator.GetViewRotation())*weaponRange;
    Instigator.bBlockHitPointTraces = false;
    Instigator.Trace(Dummy,Dummy,End,Start,True);
    return BestKFHP;
}

function bool CanFindOtherTarget()
{
    local Actor A;
    local vector Dummy,End,Start;

    if( AIController(Instigator.Controller)!=None )
        A = Instigator.Controller.Target;
    else
    {
        Start = Instigator.Location+Instigator.EyePosition();
        End = Start+vector(Instigator.GetViewRotation())*weaponRange;
        Instigator.bBlockHitPointTraces = false;
        A = Instigator.Trace(Dummy,Dummy,End,Start,True);
        Instigator.bBlockHitPointTraces = Instigator.default.bBlockHitPointTraces;
    }
    
    return IsAcceptableHealthRepairTarget(A) || KFMonster(A) != none || ExtendedZCollision(A) != none;
}

// Can the welder repair the target's health (not armour)?
// Should only be true for mechanical targets - vehicles, turrets, etc.
// Update this function if ever a new turret type is added.
function bool IsAcceptableHealthRepairTarget(Actor Other)
{
    // N/B: The Portal and USCM Turrets are subclasses of Vehicle
    return Other != none &&
        (Other.IsA('Vehicle') || Other.IsA('Tech_DoomSentry') || Other.IsA('MedSentry') ||
    Other.IsA('Tech_USCMSentry') || Other.IsA('Tech_Sentry') || Other.IsA('PTurret') );
}

simulated function Timer()
{
    local KFPlayerReplicationInfo KFPRI;
    local Actor HitActor;
    local vector StartTrace, EndTrace, HitLocation, HitNormal,AdjustedLocation;
    local rotator PointRot;
    local int MyDamage;
    local float PerkBonusMultiplier;
    
    
    If( !KFWeapon(Weapon).bNoHit )
    {
        KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
        if (KFPRI != none && KFPRI.ClientVeteranSkill != none)
            PerkBonusMultiplier = KFPRI.ClientVeteranSkill.static.GetWeldSpeedModifier(KFPRI);
        else
            PerkBonusMultiplier = 1.0f;

        PointRot = Instigator.GetViewRotation();
        StartTrace = Instigator.Location + Instigator.EyePosition();

        if( AIController(Instigator.Controller)!=None && Instigator.Controller.Target!=None )
        {
            EndTrace = StartTrace + vector(PointRot)*weaponRange;
            Weapon.bBlockHitPointTraces = false;
            HitActor = Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);
            Weapon.bBlockHitPointTraces = Weapon.default.bBlockHitPointTraces;

            if( HitActor==None )
            {
                EndTrace = Instigator.Controller.Target.Location;
                Weapon.bBlockHitPointTraces = false;
                HitActor = Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);
                Weapon.bBlockHitPointTraces = Weapon.default.bBlockHitPointTraces;
            }
            if( HitActor==None )
                HitLocation = Instigator.Controller.Target.Location;
            HitActor = Instigator.Controller.Target;
        }
        else
        {
            EndTrace = StartTrace + vector(PointRot)*weaponRange;
            Weapon.bBlockHitPointTraces = false;
            HitActor = Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);
            Weapon.bBlockHitPointTraces = Weapon.default.bBlockHitPointTraces;
        }

        LastHitActor = KFDoorMover(HitActor);

        if (ExtendedZCollision(HitActor) != none)
            HitActor = HitActor.Owner;

        if( LastHitActor!=none && Level.NetMode!=NM_Client )
        {
            MyDamage = float(MeleeDamage + Rand(MaxAdditionalDamage)) * PerkBonusMultiplier;

            AdjustedLocation = Hitlocation;
            AdjustedLocation.Z = (Hitlocation.Z - 0.15 * Instigator.collisionheight);

            HitActor.TakeDamage(MyDamage, Instigator, HitLocation , vector(PointRot),hitDamageClass);
            Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace));
        }
        else if (CachedHealee != none && Instigator != none && Level.NetMode != NM_Client)
        {
            AdjustedLocation = Hitlocation;
            AdjustedLocation.Z = (Hitlocation.Z - 0.15 * Instigator.collisionheight);
            Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace));          
            
            if (CachedHealee.ShieldStrength < ArmourRepairRateThreshold)
                WeldArmour(CachedHealee, FastArmourRepairRate);
            else
                WeldArmour(CachedHealee, SlowArmourRepairRate);
        }
        else if (IsAcceptableHealthRepairTarget(HitActor) && Level.NetMode != NM_Client)
        {
            OtherTarget = Pawn(HitActor);

            AdjustedLocation = Hitlocation;
            AdjustedLocation.Z = (Hitlocation.Z - 0.15 * Instigator.collisionheight);

            if (OtherTarget.Health < OtherTarget.HealthMax)
            {
                OtherTarget.Health += MachineRepairRate * PerkBonusMultiplier;
                if (OtherTarget.Health > OtherTarget.HealthMax)
                    OtherTarget.Health = OtherTarget.HealthMax;
            }

            Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace));
        }
        else if (KFMonster(HitActor) != none && Level.NetMode!=NM_Client )
        {
            OtherTarget = Pawn(HitActor);
            MyDamage = float(MeleeDamage + Rand(MaxAdditionalDamage)) * PerkBonusMultiplier;

            AdjustedLocation = Hitlocation;
            AdjustedLocation.Z = (Hitlocation.Z - 0.15 * Instigator.collisionheight);

            HitActor.TakeDamage(MyDamage, Instigator, HitLocation , vector(PointRot),hitDamageClass);
            Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace));
        }
        else if (HitActor == none)
        {
            CachedHealee = none;
            OtherTarget = none;
        }
    }
}

function WeldArmour(KFHumanPawn Other, float Amount)
{

    if (Other.ShieldStrength < MaxArmourRepairThreshold)
    {
        Other.ShieldStrength += Amount;
        if (Other.ShieldStrength > MaxArmourRepairThreshold)
            Other.ShieldStrength = MaxArmourRepairThreshold;
    }
}

defaultproperties
{
     FastArmourRepairRate=2.200000
     SlowArmourRepairRate=1.000000
     ArmourRepairRateThreshold=10.000000
     MaxArmourRepairThreshold=100.000000
     MachineRepairRate=4.000000
     AmmoClass=Class'BMTCustomMut.Tech_AdvancedWelderAmmo'
}
