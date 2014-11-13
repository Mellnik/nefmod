// Written by .:..: (2009)
Class BMTCustomMut extends Mutator
	Config(BMTCustomMut);

struct ChatIconType
{
	var() config string IconTexture,IconTag;
	var() config bool bCaseInsensitive;
};

struct TCustomPlayerRecord
{
	var string PlayerID;
	var string Status;
	var string CSkins;
	var Color STColor;
};


var() globalconfig array<string> Perks,TraderInventory,WeaponCategories,CustomCharacters,News;
var() globalconfig int MinPerksLevel,MaxPerksLevel,RemotePort,MidGameSaveWaves;
var() globalconfig float RequirementScaling;
var() globalconfig string RemoteDatabaseURL,RemotePassword,SharedSkins,DefaultStatus;
var() globalconfig array<ChatIconType> SmileyTags;
var() globalconfig array<TCustomPlayerRecord> CustomPlayers;

var array<byte> LoadInvCategory;
var array< class<SRVeterancyTypes> > LoadPerks;
var array< class<Pickup> > LoadInventory;
var const int VersionNumber;
var array<PlayerController> PendingPlayers;
var array<StatsObject> ActiveStats;
var localized string ServerPerksGroup;
var transient DatabaseUdpLink Link;
var array<ServerStStats> PendingData;
var KFGameType KFGT;
var int LastSavedWave,WaveCounter;
var SRGameRules RulesMod;
var transient array<name> AddedServerPackages;
var transient float NextCheckTimer;
var array<SRHUDKillingFloor.SmileyMessageType> SmileyMsgs;

var() globalconfig bool bForceGivePerk,bNoSavingProgress,bUseRemoteDatabase,bUsePlayerNameAsID,bMessageAnyPlayerLevelUp
			,bUseLowestRequirements,bBWZEDTime,bUseEnhancedScoreboard,bOverrideUnusedCustomStats,bAllowAlwaysPerkChanges
			,bForceCustomChars,bEnableChatIcons,bEnhancedShoulderView,bFixGrenadeExploit,bAdminEditStats;
var bool bEnabledEmoIcons;

final function SetCustomPlayer(PlayerController PC)
{
	local int i;
	
	for( i=(CustomPlayers.Length-1); i>=0; --i )
	{
		if (GetPlayerID(PC) ~= CustomPlayers[i].PlayerID)
		{
			SRPlayerReplicationInfo(PC.PlayerReplicationInfo).Status = CustomPlayers[i].Status;
			SRPlayerReplicationInfo(PC.PlayerReplicationInfo).STColor = CustomPlayers[i].STColor;
			SRPlayerReplicationInfo(PC.PlayerReplicationInfo).CSkins = CustomPlayers[i].CSkins;
			return;
		}
	}
}

