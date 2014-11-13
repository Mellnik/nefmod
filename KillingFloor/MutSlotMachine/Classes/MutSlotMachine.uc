// Written by Marco (2010)
Class MutSlotMachine extends Mutator
	Config(MutSlotMachine);

var const int VersionNumber;
var array<PlayerController> PendingPlayers;
var array<SlotsMachine> SlotMachinePlayers;
var array< class<SlotCard> > LoadedCards;

var() config float AlwaysWinChance,PerSlotPauseTime,AfterRoundPauseTime;
var() config int NewSlotKills;
var() config array<string> CardClasses;
var() config bool bNewSlotByScore,bLogCardChancePrct;

function PostBeginPlay()
{
	local SlotRules R;
	local int i,j;
	local class<SlotCard> C;
	local array< class<SlotCard> > Temp;
	local array<name> Packages;

	for( i=0; i<CardClasses.Length; ++i )
	{
		C = Class<SlotCard>(DynamicLoadObject(CardClasses[i],Class'Class'));
		if( C!=None )
		{
			Temp[Temp.Length] = C;
			for( j=0; j<Packages.Length; ++j )
				if( Packages[j]==C.Outer.Name )
					break;
			if( j==Packages.Length )
				Packages[j] = C.Outer.Name;
		}
	}
	if( Temp.Length==0 )
	{
		Error("No cards available?!");
		return;
	}

	while( Temp.Length>0 ) // Randomize order.
	{
		i = Rand(Temp.Length);
		LoadedCards[LoadedCards.Length] = Temp[i];
		Temp.Remove(i,1);
	}
	if( bLogCardChancePrct )
		LogChances();

	Log("Adding"@Packages.Length@"additional serverpackages...",Class.Outer.Name);
	for( i=0; i<Packages.Length; ++i )
	{
		//Log(Packages[i],'Debug');
		if( Packages[i]!=Class.Outer.Name )
			AddToPackageMap(string(Packages[i]));
	}

	R = Spawn(Class'SlotRules');
	R.Mut = Self;
	R.NextGameRules = Level.Game.GameRulesModifiers;
	Level.Game.GameRulesModifiers = R;
}
final function LogChances()
{
	local float W;
	local int i;

	for( i=0; i<LoadedCards.Length; ++i )
		W+=LoadedCards[i].Default.Desireability;
	for( i=0; i<LoadedCards.Length; ++i )
		Log("Chance for"@LoadedCards[i].Name@"is"@(LoadedCards[i].Default.Desireability/W*100.f)@"%!",'Debug');
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if( PlayerController(Other)!=None )
	{
		PendingPlayers[PendingPlayers.Length] = PlayerController(Other);
		SetTimer(0.1,false);
	}
	return true;
}
function Timer()
{
	while( PendingPlayers.Length>0 )
	{
		if( PendingPlayers[0]!=None && PendingPlayers[0].Player!=None )
			InitPlayer(PendingPlayers[0]);
		PendingPlayers.Remove(0,1);
	}
}

final function InitPlayer( PlayerController P )
{
	local SlotsMachine S;

	S = Spawn(Class'SlotsMachine',P);
	if( S==None )
		return;
	S.Mut = Self;
	S.CardsList = LoadedCards;
	SlotMachinePlayers[SlotMachinePlayers.Length] = S;
	if( NetConnection(P.Player)!=None )
		S.GoToState('LoadingClient');
}
function AwardKill( PlayerController Other, Monster Victim )
{
	local int i;
	local SlotsMachine M;

	for( i=0; i<SlotMachinePlayers.Length; ++i )
	{
		if( SlotMachinePlayers[i].Owner==Other )
		{
			M = SlotMachinePlayers[i];
			break;
		}
	}
	if( M==None || M.NextAllowedTime>Level.TimeSeconds )
		return;
	if( bNewSlotByScore )
		M.TotalKills+=Victim.ScoringValue;
	else ++M.TotalKills;
	while( M.TotalKills>=NewSlotKills )
	{
		M.DrawNextCard();
		M.TotalKills-=NewSlotKills;
	}
}

