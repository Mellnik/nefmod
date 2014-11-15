Class TurretSpawnPoint extends Triggers;

var() bool bTriggerOnceOnly,bEvilTurret,bInvulnerableTurret,bNeverKillTurret;
var() int TurretHealth,HitDamage;
var() class<PortalTurret> TurretClass;

event Trigger( Actor Other, Pawn EventInstigator )
{
	local PortalTurret T;

	T = Spawn(TurretClass);
	if( T!=None )
	{
		T.bNoAutoDestruct = bNeverKillTurret;
		T.bEvilTurret = bEvilTurret;
		T.bHasGodMode = bInvulnerableTurret;
		T.HitDamages = HitDamage;
		T.TurretHealth = TurretHealth;
		T.Health = TurretHealth;
	}
	if( bTriggerOnceOnly )
		Destroy();
}

defaultproperties
{
	bCollideActors=false
	DrawType=DT_Mesh
	bUnlit=true
	Skins(0)=Texture'Turret_01'
	Mesh=SkeletalMesh'TurretMesh'
	CollisionHeight=28
	CollisionRadius=23
	bEvilTurret=true
	TurretHealth=400
	bInvulnerableTurret=true
	TurretClass=Class'PortalTurretBad'
	HitDamage=5
}