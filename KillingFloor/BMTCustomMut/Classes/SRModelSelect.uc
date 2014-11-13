class SRModelSelect extends KFModelSelect;

var int CustomOffset;
var localized string AllText,CustomText,StockText;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local ClientPerkRepLink S;
	local int i;
	local xUtil.PlayerRecord PR;
	
	local array<string> CChars;
	local string CSkins;

	super(LockedFloatingWindow).Initcomponent(MyController, MyOwner);
	
	CSkins = SRPlayerReplicationInfo(KFPCServ(Controller.ViewportOwner.Actor).PlayerReplicationInfo).CSkins;
	
	//log("CSkins"@CSkins);

	co_Race.MyComboBox.List.bInitializeList = True;
	co_Race.ReadOnly(True);
	co_Race.AddItem(AllText);
	co_Race.AddItem(CustomText);
	co_Race.AddItem(StockText);
	co_Race.OnChange=RaceChange;

	sb_Main.SetPosition(0.040000,0.075000,0.680742,0.555859);
	sb_Main.RightPadding = 0.5;
	sb_Main.ManageComponent(CharList);

	class'xUtil'.static.GetPlayerList(PlayerList);
	CustomOffset = 0;

	// Add in custom mod chars.
	S = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
	if( S!=None )
	{
		m:
		//log("S.CustomChars.Length"@S.CustomChars.Length);
		for( i=0; i<S.CustomChars.Length; i++ )
		{
			if ( InStr( CSkins, S.CustomChars[i]$";") != -1 )
			{
				CChars.insert(0,1);
				CChars[0]=S.CustomChars[i];
				
			}
		}
		for( i=0; i<CChars.Length; i++ )
		{
			PR = Class'xUtil'.Static.FindPlayerRecord(CChars[i]);
			if( PR.DefaultName~=CChars[i] )
			{
				++CustomOffset;
				PlayerList.Insert(0,1);
				PlayerList[0] = PR;
			}
						
		}
	}

	for( i=(PlayerList.Length-1); i>=CustomOffset; --i )
		if( !IsUnLocked(PlayerList[i]) )
			PlayerList.Remove(i,1);

	RefreshCharacterList("");

	// Spawn spinning character actor
	if ( SpinnyDude == None )
		SpinnyDude = PlayerOwner().spawn(class'XInterface.SpinnyWeap');

	SpinnyDude.SetDrawType(DT_Mesh);
	SpinnyDude.SetDrawScale(0.9);
	SpinnyDude.SpinRate = 0;
}

function RefreshCharacterList(string ExcludedChars, optional string Race)
{
	local int i;
	local byte Mode;

	// Prevent list from calling OnChange events
	CharList.List.bNotify = False;
	CharList.Clear();

	if( Race=="" )
		Mode = 0;
	else if( Race~=CustomText )
		Mode = 1;
	else Mode = 2;

	for(i=0; i<PlayerList.Length; i++)
	{
		if ( Mode==0 || (Mode==1 && i<CustomOffset) || (Mode==2 && i>=CustomOffset) )
			CharList.List.Add( Playerlist[i].Portrait, i, 0 );
	}
	CharList.List.bNotify = True;
}

function RaceChange(GUIComponent Sender)
{
	local string specName;

	specName = co_Race.GetText();
	if( specName~=AllText )
		specName="";

	RefreshCharacterList("", specName);
}

function ListChange(GUIComponent Sender)
{
	local ImageListElem Elem;

	CharList.List.GetAtIndex(CharList.List.Index, Elem.Image, Elem.Item,Elem.Locked);

	if ( Elem.Item >= 0 && Elem.Item < Playerlist.Length )
	{
		if ( Elem.Locked==1 )
			b_Ok.DisableMe();
		else
			b_Ok.EnableMe();

		sb_Main.Caption = PlayerList[Elem.Item].DefaultName;
	}
	else sb_Main.Caption = "";
	UpdateSpinnyDude();
}

function bool IsUnlocked(xUtil.PlayerRecord Test)
{
	local int i;

	// If character has no menu filter, just return true
	if ( PlayerOwner() == none )
		return true;

	for( i=0; i<CustomOffset; ++i )
		if( PlayerList[i].DefaultName~=Test.DefaultName )
			return true;

	return PlayerOwner().CharacterAvailable(Test.DefaultName);
}

defaultproperties
{
     AllText="All"
     CustomText="Custom"
     StockText="Stock"
     Begin Object Class=moComboBox Name=CharRace
         bReadOnly=True
         ComponentJustification=TXTA_Left
         CaptionWidth=0.250000
         Caption="Show"
         OnCreateComponent=CharRace.InternalOnCreateComponent
         Hint="Filter the available characters."
         WinTop=0.880000
         WinLeft=0.052733
         WinWidth=0.388155
         WinHeight=0.042857
         TabOrder=4
         bBoundToParent=True
         bScaleToParent=True
     End Object
     co_Race=moComboBox'BMTCustomMut.SRModelSelect.CharRace'

}
