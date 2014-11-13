class Tech_BioLauncherProj extends Crossbowarrow;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"
var() int BaseDamage;
var() float GloblingSpeed;
var() float RestTime;
var() float TouchDetonationDelay; // gives player a split second to jump to gain extra momentum from blast
var() float DripTime;
var() int MaxGoopLevel;

var int GoopLevel;
var float GoopVolume;
var Vector SurfaceNormal;
var int Rand3;
var bool bCheckedSurface;
var() bool bMergeGlobs;
var bool bDrip;
var bool bOnMover;

var() Sound ExplodeSound;
var AvoidMarker Fear;

var     string  ImpactSoundRef;

var() array<Sound> ExplodeSounds;


static function PreloadAssets()
{
    default.ImpactSound = sound(DynamicLoadObject(default.ImpactSoundRef, class'Sound', true));
}

replication
{
    reliable if (bNetInitial && Role == ROLE_Authority)
        Rand3;
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    SetOwner(None);

    LoopAnim('flying', 1.0);

    if (Role == ROLE_Authority)
    {
        Velocity = Vector(Rotation) * Speed;
        Velocity.Z += TossZ;
    }

    if (Role == ROLE_Authority)
         Rand3 = Rand(3);
    if ( (Level.NetMode != NM_DedicatedServer) && ((Level.DetailMode == DM_Low) || Level.bDropDetail) )
    {
        bDynamicLight = false;
        LightType = LT_None;
    }
}

function AdjustSpeed()
{
    if ( GoopLevel < 1 )
        Velocity = Vector(Rotation) * Speed;
    else
        Velocity = Vector(Rotation) * Speed * (0.4 + GoopLevel)/(1.4*GoopLevel);
    Velocity.Z += TossZ;
}

simulated function PostNetBeginPlay()
{
    if (Role < ROLE_Authority && Physics == PHYS_None)
    {
        Landed(Vector(Rotation));
    }
}

simulated function Destroyed()
{
    if ( !bNoFX && EffectIsRelevant(Location,false) )
    {
        //Spawn(class'xEffects.GoopSmoke');
        //Spawn(class'xEffects.GoopSparks');
    }
    
    PlaySound(ExplodeSounds[rand(ExplodeSounds.length)],,2.0);
    Spawn(Class'BMTCustomMut.Tech_BioLauncherProjEmitter',,, self.location, rotator(vect(0,0,1)));
    
    if ( Fear != None )
        Fear.Destroy();
    if (Trail != None)
        Trail.Destroy();
    Super.Destroyed();
}

simulated function MergeWithGlob(int AdditionalGoopLevel)
{
}

auto state Flying
{
    simulated function Landed( Vector HitNormal )
    {
        local Rotator NewRot;
        local int CoreGoopLevel;

        if ( Level.NetMode != NM_DedicatedServer )
        {
            PlaySound(ImpactSound, SLOT_Misc);
            // explosion effects
        }

        SurfaceNormal = HitNormal;

        // spawn globlings
        CoreGoopLevel = Rand3 + MaxGoopLevel - 3;
        if (GoopLevel > CoreGoopLevel)
        {
            if (Role == ROLE_Authority)
                SplashGlobs(GoopLevel - CoreGoopLevel);
            SetGoopLevel(CoreGoopLevel);
        }
        //spawn(class'BioDecal',,,, rotator(-HitNormal));

        bCollideWorld = false;
        SetCollisionSize(GoopVolume*10.0, GoopVolume*10.0);
        bProjTarget = true;

        NewRot = Rotator(HitNormal);
        NewRot.Roll += 32768;
        SetRotation(NewRot);
        SetPhysics(PHYS_None);
        bCheckedsurface = false;
        if ( (Level.Game != None) && (Level.Game.NumBots > 0) )
            Fear = Spawn(class'AvoidMarker');
        GotoState('OnGround');
    }

    simulated function HitWall( Vector HitNormal, Actor Wall )
    {
        Landed(HitNormal);
        if ( !Wall.bStatic && !Wall.bWorldGeometry )
        {
            bOnMover = true;
            SetBase(Wall);
            if (Base == None)
                BlowUp(Location);
        }
    }

    simulated function ProcessTouch(Actor Other, Vector HitLocation)
    {
        local Tech_BioLauncherProj Glob;

        Glob = Tech_BioLauncherProj(Other);

        if ( Glob != None )
        {
            if (Glob.Owner == None || (Glob.Owner != Owner && Glob.Owner != self))
            {
                if (bMergeGlobs)
                {
                    Glob.MergeWithGlob(GoopLevel); // balancing on the brink of infinite recursion
                    bNoFX = true;
                    Destroy();
                }
                else
                {
                    BlowUp( HitLocation );
                }
            }
        }
        else if (!Other.isA('KFHumanPawn') && Other != Instigator && (Other.IsA('Pawn') || Other.IsA('DestroyableObjective') || Other.bProjTarget))
            BlowUp( HitLocation );
        else if ( Other != Instigator && Other.bBlockActors )
            HitWall( Normal(HitLocation-Location), Other );
    }
}

