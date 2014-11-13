class Tech_AdvancedWelderUnWeldFire extends Tech_AdvancedWelderFire;


#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"


function bool AllowFire()
{
	local KFDoorMover WeldTarget;

	WeldTarget = GetDoor();

	// Can't use welder, if no door.
	if(WeldTarget == none)
		return false;

	// Cannot unweld a door that's already unwelded
	if(WeldTarget.WeldStrength <= 0)
		return false;

	return Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire ;
}

defaultproperties
{
     MeleeDamage=20
     hitDamageClass=Class'KFMod.DamTypeUnWeld'
}
