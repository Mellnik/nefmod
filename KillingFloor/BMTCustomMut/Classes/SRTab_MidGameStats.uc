class SRTab_MidGameStats extends MidGamePanel;

var automated GUISectionBackground	i_BGPerks;
var	automated SRStatListBox	lb_PerkSelect;

//copied stuff
var automated   GUIButton			   b_Team, b_Settings, b_Browser, b_Quit, b_Favs,
										b_Leave, b_MapVote, b_KickVote, b_MatchSetup, b_Spec, b_Profile;

var() noexport  bool					bTeamGame, bFFAGame, bNetGame;

var localized   string				  LeaveMPButtonText, LeaveSPButtonText, SpectateButtonText, JoinGameButtonText;
var localized   array<string>		   ContextItems, DefaultItems;
var localized   string				  KickPlayer, BanPlayer;

var localized   string				  BuddyText;
var localized   string				  RedTeam, BlueTeam;
var			 string				  PlayerStyleName;
var			 GUIStyles			   PlayerStyle;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local string s;
	local int i;
	local eFontScale FS;

	Super.InitComponent(MyController, MyOwner);

	s = GetSizingCaption();

	for ( i = 0; i < Controls.Length; i++ )
	{
		if ( GUIButton(Controls[i]) != None && Controls[i] != b_Team )
		{
			GUIButton(Controls[i]).bAutoSize = true;
			GUIButton(Controls[i]).SizingCaption = s;
			GUIButton(Controls[i]).AutoSizePadding.HorzPerc = 0.04;
			GUIButton(Controls[i]).AutoSizePadding.VertPerc = 0.5;
		}
	}

	PlayerStyle = MyController.GetStyle(PlayerStyleName, fs);
}

function ShowPanel(bool bShow)
{
	local ClientPerkRepLink L;

	super.ShowPanel(bShow);

	if ( bShow )
	{
		L = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
		if ( L!=None )
			lb_PerkSelect.List.InitList(L);
		InitGRI();
	}
}

function string GetSizingCaption()
{
	local int i;
	local string s;

	for ( i = 0; i < Controls.Length; i++ )
	{
		if ( GUIButton(Controls[i]) != none && Controls[i] != b_Team )
		{
			if ( s == "" || Len(GUIButton(Controls[i]).Caption) > Len(s) )
			{
				s = GUIButton(Controls[i]).Caption;
			}
		}
	}

	return s;
}

function GameReplicationInfo GetGRI()
{
	return PlayerOwner().GameReplicationInfo;
}

function InitGRI()
{
	local PlayerController PC;
	local GameReplicationInfo GRI;

	GRI = GetGRI();
	PC = PlayerOwner();

	if ( PC == none || PC.PlayerReplicationInfo == none || GRI == none )
	{
		return;
	}

	bInit = False;

	if ( !bTeamGame && !bFFAGame )
	{
		if ( GRI.bTeamGame )
		{
			bTeamGame = True;
		}
		else if ( !(GRI.GameClass ~= "Engine.GameInfo") )
		{
			bFFAGame = True;
		}
	}

	bNetGame = PC.Level.NetMode != NM_StandAlone;

	if ( bNetGame )
	{
		b_Leave.Caption = LeaveMPButtonText;
	}
	else
	{
		b_Leave.Caption = LeaveSPButtonText;
	}

	if ( PC.PlayerReplicationInfo.bOnlySpectator )
	{
		b_Spec.Caption = JoinGameButtonText;
	}
	else
	{
		b_Spec.Caption = SpectateButtonText;
	}

	SetupGroups();
	//InitLists();
}

function float ItemHeight(Canvas C)
{
	local float XL, YL, H;
	local eFontScale f;

	if ( bTeamGame )
	{
		f=FNS_Medium;
	}
	else
	{
		f=FNS_Large;
	}

	PlayerStyle.TextSize(C, MSAT_Blurry, "Wqz, ", XL, H, F);

	if ( C.ClipX > 640 && bNetGame )
	{
		PlayerStyle.TextSize(C, MSAT_Blurry, "Wqz, ", XL, YL, FNS_Small);
	}

	H += YL;
	H += (H * 0.2);

	return h;
}