function PostBeginPlay()
{
	local int i,j;
	local class<SRVeterancyTypes> V;
	local class<Pickup> P;
	local string S;
	local byte Cat;
	local class<PlayerRecordClass> PR;
	local Texture T;

	if( RulesMod==None )
		RulesMod = Spawn(Class'SRGameRules');

	KFGT = KFGameType(Level.Game);
	if( Level.Game.HUDType~=Class'KFGameType'.Default.HUDType || Level.Game.HUDType~=Class'KFStoryGameInfo'.Default.HUDType )
	{
		bEnabledEmoIcons = bEnableChatIcons;
		Level.Game.HUDType = string(Class'SRHUDKillingFloor');
	}

	if( bUseEnhancedScoreboard && (Level.Game.ScoreBoardType~=Class'KFGameType'.Default.ScoreBoardType || Level.Game.ScoreBoardType~=Class'KFStoryGameInfo'.Default.ScoreBoardType) )
		Level.Game.ScoreBoardType = string(Class'SRScoreBoardMM');

	// Use own playercontroller class for security reasons.
	if( Level.Game.PlayerControllerClass==Class'KFPlayerController' || Level.Game.PlayerControllerClass==Class'KFPlayerController_Story' )
	{
		Level.Game.PlayerControllerClass = Class'KFPCServ';
		Level.Game.PlayerControllerClassName = string(Class'KFPCServ');
	}
	DeathMatch(Level.Game).LoginMenuClass = string(Class'SRInvasionLoginMenu');

	// Load perks.
	for( i=0; i<Perks.Length; i++ )
	{
		V = class<SRVeterancyTypes>(DynamicLoadObject(Perks[i],Class'Class'));
		if( V!=None )
		{
			LoadPerks[LoadPerks.Length] = V;
			ImplementPackage(V);
		}
	}
	if( WeaponCategories.Length==0 )
	{
		WeaponCategories.Length = 1;
		WeaponCategories[0] = "All";
	}

	// Load up trader inventory.
	for( i=0; i<TraderInventory.Length; i++ )
	{
		S = TraderInventory[i];
		j = InStr(S,":");
		if( j>0 )
		{
			Cat = Min(int(Left(S,j)),WeaponCategories.Length-1);
			S = Mid(S,j+1);
		}
		else Cat = 0;
		P = class<Pickup>(DynamicLoadObject(S,Class'Class'));
		if( P!=None )
		{
			LoadInventory[LoadInventory.Length] = P;
			LoadInvCategory[LoadInvCategory.Length] = Cat;
			if( P.Outer.Name!='KFMod' )
				ImplementPackage(P);
		}
	}

	// Load custom chars.
	for( i=0; i<CustomCharacters.Length; ++i )
	{
		// Separate group from actual skin.
		S = CustomCharacters[i];
		j = InStr(S,":");
		if( j>=0 )
			S = Mid(S,j+1);
		PR = class<PlayerRecordClass>(DynamicLoadObject(S$"Mod."$S,class'Class',true));
		if( PR!=None )
		{
			if( PR.Default.MeshName!="" ) // Add mesh package.
				ImplementPackage(DynamicLoadObject(PR.Default.MeshName,class'Mesh',true));
			if( PR.Default.BodySkinName!="" ) // Add skin package.
				ImplementPackage(DynamicLoadObject(PR.Default.BodySkinName,class'Material',true));
			ImplementPackage(PR);
		}
	}
	
	// Load chat icons
	if( bEnabledEmoIcons )
	{
		j = 0;
		for( i=0; i<SmileyTags.Length; ++i )
		{
			if( SmileyTags[i].IconTexture=="" || SmileyTags[i].IconTag=="" )
				continue;
			T = Texture(DynamicLoadObject(SmileyTags[i].IconTexture,class'Texture',true));
			if( T==None )
				continue;
			ImplementPackage(T);
			SmileyMsgs.Length = j+1;
			SmileyMsgs[j].SmileyTex = T;
			if( SmileyTags[i].bCaseInsensitive )
				SmileyMsgs[j].SmileyTag = Caps(SmileyTags[i].IconTag);
			else SmileyMsgs[j].SmileyTag = SmileyTags[i].IconTag;
			SmileyMsgs[j].bInCAPS = SmileyTags[i].bCaseInsensitive;
			++j;
		}
		bEnabledEmoIcons = (j!=0);
	}

	Log("Adding"@AddedServerPackages.Length@"additional serverpackages",Class.Outer.Name);
	for( i=0; i<AddedServerPackages.Length; i++ )
		AddToPackageMap(string(AddedServerPackages[i]));
	AddedServerPackages.Length = 0;
	
	if( bUseEnhancedScoreboard || (Level.Game.HUDType~=string(Class'SRHUDKillingFloor')) )
		AddToPackageMap("CountryFlagsTex");

	if( bFixGrenadeExploit )
		Class'Frag'.Default.FireModeClass[0] = Class'FragFireFix';

	if( bUseRemoteDatabase )
	{
		Log("Using remote database:"@RemoteDatabaseURL$":"$RemotePort,Class.Outer.Name);
		Link = Spawn(Class'DatabaseUdpLink');
		Link.Mut = Self;
	}
}

