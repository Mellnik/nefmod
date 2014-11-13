// Zombie Monster for KF Invasion gametype
class ZombieBloat_EX extends ZombieBloat;

simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	SetBoneScale(2,1.75,'rarm'); //let's put some big beefy arms on there...
	SetBoneScale(3,1.75,'larm');
}

defaultproperties
{
     ColHeight=33.000000
     OnlineHeadshotScale=2.500000
     HeadHealth=80.000000
     GroundSpeed=55.000000
     WaterSpeed=52.000000
     HealthMax=825.000000
     Health=3825
     HeadHeight=2.800000
     HeadScale=2.500000
     MenuName="Cock Bloat"
     DrawScale=1.500000
     CollisionHeight=66.000000
}
