//=============================================================================
// The trader menu's list with items for sale
//=============================================================================
class SRBuyMenuSaleList extends KFBuyMenuSaleList;

var int ActiveCategory,SelectionOffset;
var localized string WeaponGroupText;
var array<byte> DLCLocked;

event Opened(GUIComponent Sender)
{
	super(GUIVertList).Opened(Sender);
	// Fixed script warnings.
	UpdateForSaleBuyables();
}
final function GUIBuyable GetSelectedBuyable()
{
	if( Index>=CanBuys.Length || CanBuys[Index]>1 || (Index-SelectionOffset)>=ForSaleBuyables.Length )
		return None;
	return ForSaleBuyables[Index-SelectionOffset];
}
final function CopyAllBuyables()
{
	local ClientPerkRepLink L;
	local int i;

	L = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
	if( L==None )
		return;
	for( i=0; i<ForSaleBuyables.Length; ++i )
		if( ForSaleBuyables[i]!=None )
			L.AllocatedObjects[L.AllocatedObjects.Length] = ForSaleBuyables[i];
}
final function GUIBuyable AllocateEntry( ClientPerkRepLink L )
{
	local GUIBuyable G;

	if( L.AllocatedObjects.Length==0 )
		return new Class'GUIBuyable';
	G = L.AllocatedObjects[0];
	L.ResetItem(G);
	L.AllocatedObjects.Remove(0,1);
	return G;
}

final function SetCategoryNum( int N )
{
	if( ActiveCategory==N )
		ActiveCategory = -1;
	else ActiveCategory = N;
	SelectionOffset = (N+1);
	UpdateForSaleBuyables();
	Index = N;
}
event Closed(GUIComponent Sender, bool bCancelled)
{
	CopyAllBuyables();
	ForSaleBuyables.Length = 0;
	super.Closed(Sender, bCancelled);
}
final function bool DualIsInInventory( Class<Weapon> WC )
{
	local Inventory I;
	
	for( I=PlayerOwner().Pawn.Inventory; I!=None; I=I.Inventory )
	{
		if( Weapon(I)!=None && Weapon(I).DemoReplacement==WC )
			return true;
	}
	return false;
}
final function bool IsInInventoryWep( Class<Weapon> WC )
{
	local Inventory I;
	
	for( I=PlayerOwner().Pawn.Inventory; I!=None; I=I.Inventory )
		if( I.Class==WC )
			return true;
	return false;
}

final function bool CheckGoldGunAvailable( class<Pickup> WC, ClientPerkRepLink K )
{
	local int i;
	
	for ( i=(K.ShopInventory.Length-1); i>=0; --i )
	{
		if( K.ShopInventory[i].PC==WC )
			return (K.ShopInventory[i].bDLCLocked==0);
	}
	return false;
}

final function KFShopVolume_Story GetCurrentShop()
{
	local KFPlayerController_Story	StoryPC;

	StoryPC = KFPlayerController_Story(PlayerOwner());
	if(StoryPC != none)
		return StoryPC.CurrentShopVolume;
	return none;
}

