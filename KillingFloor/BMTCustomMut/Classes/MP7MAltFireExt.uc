class MP7MAltFireExt extends MP7MAltFire;

var KFPlayerReplicationInfo KFPRI;

event ModeDoFire()
{
	if (Instigator == None)
		return;
		
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none && KFPRI.ClientVeteranSkill == Class'WTFPerksFieldMedic')
	{
		FireRate=0.10;
		AmmoPerFire=100;
		bWaitForRelease=False;
	}
	else
	{
		FireRate=Default.FireRate;
		AmmoPerFire=Default.AmmoPerFire;
		bWaitForRelease=Default.bWaitForRelease;
	}
	
	Super.ModeDoFire();
}

defaultproperties
{
     ProjPerFire=2
     bWaitForRelease=False
     FireRate=0.100000
     AmmoPerFire=100
}
