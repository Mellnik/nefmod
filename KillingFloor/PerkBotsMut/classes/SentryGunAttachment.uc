class SentryGunAttachment extends PipeBombAttachment;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	TweenAnim('Folded',0.01f);
}

defaultproperties
{
     Mesh=SkeletalMesh'sentrybot_turret.SentryMesh'
}