function UpdateForSaleBuyables()
{
	local class<KFVeterancyTypes> PlayerVeterancy;
	local KFPlayerReplicationInfo KFPRI;
	local ClientPerkRepLink KFLR;
	local GUIBuyable ForSaleBuyable;
	local class<KFWeaponPickup> ForSalePickup;
	local int j, DualDivider, i, Num, z, PerkSaleOffset;
	local class<KFWeapon> ForSaleWeapon;
	local class<SRVeterancyTypes> Blocker;
	local KFShopVolume_Story CurrentShop;

	// Clear the ForSaleBuyables array
	CopyAllBuyables();
	ForSaleBuyables.Length = 0;
	DLCLocked.Length = 0;

	// Grab the items for sale
	KFLR = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
	if( KFLR==None )
		return; // Hmmmm?

	// Grab Players Veterancy for quick reference
	if ( KFPlayerController(PlayerOwner()) != none )
		PlayerVeterancy = KFPlayerReplicationInfo(PlayerOwner().PlayerReplicationInfo).ClientVeteranSkill;
	if( PlayerVeterancy==None )
		PlayerVeterancy = class'KFVeterancyTypes';
	CurrentShop = GetCurrentShop();

	KFPRI = KFPlayerReplicationInfo(PlayerOwner().PlayerReplicationInfo);

	// Grab the weapons!
	if( CurrentShop!=None )
		Num = CurrentShop.SaleItems.Length;
	else Num = KFLR.ShopInventory.Length;
	for ( z=0; z<Num; z++ )
	{
		if( CurrentShop!=None )
		{
			// Allow story mode volume limit weapon availability.
			ForSalePickup = class<KFWeaponPickup>(CurrentShop.SaleItems[z]);
			if( ForSalePickup==None )
				continue;
			for ( j=(KFLR.ShopInventory.Length-1); j>=KFLR.ShopInventory.Length; --j )
				if( KFLR.ShopInventory[j].PC==ForSalePickup )
					break;
			if( j<0 )
				continue;
		}
		else
		{
			ForSalePickup = class<KFWeaponPickup>(KFLR.ShopInventory[z].PC);
			j = z;
		}

		if ( ForSalePickup==None || ActiveCategory!=KFLR.ShopInventory[j].CatNum
			 || class<KFWeapon>(ForSalePickup.default.InventoryType).default.bKFNeverThrow
			 || IsInInventory(ForSalePickup) )
			continue;
			
		ForSaleWeapon = class<KFWeapon>(ForSalePickup.default.InventoryType);

		// Remove single wield.
		if ( (ForSalePickup==Class'DeaglePickup' && IsInInventory(class'DualDeaglePickup'))
			 || (ForSalePickup==Class'Magnum44Pickup' && IsInInventory(class'Dual44MagnumPickup'))
			 || (ForSalePickup==Class'MK23Pickup' && IsInInventory(class'DualMK23Pickup'))
			 || (ForSalePickup==Class'FlareRevolverPickup' && IsInInventory(class'DualFlareRevolverPickup'))
			 ||  DualIsInInventory(ForSaleWeapon))
			continue;

		DualDivider = 1;

		// Make cheaper.
		if ( (ForSalePickup==Class'DualDeaglePickup' && IsInInventory(class'DeaglePickup'))
			 || (ForSalePickup==Class'Dual44MagnumPickup' && IsInInventory(class'Magnum44Pickup'))
			 || (ForSalePickup==Class'DualMK23Pickup' && IsInInventory(class'MK23Pickup'))
			 || (ForSalePickup==Class'DualFlareRevolverPickup' && IsInInventory(class'FlareRevolverPickup'))
			 || (ForSaleWeapon.Default.DemoReplacement!=None && IsInInventoryWep(ForSaleWeapon.Default.DemoReplacement)) )
			DualDivider = 2;

		Blocker = None;
		for( i=0; i<KFLR.CachePerks.Length; ++i )
			if( !KFLR.CachePerks[i].PerkClass.Static.AllowWeaponInTrader(ForSalePickup,KFPRI,KFLR.CachePerks[i].CurrentLevel) )
			{
				Blocker = KFLR.CachePerks[i].PerkClass;
				break;
			}
		if( Blocker!=None && Blocker.Default.DisableTag=="" )
			continue;

		ForSaleBuyable = AllocateEntry(KFLR);

   		ForSaleBuyable.ItemName 		= ForSalePickup.default.ItemName;
		ForSaleBuyable.ItemDescription 		= ForSalePickup.default.Description;
		ForSaleBuyable.ItemImage		= ForSaleWeapon.default.TraderInfoTexture;
		ForSaleBuyable.ItemWeaponClass		= ForSaleWeapon;
		ForSaleBuyable.ItemAmmoClass		= ForSaleWeapon.default.FireModeClass[0].default.AmmoClass;
		ForSaleBuyable.ItemPickupClass		= ForSalePickup;
		ForSaleBuyable.ItemCost			= int((float(ForSalePickup.default.Cost)
										  	  * PlayerVeterancy.static.GetCostScaling(KFPRI, ForSalePickup)) / DualDivider);
		ForSaleBuyable.ItemAmmoCost		= 0;
		ForSaleBuyable.ItemFillAmmoCost		= 0;

		ForSaleBuyable.ItemWeight	= ForSaleWeapon.default.Weight;
		if( DualDivider==2 )
		{
			if( ForSalePickup==Class'DualDeaglePickup' )
				ForSaleBuyable.ItemWeight -= class'Deagle'.default.Weight;
			else if( ForSalePickup==Class'Dual44MagnumPickup' )
				ForSaleBuyable.ItemWeight -= class'Magnum44Pistol'.default.Weight;
			else if( ForSalePickup==Class'DualMK23Pickup' )
				ForSaleBuyable.ItemWeight -= class'MK23Pickup'.default.Weight;
			else if( ForSalePickup==Class'DualFlareRevolverPickup' )
				ForSaleBuyable.ItemWeight -= class'FlareRevolverPickup'.default.Weight;
			else ForSaleBuyable.ItemWeight -= Class<KFWeapon>(ForSaleWeapon.Default.DemoReplacement).Default.Weight;
		}

		ForSaleBuyable.ItemPower		= ForSalePickup.default.PowerValue;
		ForSaleBuyable.ItemRange		= ForSalePickup.default.RangeValue;
		ForSaleBuyable.ItemSpeed		= ForSalePickup.default.SpeedValue;
		ForSaleBuyable.ItemAmmoMax		= 0;
		ForSaleBuyable.ItemPerkIndex		= ForSalePickup.default.CorrespondingPerkIndex;

		// Make sure we mark the list as a sale list
		ForSaleBuyable.bSaleList = true;

		// Sort same perk weapons in front.
		if( ForSalePickup.default.CorrespondingPerkIndex == PlayerVeterancy.default.PerkIndex )
		{
			ForSaleBuyables.Insert(PerkSaleOffset, 1);
			DLCLocked.Insert(PerkSaleOffset,1);
			i = PerkSaleOffset++;
		}
		else
		{
			i = ForSaleBuyables.Length;
			ForSaleBuyables.Length = i+1;
			DLCLocked.Length = i+1;
		}
		ForSaleBuyables[i] = ForSaleBuyable;
		DLCLocked[i] = KFLR.ShopInventory[j].bDLCLocked;
		if( DLCLocked[i]==0 && Blocker!=None )
		{
			ForSaleBuyable.ItemCategorie = Blocker.Default.DisableTag$":"$Blocker.Default.DisableDescription;
			DLCLocked[i] = 3;
		}
		ForSaleBuyable.ItemAmmoCurrent = DLCLocked[i]; // DLC info.
	}

	// Now Update the list
	UpdateList();
}