state OnGround
{
    simulated function BeginState()
    {
        PlayAnim('idle');
        SetTimer(RestTime, false);
    }

    simulated function Timer()
    {
        if (bDrip)
        {
            bDrip = false;
            SetCollisionSize(default.CollisionHeight, default.CollisionRadius);
            Velocity = PhysicsVolume.Gravity * 0.2;
            SetPhysics(PHYS_Falling);
            bCollideWorld = true;
            bCheckedsurface = false;
            bProjTarget = false;
            LoopAnim('flying', 1.0);
            GotoState('Flying');
        }
        else
        {
            BlowUp(Location);
        }
    }

    simulated function ProcessTouch(Actor Other, Vector HitLocation)
    {
        if ( !Other.isA('KFHumanPawn') && Other.IsA('Pawn') && (Other != Base) )
        {
            bDrip = false;
            SetTimer(TouchDetonationDelay, false);
        }
    }

    function TakeDamage( int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, class<DamageType> DamageType, optional int HitIndex )
    {
        if (DamageType.default.bDetonatesGoop)
        {
            bDrip = false;
            SetTimer(0.1, false);
        }
    }

    simulated function AnimEnd(int Channel)
    {
        local float DotProduct;

        if (!bCheckedSurface)
        {
            DotProduct = SurfaceNormal dot Vect(0,0,-1);
            if (DotProduct > 0.7)
            {
                //PlayAnim('Drip', 0.66);
                bDrip = true;
                SetTimer(DripTime, false);
                if (bOnMover)
                    BlowUp(Location);
            }
            else if (DotProduct > -0.5)
            {
                //PlayAnim('Slide', 1.0);
                if (bOnMover)
                    BlowUp(Location);
            }
            bCheckedSurface = true;
        }
    }

    simulated function MergeWithGlob(int AdditionalGoopLevel)
    {
        local int NewGoopLevel, ExtraSplash;
        NewGoopLevel = AdditionalGoopLevel + GoopLevel;
        if (NewGoopLevel > MaxGoopLevel)
        {
            Rand3 = (Rand3 + 1) % 3;
            ExtraSplash = Rand3;
            if (Role == ROLE_Authority)
                SplashGlobs(NewGoopLevel - MaxGoopLevel + ExtraSplash);
            NewGoopLevel = MaxGoopLevel - ExtraSplash;
        }
        SetGoopLevel(NewGoopLevel);
        SetCollisionSize(GoopVolume*10.0, GoopVolume*10.0);
        PlaySound(ImpactSound, SLOT_Misc);
        PlayAnim('idle');
        bCheckedSurface = false;
        SetTimer(RestTime, false);
    }

}

function BlowUp(Vector HitLocation)
{
    if (Role == ROLE_Authority)
    {
        Damage = BaseDamage + Damage * GoopLevel;
        DamageRadius = DamageRadius * GoopVolume;
        MomentumTransfer = MomentumTransfer * GoopVolume;
        if (Physics == PHYS_Flying) MomentumTransfer *= 0.5;
        DelayedHurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation);
    }

    PlaySound(ExplodeSound, SLOT_Misc);

    Destroy();
    //GotoState('shriveling');
}

singular function SplashGlobs(int NumGloblings)
{
    local int g;
    local Tech_BioLauncherProj NewGlob;
    local Vector VNorm;

    for (g=0; g<NumGloblings; g++)
    {
        NewGlob = Spawn(Class, self,, Location+GoopVolume*(CollisionHeight+4.0)*SurfaceNormal);
        if (NewGlob != None)
        {
            NewGlob.Velocity = (GloblingSpeed + FRand()*150.0) * (SurfaceNormal + VRand()*0.8);
            if (Physics == PHYS_Falling)
            {
                VNorm = (Velocity dot SurfaceNormal) * SurfaceNormal;
                NewGlob.Velocity += (-VNorm + (Velocity - VNorm)) * 0.1;
            }
            NewGlob.InstigatorController = InstigatorController;
        }
        //else log("unable to spawn globling");
    }
}

state Shriveling
{
    simulated function BeginState()
    {
        bProjTarget = false;
        PlayAnim('Idle', 1.0);
    }

    simulated function AnimEnd(int Channel)
    {
        Destroy();
    }

    simulated function ProcessTouch(Actor Other, Vector HitLocation)
    {
    }
}

