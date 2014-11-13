class BizonBullet extends ShotgunBullet;

#exec OBJ LOAD FILE="Bizon_A.ukx"

var() array<Sound> ExplodeSounds;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Velocity = Speed * Vector(Rotation); // starts off slower so combo can be done closer

    SetTimer(0.4, false);

/*    if ( Level.NetMode != NM_DedicatedServer )
    {
        if ( !PhysicsVolume.bWaterVolume )
        {

            Trail = Spawn(class'KFTracer',self);
            Trail.Lifespan = Lifespan;
        }
    }*/
}

simulated function Explode(vector HitLocation,vector HitNormal)
{
	if ( Role == ROLE_Authority )
	{
		HurtRadius(Damage*0.75, DamageRadius, MyDamageType, 0.0, HitLocation );
		HurtRadius(Damage*0.25, DamageRadius*2.0, MyDamageType, MomentumTransfer, HitLocation );
		
		//does full damage within DamageRadius (dealt in two chunks), but less damage to things outside of DamageRadius but within
		//DamageRadius*2.0
	}

	//why would it matter if instigator exists or not for spawning an fx???
	//if ( KFHumanPawn(Instigator) != none )
	//{
	
		PlaySound(ExplodeSounds[rand(ExplodeSounds.length)],,1.0);
		
		if ( EffectIsRelevant(Location,false) )
		{
			Spawn(class'BMTCustomMut.BizonBulletEmitter',self,,Location);
		}
		
	//}

	Destroy();
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if ( Other != Instigator && !Other.IsA('PhysicsVolume') && (Other.IsA('Pawn') || Other.IsA('ExtendedZCollision')) )
	{
		Other.Velocity.X = Self.Velocity.X * 0.10;
		Other.Velocity.Y = Self.Velocity.Y * 0.10;
		Other.Velocity.Z = Self.Velocity.Z * 0.10;
		Other.Acceleration = vect(0,0,0); //0,0,0
		
		Explode(Other.Location,Other.Location);
	}
}

defaultproperties
{
     ExplodeSounds(0)=Sound'Bizon_A.Bizon_explode'
     ExplodeSounds(1)=Sound'Bizon_A.Bizon_explode'
     ExplodeSounds(2)=Sound'Bizon_A.Bizon_explode'
     Speed=9000.000000
     MaxSpeed=9000.000000
     Damage=10.000000
     DamageRadius=10.000000
     MomentumTransfer=30000.000000
     MyDamageType=Class'BMTCustomMut.DamTypeBizon'
}
