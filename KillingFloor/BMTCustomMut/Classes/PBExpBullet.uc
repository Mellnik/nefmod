//=============================================================================
// Shotgun Bullet
//=============================================================================
class PBExpBullet extends ShotgunBullet;


var() array<Sound> ExplodeSounds;

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
			Spawn(class'BMTCustomMut.PBExpBulletEmitter',self,,Location);
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
     ExplodeSounds(0)=SoundGroup'KF_GrenadeSnd.Nade_Explode_1'
     ExplodeSounds(1)=SoundGroup'KF_GrenadeSnd.Nade_Explode_2'
     ExplodeSounds(2)=SoundGroup'KF_GrenadeSnd.Nade_Explode_3'
     Speed=7000.000000
     MaxSpeed=9000.000000
     Damage=50.000000
     DamageRadius=55.000000
     MyDamageType=Class'BMTCustomMut.DamTypeDemoProgress'
}
