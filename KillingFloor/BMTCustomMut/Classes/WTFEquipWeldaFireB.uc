class WTFEquipWeldaFireB extends WTFEquipWeldaFire;

function bool AllowFire()
{
	local KFDoorMover WeldTarget;
	
	WeldTarget = KFDoorMover(Super.GetTarget());
	
	if(WeldTarget != none && WeldTarget.WeldStrength <= 0)
		return false;

	return Super.AllowFire();	
}

defaultproperties
{
     MeleeDamage=15
     hitDamageClass=Class'KFMod.DamTypeUnWeld'
     AmmoPerFire=15
}