function UpdateList()
{
	local int i,j;
	local ClientPerkRepLink KFLR;

	KFLR = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());

	// Update the ItemCount and select the first item
	ItemCount = KFLR.ShopCategories.Length + ForSaleBuyables.Length;

	// Clear the arrays
	if ( ForSaleBuyables.Length < ItemPerkIndexes.Length )
	{
		ItemPerkIndexes.Length = ItemCount;
		PrimaryStrings.Length = ItemCount;
		SecondaryStrings.Length = ItemCount;
		CanBuys.Length = ItemCount;
	}

	// Update categories
	if( ActiveCategory>=0 )
	{
		for( i=0; i<(ActiveCategory+1); ++i )
		{
			PrimaryStrings[j] = KFLR.ShopCategories[i];
			CanBuys[j] = 2+i;
			++j;
		}
	}
	else
	{
		for( i=0; i<KFLR.ShopCategories.Length; ++i )
		{
			PrimaryStrings[j] = KFLR.ShopCategories[i];
			CanBuys[j] = 2+i;
			++j;
		}
	}

	// Update the players inventory list
	for ( i=0; i<ForSaleBuyables.Length; i++ )
	{
		PrimaryStrings[j] = ForSaleBuyables[i].ItemName;
		SecondaryStrings[j] = "£" @ int(ForSaleBuyables[i].ItemCost);

		ItemPerkIndexes[j] = ForSaleBuyables[i].ItemPerkIndex;

		if( DLCLocked[i]!=0 )
		{
			CanBuys[j] = 0;
			if( DLCLocked[i]==1 )
				SecondaryStrings[j] = "DLC";
			else if( DLCLocked[i]==2 )
				SecondaryStrings[j] = "LOCKED";
			else SecondaryStrings[j] = Left(ForSaleBuyables[i].ItemCategorie,InStr(ForSaleBuyables[i].ItemCategorie,":"));
		}
		else if ( ForSaleBuyables[i].ItemCost > PlayerOwner().PlayerReplicationInfo.Score ||
			 ForSaleBuyables[i].ItemWeight + KFHumanPawn(PlayerOwner().Pawn).CurrentWeight > KFHumanPawn(PlayerOwner().Pawn).MaxCarryWeight )
		{
			CanBuys[j] = 0;
		}
		else
		{
			CanBuys[j] = 1;
		}
		++j;
	}

	if( ActiveCategory>=0 && ActiveCategory<KFLR.ShopCategories.Length )
	{
		for( i=(ActiveCategory+1); i<KFLR.ShopCategories.Length; ++i )
		{
			PrimaryStrings[j] = KFLR.ShopCategories[i];
			CanBuys[j] = 2+i;
			++j;
		}
	}

	if ( bNotify )
 	{
		CheckLinkedObjects(Self);
	}

	if ( MyScrollBar != none )
	{
		MyScrollBar.AlignThumb();
	}

	bNeedsUpdate = false;
}

