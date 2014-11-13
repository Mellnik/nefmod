//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieGiantReindeer extends ZombieCrawler_XMas;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax
//#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

// Extras used by the Stalker cloak code, normally declared in ZombieStalkerBase
var KFHumanPawn     LocalKFHumanPawn;
var float           NextCheckTime;
var float           LastUncloakTime;


simulated function PostBeginPlay()
{
    CloakStalker();
    super.PostBeginPlay();
}

simulated function PostNetBeginPlay()
{
    local PlayerController PC;

    super.PostNetBeginPlay();

    if( Level.NetMode!=NM_DedicatedServer )
    {
        PC = Level.GetLocalPlayerController();
        if( PC != none && PC.Pawn != none )
        {
            LocalKFHumanPawn = KFHumanPawn(PC.Pawn);
        }
    }
}

simulated event SetAnimAction(name NewAction)
{
    if ( NewAction == 'Claw' || NewAction == MeleeAnims[0] || NewAction == MeleeAnims[1] || NewAction == MeleeAnims[2] )
    {
        UncloakStalker();
    }

    super.SetAnimAction(NewAction);
}

simulated function Tick(float DeltaTime)
{
    Super.Tick(DeltaTime);
    if( Level.NetMode==NM_DedicatedServer )
        Return; // Servers aren't intrested in this info.

    if( Level.TimeSeconds > NextCheckTime && Health > 0 )
    {
        NextCheckTime = Level.TimeSeconds + 0.5;

        if( LocalKFHumanPawn != none && LocalKFHumanPawn.Health > 0 && LocalKFHumanPawn.ShowStalkers() &&
            VSizeSquared(Location - LocalKFHumanPawn.Location) < LocalKFHumanPawn.GetStalkerViewDistanceMulti() * 640000.0 ) // 640000 = 800 Units
        {
            bSpotted = True;
        }
        else
        {
            bSpotted = false;
        }

        if (!bSpotted && !bCloaked && Skins[0] != default.Skins[0])
        {
            UncloakStalker();
        }
        else if ( Level.TimeSeconds - LastUncloakTime > 1.2 )
        {
            // if we're uberbrite, turn down the light
            if( bSpotted && Skins[0] != Finalblend'KFX.StalkerGlow' )
            {
                bUnlit = false;
                CloakStalker();
            }
            else if ( Skins[0] != Shader'KF_Specimens_Trip_T.stalker_invisible' )
            {
                CloakStalker();
            }
        }
    }
}

// Cloak Functions ( called from animation notifies to save Gibby trouble ;) )

simulated function CloakStalker()
{
    if ( bSpotted )
    {
        if( Level.NetMode == NM_DedicatedServer )
            return;

        Skins[0] = Finalblend'KFX.StalkerGlow';
        bUnlit = true;
        return;
    }

    if ( !bDecapitated && !bCrispified ) // No head, no cloak, honey.  updated :  Being charred means no cloak either :D
    {
        Visibility = 1;
        bCloaked = true;

        if( Level.NetMode == NM_DedicatedServer )
            Return;

        Skins[0] = Shader'KF_Specimens_Trip_T.stalker_invisible';

        // Invisible - no shadow
        if(PlayerShadow != none)
            PlayerShadow.bShadowActive = false;
        if(RealTimeShadow != none)
            RealTimeShadow.Destroy();

        // Remove/disallow projectors on invisible people
        Projectors.Remove(0, Projectors.Length);
        bAcceptsProjectors = false;
        SetOverlayMaterial(Material'KFX.FBDecloakShader', 0.25, true);
    }
}

simulated function UnCloakStalker()
{
    if( !bCrispified )
    {
        LastUncloakTime = Level.TimeSeconds;

        Visibility = default.Visibility;
        bCloaked = false;

        if( Level.NetMode == NM_DedicatedServer )
            Return;

        if (Skins[0] != default.Skins[0])
        {
            Skins[0] = default.Skins[0];

            if (PlayerShadow != none)
                PlayerShadow.bShadowActive = true;

            bAcceptsProjectors = true;

            SetOverlayMaterial(Material'KFX.FBDecloakShader', 0.25, true);
        }
    }
}

function RemoveHead()
{
    Super.RemoveHead();

    if (!bCrispified)
        Skins[0] = default.Skins[0];
}

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
    Super.PlayDying(DamageType,HitLoc);

    if(bUnlit)
        bUnlit=!bUnlit;

    LocalKFHumanPawn = none;

    if (!bCrispified)
        Skins[0] = default.Skins[0];
}

defaultproperties
{
     ZombieDamType(0)=Class'KFMod.DamTypeSlashingAttack'
     ZombieDamType(1)=Class'KFMod.DamTypeSlashingAttack'
     ZombieDamType(2)=Class'KFMod.DamTypeSlashingAttack'
     SeveredArmAttachScale=0.320000
     SeveredLegAttachScale=0.340000
     SeveredHeadAttachScale=0.440000
     OnlineHeadshotOffset=(X=44.799999,Z=11.200000)
     OnlineHeadshotScale=1.920000
     MotionDetectorThreat=0.000000
     ScoringValue=20
     HealthMax=250.000000
     Health=250
     HeadScale=1.680000
     MenuName="Giant Reindeer"
     DrawScale=1.760000
     PrePivot=(Z=10.000000)
     CollisionRadius=46.000000
     CollisionHeight=28.000000
}