function SetupGroups()
{
	local int i;
	local PlayerController PC;

	PC = PlayerOwner();

	if ( bTeamGame )
	{
		//RemoveComponent(lb_FFA, True);
		//RemoveComponent(sb_FFA, true);

		if ( PC.GameReplicationInfo != None && PC.GameReplicationInfo.bNoTeamChanges )
		{
			RemoveComponent(b_Team,true);
		}

		//lb_FFA = None;
	}
	else if ( bFFAGame )
	{
		RemoveComponent(b_Team, true);
	}
	else
	{
		for ( i = 0; i < Controls.Length; i++ )
		{
			if ( Controls[i] != i_BGPerks && Controls[i] != lb_PerkSelect )
			{
				RemoveComponent(Controls[i], True);
			}
		}
	}

	if ( PC.Level.NetMode != NM_Client )
	{
		RemoveComponent(b_Favs);
		RemoveComponent(b_Browser);
	}
	else if ( CurrentServerIsInFavorites() )
	{
		DisableComponent(b_Favs);
	}

	if ( PC.Level.NetMode == NM_StandAlone )
	{
		RemoveComponent(b_MapVote, True);
		RemoveComponent(b_MatchSetup, True);
		RemoveComponent(b_KickVote, True);
	}
	else if ( PC.VoteReplicationInfo != None )
	{
		if ( !PC.VoteReplicationInfo.MapVoteEnabled() )
		{
			RemoveComponent(b_MapVote,True);
		}

		if ( !PC.VoteReplicationInfo.KickVoteEnabled() )
		{
			RemoveComponent(b_KickVote);
		}

		if ( !PC.VoteReplicationInfo.MatchSetupEnabled() )
		{
			RemoveComponent(b_MatchSetup);
		}
	}
	else
	{
		RemoveComponent(b_MapVote);
		RemoveComponent(b_KickVote);
		RemoveComponent(b_MatchSetup);
	}

	RemapComponents();
}

function SetButtonPositions(Canvas C)
{
	local int i, j, ButtonsPerRow, ButtonsLeftInRow, NumButtons;
	local float Width, Height, Center, X, Y, YL, ButtonSpacing;

	Width = b_Settings.ActualWidth();
	Height = b_Settings.ActualHeight();
	Center = ActualLeft() + (ActualWidth() / 2.0);

	ButtonSpacing = Width * 0.05;
	YL = Height * 1.2;
	Y = b_Settings.ActualTop();

	ButtonsPerRow = ActualWidth() / (Width + ButtonSpacing);
	ButtonsLeftInRow = ButtonsPerRow;

	for ( i = 0; i < Components.Length; i++)
	{
		if ( Components[i].bVisible && GUIButton(Components[i]) != none && Components[i] != b_Team )
		{
			NumButtons++;
		}
	}

	if ( NumButtons < ButtonsPerRow )
	{
		X = Center - (((Width * float(NumButtons)) + (ButtonSpacing * float(NumButtons - 1))) * 0.5);
	}
	else if ( ButtonsPerRow > 1 )
	{
		X = Center - (((Width * float(ButtonsPerRow)) + (ButtonSpacing * float(ButtonsPerRow - 1))) * 0.5);
	}
	else
	{
		X = Center - Width / 2.0;
	}

	for ( i = 0; i < Components.Length; i++)
	{
		if ( !Components[i].bVisible || GUIButton(Components[i]) == none || Components[i]==b_Team )
		{
			continue;
		}

		Components[i].SetPosition( X, Y, Width, Height, true );

		if ( --ButtonsLeftInRow > 0 )
		{
			X += Width + ButtonSpacing;
		}
		else
		{
			Y += YL;

			for ( j = i + 1; j < Components.Length && ButtonsLeftInRow < ButtonsPerRow; j++)
			{
				if ( Components[i].bVisible && GUIButton(Components[i]) != none && Components[i] != b_Team )
				{
					ButtonsLeftInRow++;
				}
			}

			if ( ButtonsLeftInRow > 1 )
			{
				X = Center - (((Width * float(ButtonsLeftInRow)) + (ButtonSpacing * float(ButtonsLeftInRow - 1))) * 0.5);
			}
			else
			{
				X = Center - Width / 2.0;
			}
		}
	}
}

// See if we already have this server in our favorites
function bool CurrentServerIsInFavorites()
{
	local ExtendedConsole.ServerFavorite Fav;
	local string address,portString;

	// Get current network address
	if ( PlayerOwner() == None )
	{
		return true;
	}

	address = PlayerOwner().GetServerNetworkAddress();

	if( address == "" )
	{
		return true; // slightly hacky - dont want to add "none"!
	}

	// Parse text to find IP and possibly port number
	if ( Divide(address, ":", Fav.IP, portstring) )
	{
		Fav.Port = int(portString);
	}
	else
	{
		Fav.IP = address;
	}

	return class'KFConsole'.static.InFavorites(Fav);
}

