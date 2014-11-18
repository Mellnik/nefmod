class RPTurretAttachment extends PipeBombAttachment;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	TweenAnim('Idle_alert',0.01f);
}

defaultproperties
{
     Mesh=SkeletalMesh'RocketPortalTurret.RTMesh'
}
