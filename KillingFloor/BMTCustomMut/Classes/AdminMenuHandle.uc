Class AdminMenuHandle extends Info;

var bool bMainMenuOpened;
var KFPlayerController PlayerOwner;
var UI_Replication Rep;
var array<int> PlayerList;
var int EditingIndex;
var ServerStStats EditingStats;
var() name MainMenuID,StatEditID;

var array<string> StatNames,NewStatValues;

function PostBeginPlay()
{
	PlayerOwner = KFPlayerController(Owner);
	if( PlayerOwner==None )
		Error("No KFPlayerController as owner.");
	else
	{
		Rep = Spawn(Class'UI_Replication',PlayerOwner);
		Rep.DlgWindowClosed = WindowClosed;
		Rep.DlgSubmittedValue = SubmittedValue;
	}
}
function Destroyed()
{
	if( Rep!=None )
		Rep.Destroy();
}

function WindowClosed( name ID )
{
	if( ID==MainMenuID )
		Destroy();
}
function SubmittedValue( name ID, int CompID, string Value );
function Tick( float Delta )
{
	if( PlayerOwner==None || Level.Game.bGameEnded )
	{
		if( PlayerOwner!=None )
			PlayerOwner.ClientMessage("Can't edit stats anymore after endgame.");
		Destroy();
	}
}

auto state MainMenu
{
	function BeginState()
	{
		if( !bMainMenuOpened )
		{
			bMainMenuOpened = true;
			Rep.ClientOpenWindow(MainMenuID,0.4,0.3,"Stats Editor");
			Rep.ClientAddComponent(MainMenuID,0,0,true,false,0.1,0.6,0.3,0.2,"Refresh","Refresh players list");
			Rep.ClientAddComponent(MainMenuID,1,1,true,true,0.6,0.6,0.3,0.2,"Edit","Edit stats of selected player");
			Rep.ClientAddComponent(MainMenuID,3,2,true,false,0.35,0.82,0.3,0.15,"Close","Close menu");
		}
		SetPlayerList();
	}
	final function SetPlayerList()
	{
		local Controller C;
		local string S;
		
		PlayerList.Length = 0;
		EditingIndex = 0;
		S = "0;None";
		for( C=Level.ControllerList; C!=None; C=C.nextController )
		{
			if( C.bIsPlayer && xPlayer(C)!=None && ServerStStats(xPlayer(C).SteamStatsAndAchievements)!=none )
			{
				PlayerList[PlayerList.Length] = C.PlayerReplicationInfo.PlayerID;
				S $= ":"$C.PlayerReplicationInfo.PlayerID$" - "$Repl(Left(C.PlayerReplicationInfo.PlayerName,16),":",".");
				if( Len(S)>150 )
				{
					Rep.ClientPendingData(S);
					S = "";
				}
			}
		}
		Rep.ClientAddComponent(MainMenuID,2,6,true,false,0.1,0.1,0.8,0.2,S,"Select player:");
		Rep.ClientSetCompLock(MainMenuID,1,true);
	}
	final function EditPlayerEntry()
	{
		local Controller C;
		local int i;

		if( EditingIndex==0 || (EditingIndex-1)>=PlayerList.Length )
		{
			PlayerOwner.ClientMessage("You selected an invalid player to edit.");
			return;
		}
		i = PlayerList[EditingIndex-1];
		for( C=Level.ControllerList; C!=None; C=C.nextController )
		{
			if( C.bIsPlayer && xPlayer(C)!=None && C.PlayerReplicationInfo.PlayerID==i && ServerStStats(xPlayer(C).SteamStatsAndAchievements)!=none )
			{
				EditingStats = ServerStStats(xPlayer(C).SteamStatsAndAchievements);
				if( !EditingStats.bStatsReadyNow || EditingStats.MyStatsObject==None )
					PlayerOwner.ClientMessage("Your selected players stats aren't ready to be edited yet.");
				else GoToState('EditStats');
				return;
			}
		}
		PlayerOwner.ClientMessage("Your selected player isn't available on server anymore, please refresh.");
	}
	function SubmittedValue( name ID, int CompID, string Value )
	{
		if( ID==MainMenuID )
		{
			switch( CompID )
			{
			case 0:
				SetPlayerList();
				break;
			case 1:
				EditPlayerEntry();
				break;
			case 2:
				EditingIndex = int(Value);
				Rep.ClientSetCompLock(MainMenuID,1,(EditingIndex==0));
				break;
			}
		}
	}
}

