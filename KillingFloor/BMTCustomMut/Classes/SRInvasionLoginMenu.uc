class SRInvasionLoginMenu extends KFInvasionLoginMenu;

var automated GUIButton b_Site;

function bool NotifyLevelChange() // We want to get rid of this menu!
{
	bPersistent = false;
	return true;
}

function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
	Panels[1].ClassName = string(Class'SRTab_MidGamePerks');
	Panels[4].ClassName = string(Class'SRTab_MidGameStats');
	Super(UT2K4PlayerLoginMenu).InitComponent(MyController, MyComponent);
	//c_Main.RemoveTab(Panels[0].Caption);
	c_Main.ActivateTabByName(Panels[1].Caption, true);
}

function bool SiteButtonClicked(GUIComponent Sender)
{
	PlayerOwner().ConsoleCommand("start"@"http://nefserver.net");
	return true;
}

defaultproperties
{
     Begin Object Class=GUIButton Name=SiteButton
         Caption="Our Website"
         bAutoSize=True
         Hint="Opens in Standard-Browser"
         WinTop=0.003000
         WinLeft=0.800000
         WinWidth=0.150000
         WinHeight=0.030000
         TabOrder=1
         OnClick=SRInvasionLoginMenu.SiteButtonClicked
         OnKeyEvent=SiteButton.InternalOnKeyEvent
     End Object
     b_Site=GUIButton'BMTCustomMut.SRInvasionLoginMenu.SiteButton'
     Panels(0)=(ClassName="BMTCustomMut.KFTab_ServerNews",Caption="Information",Hint="You can read the Server-News and information")
     Panels(1)=(ClassName="BMTCustomMut.SRTab_MidGamePerks",Hint="Select your current Perk/view your progress")
	 Panels(4)=(Caption="Stats",Hint="View your current stats of this server")
}