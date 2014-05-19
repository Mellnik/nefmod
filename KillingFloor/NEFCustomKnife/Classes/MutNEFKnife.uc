class MutNEFKnife extends Mutator;

function PreBeginPlay()
{
	// Add all needed packages.
	AddToPackageMap("NEFCustomKnife");
}
 
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if (Other.IsA('KFHumanPawn'))
	{
		KFHumanPawn(Other).RequiredEquipment[0] = "NEFCustomKnife.NEFKnife";
	}
	return true;
}

defaultproperties
{
     bAddToServerPackages=True
     GroupName="KF-NEFCustomKnife"
     FriendlyName="NEFCustomKnife"
     Description="Adds the NEF-Knife."
}