function Mutate(string MutateString, PlayerController Sender)
{
	if( bAdminEditStats && MutateString~="EditStats" && (Sender.PlayerReplicationInfo.bAdmin || Sender.PlayerReplicationInfo.bSilentAdmin || Viewport(Sender.Player)!=None) )
		Spawn(Class'AdminMenuHandle',Sender);
	else if( NextCheckTimer<Level.TimeSeconds && MutateString~="Debug" ) // Allow developer to lookup bugs.
	{
		NextCheckTimer = Level.TimeSeconds+0.25;
		Sender.ClientMessage("Debug info: "$Sender.SteamStatsAndAchievements);
		if( ServerStStats(Sender.SteamStatsAndAchievements)!=None )
		{
			Sender.ClientMessage("Ready:"@ServerStStats(Sender.SteamStatsAndAchievements).bStatsReadyNow@ServerStStats(Sender.SteamStatsAndAchievements).bStatsChecking);
			Sender.ClientMessage("MyStatsObject:"@ServerStStats(Sender.SteamStatsAndAchievements).MyStatsObject);
			Sender.ClientMessage("Timer:"@Sender.SteamStatsAndAchievements.TimerCounter@Sender.SteamStatsAndAchievements.TimerRate);
		}
	}
	if ( NextMutator != None )
		NextMutator.Mutate(MutateString, Sender);
}
final function ImplementPackage( Object O )
{
	local int i;
	
	if( O==None )
		return;
	while( O.Outer!=None )
		O = O.Outer;
	if( O.Name=='KFMod' )
		return;
	for( i=(AddedServerPackages.Length-1); i>=0; --i )
		if( AddedServerPackages[i]==O.Name )
			return;
	AddedServerPackages[AddedServerPackages.Length] = O.Name;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if( Controller(Other) !=None )
		Controller(Other).PlayerReplicationInfoClass = Class'SRPlayerReplicationInfo';
		
	if( PlayerController(Other)!=None )
	{
		PendingPlayers[PendingPlayers.Length] = PlayerController(Other);
		SetTimer(0.1,false);
	}
	else if( ServerStStats(Other)!=None )
		SetServerPerks(ServerStStats(Other));
	else if( ClientPerkRepLink(Other)!=None )
		SetupRepLink(ClientPerkRepLink(Other));

	return true;
}
final function SetServerPerks( ServerStStats Stat )
{
	local int i;

	Stat.MutatorOwner = Self;
	Stat.Rep.MinimumLevel = MinPerksLevel+1;
	Stat.Rep.MaximumLevel = MaxPerksLevel+1;
	Stat.Rep.RequirementScaling = RequirementScaling;
	Stat.Rep.CachePerks.Length = LoadPerks.Length;
	for( i=0; i<LoadPerks.Length; i++ )
		Stat.Rep.CachePerks[i].PerkClass = LoadPerks[i];
}
final function SetupRepLink( ClientPerkRepLink R )
{
	local int i;

	R.bMinimalRequirements = bUseLowestRequirements;
	R.bBWZEDTime = bBWZEDTime;
	R.bNoStandardChars = bForceCustomChars;

	R.ShopInventory.Length = LoadInventory.Length;
	for( i=0; i<LoadInventory.Length; ++i )
	{
		R.ShopInventory[i].PC = LoadInventory[i];
		R.ShopInventory[i].CatNum = LoadInvCategory[i];
	}
	R.ShopCategories = WeaponCategories;
	R.CustomChars = CustomCharacters;
	if( bEnabledEmoIcons )
		R.SmileyTags = SmileyMsgs;
}

function GetServerDetails( out GameInfo.ServerResponseLine ServerState )
{
	local int i,l;

	Super.GetServerDetails( ServerState );
	l = ServerState.ServerInfo.Length;
	ServerState.ServerInfo.Length = l+1;
	ServerState.ServerInfo[l].Key = "Veterancy Handler";
	ServerState.ServerInfo[l].Value = "Ver"@VersionNumber;
	l++;
	ServerState.ServerInfo.Length = l+1;
	ServerState.ServerInfo[l].Key = "Veterancy saving";
	ServerState.ServerInfo[l].Value = Eval(bNoSavingProgress,"Disabled","Enabled");
	l++;
	ServerState.ServerInfo.Length = l+1;
	ServerState.ServerInfo[l].Key = "Min perk level";
	ServerState.ServerInfo[l].Value = string(MinPerksLevel);
	l++;
	ServerState.ServerInfo.Length = l+1;
	ServerState.ServerInfo[l].Key = "Max perk level";
	ServerState.ServerInfo[l].Value = string(MaxPerksLevel);
	l++;
	ServerState.ServerInfo.Length = l+1;
	ServerState.ServerInfo[l].Key = "Num trader weapons";
	ServerState.ServerInfo[l].Value = string(LoadInventory.Length);
	l++;
	For( i=0; i<LoadPerks.Length; i++ )
	{
		ServerState.ServerInfo.Length = l+1;
		ServerState.ServerInfo[l].Key = "Veterancy";
		ServerState.ServerInfo[l].Value = LoadPerks[i].Default.VeterancyName;
		l++;
	}
}
function Timer()
{
	local int i;
	
	for( i=(PendingPlayers.Length-1); i>=0; --i )
	{
		if( KFPCServ(PendingPlayers[i])!=None )
			KFPCServ(PendingPlayers[i]).bUseAdvBehindview = bEnhancedShoulderView;
		if( PendingPlayers[i]!=None && PendingPlayers[i].Player!=None && ServerStStats(PendingPlayers[i].SteamStatsAndAchievements)==None )
		{
			if( PendingPlayers[i].SteamStatsAndAchievements!=None )
				PendingPlayers[i].SteamStatsAndAchievements.Destroy();
			PendingPlayers[i].SteamStatsAndAchievements = Spawn(Class'ServerStStats',PendingPlayers[i]);
			SetCustomPlayer(PendingPlayers[0]);
			SRPlayerReplicationInfo(PendingPlayers[0].PlayerReplicationInfo).CSkins $= SharedSkins;
		}
	}
	PendingPlayers.Length = 0;
}

