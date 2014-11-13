class ZombieBossSantatriarchProj extends LAWProj;
/*
struct RocketSquadPart
{
    var class<KFMonster>    Type;
    var int                 Num;
};

struct RocketSquad
{
    var array<RocketSquadPart> Parts;
};

var array<RocketSquad> RocketSquads;

   
simulated function PostBeginPlay()
{
    // Difficulty Scaling
    if (Level.Game != none)
    {
        //log(self$" Beginning ground speed "$default.GroundSpeed);

        // If you are playing by yourself, greatly reduce the rocket damage
        if( Level.Game.NumPlayers == 1 )
        {
            if( Level.Game.GameDifficulty < 2.0 )
            {
                Damage = default.Damage * 0.25;
            }
            else if( Level.Game.GameDifficulty < 4.0 )
            {
                Damage = default.Damage * 0.375;
            }
            else if( Level.Game.GameDifficulty < 5.0 )
            {
                Damage = default.Damage * 1.15;
            }
            else // Hardest difficulty
            {
                Damage = default.Damage * 1.3;
            }
        }
        else
        {
            if( Level.Game.GameDifficulty < 2.0 )
            {
                Damage = default.Damage * 0.375;
            }
            else if( Level.Game.GameDifficulty < 4.0 )
            {
                Damage = default.Damage * 1.0;
            }
            else if( Level.Game.GameDifficulty < 5.0 )
            {
                Damage = default.Damage * 1.15;
            }
            else // Hardest difficulty
            {
                Damage = default.Damage * 1.3;
            }
        }
    }

    super.PostBeginPlay();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    local Controller C;
    local PlayerController  LocalPlayer;

    bHasExploded = True;

    // Don't explode if this is a dud
    if( bDud )
    {
        Velocity = vect(0,0,0);
        LifeSpan=1.0;
        SetPhysics(PHYS_Falling);
    }


    PlaySound(ExplosionSound,,2.0);
    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(class'KFMod.LawExplosion',,,HitLocation + HitNormal*20,rotator(HitNormal));
        Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
    }

    BlowUp(HitLocation);
    SummonMobs(HitLocation, HitNormal);
    Destroy();

    // Shake nearby players screens
    LocalPlayer = Level.GetLocalPlayerController();
    if ( (LocalPlayer != None) && (VSize(Location - LocalPlayer.ViewTarget.Location) < DamageRadius) )
        LocalPlayer.ShakeView(RotMag, RotRate, RotTime, OffsetMag, OffsetRate, OffsetTime);

    for ( C=Level.ControllerList; C!=None; C=C.NextController )
        if ( (PlayerController(C) != None) && (C != LocalPlayer)
            && (VSize(Location - PlayerController(C).ViewTarget.Location) < DamageRadius) )
            C.ShakeView(RotMag, RotRate, RotTime, OffsetMag, OffsetRate, OffsetTime);
}

function SummonMobs(vector HitLocation, vector HitNormal)
{
    local RocketSquad Squad;
    local KFMonster currentMinion;
    local int TotalSquadSize, TotalSpecimensSpawned;
    local int i, j;
    
    Squad = RocketSquads[rand(RocketSquads.Length)];

    // Get some info about the squad first
    for (i = 0; i < Squad.Parts.Length; ++i)
    {
        TotalSquadSize += Squad.Parts[i].Num;
/*        if (TallestMinionHeight < RocketSquad[i].Type.default.ColHeight)
            TallestMinionHeight = RocketSquad[i].Type.default.ColHeight;
        if (WidestMinionRadius < RocketSquad[i].Type.default.ColRadius)
            WidestMinionRadius = RocketSquad[i].Type.default.ColRadius;*/
    }
    
    // Ent: Writing some better code for the squad spawn, but it's not finished yet -
    // just use the old for the time being

    for (i = 0; i <= Squad.Parts.Length; ++i)
    {
        for (j = 0; j < Squad.Parts[i].Num; ++j)
        {
            SpawnLocation = HitLocation;
            
            switch (TotalSpecimensSpawned) //Shifts spawn location Nouth, East, Sout, West for each spawn.
            {
            case 1:
                SpawnLocation.X += 50;
                break;
            case 2:
                SpawnLocation.X -= 50;
                break;
            case 3:
                SpawnLocation.Y += 50;
                break;
            case 4:
                SpawnLocation.Y -= 50;      
                break;
            default:            
            }
            
            CurrentMinion = Spawn(Squad.Parts[i].Type, , , SpawnLocation, self.Rotation);

            // Second chance
            if (currentMinion == none)
            {
                spawnLocation = HitLocation;
                spawnLocation.Z += Squad.Parts[i].Type.default.CollisionHeight + 50.0;
                CurrentMinion = Spawn(Squad.Parts[i].Type, , , SpawnLocation, self.Rotation);
            }

            if (CurrentMinion != none)
                ++TotalSpecimensSpawned;
        }
    }
}



simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation ){
return;
}
*/

defaultproperties
{
     ArmDistSquared=0.000000
     Damage=50.000000
     MyDamageType=Class'KFMod.DamTypeFrag'
}