function NotifyLogout(Controller Exiting)
{
	local int i;

	for( i=0; i<SlotMachinePlayers.Length; ++i )
	{
		if( SlotMachinePlayers[i]==None )
			SlotMachinePlayers.Remove(i--,1);
		else if( SlotMachinePlayers[i].Owner==None || SlotMachinePlayers[i].Owner==Exiting )
		{
			SlotMachinePlayers[i].Destroy();
			SlotMachinePlayers.Remove(i--,1);
		}
	}
	Super.NotifyLogout(Exiting);
}

function GetServerDetails( out GameInfo.ServerResponseLine ServerState )
{
	local int l;

	Super.GetServerDetails( ServerState );
	l = ServerState.ServerInfo.Length;
	ServerState.ServerInfo.Length = l+1;
	ServerState.ServerInfo[l].Key = "Slot Machines";
	ServerState.ServerInfo[l].Value = "Ver"@VersionNumber;
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	local int i;
	local class<SlotCard> C;

	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting(default.RulesGroup,"CardClasses","Cards",1,1,"Text","42",,,True);
	PlayInfo.AddSetting(default.RulesGroup,"AlwaysWinChance","Always win chance",1,0, "Text", "6;0.00:100.00");
	PlayInfo.AddSetting(default.RulesGroup,"PerSlotPauseTime","Per slot pause time",1,0, "Text", "6;0.00:999.00");
	PlayInfo.AddSetting(default.RulesGroup,"AfterRoundPauseTime","After round pause time",1,0, "Text", "6;0.00:999.00");
	PlayInfo.AddSetting(default.RulesGroup,"NewSlotKills","New card kills",1,0, "Text", "5;1:9999");
	PlayInfo.AddSetting(default.RulesGroup,"bNewSlotByScore","New cards by score",1,0, "Check");
	for( i=0; i<Default.CardClasses.Length; ++i )
	{
		C = Class<SlotCard>(DynamicLoadObject(Default.CardClasses[i],Class'Class'));
		if( C!=None )
		{
			C.Static.FillPlayInfo(PlayInfo);
			PlayInfo.PopClass();
		}
	}
}

static function string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "CardClasses":		return "Card classes.";
		case "AlwaysWinChance":		return "In percent, how likely it is that you always get 3 same cards.";
		case "PerSlotPauseTime":	return "Minimum pause time between earning new cards.";
		case "AfterRoundPauseTime":	return "Minimum pause time between rounds of cards.";
		case "NewSlotKills":		return "Minimum number of kills required before getting next card.";
		case "bNewSlotByScore":		return "New cards are earned by score rather than kills.";
	}
	return "";
}

defaultproperties
{
     VersionNumber=100
     AlwaysWinChance=20.000000
     AfterRoundPauseTime=4.000000
     NewSlotKills=4
     CardClasses(0)="MutSlotMachine.CashCard"
     CardClasses(1)="MutSlotMachine.ToxicCard"
     CardClasses(2)="MutSlotMachine.HeartBreakCard"
     CardClasses(3)="MutSlotMachine.AmmoCard"
     CardClasses(4)="MutSlotMachine.ArmorCard"
     CardClasses(5)="MutSlotMachine.GrenadeCard"
     CardClasses(6)="MutSlotMachine.GodModeCard"
     CardClasses(7)="MutSlotMachine.StarmanCard"
     CardClasses(8)="MutSlotMachine.InstaDeathCard"
     CardClasses(9)="MutSlotMachine.ZedDeathCard"
     CardClasses(10)="MutSlotMachine.PipeSelfDestCard"
     CardClasses(11)="MutSlotMachine.PipeSelfDestBCard"
     CardClasses(12)="MutSlotMachine.FleshPoundCard"
     CardClasses(13)="MutSlotMachine.ClotCard"
     CardClasses(14)="MutSlotMachine.SirenCard"
     CardClasses(15)="MutSlotMachine.BloatCard"
     CardClasses(16)="MutSlotMachine.CashShareCard"
     CardClasses(17)="MutSlotMachine.AdrenalineCard"
     CardClasses(18)="MutSlotMachine.DrunkCard"
     CardClasses(19)="MutSlotMachine.TeamFatalityCard"
     CardClasses(20)="MutSlotMachine.CashJackpotCard"
     CardClasses(21)="MutSlotMachine.PatriarchCard"
     bAddToServerPackages=True
     GroupName="KF-Slots"
     FriendlyName="Slot Machines"
     Description="Give players random rewards for kills."
}
