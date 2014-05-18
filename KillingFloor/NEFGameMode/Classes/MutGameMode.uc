class MutGameMode extends Mutator;

function PostBeginPlay()
{
	SetTimer(100, true);
}

function Timer()
{
	Level.Game.Broadcast(None, "Welcome to New Evolution Freeroam");
}

/*function bool CheckReplacement(Actor Other, out byte bSuperRelevant) 
{
	if (Other.IsA('KFHumanPawn'))
	{
		KFHumanPawn(Other).RequiredEquipment[0] = "KnifeShadowBladeMut.MutKnifeShadowBlade";
		KFHumanPawn(Other).RequiredEquipment[1] = "Pistol9mmNinemmMut.Mut9mmNinemm";
		KFHumanPawn(Other).RequiredEquipment[2] = "KFMod.Frag";
		KFHumanPawn(Other).RequiredEquipment[3] = "KFMod.Syringe";
		KFHumanPawn(Other).RequiredEquipment[4] = "KFMod.Welder";
	}
	return true;
}*/

defaultproperties
{
    GroupName="KF-NEFGameMode"
    FriendlyName="NEFGameMode"
    Description="The New Evolution Freeroam Gamemode"
}