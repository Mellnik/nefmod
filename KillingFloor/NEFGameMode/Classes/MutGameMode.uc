class MutGameMode extends Mutator;

function PostBeginPlay()
{
	SetTimer(100, true);
}

function Timer()
{
	Level.Game.Broadcast(None, "Welcome to New Evolution Freeroam");
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local KFHumanPawn KFHP;
	
	if(Other != None)
	{
		if(Other.IsA('KFHumanPawn'))
		{
			KFHP = KFHumanPawn(Other);
			KFHP.RequiredEquipment[0] = ""; // KnifeShadowBladeMut.KnifeShadowBlade
			KFHP.RequiredEquipment[1] = ""; // Pistol9mmNinemmMut.SingleNinemmSingle
			KFHP.RequiredEquipment[2] = "KFMod.Frag";
			KFHP.RequiredEquipment[3] = "KFMod.Syringe";
			KFHP.RequiredEquipment[4] = "KFMod.Welder";
			Level.Game.Broadcast(None, "Now updating the defaults, yes");
		}
	}
	return true;
}

defaultproperties
{
	bAddToServerPackages=True
	bAlwaysRelevant=True
    GroupName="KF-NEFGameMode"
    FriendlyName="NEFGameMode"
    Description="The New Evolution Freeroam Gamemode"
}