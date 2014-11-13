//-----------------------------------------------------------
//
//-----------------------------------------------------------
class KFTab_BaseNews extends MidGamePanel;
//copied stuff
var automated   GUIButton               b_Team, b_Settings, b_Browser, b_Quit, b_Favs,
                                        b_Leave, b_MapVote, b_KickVote, b_MatchSetup, b_Spec;
var() noexport  bool                    bTeamGame, bFFAGame, bNetGame;
var             string                  PlayerStyleName;
var             GUIStyles               PlayerStyle;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;
    local string s;
    local eFontScale FS;

    b_Spec.Caption=class'KFTab_MidGamePerks'.default.b_Spec.Caption;
    b_MatchSetup.Caption=class'KFTab_MidGamePerks'.default.b_MatchSetup.Caption;
    b_KickVote.Caption=class'KFTab_MidGamePerks'.default.b_KickVote.Caption;
    b_MapVote.Caption=class'KFTab_MidGamePerks'.default.b_MapVote.Caption;
    b_Quit.Caption=class'KFTab_MidGamePerks'.default.b_Quit.Caption;
    b_Favs.Caption=class'KFTab_MidGamePerks'.default.b_Favs.Caption;
    b_Quit.Caption=class'KFTab_MidGamePerks'.default.b_Quit.Caption;
    b_Settings.Caption=class'KFTab_MidGamePerks'.default.b_Settings.Caption;
    b_Browser.Caption=class'KFTab_MidGamePerks'.default.b_Browser.Caption;

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
    PlayerStyleName = class'KFTab_MidGamePerks'.default.PlayerStyleName;
    PlayerStyle = MyController.GetStyle(PlayerStyleName, fs);
}

function ShowPanel(bool bShow)
{
	Super.ShowPanel(bShow);
	if(bShow)
	{
		InitGRI();
	}

}
function string GetSizingCaption()
{
    local int i;
    local string s;

    for ( i = 0; i < Controls.Length; i++ )
    {
        if ( GUIButton(Controls[i]) != none && Controls[i] != b_Team)
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
        b_Leave.Caption = class'KFTab_MidGamePerks'.default.LeaveMPButtonText;
    }
    else
    {
        b_Leave.Caption = class'KFTab_MidGamePerks'.default.LeaveSPButtonText;
    }

    if ( PC.PlayerReplicationInfo.bOnlySpectator )
    {
        b_Spec.Caption = class'KFTab_MidGamePerks'.default.JoinGameButtonText;
    }
    else
    {
        b_Spec.Caption = class'KFTab_MidGamePerks'.default.SpectateButtonText;
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
        //RemoveComponent(i_JoinRed, true);
        //RemoveComponent(lb_Red, true);
        //RemoveComponent(sb_Red, true);
        RemoveComponent(b_Team, true);
    }
    else
    {
        for ( i = 0; i < Controls.Length; i++ )
        {

				RemoveComponent(Controls[i], True);
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
                if ( Components[i].bVisible && GUIButton(Components[i]) != none && Components[i] != b_Team)
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

    return class'ExtendedConsole'.static.InFavorites(Fav);
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

defaultproperties
{
     Begin Object Class=GUIButton Name=SettingsButton
         Caption="Settings"
         WinTop=0.878657
         WinLeft=0.194420
         WinWidth=0.147268
         WinHeight=0.048769
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=SettingsButton.InternalOnKeyEvent
     End Object
     b_Settings=GUIButton'BMTCustomMut.KFTab_BaseNews.SettingsButton'

     Begin Object Class=GUIButton Name=BrowserButton
         Caption="Server Browser"
         bAutoSize=True
         WinTop=0.850000
         WinLeft=0.375000
         WinWidth=0.200000
         WinHeight=0.050000
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=BrowserButton.InternalOnKeyEvent
     End Object
     b_Browser=GUIButton'BMTCustomMut.KFTab_BaseNews.BrowserButton'

     Begin Object Class=GUIButton Name=QuitGameButton
         Caption="Exit Game"
         bAutoSize=True
         WinTop=0.870000
         WinLeft=0.725000
         WinWidth=0.200000
         WinHeight=0.050000
         TabOrder=11
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=QuitGameButton.InternalOnKeyEvent
     End Object
     b_Quit=GUIButton'BMTCustomMut.KFTab_BaseNews.QuitGameButton'

     Begin Object Class=GUIButton Name=FavoritesButton
         Caption="Add to Favs"
         bAutoSize=True
         Hint="Add this server to your Favorites"
         WinTop=0.870000
         WinLeft=0.025000
         WinWidth=0.200000
         WinHeight=0.050000
         TabOrder=3
         bBoundToParent=True
         bScaleToParent=True
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=FavoritesButton.InternalOnKeyEvent
     End Object
     b_Favs=GUIButton'BMTCustomMut.KFTab_BaseNews.FavoritesButton'

     Begin Object Class=GUIButton Name=LeaveMatchButton
         bAutoSize=True
         WinTop=0.870000
         WinLeft=0.725000
         WinWidth=0.200000
         WinHeight=0.050000
         TabOrder=10
         bBoundToParent=True
         bScaleToParent=True
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=LeaveMatchButton.InternalOnKeyEvent
     End Object
     b_Leave=GUIButton'BMTCustomMut.KFTab_BaseNews.LeaveMatchButton'

     Begin Object Class=GUIButton Name=MapVotingButton
         Caption="Map Voting"
         bAutoSize=True
         WinTop=0.890000
         WinLeft=0.025000
         WinWidth=0.200000
         WinHeight=0.050000
         TabOrder=5
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=MapVotingButton.InternalOnKeyEvent
     End Object
     b_MapVote=GUIButton'BMTCustomMut.KFTab_BaseNews.MapVotingButton'

     Begin Object Class=GUIButton Name=KickVotingButton
         Caption="Kick Voting"
         bAutoSize=True
         WinTop=0.890000
         WinLeft=0.375000
         WinWidth=0.200000
         WinHeight=0.050000
         TabOrder=6
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=KickVotingButton.InternalOnKeyEvent
     End Object
     b_KickVote=GUIButton'BMTCustomMut.KFTab_BaseNews.KickVotingButton'

     Begin Object Class=GUIButton Name=MatchSetupButton
         Caption="Match Setup"
         bAutoSize=True
         WinTop=0.890000
         WinLeft=0.725000
         WinWidth=0.200000
         WinHeight=0.050000
         TabOrder=7
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=MatchSetupButton.InternalOnKeyEvent
     End Object
     b_MatchSetup=GUIButton'BMTCustomMut.KFTab_BaseNews.MatchSetupButton'

     Begin Object Class=GUIButton Name=SpectateButton
         Caption="Spectate"
         bAutoSize=True
         WinTop=0.890000
         WinLeft=0.725000
         WinWidth=0.200000
         WinHeight=0.050000
         TabOrder=9
         OnClick=KFTab_BaseNews.ButtonClicked
         OnKeyEvent=SpectateButton.InternalOnKeyEvent
     End Object
     b_Spec=GUIButton'BMTCustomMut.KFTab_BaseNews.SpectateButton'

     PropagateVisibility=False
     WinTop=0.125000
     WinLeft=0.250000
     WinWidth=0.500000
     WinHeight=0.750000
     OnPreDraw=KFTab_BaseNews.InternalOnPreDraw
}
