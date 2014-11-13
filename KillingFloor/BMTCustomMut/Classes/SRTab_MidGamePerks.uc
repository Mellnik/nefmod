class SRTab_MidGamePerks extends KFTab_MidGamePerks;

var automated GUIButton b_Profile;

var localized string NextInfoStr;

function bool ButtonClicked(GUIComponent Sender)
{
	if( Sender==b_Profile )
	{
		// Profile
		Controller.OpenMenu(string(Class'SRProfilePage'));
		return true;
	}
	else return Super.ButtonClicked(Sender);
}

function ShowPanel(bool bShow)
{
	super(MidGamePanel).ShowPanel(bShow);

	if ( bShow )
	{
		if ( Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner())!=none )
		{
			// Initialize the List
			lb_PerkSelect.List.InitList(None);
			lb_PerkProgress.List.InitList();
		}
		InitGRI();
	}
}

function OnPerkSelected(GUIComponent Sender)
{
	local ClientPerkRepLink ST;
	local byte Idx;

	ST = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
	if ( ST==None || ST.CachePerks.Length==0 )
	{
		if( ST!=None )
			ST.ServerRequestPerks();
		lb_PerkEffects.SetContent("Please wait while your client is loading the perks...");
	}
	else
	{
		Idx = lb_PerkSelect.GetIndex();
		if( ST.CachePerks[Idx].CurrentLevel==0 )
			lb_PerkEffects.SetContent(ST.CachePerks[Idx].PerkClass.Static.GetVetInfoText(0,1));
		else if( ST.CachePerks[Idx].CurrentLevel==ST.MaximumLevel )
			lb_PerkEffects.SetContent(ST.CachePerks[Idx].PerkClass.Static.GetVetInfoText(ST.CachePerks[Idx].CurrentLevel-1,1));
		else lb_PerkEffects.SetContent(ST.CachePerks[Idx].PerkClass.Static.GetVetInfoText(ST.CachePerks[Idx].CurrentLevel-1,1)$NextInfoStr$ST.CachePerks[Idx].PerkClass.Static.GetVetInfoText(ST.CachePerks[Idx].CurrentLevel,1));
		lb_PerkProgress.List.PerkChanged(KFStatsAndAchievements, Idx);
	}
}

function bool OnSaveButtonClicked(GUIComponent Sender)
{
	local ClientPerkRepLink ST;

	ST = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
	if ( ST!=None && lb_PerkSelect.GetIndex()>=0 )
		ST.ServerSelectPerk(ST.CachePerks[lb_PerkSelect.GetIndex()].PerkClass);
	return true;
}

defaultproperties
{
	Begin Object Class=GUIScrollTextBox Name=PerkEffectsScroll
		WinWidth=0.465143
		WinHeight=0.313477
		WinLeft=0.500554
		WinTop=0.083121
		CharDelay=0.0025
		EOLDelay=0.1
		TabOrder=9
		StyleName="NoBackground"
	End Object
	lb_PerkEffects=PerkEffectsScroll

	Begin Object class=SRPerkSelectListBox Name=PerkSelectList
		WinWidth=0.437166
		WinHeight=0.742836
		WinLeft=0.029240
		WinTop=0.057760
	End Object
	lb_PerkSelect=PerkSelectList

	Begin Object class=SRPerkProgressListBox Name=PerkProgressList
		WinWidth=0.463858
		WinHeight=0.341256
		WinLeft=0.499269
		WinTop=0.476850
	End Object
	lb_PerkProgress=PerkProgressList

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

	NextInfoStr="||Next level effects:|"
}
