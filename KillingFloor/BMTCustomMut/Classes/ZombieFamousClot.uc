// Zombie Monster for KF Invasion gametype
class ZombieFamousClot extends ZombieClot;

simulated function BeginPlay()
{
	LinkSkelAnim(MeshAnimation'Clot_anim');
	Super.BeginPlay();
    SetHeadScale(2.0);
	
}

defaultproperties
{
     GroundSpeed=175.000000
     MenuName="Famous Clot"
}
