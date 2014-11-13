Class PBHandle extends Info;

function PostBeginPlay()
{
	Class'PipeBombFire'.Default.ProjectileClass = Class'NPipeBombProjectile';
	Destroy();
}

defaultproperties
{
}
