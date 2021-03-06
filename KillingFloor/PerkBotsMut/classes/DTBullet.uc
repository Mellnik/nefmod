class DTBullet extends ShotgunBullet;

var() array<Sound> ExplodeSounds;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Velocity = Speed * Vector(Rotation); // starts off slower so combo can be done closer

    SetTimer(0.4, false);
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
		PlaySound(ExplodeSounds[rand(ExplodeSounds.length)],,1.0);
		
		if ( EffectIsRelevant(Location,false) )
		{
			Spawn(class'DTBulletEmitter',self,,Location);
		}	

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
	Speed=4000.000000
	MaxSpeed=5000.000000
	ExplodeSounds(0)=Sound'KF_GrenadeSnd.NadeBase.Nade_Explode1'	
	Damage=7.000000
	DamageRadius=10.000000
	MomentumTransfer=30000.000000
	MyDamageType=Class'DemoDamTypeSentryFire'
}
