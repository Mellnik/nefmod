//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieBabyPat extends ZombieBoss;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax
#exec OBJ LOAD FILE=CAKESounds.uax

simulated function CloakBoss()
{
    local Controller C;
    local int Index;

    if ( bSpotted )
    {
        Visibility = 120;

        if ( Level.NetMode==NM_DedicatedServer )
        {
            Return;
        }

        Skins[0] = Finalblend'KFX.StalkerGlow';
        Skins[1] = Finalblend'KFX.StalkerGlow';
        bUnlit = true;

        return;
    }

    Visibility = 1;
    bCloaked = true;

    if ( Level.NetMode!=NM_Client )
    {
        for ( C=Level.ControllerList; C!=None; C=C.NextController )
        {
            if ( C.bIsPlayer && C.Enemy==Self )
            {
                C.Enemy = None; // Make bots lose sight with me.
            }
        }
    }

    if( Level.NetMode==NM_DedicatedServer )
    {
        Return;
    }

    Skins[1] = Shader'KF_Specimens_Trip_T.patriarch_invisible_gun';

    // Invisible - no shadow
    if(PlayerShadow != none)
    {
        PlayerShadow.bShadowActive = false;
    }

    // Remove/disallow projectors on invisible people
    Projectors.Remove(0, Projectors.Length);
    bAcceptsProjectors = false;
    SetOverlayMaterial(FinalBlend'KF_Specimens_Trip_T.patriarch_fizzle_FB', 1.0, true);

    // Randomly send out a message about Patriarch going invisible(10% chance)
    if ( FRand() < 0.10 )
    {
        // Pick a random Player to say the message
        Index = Rand(Level.Game.NumPlayers);

        for ( C = Level.ControllerList; C != none; C = C.NextController )
        {
            if ( PlayerController(C) != none )
            {
                if ( Index == 0 )
                {
                    PlayerController(C).Speech('AUTO', 8, "");
                    break;
                }

                Index--;
            }
        }
    }
}

