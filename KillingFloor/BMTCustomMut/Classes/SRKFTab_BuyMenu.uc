//=============================================================================
// The actual trader menu
//=============================================================================
class SRKFTab_BuyMenu extends KFTab_BuyMenu;

var Class<Pickup> SelectedItem;
var() localized string ArchivementGetInfo;
struct FIDPair
{
	var int ID;
	var string Name;
};
var array<FIDPair> DLCMap;

final function RefreshSelection()
{
	if( SaleSelect.List.Index==-1 )
	{
		if( InvSelect.List.Index!=-1 )
			TheBuyable = InvSelect.GetSelectedBuyable();
		else TheBuyable = None;
	}
	else TheBuyable = SaleSelect.GetSelectedBuyable();
}
function OnAnychange()
{
	RefreshSelection();
	Super.OnAnychange();
}
function bool InternalOnClick(GUIComponent Sender)
{
	RefreshSelection();
	return Super.InternalOnClick(Sender);
}
function UpdateAll()
{
	KFPlayerController(PlayerOwner()).bDoTraderUpdate = false;
	InvSelect.List.UpdateMyBuyables();
	SaleSelect.List.UpdateForSaleBuyables();

	RefreshSelection();
	GetUpdatedBuyable();
	UpdatePanel();
}
function UpdateBuySellButtons()
{
	RefreshSelection();
	if ( InvSelect.List.Index==-1 || TheBuyable==None || !TheBuyable.bSellable )
		SaleButton.DisableMe();
	else SaleButton.EnableMe();

	if ( SaleSelect.List.Index==-1 || TheBuyable==None || SaleSelect.List.CanBuys[SaleSelect.List.Index]!=1 )
		PurchaseButton.DisableMe();
	else PurchaseButton.EnableMe();
}
function GetUpdatedBuyable(optional bool bSetInvIndex)
{
	InvSelect.List.UpdateMyBuyables();
	RefreshSelection();
}
function UpdateAutoFillAmmo()
{
	Super.UpdateAutoFillAmmo();
	RefreshSelection();
}

function SaleChange(GUIComponent Sender)
{
	InvSelect.List.Index = -1;
	
	TheBuyable = SaleSelect.GetSelectedBuyable();

	if( TheBuyable==None ) // Selected category.
	{
		GUIBuyMenu(OwnerPage()).WeightBar.NewBoxes = 0;
		if( SaleSelect.List.CanBuys[SaleSelect.List.Index]>1 )
		{
			SRBuyMenuSaleList(SaleSelect.List).SetCategoryNum(SaleSelect.List.CanBuys[SaleSelect.List.Index]-2);
		}
	}
	else GUIBuyMenu(OwnerPage()).WeightBar.NewBoxes = TheBuyable.ItemWeight;
	OnAnychange();
}
function bool SaleDblClick(GUIComponent Sender)
{
	InvSelect.List.Index = -1;
	
	TheBuyable = SaleSelect.GetSelectedBuyable();

	if( TheBuyable==None ) // Selected category.
	{
		GUIBuyMenu(OwnerPage()).WeightBar.NewBoxes = 0;
	}
	else
	{
		GUIBuyMenu(OwnerPage()).WeightBar.NewBoxes = TheBuyable.ItemWeight;
		if ( SaleSelect.List.CanBuys[SaleSelect.List.Index]==1 )
		{
			DoBuy();
   			TheBuyable = none;
		}
	}
	OnAnychange();
	return false;
}

final function string InitNewDLCName( int ID )
{
	local int i;
	local SRSteamStatsGet ST;
	local string S;
	
	// Grab DLC name through an ugly hack.
	Class'SRSteamStatsGet'.Default.bNoInit = true;
	ST = PlayerOwner().Spawn(Class'SRSteamStatsGet');
	Class'SRSteamStatsGet'.Default.bNoInit = false;
	S = ST.GetWeaponDLCPackName(ID);
	ST.Destroy();
	
	if( S=="" ) // Misc, unnamed.
		S = Eval((ID==210944 || ID==210938),"Golden Weapons","Unknown");

	// Cache result.
	i = DLCMap.Length;
	DLCMap.Length = i+1;
	DLCMap[i].ID = ID;
	DLCMap[i].Name = S;
	return S;
}
final function string GetDLCName( int ID )
{
	local int i;

	// See if already cached.
	for( i=0; i<DLCMap.Length; ++i )
		if( DLCMap[i].ID==ID )
			return DLCMap[i].Name;
			
	// Cache new one.
	return InitNewDLCName(ID);
}
function SetInfoText()
{
	local string TempString;

	if ( TheBuyable == none && !bDidBuyableUpdate )
	{
		InfoScrollText.SetContent(InfoText[0]);
		bDidBuyableUpdate = true;

		return;
	}

	if ( TheBuyable != none && OldPickupClass != TheBuyable.ItemPickupClass )
	{
		// Unowned Weapon DLC
		if( TheBuyable.bSaleList && TheBuyable.ItemAmmoCurrent>0 )
		{
			if( TheBuyable.ItemAmmoCurrent==1 )
				InfoScrollText.SetContent(Repl(InfoText[4], "%1", GetDLCName(TheBuyable.ItemWeaponClass.Default.AppID)));
			else if( TheBuyable.ItemAmmoCurrent==2 )
				InfoScrollText.SetContent(Repl(ArchivementGetInfo, "%1", Class'SRSteamStatsGet'.Default.Achievements[TheBuyable.ItemWeaponClass.Default.UnlockedByAchievement].DisplayName));
			else InfoScrollText.SetContent(Mid(TheBuyable.ItemCategorie,InStr(TheBuyable.ItemCategorie,":")+1));
		}
		// Too expensive
		else if ( TheBuyable.ItemCost > PlayerOwner().PlayerReplicationInfo.Score && TheBuyable.bSaleList )
		{
			InfoScrollText.SetContent(InfoText[2]);
		}
		// Too heavy
		else if ( TheBuyable.ItemWeight + KFHumanPawn(PlayerOwner().Pawn).CurrentWeight > KFHumanPawn(PlayerOwner().Pawn).MaxCarryWeight && TheBuyable.bSaleList )
		{
			TempString = Repl(Infotext[1], "%1", int(TheBuyable.ItemWeight));
			TempString = Repl(TempString, "%2", int(KFHumanPawn(PlayerOwner().Pawn).MaxCarryWeight - KFHumanPawn(PlayerOwner().Pawn).CurrentWeight));
			InfoScrollText.SetContent(TempString);
		}
		// default
		else if( TheBuyable.ItemWeaponClass!=None )
			InfoScrollText.SetContent(TheBuyable.ItemWeaponClass.Default.Description);
		else InfoScrollText.SetContent(InfoText[0]);

		bDidBuyableUpdate = false;
		OldPickupClass = TheBuyable.ItemPickupClass;
	}
}

defaultproperties
{
	InfoText(4)="This weapon requires '%1' DLC pack."
	ArchivementGetInfo="This weapon requires archivement '%1' to be unlocked."

	Begin Object class=SRKFBuyMenuInvListBox Name=InventoryBox
		WinTop=0.070841
		WinLeft=0.000108
		WinWidth=0.328204
		WinHeight=0.521856
	End Object
	InvSelect=InventoryBox

	Begin Object class=SRBuyMenuSaleListBox Name=SaleBox
		WinTop=0.064312
		WinLeft=0.672632
		WinWidth=0.325857
		WinHeight=0.674039
	End Object
	SaleSelect=SaleBox
}
