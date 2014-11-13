class FreezingProj extends FlameTendril;

var() KFHumanPawn StuckTo;

var float NGSpeed,NWSpeed,NASpeed;
var bool bActive;

simulated function PostBeginPlay();

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	Destroy();
}

simulated function Landed( vector HitNormal )
{
	Destroy();
}

simulated function Explode(vector HitLocation,vector HitNormal)
{
	Destroy();
}

simulated function ProcessTouch (Actor Other, vector HitLocation);

simulated function Destroyed();

function Timer()
{

	if (StuckTo != None)
	{
/*
		if (StuckTo.Health <= 0)
			Destroy();
*/
		if (ROLE == ROLE_Authority)
		{
			if ( !bActive )
				return;
			StuckTo.GroundSpeed = 0.0;
			StuckTo.WaterSpeed = 0.0;
			StuckTo.AirSpeed = 0.0;
			if ( lifespan <= 1.0 )
			{
				StuckTo.GroundSpeed = NGSpeed;
				StuckTo.WaterSpeed = NWSpeed;
				StuckTo.AirSpeed = NASpeed;
				bActive = false;
			}
			else
			{
				StuckTo.GroundSpeed = 0.0;
				StuckTo.WaterSpeed = 0.0;
				StuckTo.AirSpeed = 0.0;
			}
		
		}

	}
}

simulated function Stick(actor HitActor, vector HitLocation)
{
	local name NearestBone;
	local float dist;

	bActive = true;
	StuckTo = KFHumanPawn(HitActor);
	NGSpeed = StuckTo.GroundSpeed;
	NWSpeed = StuckTo.WaterSpeed;
	NASpeed = StuckTo.AirSpeed;
	
	SetPhysics(PHYS_None);

	NearestBone = GetClosestBone(HitLocation, HitLocation, dist , 'CHR_Spine2' , 15 );
	HitActor.AttachToBone(self,NearestBone);
	
	SetTimer(0.5,true);
}

simulated function DestroyTrail()
{
	if ( Trail != none )
	{
		Trail.mRegen=False;
		Trail.SetPhysics(PHYS_None);
	}

	if ( FlameTrail != none )
	{
		FlameTrail.Kill();
		FlameTrail.SetPhysics(PHYS_None);
	}
}

defaultproperties
{
     Speed=1.000000
     MaxSpeed=1.000000
     Damage=15.000000
     DamageRadius=1.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'KF_pickups2_Trip.Supers.MP7_Dart'
     LifeSpan=16.000000
     DrawScale=0.010000
}
