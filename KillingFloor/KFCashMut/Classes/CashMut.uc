class CashMut extends Mutator
	config(KFCashMut);

var config float CashSpawnAmount;

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting("KFCashMut", "CashSpawnAmount", "Cash Amount", 0, 0, "Text", "250;10.0:1000.0");
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "CashSpawnAmount":	return "Set the amount of cash you want to start with.";
	}
}

simulated function PostBeginPlay()
{
	local KFGameType KF;

	KF = KFGameType(Level.Game);
	if ( KF!=None )
	{
		KF.StartingCashBeginner = CashSpawnAmount;
     		KF.StartingCashNormal = CashSpawnAmount;
     		KF.StartingCashHard = CashSpawnAmount;
     		KF.StartingCashSuicidal = CashSpawnAmount;
     		KF.MinRespawnCashBeginner = CashSpawnAmount;
     		KF.MinRespawnCashNormal = CashSpawnAmount;
     		KF.MinRespawnCashHard = CashSpawnAmount;
     		KF.MinRespawnCashSuicidal = CashSpawnAmount;
    		KF.StartingCash = CashSpawnAmount;
    		KF.MinRespawnCash = CashSpawnAmount;
	}
}

defaultproperties
{
     CashSpawnAmount=250.000000
     GroupName="KF-CashMut"
     FriendlyName="Cash Mutator"
     Description="Sets how much cash to respawn and start with."
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