function bool ButtonClicked(GUIComponent Sender)
{
	local PlayerController PC;
	local GUIController C;

	C = Controller;

	PC = PlayerOwner();

	/*if ( Sender == i_JoinRed )
	{
		//Join Red team
		if ( PC.PlayerReplicationInfo == None || PC.PlayerReplicationInfo.Team == none ||
			 PC.PlayerReplicationInfo.Team.TeamIndex != 0 )
		{
			PC.ChangeTeam(0);
		}

		Controller.CloseMenu(false);
	}
	*/
	if ( Sender == b_Settings )
	{
		//Settings
		Controller.OpenMenu(Controller.GetSettingsPage());
	}
	else if ( Sender == b_Browser )
	{
		//Server browser
		Controller.OpenMenu("KFGUI.KFServerBrowser");
	}
	else if ( Sender == b_Leave )
	{
		//Forfeit/Disconnect
		PC.ConsoleCommand("DISCONNECT");
		KFGUIController(C).ReturnToMainMenu();
	}
	else if ( Sender == b_Favs )
	{
		//Add this server to favorites
		PC.ConsoleCommand( "ADDCURRENTTOFAVORITES" );
		b_Favs.MenuStateChange(MSAT_Disabled);
	}
	else if ( Sender == b_Quit )
	{
		//Quit game
		Controller.OpenMenu(Controller.GetQuitPage());
	}
	else if ( Sender == b_MapVote )
	{
		//Map voting
		Controller.OpenMenu(Controller.MapVotingMenu);
	}
	else if ( Sender == b_KickVote )
	{
		//Kick voting
		Controller.OpenMenu(Controller.KickVotingMenu);
	}
	else if ( Sender == b_MatchSetup )
	{
		//Match setup
		Controller.OpenMenu(Controller.MatchSetupMenu);
	}
	else if ( Sender == b_Spec )
	{
		Controller.CloseMenu();

		//Spectate/rejoin
		if ( PC.PlayerReplicationInfo.bOnlySpectator )
		{
			PC.BecomeActivePlayer();
		}
		else
		{
			PC.BecomeSpectator();
		}
	}
	
	else if( Sender==b_Profile )
	{
		// Profile
		Controller.OpenMenu(string(Class'SRProfilePage'));
	}

	return true;
}

function bool InternalOnPreDraw(Canvas C)
{
	local GameReplicationInfo GRI;

	GRI = GetGRI();

	if ( GRI != none )
	{
		if ( bInit )
		{
			InitGRI();
		}

		/*
		if ( bTeamGame )
		{
			if ( PlayerOwner().PlayerReplicationInfo.Team != none )
			{
				sb_Red.HeaderBase = texture'InterfaceArt_tex.Menu.RODisplay';
			}
		}

		sb_Red.SetPosition((ActualWidth() / 2.0) - ((sb_Red.WinWidth * ActualWidth()) / 2.0), sb_Red.WinTop, sb_Red.WinWidth, sb_Red.WinHeight);
		*/

		SetButtonPositions(C);
		//UpdatePlayerLists();

		if ( (PlayerOwner().myHUD == None || !PlayerOwner().myHUD.IsInCinematic()) && GRI != none && GRI.bMatchHasBegun && !PlayerOwner().IsInState('GameEnded') )
		{
			EnableComponent(b_Spec);
		}
		else
		{
			DisableComponent(b_Spec);
		}
	}

	return false;
}