function DrawInvItem(Canvas Canvas, int CurIndex, float X, float Y, float Width, float Height, bool bSelected, bool bPending)
{
	local float TempX, TempY, TempHeight;
	local float StringHeight, StringWidth;
	local ClientPerkRepLink KFLR;
	local Material M;

	OnClickSound = CS_Click;

	// Offset for the Background
	TempX = X;
	TempY = Y + ItemSpacing / 2.0;

	// Initialize the Canvas
	Canvas.Style = 1;
	//Canvas.Font = class'ROHUD'.Static.GetSmallMenuFont(Canvas);
	Canvas.SetDrawColor(255, 255, 255, 255);

	// Draw Item Background
	Canvas.SetPos(TempX, TempY);

	if ( CanBuys[CurIndex]==0 )
	{
		Canvas.DrawTileStretched(DisabledItemBackgroundLeft, Height - ItemSpacing, Height - ItemSpacing);

		TempX += ((Height - ItemSpacing) - 1);
		TempHeight = Height - 12;
		TempY += 6;//(Height - TempHeight) / 2;

		Canvas.SetPos(TempX, TempY);

		Canvas.DrawTileStretched(DisabledItemBackgroundRight, Width - (Height - ItemSpacing), Height - 12);
	}
	else if ( CanBuys[CurIndex]>1 )
	{
		// Drawing without perk icon.
		TempHeight = Height - 12;
		TempY += 6;
		Canvas.SetPos(TempX, TempY);

		if ( bSelected )
			Canvas.DrawTileStretched(SelectedItemBackgroundRight, Width - (Height - ItemSpacing), Height - 12);
		else Canvas.DrawTileStretched(ItemBackgroundRight, Width - (Height - ItemSpacing), Height - 12);
	}
	else if ( bSelected )
	{
		Canvas.DrawTileStretched(SelectedItemBackgroundLeft, Height - ItemSpacing, Height - ItemSpacing);

		TempX += ((Height - ItemSpacing) - 1);
		TempHeight = Height - 12;
		TempY += 6;//(Height - TempHeight) / 2;

		Canvas.SetPos(TempX, TempY);
		Canvas.DrawTileStretched(SelectedItemBackgroundRight, Width - (Height - ItemSpacing), Height - 12);
	}
	else
	{
		Canvas.DrawTileStretched(ItemBackgroundLeft, Height - ItemSpacing, Height - ItemSpacing);

		TempX += ((Height - ItemSpacing) - 1);
		TempHeight = Height - 12;
		TempY += 6;//(Height - TempHeight) / 2;

		Canvas.SetPos(TempX, TempY);

		Canvas.DrawTileStretched(ItemBackgroundRight, Width - (Height - ItemSpacing), Height - 12);
	}

	if( CanBuys[CurIndex]<2 )
	{
		Canvas.SetPos(X + 4, Y + 4);

		KFLR = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
		if( KFLR!=None && KFLR.ShopPerkIcons.Length>ItemPerkIndexes[CurIndex] )
			M = KFLR.ShopPerkIcons[ItemPerkIndexes[CurIndex]];
		else M = NoPerkIcon;
		if( M!=None )
			Canvas.DrawTile(M, Height - 8, Height - 8, 0, 0, M.MaterialUSize(), M.MaterialVSize());
	}

	// Select Text color
	if ( CurIndex == MouseOverIndex )
	{
		Canvas.SetDrawColor(255, 255, 255, 255);
	}
	else
	{
		Canvas.SetDrawColor(0, 0, 0, 255);
	}

	// Draw the item's name or category
	Canvas.StrLen(PrimaryStrings[CurIndex], StringWidth, StringHeight);
	Canvas.SetPos(TempX + (0.2 * Height), TempY + ((TempHeight - StringHeight) / 2));
	Canvas.DrawText(PrimaryStrings[CurIndex]);

	// Draw the item's price
	if ( CanBuys[CurIndex] <2 )
	{
		Canvas.StrLen(SecondaryStrings[CurIndex], StringWidth, StringHeight);
		Canvas.SetPos((TempX - Height) + Width - (StringWidth + (0.2 * Height)), TempY + ((TempHeight - StringHeight) / 2));
		Canvas.DrawText(SecondaryStrings[CurIndex]);
	}
	else
	{
		Canvas.StrLen(WeaponGroupText, StringWidth, StringHeight);
		Canvas.SetPos((TempX - Height) + Width - (StringWidth + (0.2 * Height)), TempY + ((TempHeight - StringHeight) / 2));
		Canvas.DrawText(WeaponGroupText);
	}

	Canvas.SetDrawColor(255, 255, 255, 255);
}

function IndexChanged(GUIComponent Sender)
{
	if ( CanBuys[Index]==0 && ForSaleBuyables[Index-SelectionOffset].ItemAmmoCurrent==0 )
	{
		if ( ForSaleBuyables[Index-SelectionOffset].ItemCost > PlayerOwner().PlayerReplicationInfo.Score )
			PlayerOwner().Pawn.DemoPlaySound(TraderSoundTooExpensive, SLOT_Interface, 2.0);
		else if ( ForSaleBuyables[Index-SelectionOffset].ItemWeight + KFHumanPawn(PlayerOwner().Pawn).CurrentWeight > KFHumanPawn(PlayerOwner().Pawn).MaxCarryWeight )
			PlayerOwner().Pawn.DemoPlaySound(TraderSoundTooHeavy, SLOT_Interface, 2.0);
	}
	Super(GUIVertList).IndexChanged(Sender);
}

defaultproperties
{
	ActiveCategory=-1
	WeaponGroupText="Weapon group"
}
