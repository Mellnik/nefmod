class PBMut extends Mutator;

function ModifyPlayer(Pawn Player)
{
     Super.ModifyPlayer(Player);
     //Player.GiveWeapon("PerkBotsMut.ZerkSentryGun");
	 //Player.GiveWeapon("PerkBotsMut.SSSentryGun");
	 //Player.GiveWeapon("PerkBotsMut.DemoSentryGun");
	 //Player.GiveWeapon("PerkBotsMut.ArmSentryGun");
}

defaultproperties
{
     bAddToServerPackages=True
     GroupName="KF-PerkBots"
     FriendlyName="Perk Bots Mutator1s"
     Description="Adds Perk Bots."
}