function bool ContextMenuOpened(GUIContextMenu Menu)
{
	local GUIList List;
	local PlayerReplicationInfo PRI;
	local byte Restriction;
	local GameReplicationInfo GRI;

	GRI = GetGRI();

	if ( GRI == None )
	{
		return false;
	}

	List = GUIList(Controller.ActiveControl);

	if ( List == None )
	{
		log(Name @ "ContextMenuOpened active control was not a list - active:" $ Controller.ActiveControl.Name);
		return False;
	}

	if ( !List.IsValid() )
	{
		return False;
	}

	PRI = GRI.FindPlayerByID(int(List.GetExtra()));

	if ( PRI == None || PRI.bBot || PlayerIDIsMine(PRI.PlayerID) )
	{
		return False;
	}

	Restriction = PlayerOwner().ChatManager.GetPlayerRestriction(PRI.PlayerID);

	if ( bool(Restriction & 1) )
	{
		Menu.ContextItems[0] = ContextItems[0];
	}
	else
	{
		Menu.ContextItems[0] = DefaultItems[0];
	}

	if ( bool(Restriction & 2) )
	{
		Menu.ContextItems[1] = ContextItems[1];
	}
	else
	{
		Menu.ContextItems[1] = DefaultItems[1];
	}

	if ( bool(Restriction & 4) )
	{
		Menu.ContextItems[2] = ContextItems[2];
	}
	else
	{
		Menu.ContextItems[2] = DefaultItems[2];
	}

	if ( bool(Restriction & 8) )
	{
		Menu.ContextItems[3] = ContextItems[3];
	}
	else
	{
		Menu.ContextItems[3] = DefaultItems[3];
	}

	Menu.ContextItems[4] = "-";
	Menu.ContextItems[5] = BuddyText;

	if ( PlayerOwner().PlayerReplicationInfo.bAdmin )
	{
		Menu.ContextItems[6] = "-";
		Menu.ContextItems[7] = KickPlayer $ "["$List.Get() $ "]";
		Menu.ContextItems[8] = BanPlayer $ "["$List.Get() $ "]";
	}
	else if ( Menu.ContextItems.Length > 6 )
	{
		Menu.ContextItems.Remove(6,Menu.ContextItems.Length - 6);
	}

	return True;
}

function ContextClick(GUIContextMenu Menu, int ClickIndex)
{
	local bool bUndo;
	local byte Type;
	local GUIList List;
	local PlayerController PC;
	local PlayerReplicationInfo PRI;
	local GameReplicationInfo GRI;

	GRI = GetGRI();

	if ( GRI == None )
	{
		return;
	}

	PC = PlayerOwner();
	bUndo = Menu.ContextItems[ClickIndex] == ContextItems[ClickIndex];
	List = GUIList(Controller.ActiveControl);

	if ( List == None )
	{
		return;
	}

	PRI = GRI.FindPlayerById(int(List.GetExtra()));

	if ( PRI == None )
	{
		return;
	}

	if ( ClickIndex > 5 ) // Admin stuff
	{
		switch ( ClickIndex )
		{
			case 6:
			case 7: PC.AdminCommand("admin kick"@List.GetExtra()); break;
			case 8: PC.AdminCommand("admin kickban"@List.GetExtra()); break;
		}

		return;
	}

	if ( ClickIndex > 3 )
	{
		Controller.AddBuddy(List.Get());

		return;
	}

	Type = 1 << ClickIndex;

	if ( bUndo )
	{
		if ( PC.ChatManager.ClearRestrictionID(PRI.PlayerID, Type) )
		{
			PC.ServerChatRestriction(PRI.PlayerID, PC.ChatManager.GetPlayerRestriction(PRI.PlayerID));
			ModifiedChatRestriction(Self, PRI.PlayerID);
		}
	}
	else
	{
		if ( PC.ChatManager.AddRestrictionID(PRI.PlayerID, Type) )
		{
			PC.ServerChatRestriction(PRI.PlayerID, PC.ChatManager.GetPlayerRestriction(PRI.PlayerID));
			ModifiedChatRestriction(Self, PRI.PlayerID);
		}
	}
}