state EditStats
{
	function BeginState()
	{
		Rep.ClientOpenWindow(StatEditID,0.9,0.9,"Stats of "$EditingStats.PlayerOwner.PlayerReplicationInfo.PlayerName);
		Rep.ClientAddComponent(StatEditID,0,1,true,false,0.1,0.9,0.15,0.05,"Save","Save changes of this player stats");
		Rep.ClientAddComponent(StatEditID,1,0,true,false,0.47,0.9,0.15,0.05,"Update","Update stats to match client current stats");
		Rep.ClientAddComponent(StatEditID,2,2,true,false,0.8,0.9,0.15,0.05,"Close","Close window without saving changes");
		ReadStats();
	}
	function EndState()
	{
		Rep.ClientCloseWindow(StatEditID);
	}
	function Tick( float Delta )
	{
		if( EditingStats==None )
		{
			PlayerOwner.ClientMessage("Desired player disconnected.");
			GoToState('MainMenu');
		}
		Global.Tick(Delta);
	}
	function WindowClosed( name ID )
	{
		if( ID==StatEditID )
			GoToState('MainMenu');
		else Global.WindowClosed(ID);
	}
	final function AddStat( out int ID, int CurValue, out float X, out float Y, string Info )
	{
		Rep.ClientAddComponent(StatEditID,ID++,5,true,false,X,Y,0.28,0.04,"0:150000000:1:"$CurValue,Left(Info,13));
		Y+=0.04;
		if( Y>=0.85 )
		{
			X += 0.3;
			Y = 0.025;
		}
	}
	final function AddStatStr( out int ID, string CurValue, out float X, out float Y, string Info )
	{
		Rep.ClientAddComponent(StatEditID,ID++,3,true,false,X,Y,0.28,0.04,CurValue,Left(Info,13));
		Y+=0.04;
		if( Y>=0.85 )
		{
			X += 0.3;
			Y = 0.025;
		}
	}
	final function ReadStats()
	{
		local int i,j;
		local float X,Y;
		local StatsObject S;
		
		i = 3;
		S = EditingStats.MyStatsObject;
		X = 0.015;
		Y = 0.025;

		NewStatValues.Length = 0;
		for( j=0; j<StatNames.Length; ++j )
			AddStat(i,int(S.GetPropertyText(StatNames[j])),X,Y,StatNames[j]);
		for( j=0; j<S.CC.Length; ++j )
			AddStatStr(i,S.CC[j].V,X,Y,string(S.CC[j].N));
	}
	final function SaveStats()
	{
		local int i;
		local StatsObject S;
		
		Log(PlayerOwner.PlayerReplicationInfo.PlayerName$" edited stats of "$EditingStats.PlayerOwner.PlayerReplicationInfo.PlayerName,Class.Outer.Name);
		S = EditingStats.MyStatsObject;
		for( i=0; i<NewStatValues.Length; ++i )
			if( NewStatValues[i]!="" )
			{
				if( i<StatNames.Length )
					S.SetPropertyText(StatNames[i],NewStatValues[i]);
				else S.CC[i-StatNames.Length].V = NewStatValues[i];
			}
		EditingStats.RepCopyStats();
		EditingStats.NotifyStatChanged();
	}

	function SubmittedValue( name ID, int CompID, string Value )
	{
		if( ID==StatEditID )
		{
			switch( CompID )
			{
			case 0:
				SaveStats();
				break;
			case 1:
				ReadStats();
				break;
			case 2:
				GoToState('MainMenu');
				break;
			default:
				if( CompID>=3 )
				{
					CompID-=3;
					if( CompID>=NewStatValues.Length )
						NewStatValues.Length = CompID+1;
					NewStatValues[CompID] = Value;
				}
			}
		}
	}
}

defaultproperties
{
	StatNames(0)="DamageHealedStat"
	StatNames(1)="WeldingPointsStat"
	StatNames(2)="ShotgunDamageStat"
	StatNames(3)="HeadshotKillsStat"
	StatNames(4)="StalkerKillsStat"
	StatNames(5)="BullpupDamageStat"
	StatNames(6)="MeleeDamageStat"
	StatNames(7)="FlameThrowerDamageStat"
	StatNames(8)="SelfHealsStat"
	StatNames(9)="SoleSurvivorWavesStat"
	StatNames(10)="CashDonatedStat"
	StatNames(11)="FeedingKillsStat"
	StatNames(12)="BurningCrossbowKillsStat"
	StatNames(13)="GibbedFleshpoundsStat"
	StatNames(14)="StalkersKilledWithExplosivesStat"
	StatNames(15)="GibbedEnemiesStat"
	StatNames(16)="BloatKillsStat"
	StatNames(17)="SirenKillsStat"
	StatNames(18)="KillsStat"
	StatNames(19)="ExplosivesDamageStat"
	StatNames(20)="TotalPlayTime"
	StatNames(21)="WinsCount"
	StatNames(22)="LostsCount"
	StatNames(23)="TotalZedTimeStat"
	MainMenuID="i"
	StatEditID="j"
}