simulated function SetGoopLevel( int NewGoopLevel )
{
    GoopLevel = NewGoopLevel;
    GoopVolume = sqrt(float(GoopLevel));
    SetDrawScale(GoopVolume*default.DrawScale);
    LightBrightness = Min(100 + 15*GoopLevel, 255);
    LightRadius = 1.7 + 0.2*GoopLevel;
    FluidSurfaceShootStrengthMod=5.f + 0.3 * NewGoopLevel;
}
simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
    local actor Victims;
    local float damageScale, dist;
    local vector dirs;
    local int NumKilled;
    local KFMonster KFMonsterVictim;
    local Pawn P;
    local KFPawn KFP;
    local array<Pawn> CheckedPawns;
    local int i;
    local bool bAlreadyChecked;

    if ( bHurtEntry )
        return;

    bHurtEntry = true;

    foreach CollidingActors (class 'Actor', Victims, DamageRadius, HitLocation)
    {
        // don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
        if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo')
         && ExtendedZCollision(Victims)==None )
        {
            dirs = Victims.Location - HitLocation;
            dist = FMax(1,VSize(dirs));
            dirs = dirs/dist;
            damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
            if ( Instigator == None || Instigator.Controller == None )
                Victims.SetDelayedDamageInstigatorController( InstigatorController );
            if ( Victims == LastTouched )
                LastTouched = None;

            P = Pawn(Victims);

            if( P != none )
            {
                for (i = 0; i < CheckedPawns.Length; i++)
                {
                    if (CheckedPawns[i] == P)
                    {
                        bAlreadyChecked = true;
                        break;
                    }
                }

                if( bAlreadyChecked )
                {
                    bAlreadyChecked = false;
                    P = none;
                    continue;
                }

                KFMonsterVictim = KFMonster(Victims);

                if( KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
                {
                    KFMonsterVictim = none;
                }

                KFP = KFPawn(Victims);

                if( KFMonsterVictim != none )
                {
                    damageScale *= KFMonsterVictim.GetExposureTo(HitLocation/*Location + 15 * -Normal(PhysicsVolume.Gravity)*/);
                }
                else if( KFP != none )
                {
                    damageScale *= KFP.GetExposureTo(HitLocation/*Location + 15 * -Normal(PhysicsVolume.Gravity)*/);
                }

                CheckedPawns[CheckedPawns.Length] = P;

                if ( damageScale <= 0)
                {
                    P = none;
                    continue;
                }
                else
                {
                    //Victims = P;
                    P = none;
                }
            }


            Victims.TakeDamage
            (
                damageScale * DamageAmount,
                Instigator,
                Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dirs,
                (damageScale * Momentum * dirs),
                DamageType
            );

            if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
                Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);

            if( Role == ROLE_Authority && KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
            {
                NumKilled++;
            }
        }
    }
    if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
    {
        Victims = LastTouched;
        LastTouched = None;
        dirs = Victims.Location - HitLocation;
        dist = FMax(1,VSize(dirs));
        dirs = dirs/dist;
        damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));
        if ( Instigator == None || Instigator.Controller == None )
            Victims.SetDelayedDamageInstigatorController(InstigatorController);
        Victims.TakeDamage
        (
            damageScale * DamageAmount,
            Instigator,
            Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dirs,
            (damageScale * Momentum * dirs),
            DamageType
        );
        if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
            Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
    }

    if( Role == ROLE_Authority )
    {
        if( NumKilled >= 4 )
        {
            KFGameType(Level.Game).DramaticEvent(0.05);
        }
        else if( NumKilled >= 2 )
        {
            KFGameType(Level.Game).DramaticEvent(0.03);
        }
    }

    bHurtEntry = false;
}

defaultproperties
{
     BaseDamage=250
     GloblingSpeed=200.000000
     RestTime=30.000000
     TouchDetonationDelay=0.150000
     DripTime=10.800000
     MaxGoopLevel=5
     GoopLevel=1
     GoopVolume=1.000000
     bMergeGlobs=True
     ImpactSoundRef="SentryTechSounds.Weapon_BioLauncher.BioLauncher_Goo1"
     ExplodeSounds(0)=Sound'SentryTechSounds.Weapon_Biolauncher.BioLauncher_Goo1'
     ExplodeSounds(1)=Sound'SentryTechSounds.Weapon_Biolauncher.BioLauncher_Goo2'
     Speed=3000.000000
     TossZ=0.000000
     bSwitchToZeroCollision=True
     Damage=250.000000
     DamageRadius=50.000000
     MomentumTransfer=40000.000000
     MyDamageType=Class'BMTCustomMut.DamTypeTech_BioLauncher'
     MaxEffectDistance=7000.000000
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=82
     LightSaturation=10
     LightBrightness=190.000000
     LightRadius=0.600000
     bDynamicLight=True
     bOnlyDirtyReplication=True
     Physics=PHYS_Falling
     LifeSpan=15.000000
     Mesh=SkeletalMesh'SentryTechAnim1.Weapon_Biolauncher_Glob'
     DrawScale=2.400000
     Skins(0)=Combiner'SentryTechTex1.Weapon_Biolauncher.Biolauncher_Cmb_Proj'
     AmbientGlow=80
     bUnlit=True
     SoundVolume=255
     SoundRadius=100.000000
     TransientSoundVolume=2.000000
     TransientSoundRadius=500.000000
     CollisionRadius=4.000000
     CollisionHeight=4.000000
     bUseCollisionStaticMesh=True
}