defaultproperties
{
	PropagateVisibility=False

	WinWidth=.5
	WinHeight=.75
	WinTop=0.125
	WinLeft=0.25

	LeaveMPButtonText="Disconnect"
	LeaveSPButtonText="Forfeit"

	SpectateButtonText="Spectate"
	JoinGameButtonText="Join"

//	OnRightClick=RightClick

	ContextItems(0)="Unignore text"
	ContextItems(1)="Unignore speech"
	ContextItems(2)="Unignore voice chat"
	ContextItems(3)="Unban from voice chat"

	DefaultItems(0)="Ignore text"
	DefaultItems(1)="Ignore speech"
	DefaultItems(2)="Ignore voice chat"
	DefaultItems(3)="Ban from voice chat"

	PlayerStyleName="TextLabel"
	OnPreDraw=InternalOnPreDraw

	KickPlayer="Kick "
	BanPlayer="Ban "

	Begin Object Class=GUIContextMenu name=PlayerListContextMenu
		OnSelect=ContextClick
		OnOpen=ContextMenuOpened
	End Object
	ContextMenu=PlayerListContextMenu

	Begin Object class=GUISectionBackground Name=BGPerks
		WinWidth=0.96152
		WinHeight=0.796032
		WinLeft=0.019240
		WinTop=0.012063
		Caption="Stats"
		bFillClient=true
	End Object
	i_BGPerks=BGPerks

	Begin Object class=SRStatListBox Name=StatSelectList
		WinWidth=0.94152
		WinHeight=0.742836
		WinLeft=0.029240
		WinTop=0.057760
	End Object
	lb_PerkSelect=StatSelectList

	Begin Object Class=GUIButton Name=SettingsButton
		Caption="Settings"
		StyleName="SquareButton"
		OnClick=ButtonClicked
  		WinWidth=0.147268
		WinHeight=0.048769
		WinLeft=0.194420
		WinTop=0.878657
		TabOrder=0
		bBoundToParent=true
		bScaleToParent=true
	End Object
	b_Settings=SettingsButton

	Begin Object Class=GUIButton Name=BrowserButton
		Caption="Server Browser"
		StyleName="SquareButton"
		OnClick=ButtonClicked
		WinWidth=0.20000
		WinHeight=0.05000
		WinLeft=0.375000
		WinTop=0.85000//0.675
		bAutoSize=True
		TabOrder=1
		bBoundToParent=true
		bScaleToParent=true
	End Object
	b_Browser=BrowserButton

	Begin Object Class=GUIButton Name=LeaveMatchButton
		Caption=""
		StyleName="SquareButton"
		OnClick=ButtonClicked
		WinWidth=0.20000
		WinHeight=0.05000
		WinLeft=0.7250000
		WinTop=0.87//0.750
		bAutoSize=True
		TabOrder=10
		bBoundToParent=true
		bScaleToParent=true
	End Object
	b_Leave=LeaveMatchButton

	Begin Object Class=GUIButton Name=FavoritesButton
		Caption="Add to Favs"
		Hint="Add this server to your Favorites"
		StyleName="SquareButton"
		WinWidth=0.20000
		WinHeight=0.05000
		WinLeft=0.02500
		WinTop=0.870
		bBoundToParent=true
		bScaleToParent=true
		OnClick=ButtonClicked
		bAutoSize=True
		TabOrder=3
	End Object
	b_Favs=FavoritesButton

	Begin Object Class=GUIButton Name=QuitGameButton
		Caption="Exit Game"
		StyleName="SquareButton"
		OnClick=ButtonClicked
		WinWidth=0.20000
		WinHeight=0.05000
		WinLeft=0.725000
		WinTop=0.870
		bAutoSize=True
		TabOrder=11
	End Object
	b_Quit=QuitGameButton

	Begin Object Class=GUIButton Name=MapVotingButton
		Caption="Map Voting"
		StyleName="SquareButton"
		OnClick=ButtonClicked
		WinWidth=0.20000
		WinHeight=0.050000
		WinLeft=0.025000
		WinTop=0.890
		bAutoSize=True
		TabOrder=5
	End Object
	b_MapVote=MapVotingButton

	Begin Object Class=GUIButton Name=KickVotingButton
		Caption="Kick Voting"
		StyleName="SquareButton"
		OnClick=ButtonClicked
		WinWidth=0.20000
		WinHeight=0.050000
		WinLeft=0.375000
		WinTop=0.890
		bAutoSize=True
		TabOrder=6
	End Object
	b_KickVote=KickVotingButton

	Begin Object Class=GUIButton Name=MatchSetupButton
		Caption="Match Setup"
		StyleName="SquareButton"
		OnClick=ButtonClicked
		WinWidth=0.20000
		WinHeight=0.050000
		WinLeft=0.725000
		WinTop=0.890
		bAutoSize=True
		TabOrder=7
	End Object
	b_MatchSetup=MatchSetupButton

	Begin Object Class=GUIButton Name=SpectateButton
		Caption="Spectate"
		StyleName="SquareButton"
		OnClick=ButtonClicked
		WinWidth=0.20000
		WinHeight=0.050000
		WinLeft=0.725000
		WinTop=0.890
		bAutoSize=True
		TabOrder=9
	End Object
	b_Spec=SpectateButton

	Begin Object Class=GUIButton Name=ProfileButton
		Caption="Profile"
		StyleName="SquareButton"
		OnClick=ButtonClicked
		WinWidth=0.20000
		WinHeight=0.050000
		WinLeft=0.725000
		WinTop=0.890
		bAutoSize=True
		TabOrder=10
	End Object
	b_Profile=ProfileButton
}
