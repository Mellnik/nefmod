class WTFEquipAFS12ForceBullet extends ShotgunBullet;

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None)
		return;

	if (KFMonster(Other) == None)
		return;

	if ( Other.Physics == PHYS_Walking )
		Other.SetPhysics(PHYS_Falling);

	Other.Velocity.X = Self.Velocity.X * 0.05;
	Other.Velocity.Y = Self.Velocity.Y * 0.05;
	Other.Velocity.Z = Self.Velocity.Z * 0.05;

	Other.Acceleration = vect(0,0,0); //0,0,0

	Super.ProcessTouch(Other,HitLocation);
}

defaultproperties
{
     PenDamageReduction=0.750000
     Damage=49.000000
     DamageRadius=1.000000
     MomentumTransfer=60000.000000
     MyDamageType=Class'BMTCustomMut.DamTypeAFS12Bullet'
     LifeSpan=5.000000
     DrawScale=5.000000
}
