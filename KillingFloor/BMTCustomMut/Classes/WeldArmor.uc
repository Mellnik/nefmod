class WeldArmor extends Mutator;
    
function PreBeginPlay()
{
    // Add all needed packages.
    AddToPackageMap("WeldArmor");
}

/*function ModifyPlayer(Pawn Player)
{
     Super.ModifyPlayer(Player);
     Player.GiveWeapon("BMTCustomMut.WelderEX");
}*/

function bool CheckReplacement(Actor Other, out byte bSuperRelevant) {
    if (Other.IsA('KFHumanPawn'))
        KFHumanPawn(Other).RequiredEquipment[4] = "BMTCustomMut.WelderEX";

    return true;
}

defaultproperties
{
     bAddToServerPackages=True
     GroupName="KF_WeldArmor"
     FriendlyName="-BMT- Weld Bots"
     Description="Weld Teammates and Bots but at a price"
     bAlwaysRelevant=True
}