static final function string GetPlayerID( PlayerController PC )
{
	if( Default.bUsePlayerNameAsID )
		return PC.PlayerReplicationInfo.PlayerName;
	return PC.GetPlayerIDHash();
}
final function StatsObject GetStatsForPlayer( PlayerController PC )
{
	local StatsObject S;
	local string SId;
	local int i;

	if( bNoSavingProgress || Level.Game.bGameEnded )
		return None;
	SId = GetPlayerID(PC);
	for( i=0; i<ActiveStats.Length; ++i )
		if( string(ActiveStats[i].Name)~=SId )
		{
			S = ActiveStats[i];
			break;
		}
	if( S==None )
	{
		S = new(None,SId) Class'StatsObject';
		ActiveStats[ActiveStats.Length] = S;
	}
	S.PlayerName = PC.PlayerReplicationInfo.PlayerName;
	S.PlayerIP = PC.GetPlayerNetworkAddress();
	return S;
}

final function SaveStats()
{
	local int i;
	local ClientPerkRepLink CP;

	Log("*** Saving "$ActiveStats.Length$" stat objects ***",Class.Outer.Name);
	foreach DynamicActors(Class'ClientPerkRepLink',CP)
		if( CP.StatObject!=None && ServerStStats(CP.StatObject).MyStatsObject!=None )
			ServerStStats(CP.StatObject).MyStatsObject.SetCustomValues(CP.CustomLink);

	if( bUseRemoteDatabase )
	{
		if( Link!=None )
			Link.SaveStats();
		return;
	}
	for( i=0; i<ActiveStats.Length; ++i )
		if( ActiveStats[i].bStatsChanged )
		{
			ActiveStats[i].bStatsChanged = false;
			ActiveStats[i].SaveConfig();
		}
}
final function CheckWinOrLose()
{
	local bool bWin;
	local Controller P;
	local PlayerController Player;

	bWin = (KFGameReplicationInfo(Level.GRI)!=None && KFGameReplicationInfo(Level.GRI).EndGameType==2);
	for ( P = Level.ControllerList; P != none; P = P.nextController )
	{
		Player = PlayerController(P);

		if ( Player != none )
		{
			if ( ServerStStats(Player.SteamStatsAndAchievements)!=None )
				ServerStStats(Player.SteamStatsAndAchievements).WonLostGame(bWin);
		}
	}
}
final function InitNextWave()
{
	if( ++WaveCounter>=MidGameSaveWaves )
	{
		WaveCounter = 0;
		SaveStats();
	}
}

Auto state EndGameTracker
{
Begin:
	while( !Level.Game.bGameEnded )
	{
		Sleep(1.f);
		if( MidGameSaveWaves>0 && KFGT!=None && KFGT.WaveNum!=LastSavedWave )
		{
			LastSavedWave = KFGT.WaveNum;
			InitNextWave();
		}
		if( Level.bLevelChange )
		{
			SaveStats();
			Stop;
		}
	}
	CheckWinOrLose();
	SaveStats();
}