// Speech notifies called from the anims
function PatriarchKnockDown()
{
    PlaySound(SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_KnockedDown', SLOT_Misc, 2.0,true,500.0);
}

function PatriarchEntrance()
{
    PlaySound(SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_Entrance', SLOT_Misc, 2.0,true,500.0);
}

function PatriarchVictory()
{
    PlaySound(SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_Victory', SLOT_Misc, 2.0,true,500.0);
}

function PatriarchMGPreFire()
{
    PlaySound(SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_WarnGun', SLOT_Misc, 2.0,true,1000.0);
}

function PatriarchMisslePreFire()
{
    PlaySound(SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_WarnRocket', SLOT_Misc, 2.0,true,1000.0);
}

state KnockDown // Knocked
{
    function bool ShouldChargeFromDamage()
    {
        return false;
    }

Begin:
    if ( Health > 0 )
    {
        Sleep(GetAnimDuration('KnockDown'));
        CloakBoss();
        PlaySound(sound'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_SaveMe1', SLOT_Misc, 2.0,,500.0);

        GotoState('Escaping');
    }
    else
    {
       GotoState('');
    }
}



// Overridden to do a cool slomo death view of the patriarch dying
function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{

    super(ZombieBossBase).Died(Killer,damageType,HitLocation);
/*
    local Controller C;


    KFGameType(Level.Game).DoBossDeath();

    For( C=Level.ControllerList; C!=None; C=C.NextController )
    {
        if( PlayerController(C)!=None )
        {
            PlayerController(C).SetViewTarget(Self);
            PlayerController(C).ClientSetViewTarget(Self);
            PlayerController(C).bBehindView = true;
            PlayerController(C).ClientSetBehindView(True);
        }
    }*/
}

function bool MakeGrandEntry()
{
    return false;
}
    
function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{
    local float DamagerDistSq;
    local float UsedPipeBombDamScale;

    if (InstigatedBy.isa('ZombieHateriarch') || InstigatedBy.isa('ZombieBabyPatSanta') || InstigatedBy.isa('KFMonster')) 
        Damage = 0; // nulled
    
    //log(GetStateName()$" Took damage. Health="$Health$" Damage = "$Damage$" HealingLevels "$HealingLevels[SyringeCount]);

    if ( class<DamTypeCrossbow>(damageType) == none && class<DamTypeCrossbowHeadShot>(damageType) == none )
    {
        bOnlyDamagedByCrossbow = false;
    }

    // Scale damage from the pipebomb down a bit if lots of pipe bomb damage happens
    // at around the same times. Prevent players from putting all thier pipe bombs
    // in one place and owning the patriarch in one blow.
    if ( class<DamTypePipeBomb>(damageType) != none )
    {
       UsedPipeBombDamScale = FMax(0,(1.0 - PipeBombDamageScale));

       PipeBombDamageScale += 0.075;

       if( PipeBombDamageScale > 1.0 )
       {
           PipeBombDamageScale = 1.0;
       }

       Damage *= UsedPipeBombDamScale;
    }

    Super.TakeDamage(Damage,instigatedBy,hitlocation,Momentum,damageType);

    if( Level.TimeSeconds - LastDamageTime > 10 )
    {
        ChargeDamage = 0;
    }
    else
    {
        LastDamageTime = Level.TimeSeconds;
        ChargeDamage += Damage;
    }

    if( ShouldChargeFromDamage() && ChargeDamage > 200 )
    {
        // If someone close up is shooting us, just charge them
        if( InstigatedBy != none )
        {
            DamagerDistSq = VSizeSquared(Location - InstigatedBy.Location);

            if( DamagerDistSq < (700 * 700) )
            {
                SetAnimAction('transition');
                ChargeDamage=0;
                LastForceChargeTime = Level.TimeSeconds;
                GoToState('Charging');
                return;
            }
        }
    }

    if( Health<=0 || SyringeCount==3 || IsInState('Escaping') || IsInState('KnockDown') /*|| bShotAnim*/ )
        Return;

    if( (SyringeCount==0 && Health<HealingLevels[0]) || (SyringeCount==1 && Health<HealingLevels[1]) || (SyringeCount==2 && Health<HealingLevels[2]) )
    {
        //log(GetStateName()$" Took damage and want to heal!!! Health="$Health$" HealingLevels "$HealingLevels[SyringeCount]);

        bShotAnim = true;
        Acceleration = vect(0,0,0);
        SetAnimAction('KnockDown');
        HandleWaitForAnim('KnockDown');
        KFMonsterController(Controller).bUseFreezeHack = True;
        GoToState('KnockDown');
    }
}

     
        
state FireMissile
{

Ignores RangedAttack;

    function bool ShouldChargeFromDamage()
    {
        return false;
    }

    function BeginState()
    {
        Acceleration = vect(0,0,0);
    }

    function AnimEnd( int Channel )
    {
        local vector Start;
        local Rotator R;

        Start = GetBoneCoords('tip').Origin;

        if ( !SavedFireProperties.bInitialized )
        {
            SavedFireProperties.AmmoClass = MyAmmo.Class;
            SavedFireProperties.ProjectileClass = MyAmmo.ProjectileClass;
            SavedFireProperties.WarnTargetPct = 0.15;
            SavedFireProperties.MaxRange = 10000;
            SavedFireProperties.bTossed = False;
            SavedFireProperties.bTrySplash = False;
            SavedFireProperties.bLeadTarget = True;
            SavedFireProperties.bInstantHit = True;
            SavedFireProperties.bInitialized = true;
        }

        R = AdjustAim(SavedFireProperties,Start,100);
        PlaySound(RocketFireSound,SLOT_Interact,2.0,,TransientSoundRadius,,false);
        Spawn(Class'BabyPatSantaLAWProj',,,Start,R);

        bShotAnim = true;
        Acceleration = vect(0,0,0);
        SetAnimAction('FireEndMissile');
        HandleWaitForAnim('FireEndMissile');

        // Randomly send out a message about Patriarch shooting a rocket(5% chance)
        if ( FRand() < 0.05 && Controller.Enemy != none && PlayerController(Controller.Enemy.Controller) != none )
        {
            PlayerController(Controller.Enemy.Controller).Speech('AUTO', 10, "");
        }

        GoToState('');
    }
Begin:
    while ( true )
    {
        Acceleration = vect(0,0,0);
        Sleep(0.1);
    }
}

function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
	if( Level.TimeSeconds - LastPainAnim < MinTimeBetweenPainAnims )
		return;

	if( Damage>=150 || (DamageType.name=='DamTypeStunNade' && rand(5)>3) || (DamageType.name=='DamTypeCrossbowHeadshot' && Damage>=200) || (DamageType.name=='DamTypeM44' && Damage>=350) || (DamageType.name=='DamTypeM99' && Damage>=350) || (DamageType.name=='DamTypeM99HeadShot' && Damage>=350) )
		PlayDirectionalHit(HitLocation);

	LastPainAnim = Level.TimeSeconds;

	if( Level.TimeSeconds - LastPainSound < MinTimeBetweenPainSounds )
		return;

	LastPainSound = Level.TimeSeconds;
	PlaySound(HitSound[0], SLOT_Pain,2*TransientSoundVolume,,400);
}

defaultproperties
{
     HealingLevels(0)=300
     HealingLevels(1)=200
     HealingLevels(2)=100
     HealingAmount=300
     MGDamage=0.500000
     ClawMeleeDamageRange=5.000000
     ImpaleMeleeDamageRange=5.000000
     MoanVoice=SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_Talk'
     MeleeDamage=5
     JumpSound=SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_Jump'
     ColRadius=4.000000
     ColHeight=3.000000
     PlayerCountHealthScale=0.150000
     OnlineHeadshotOffset=(Z=15.000000)
     bBoss=False
     HitSound(0)=SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_Pain'
     DeathSound(0)=SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_Death'
     ScoringValue=50
     HealthMax=800.000000
     Health=800
     HeadHeight=4.000000
     HeadScale=0.650000
     MenuName="Pattys little Helpers"
     AmbientSound=SoundGroup'CAKESounds.Zombie_BabyPatSanta.BabyPatSanta_IdleLoop'
     DrawScale=0.525000
}
