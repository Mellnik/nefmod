Class PortalMut extends Mutator;
    
function ModifyPlayer(Pawn Player)
{
     Super.ModifyPlayer(Player);
     Player.GiveWeapon("RocketPortalTurret.RPTurret");
	 
}

defaultproperties
{
     bAddToServerPackages=True
     GroupName="KF_PTurretR1"
     FriendlyName="PTurret R1"
     Description="PTurretR1"
     bAlwaysRelevant=True
}
