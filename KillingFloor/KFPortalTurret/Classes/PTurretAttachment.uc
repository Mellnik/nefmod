class PTurretAttachment extends PipeBombAttachment;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	TweenAnim('IdleAlert',0.01f);
}

defaultproperties
{
	Mesh=SkeletalMesh'TurretMesh'
}