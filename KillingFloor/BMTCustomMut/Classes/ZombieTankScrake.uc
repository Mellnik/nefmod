//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieTankScrake extends ZombieScrake;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax
#exec OBJ LOAD FILE=KF_BaseScrake.uax
//#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax
//#exec OBJ LOAD FILE=KF_BaseScrake_Xmas.uax

var int AdjustedMeleeDamage;
var bool bHasEnragedDamageBonus;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    AdjustedMeleeDamage = MeleeDamage;
}

simulated function SpawnExhaustEmitter()
{
}

simulated function UpdateExhaustEmitter()
{
}

function RangedAttack(Actor A)
{
    if ( bShotAnim || Physics == PHYS_Swimming)
        return;
    else if ( CanAttack(A) )
    {
        bShotAnim = true;
        SetAnimAction(MeleeAnims[Rand(2)]);
        CurrentDamType = ZombieDamType[0];
        //PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
        GoToState('SawingLoop');
    }

    if( !bShotAnim && !bDecapitated )
    {
        if ( float(Health)/HealthMax < 0.15 )
            GoToState('RunningState');
    }
}

function BeginState()
	{
        local float ChargeChance, RagingChargeChance;

        // Decide what chance the scrake has of charging during an attack
        if( Level.Game.GameDifficulty < 2.0 )
        {
            ChargeChance = 0.75;
            RagingChargeChance = 0.85;
        }
        else if( Level.Game.GameDifficulty < 4.0 )
        {
            ChargeChance = 0.95;
            RagingChargeChance = 1.00;
        }
        else if( Level.Game.GameDifficulty < 5.0 )
        {
            ChargeChance = 0.65;
            RagingChargeChance = 0.85;
        }
        else // Hardest difficulty
        {
            ChargeChance = 0.95;
            RagingChargeChance = 1.0;
        }
		
		// Randomly have the scrake charge during an attack so it will be less predictable
        if( (Health/HealthMax < 0.1 && FRand() <= RagingChargeChance ) || FRand() <= ChargeChance )
		{
            GroundSpeed = OriginalGroundSpeed * AttackChargeRate;
    		bCharging = true;
    		if( Level.NetMode!=NM_DedicatedServer )
    			PostNetReceive();

    		NetUpdateTime = Level.TimeSeconds - 1;
		}
	}
		
simulated function PostNetBeginPlay()
	{
    super.PostNetBeginPlay();
    SetBoneScale(1,1.75,'rarm'); //let's put some big beefy arms on there...
    SetBoneScale(2,1.75,'larm');
	
	SetBoneScale(7,1.5,'rshoulder');
    SetBoneScale(8,1.5,'lshoulder');
}

defaultproperties
{
     AdjustedMeleeDamage=20
     AttackChargeRate=10.000000
     StunsRemaining=0
     BleedOutDuration=60.000000
     MeleeDamage=18
     ColRadius=35.000000
     ColHeight=50.000000
     PlayerCountHealthScale=0.300000
     OnlineHeadshotOffset=(Z=100.000000)
     OnlineHeadshotScale=2.000000
     HeadHealth=3800.000000
     ScoringValue=150
     MeleeRange=42.500000
     GroundSpeed=40.000000
     WaterSpeed=35.000000
     HealthMax=5000.000000
     Health=5000
     MenuName="Tank Scrake"
     Mesh=SkeletalMesh'KF_Freaks_Trip_Xmas.ScrakeFrost'
     DrawScale=1.387500
     PrePivot=(Z=20.000000)
     Skins(0)=Shader'KF_Specimens_Trip_XMAS_T.ScrakeFrost.scrake_frost_shdr'
}