final function ReceivedPlayerID( string S )
{
	local int i,RID;

	i = InStr(S,"|");
	RID = int(Left(S,i));
	S = Mid(S,i+1);

	for( i=0; i<PendingData.Length; ++i )
	{
		if( PendingData[i]==None )
			PendingData.Remove(i--,1);
		else if( S~=string(PendingData[i].MyStatsObject.Name) )
		{
			PendingData[i].SetID(RID);
			break;
		}
	}
}
final function ReceivedPlayerData( string S )
{
	local int i,RID;

	i = InStr(S,"|");
	RID = int(Left(S,i));
	S = Mid(S,i+1);

	for( i=0; i<PendingData.Length; ++i )
	{
		if( PendingData[i]==None )
			PendingData.Remove(i--,1);
		else if( RID==PendingData[i].GetID() )
		{
			PendingData[i].GetData(S);
			PendingData.Remove(i,1);
			break;
		}
	}
}
final function string GetSafeName( string S )
{
	ReplaceText(S,"=","-");
	ReplaceText(S,Chr(10),""); // LF
	ReplaceText(S,Chr(13),""); // CR
	ReplaceText(S,Chr(34),"'"); // "
	return S;
}
final function GetRemoteStatsForPlayer( ServerStStats Other )
{
	local int i;

	if( Link==None || !Link.bConnectionReady )
		return;
	Link.SendText(Link.A,Chr(Link.ENetID.ID_NewPlayer)$Other.MyStatsObject.Name$"*"$GetSafeName(Other.PlayerOwner.PlayerReplicationInfo.PlayerName));
	for( i=0; i<PendingData.Length; ++i )
		if( PendingData[i]==Other )
			return;
	PendingData[PendingData.Length] = Other;
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting(default.ServerPerksGroup,"Perks","Perk Classes",1,1,"Text","42",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"News","Servernews",1,1,"Text","50",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"CustomCharacters","Custom chars",1,1,"Text","42",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"TraderInventory","Trader Weapons",1,1,"Text","42",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"WeaponCategories","Weapon categories",1,1,"Text","42",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"MinPerksLevel","Min Perk Level",1,0, "Text", "4;-1:254",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"MaxPerksLevel","Max Perk Level",1,0, "Text", "4;0:254",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"RequirementScaling","Req Scaling",1,0, "Text", "6;0.01:4.00",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"bForceGivePerk","Force perks",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bNoSavingProgress","No saving",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bAllowAlwaysPerkChanges","Unlimited perk changes",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bUseRemoteDatabase","Use remote database",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"RemoteDatabaseURL","Remote database URL",1,1,"Text","64",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"RemotePort","Remote database port",1,0, "Text", "5;0:65535",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"RemotePassword","Remote database password",1,0, "Text", "64",,,True);
	PlayInfo.AddSetting(default.ServerPerksGroup,"MidGameSaveWaves","MidGame Save Waves",1,0, "Text", "5;0:10",,,True);

	PlayInfo.AddSetting(default.ServerPerksGroup,"bUsePlayerNameAsID","Use PlayerName as ID",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bMessageAnyPlayerLevelUp","Notify any levelup",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bUseLowestRequirements","Use lowest req",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bBWZEDTime","BW ZED-time",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bUseEnhancedScoreboard","Enhanced scoreboard",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bForceCustomChars","Force Custom Chars",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bEnableChatIcons","Enable chat icons",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bEnhancedShoulderView","Shoulder view",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bFixGrenadeExploit","No Grenade Exploit",1,0, "Check");
	PlayInfo.AddSetting(default.ServerPerksGroup,"bAdminEditStats","Admin edit stats",1,0, "Check");
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "Perks":				return "Perk classes.";
		case "News":						return "Servernews.";
		case "CustomCharacters":	return "Custom mod characters.";
		case "MinPerksLevel":		return "Minimum perk level players can have.";
		case "MaxPerksLevel":		return "Maximum perk level players can have.";
		case "RequirementScaling":	return "Perk requirements scaling.";
		case "bForceGivePerk":		return "Force all players to get at least a random perk if they have none selected.";
		case "bNoSavingProgress":	return "Server shouldn't save perk progression.";
		case "bUseRemoteDatabase":	return "Instead of storing perk data locally on server, use remote data storeage server.";
		case "RemoteDatabaseURL":	return "URL of the remote database.";
		case "RemotePort":			return "Port of the remote database.";
		case "RemotePassword":		return "Password for server to access the remote database.";
		case "MidGameSaveWaves":	return "Between how many waves should it mid-game save stats.";
		case "TraderInventory":		return "Trader inventory classes list";
		case "bUsePlayerNameAsID":	return "Use PlayerName's as ID instead of ID Hash.";
		case "bMessageAnyPlayerLevelUp": return "Broadcast a global message anytime someone gains a perk upgrade.";
		case "bUseLowestRequirements":	return "Use lowest form of requirements for perks.";
		case "bBWZEDTime":			return "Make screen go black and white during ZED-time.";
		case "WeaponCategories":	return "Weapon category names.";
		case "bUseEnhancedScoreboard":	return "Should use serverperk's own scoreboard.";
		case "bAllowAlwaysPerkChanges":	return "Allow unlimited perk changes.";
		case "bForceCustomChars":	return "Force players to use specified custom characters.";
		case "bEnableChatIcons":	return "Should enable chat icons to replace specific tags in chat.";
		case "bEnhancedShoulderView": return "Should enable a more enhanced on shoulder behindview.";
		case "bFixGrenadeExploit":	return "Should fix unlimited grenades glitch/exploit.";
		case "bAdminEditStats":		return "Allow admins edit stats through an admin menu.";
	}
	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
     VersionNumber=650
     ServerPerksGroup="Perks"
     GroupName="KF-BMTCustomPerks"
     FriendlyName="BMT Custom Perks"
     Description="BMT Custom perks."
	 Perks(0)="BMTCustomMut.WTFPerksFieldMedic"
	 Perks(1)="BMTCustomMut.WTFPerksSupportSpec"
	 Perks(2)="BMTCustomMut.WTFPerksSharpshooter"
	 Perks(3)="BMTCustomMut.WTFPerksCommando"
	 Perks(4)="BMTCustomMut.WTFPerksBerserker"
	 Perks(5)="BMTCustomMut.WTFPerksFirebug"
	 Perks(6)="BMTCustomMut.WTFPerksDemolitions"
	 Perks(7)="BMTCustomMut.WTFPerksMarine"
	 Perks(8)="BMTCustomMut.WTFPerksOddball"
	 Perks(9)="BMTCustomMut.WTFPerksOutlaw"
	 Perks(10)="BMTCustomMut.WTFPerksMachineGunner"
	 Perks(11)="BMTCustomMut.WTFPerksJedi"
	 Perks(12)="BMTCustomMut.WTFPerksLoser"
	 Perks(13)="BMTCustomMut.WTFPerksGeneral"
	 MinPerksLevel=0
	 MaxPerksLevel=50
	 RequirementScaling=1
	 RemotePort=5000
	 RemoteDatabaseURL="192.168.1.33"
	 RemotePassword="Pass"
	 bUseEnhancedScoreboard=true
	 bEnableChatIcons=true
	 bEnhancedShoulderView=false
	 bFixGrenadeExploit=true
	 bAdminEditStats=true

	 TraderInventory(0)="0:KFMod.MachetePickup"
	 TraderInventory(1)="0:KFMod.AxePickup"
	 TraderInventory(2)="0:KFMod.ChainsawPickup"
	 TraderInventory(3)="0:KFMod.KatanaPickup"
	 TraderInventory(4)="0:BMTCustomMut.SekiraPickup"
	 TraderInventory(5)="0:BMTCustomMut.WTFEquipChainsawPickup"
	 TraderInventory(6)="0:BMTCustomMut.WTFEquipFireAxePickup"
	 TraderInventory(7)="0:BMTCustomMut.WTFEquipKatanaPickup"
	 TraderInventory(8)="0:BMTCustomMut.WTFKnifePickup"
	 TraderInventory(9)="0:BMTCustomMut.ScytheaPickup"
	 TraderInventory(10)="1:BMTCustomMut.DeaglePickupExt"
	 TraderInventory(11)="1:BMTCustomMut.DualDeaglePickupExt"
	 //TraderInventory(12)="1:BMTCustomMut.PTurretPickup"
	 TraderInventory(13)="1:BMTCustomMut.MK23PickupExt"
	 TraderInventory(14)="1:BMTCustomMut.DualMK23PickupExt"
	 TraderInventory(15)="1:BMTCustomMut.WTFEquipMachineDualiesPickup"
	 TraderInventory(16)="1:BMTCustomMut.WTFEquipMachinePistolPickup"
	 TraderInventory(17)="2:BMTCustomMut.Winchester2Pickup"
	 TraderInventory(18)="2:BMTCustomMut.CrossbowExtPickup"
	 TraderInventory(19)="2:BMTCustomMut.SA80Pickup"
	 TraderInventory(20)="2:BMTCustomMut.WTFEquipCrossbowPickup"
	 TraderInventory(21)="2:BMTCustomMut.B94Pickup"
	 TraderInventory(22)="3:KFMod.ShotgunPickup"
	 TraderInventory(23)="3:KFMod.BoomStickPickup"
	 TraderInventory(24)="3:BMTCustomMut.AA12ExtPickup"
	 TraderInventory(25)="3:KFMod.BenelliPickup"
	 TraderInventory(26)="3:BMTCustomMut.KSGPickup"
	 TraderInventory(27)="3:BMTCustomMut.WTFEquipAFS12Pickup"
	 TraderInventory(28)="3:BMTCustomMut.WTFEquipShotgunPickup"
	 TraderInventory(29)="3:BMTCustomMut.WTFEquipBoomStickPickup"
	 TraderInventory(30)="3:BMTCustomMut.WTFEquipSawedOffShotgunPickup"
	 TraderInventory(31)="3:BMTCustomMut.WTFEquipShotgun"
	 TraderInventory(32)="3:BMTCustomMut.LilithKissPickup"
	 TraderInventory(33)="4:KFMod.M4Pickup"
	 TraderInventory(34)="4:KFMod.BullpupPickup"
	 TraderInventory(35)="4:KFMod.AK47Pickup"
	 TraderInventory(36)="4:KFMod.SCARMK17Pickup"
	 TraderInventory(37)="4:BMTCustomMut.FnFalAPickup2"
	 TraderInventory(38)="4:BMTCustomMut.P90Pickup"
	 TraderInventory(39)="4:BMTCustomMut.WTFEquipAK48SPickup"
	 TraderInventory(40)="4:BMTCustomMut.WTFEquipBulldogPickup"
	 TraderInventory(41)="4:BMTCustomMut.WTFEquipSCAR19Pickup"
	 TraderInventory(42)="4:BMTCustomMut.HK417Pickup"
	 TraderInventory(43)="5:KFMod.LAWPickup"
	 TraderInventory(44)="5:KFMod.PipeBombPickup"
	 TraderInventory(45)="5:KFMod.M79Pickup"
	 TraderInventory(46)="5:KFMod.M32Pickup"
	 TraderInventory(47)="5:BMTCustomMut.WTFEquipBanHammerPickup"
	 TraderInventory(48)="5:BMTCustomMut.M79CFPickup"
	 TraderInventory(49)="5:BMTCustomMut.PipeBomb2Pickup"
	 TraderInventory(50)="5:BMTCustomMut.WTFLawPickup"
	 TraderInventory(51)="5:BMTCustomMut.WTFEquipSelfDestructPickup"
	 TraderInventory(52)="5:BMTCustomMut.WTFEquipUM32Pickup"
	 TraderInventory(53)="5:BMTCustomMut.BizonPickup"
	 TraderInventory(54)="6:KFMod.FlameThrowerPickup"
	 TraderInventory(55)="6:KFMod.Mac10Pickup"
	 TraderInventory(56)="6:KFMod.HuskgunPickup"
	 TraderInventory(57)="6:BMTCustomMut.UMP45Pickup"
	 TraderInventory(58)="6:BMTCustomMut.WTFFlamerPickup"
	 TraderInventory(59)="6:BMTCustomMut.M79CFPickup"
	 TraderInventory(60)="6:BMTCustomMut.FRevolverPickup"
	 TraderInventory(61)="6:BMTCustomMut.DualFRevolverPickup"
	 TraderInventory(62)="6:BMTCustomMut.FM32Pickup"
	 TraderInventory(63)="7:BMTCustomMut.MP5PickupExtend"
	 TraderInventory(64)="7:BMTCustomMut.M7A3MPickupExt"
	 TraderInventory(65)="7:BMTCustomMut.HealingKatanaPickup"
	 TraderInventory(66)="7:BMTCustomMut.WTFEquipLethalInjectionPickup"
	 TraderInventory(67)="7:BMTCustomMut.MP7MPickupExt"
	 TraderInventory(68)="7:BMTCustomMut.KrissMPickupA"
	 TraderInventory(69)="7:BMTCustomMut.XMk5Pickup"
	 TraderInventory(70)="7:BMTCustomMut.NetskySyringeDropPickup"
	 TraderInventory(71)="10:BMTCustomMut.OutlawWinchesterPickup"
	 TraderInventory(72)="10:BMTCustomMut.WColtPickup"
	 TraderInventory(73)="10:BMTCustomMut.OutlawDeaglePickup"
	 TraderInventory(74)="10:BMTCustomMut.OutlawDualDeaglePickup"
	 TraderInventory(75)="10:BMTCustomMut.OutlawDualiesPickup"
	 TraderInventory(76)="11:BMTCustomMut.M41APickup"
	 TraderInventory(77)="11:BMTCustomMut.G43ScopePickup"
	 TraderInventory(78)="11:BMTCustomMut.STG44Pickup"
	 TraderInventory(79)="11:BMTCustomMut.TT33Pickup"
	 TraderInventory(80)="12:BMTCustomMut.MP40Pickup"
	 TraderInventory(81)="12:BMTCustomMut.PPDPickup"
	 TraderInventory(82)="12:BMTCustomMut.M44Pickup"
	 TraderInventory(83)="12:BMTCustomMut.ThompsonPickup"
	 TraderInventory(84)="12:BMTCustomMut.M249Pickup"
	 TraderInventory(85)="12:BMTCustomMut.XMV850Pickup"
	 TraderInventory(86)="12:BMTCustomMut.MKb42aPickup"
	 TraderInventory(87)="13:BMTCustomMut.ZEDGunPickupA"
	 TraderInventory(88)="13:BMTCustomMut.litesaberpickup"
	 TraderInventory(89)="14:BMTCustomMut.Tech_AdvancedWelderPickup"
	 TraderInventory(90)="14:BMTCustomMut.Tech_BioLauncherPickup"
	 TraderInventory(91)="14:BMTCustomMut.Tech_DoomSentryBotPickup"
	 TraderInventory(92)="14:BMTCustomMut.Tech_HL_BugBaitPickup"
	 TraderInventory(93)="14:BMTCustomMut.Tech_HL_GravityGunPickup"
	 TraderInventory(94)="14:BMTCustomMut.Tech_HL_RPGPickup"
	 TraderInventory(95)="14:BMTCustomMut.Tech_IncendiaryPipeBombPickup"
	 TraderInventory(96)="14:BMTCustomMut.Tech_M7A3MPickup"
	 TraderInventory(97)="14:BMTCustomMut.Tech_MachineDualiesPickup"
	 TraderInventory(98)="14:BMTCustomMut.Tech_MachinePistolPickup"
	 TraderInventory(99)="14:BMTCustomMut.Tech_PipeBombPickup"
	 TraderInventory(100)="14:BMTCustomMut.Tech_PlasmaCutterPickup"
	 TraderInventory(101)="14:BMTCustomMut.Tech_ShockRiflePickup"
	 TraderInventory(102)="14:BMTCustomMut.Tech_USCMSentryPickup"
	 TraderInventory(103)="14:BMTCustomMut.Tech_HL2WeaponPickup"
	 TraderInventory(104)="14:BMTCustomMut.MedSentryGunPickup"
	 TraderInventory(105)="15:BMTCustomMut.PBPickup"
	 TraderInventory(106)="15:KFBox.AmmoBPickup"
	 TraderInventory(107)="16:BMTCustomMut.ProtectaPickup"
	 TraderInventory(108)="16:BMTCustomMut.StingerPickup"
	 TraderInventory(109)="16:BMTCustomMut.Glock18Pickup"
	 TraderInventory(110)="16:BMTCustomMut.P90DTPickup"
	 TraderInventory(111)="16:BMTCustomMut.P57LLIPickup"
	 //TraderInventory(112)="16:BMTCustomMut.ShieldPickup"
	 WeaponCategories(0)="-=Berserk Weapons=-"
	 WeaponCategories(1)="-=SharpShooter Pistol/Ect Weapons=-"
	 WeaponCategories(2)="-=SharpShooter Rifles Weapons=-"
	 WeaponCategories(3)="-=Support Weapons=-"
	 WeaponCategories(4)="-=Commando Weapons=-"
	 WeaponCategories(5)="-=Demolitions Weapons=-"
	 WeaponCategories(6)="-=Firebug Weapons=-"
	 WeaponCategories(7)="-=Medic Weapons=-"
	 WeaponCategories(8)="-+==========+-"
	 WeaponCategories(9)="-+==========+-"
	 WeaponCategories(10)="-=Outlaw Weapons=-"
	 WeaponCategories(11)="-=Marine Weapons=-"
	 WeaponCategories(12)="-=MachineGunner Weapons=-"
	 WeaponCategories(13)="-=Jedi Weapons=-"
	 WeaponCategories(14)="-=Sentry Tech Weapons=-"
	 WeaponCategories(15)="-=Multi Perk=-"
	 WeaponCategories(16)="-=General Weapons=-"

	 News(14)="Enjoy your stay :)"
     News(15)="----------------------------------------------------------------------"
     News(17)="----------------------------------------------------------------------"
     News(18)="All Perks are server sided and held ONLY On BMT servers!"
     News(19)="Perk Levels go from 1- Level 50 On this server"
     News(20)="----------------------------------------------------------------------"
     News(21)="Total of 112 Weapons on this server"
     News(22)="----------------------------------------------------------------------"
     News(23)="Total of 14 Perks on this server"
     News(24)="----------------------------------------------------------------------"
     News(25)="Total of ? Maps on this server"
     News(26)="---------------------------------------------------------------------  "
     News(33)="-----------------------------------------------------------------------"
     News(34)="If you have any questions please contact the following:"
     News(35)="LasVegasPunk"
     News(36)=""
     News(37)=""
     News(38)="------------------------------------------------------------------------"
     News(39)=""
     News(40)=""
     News(41)=""
     News(42)=""
     News(43)="If you are new we suggest using the Newbies Choice Perk."
     News(44)="-----------------------------------------------------------------------"
	 SmileyTags(0)=(IconTag=">:(",IconTexture="BMTCustomMut.I_Mad")
	 SmileyTags(1)=(IconTag=":(",IconTexture="BMTCustomMut.I_Frown")
	 SmileyTags(2)=(IconTag=":)",IconTexture="BMTCustomMut.I_GreenLickB")
	 SmileyTags(3)=(IconTag=":P",IconTexture="BMTCustomMut.I_Tongue",bCaseInsensitive=true)
	 SmileyTags(4)=(IconTag=":d",IconTexture="BMTCustomMut.I_GreenLick")
	 SmileyTags(5)=(IconTag=":D",IconTexture="BMTCustomMut.I_BigGrin")
	 SmileyTags(6)=(IconTag=":|",IconTexture="BMTCustomMut.I_Indiffe")
	 SmileyTags(7)=(IconTag=":/",IconTexture="BMTCustomMut.I_Ohwell")
	 SmileyTags(8)=(IconTag=":*",IconTexture="BMTCustomMut.I_RedFace")
	 SmileyTags(9)=(IconTag=":-*",IconTexture="BMTCustomMut.I_RedFace")
	 SmileyTags(10)=(IconTag="Ban?",IconTexture="BMTCustomMut.I_Ban",bCaseInsensitive=true)
	 SmileyTags(11)=(IconTag="B)",IconTexture="BMTCustomMut.I_Cool")
	 SmileyTags(12)=(IconTag="Hmm",IconTexture="BMTCustomMut.I_Hmm")
	 SmileyTags(13)=(IconTag="XD",IconTexture="BMTCustomMut.I_Scream")
	 SmileyTags(14)=(IconTag="SPAM",IconTexture="BMTCustomMut.I_Spam")
	
	 DefaultStatus="Player"
}