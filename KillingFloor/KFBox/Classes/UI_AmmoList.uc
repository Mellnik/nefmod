//=============================================================================
// The trader menu's list with player's current inventory
//=============================================================================
// Killing Floor Source
// Copyright (C) 2009 Tripwire Interactive LLC
// Dayle "Xienen" Flowers
//=============================================================================
class UI_AmmoList extends GUIVertList;

// Settings
var	float	ItemBGWidthScale;
var	float	AmmoBGWidthScale;
var	float	ClipButtonWidthScale;
var	float	AmmoBGHeightScale;
var	float	ButtonBGHeightScale;
var	float	EquipmentBGWidthScale;
var	float	EquipmentBGHeightScale;
var	float	ItemBGYOffset;
var	float	AmmoSpacing;
var	float	ItemNameSpacing;
var	float	ButtonSpacing;
var	float	EquipmentBGXOffset;
var	float	EquipmentBGYOffset;
var float	AmmoCostScale;

// Display
var	texture	ItemBackgroundLeft;
var	texture	ItemBackgroundRight;
var	texture	SelectedItemBackgroundLeft;
var	texture	SelectedItemBackgroundRight;
var	texture	DisabledItemBackgroundLeft;
var	texture	DisabledItemBackgroundRight;
var	texture	AmmoBackground;
var	texture	ButtonBackground;
var	texture	HoverButtonBackground;
var	texture	DisabledButtonBackground;

// state
var	array<GUIBuyable>	MyBuyables,AllocatedBuyables;
var	int					MouseOverIndex;
var	int					MouseOverXIndex;

var bool	bNeedsUpdate;
var int		UpdateCounter;
var float	AutoFillCost;

delegate OnBuyClipClick(GUIBuyable Buyable);
delegate OnFillAmmoClick(GUIBuyable Buyable);

event InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	OnDrawItem = DrawInvItem;
	UpdateMyBuyables();
}

event Opened(GUIComponent Sender)
{
	Super.Opened(Sender);
	UpdateMyBuyables();
}

event Closed(GUIComponent Sender, bool bCancelled)
{
	MyBuyables.Length = 0;
	Super.Closed(Sender, bCancelled);
}

final function GUIBuyable GetBuyable()
{
	local GUIBuyable B;

	if( AllocatedBuyables.Length!=0 )
	{
		B = AllocatedBuyables[0];
		AllocatedBuyables.Remove(0,1);
	}
	else B = new (None) Class'GUIBuyable';
	return B;
}
final function EmptyBuyables()
{
	local int i;
	
	for( i=(MyBuyables.Length-1); i>=0; --i )
		if( MyBuyables[i]!=None )
			AllocatedBuyables[AllocatedBuyables.Length] = MyBuyables[i];
	MyBuyables.Length = 0;
}
function UpdateMyBuyables()
{
	local PlayerController PC;
	local class<KFVeterancyTypes> Vet;
	local KFWeapon Weap;
	local KFPlayerReplicationInfo KFPRI;
	local GUIBuyable MyBuyable, FragBuyable;
	local Inventory CurInv;
	local float CurAmmo, MaxAmmo;
	local class<KFWeaponPickup> MyPickup, MyPrimaryPickup;

	PC = PlayerOwner();
	if( PC.Pawn==None )
		return;

	KFPRI = KFPlayerReplicationInfo(PC.PlayerReplicationInfo);
	EmptyBuyables();
	AutoFillCost = 0.00000;

	// Grab Players Veterancy for quick reference
	if ( KFPRI!=none && KFPRI.ClientVeteranSkill!=None )
		Vet = KFPRI.ClientVeteranSkill;
	else Vet = class'KFVeterancyTypes';

	// Fill the Buyables
	MyBuyables.Length = 1;
	for ( CurInv=PC.Pawn.Inventory; CurInv!=none; CurInv=CurInv.Inventory )
    {
		if ( !CurInv.IsA('KFWeapon') || CurInv.IsA('Welder') || CurInv.IsA('Syringe') || CurInv.IsA('KFMeleeGun') )
            continue;

		MyPickup = class<KFWeaponPickup>(CurInv.default.PickupClass);
		Weap = KFWeapon(CurInv);
		if( MyPickup==None || Weap.GetAmmoClass(0)==None )
			continue;

		Weap.GetAmmoCount(MaxAmmo, CurAmmo);

		MyBuyable = GetBuyable();

		// This is a rather ugly way to support Secondary Ammo because all of the needed Data is jumbled between the Weapon and it's 2 Pickup Classes
		if ( Weap.bHasSecondaryAmmo )
			MyPrimaryPickup = MyPickup.default.PrimaryWeaponPickup;
		else MyPrimaryPickup = MyPickup;

		MyBuyable.ItemName 			= MyPickup.default.ItemShortName;
		MyBuyable.ItemDescription 	= Weap.default.Description;
		MyBuyable.ItemImage			= Weap.default.TraderInfoTexture;
		MyBuyable.ItemWeaponClass	= Weap.class;
		MyBuyable.ItemAmmoClass		= Weap.GetAmmoClass(0);
		MyBuyable.ItemPickupClass	= MyPrimaryPickup;
		MyBuyable.ItemAmmoCost		= MyPrimaryPickup.default.AmmoCost * AmmoCostScale * Vet.static.GetAmmoCostScaling(KFPRI, MyPrimaryPickup) * Vet.static.GetMagCapacityMod(KFPRI, Weap);
		if( Class<HuskGunPickup>(MyPickup)!=None )
		{
			MyBuyable.ItemFillAmmoCost	= (int(((MaxAmmo - CurAmmo) * (MyPrimaryPickup.default.AmmoCost * AmmoCostScale)) / float(MyPrimaryPickup.default.BuyClipSize))) * Vet.static.GetAmmoCostScaling(KFPRI, MyPrimaryPickup);
		}
		else
		{
			MyBuyable.ItemFillAmmoCost	= (int(((MaxAmmo - CurAmmo) * (MyPrimaryPickup.default.AmmoCost * AmmoCostScale)) / float(Weap.default.MagCapacity))) * Vet.static.GetAmmoCostScaling(KFPRI, MyPrimaryPickup);
		}
		MyBuyable.ItemWeight		= Weap.Weight;
		MyBuyable.ItemPower			= MyPickup.default.PowerValue;
		MyBuyable.ItemRange			= MyPickup.default.RangeValue;
		MyBuyable.ItemSpeed			= MyPickup.default.SpeedValue;
		MyBuyable.ItemAmmoCurrent	= CurAmmo;
		MyBuyable.ItemAmmoMax		= MaxAmmo;
		MyBuyable.bSaleList			= false;

		if ( int(MaxAmmo) > int(CurAmmo) )
			AutoFillCost += MyBuyable.ItemFillAmmoCost;

		if ( CurInv.IsA('Frag') )
			FragBuyable = MyBuyable;
		else
		{
			MyBuyables.Insert(0, 1);
			MyBuyables[0] = MyBuyable;
		}

		if ( Weap.bHasSecondaryAmmo )
		{
			Weap.GetSecondaryAmmoCount(MaxAmmo, CurAmmo);

			MyBuyable = GetBuyable();

			MyBuyable.ItemName 			= MyPickup.default.SecondaryAmmoShortName;
			MyBuyable.ItemDescription 	= Weap.default.Description;
			MyBuyable.ItemImage			= Weap.default.TraderInfoTexture;
			MyBuyable.ItemWeaponClass	= Weap.class;
			MyBuyable.ItemAmmoClass		= Weap.GetAmmoClass(1);
			MyBuyable.ItemPickupClass	= MyPickup;
			MyBuyable.ItemAmmoCost		= MyPickup.default.AmmoCost * AmmoCostScale * Vet.static.GetAmmoCostScaling(KFPRI, MyPickup) * Vet.static.GetMagCapacityMod(KFPRI, Weap);
			MyBuyable.ItemFillAmmoCost	= (int(((MaxAmmo - CurAmmo) * (MyPickup.default.AmmoCost * AmmoCostScale)))) * Vet.static.GetAmmoCostScaling(KFPRI, MyPickup);
			MyBuyable.ItemWeight		= Weap.Weight;
			MyBuyable.ItemPower			= MyPickup.default.PowerValue;
			MyBuyable.ItemRange			= MyPickup.default.RangeValue;
			MyBuyable.ItemSpeed			= MyPickup.default.SpeedValue;
			MyBuyable.ItemAmmoCurrent	= CurAmmo;
			MyBuyable.ItemAmmoMax		= MaxAmmo;
			MyBuyable.bSaleList			= false;

			if ( int(MaxAmmo) > int(CurAmmo) )
				AutoFillCost += MyBuyable.ItemFillAmmoCost;
			MyBuyables[MyBuyables.Length] = MyBuyable;
		}
	}

	if( FragBuyable!=None )
		MyBuyables[MyBuyables.Length] = FragBuyable;

	// Now Update the list
	UpdateList();
}

function UpdateList()
{
	// Update the ItemCount and select the first item
	ItemCount = MyBuyables.Length;

	if ( bNotify )
		CheckLinkedObjects(Self);

	if ( MyScrollBar != none )
		MyScrollBar.AlignThumb();
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int NewIndex;
	local float RelativeMouseX;

	if ( IsInClientBounds() )
	{
		//  Figure out which Item we're clicking on
		NewIndex = CalculateIndex();
		RelativeMouseX = Controller.MouseX - ClientBounds[0];
		if ( RelativeMouseX < ActualWidth() * ItemBGWidthScale )
		{
			if ( MyBuyables[NewIndex] != none )
			{
				SetIndex(NewIndex);
				MouseOverXIndex = 0;
				return true;
			}
		}
		else
		{
			RelativeMouseX -= ActualWidth() * (ItemBGWidthScale + AmmoBGWidthScale);

			if ( RelativeMouseX > 0 )
			{
				if ( RelativeMouseX < ActualWidth() * (1.0 - ItemBGWidthScale - AmmoBGWidthScale) * ClipButtonWidthScale )
				{
					// Buy Clip
					OnBuyClipClick(MyBuyables[NewIndex]);
				}
				else
				{
					// Fill Ammo
					OnFillAmmoClick(MyBuyables[NewIndex]);
				}
			}
		}
	}

	return false;
}

function bool PreDraw(Canvas Canvas)
{
	local float RelativeMouseX;

	if ( IsInClientBounds() )
	{
		//  Figure out which Item we're clicking on
		MouseOverIndex = Top + ((Controller.MouseY - ClientBounds[1]) / ItemHeight);
		if ( MouseOverIndex >= ItemCount )
		{
			MouseOverIndex = -1;
		}
		else
		{
			RelativeMouseX = Controller.MouseX - ClientBounds[0];
			if ( RelativeMouseX < ActualWidth() * ItemBGWidthScale )
			{
				MouseOverXIndex = 0;
			}
			else
			{
				RelativeMouseX -= ActualWidth() * (ItemBGWidthScale + AmmoBGWidthScale);

				if ( RelativeMouseX > 0 )
				{
					if ( RelativeMouseX < ActualWidth() * (1.0 - ItemBGWidthScale - AmmoBGWidthScale) * ClipButtonWidthScale )
					{
						MouseOverXIndex = 1;
					}
					else
					{
						MouseOverXIndex = 2;
					}
				}
				else
				{
					MouseOverXIndex = -1;
				}
			}
		}
	}
	else
	{
		MouseOverIndex = -1;
	}

	return false;
}

function DrawInvItem(Canvas Canvas, int CurIndex, float X, float Y, float Width, float Height, bool bSelected, bool bPending)
{
	local float ItemBGWidth, AmmoBGWidth, ClipButtonWidth, FillButtonWidth;
	local float TempX, TempY;
	local float StringHeight, StringWidth;
	local string S;

	OnClickSound=CS_Click;

	// Initialize the Canvas
	Canvas.Style = 1;
	// Canvas.Font = class'ROHUD'.Static.GetSmallMenuFont(Canvas);
	Canvas.SetDrawColor(255, 255, 255, 255);

	if ( MyBuyables[CurIndex] == none )
	{
		Canvas.SetPos(X + EquipmentBGXOffset, Y + Height - EquipmentBGYOffset - EquipmentBGHeightScale * Height);
		Canvas.DrawTileStretched(AmmoBackground, EquipmentBGWidthScale * Width, EquipmentBGHeightScale * Height);

		Canvas.SetDrawColor(175, 176, 158, 255);
		Canvas.TextSize(Class'KFBuyMenuInvList'.Default.EquipmentString, StringWidth, StringHeight);
		Canvas.SetPos(X + EquipmentBGXOffset + ((EquipmentBGWidthScale * Width - StringWidth) / 2.0), Y + Height - EquipmentBGYOffset - EquipmentBGHeightScale * Height + ((EquipmentBGHeightScale * Height - StringHeight) / 2.0));
		Canvas.DrawTextClipped(Class'KFBuyMenuInvList'.Default.EquipmentString);
	}
	else
	{
		// Calculate Widths for all components
		ItemBGWidth = (Width * ItemBGWidthScale);
		AmmoBGWidth = Width * AmmoBGWidthScale;

		FillButtonWidth = ((1.0 - ItemBGWidthScale - AmmoBGWidthScale) * Width) - ButtonSpacing;
		ClipButtonWidth = FillButtonWidth * ClipButtonWidthScale;
		FillButtonWidth -= ClipButtonWidth;

		// Offset for the Background
		TempX = X;
		TempY = Y;

		// Draw Item Background
		Canvas.SetPos(TempX, TempY);

		if ( bSelected )
		{
			Canvas.SetPos(TempX, TempY + ItemBGYOffset);
			Canvas.DrawTileStretched(SelectedItemBackgroundRight, ItemBGWidth, Height - (2.0 * ItemBGYOffset));
		}
		else
		{
			Canvas.SetPos(TempX, TempY + ItemBGYOffset);
			Canvas.DrawTileStretched(ItemBackgroundRight, ItemBGWidth, Height - (2.0 * ItemBGYOffset));
		}

		// Select Text color
		if ( CurIndex == MouseOverIndex && MouseOverXIndex == 0 )
		{
			Canvas.SetDrawColor(255, 255, 255, 255);
		}
		else
		{
			Canvas.SetDrawColor(0, 0, 0, 255);
		}

		// Draw the item's name
		Canvas.TextSize(MyBuyables[CurIndex].ItemName, StringWidth, StringHeight);
		Canvas.SetPos(TempX + ItemNameSpacing, Y + ((Height - StringHeight) / 2.0));
		Canvas.DrawTextClipped(MyBuyables[CurIndex].ItemName);

		// Draw the item's ammo status if it is not a melee weapon
		TempX += ItemBGWidth + AmmoSpacing;

		Canvas.SetDrawColor(255, 255, 255, 255);
		Canvas.SetPos(TempX, TempY + ((Height - AmmoBGHeightScale * Height) / 2.0));
		Canvas.DrawTileStretched(AmmoBackground, AmmoBGWidth, AmmoBGHeightScale * Height);

		Canvas.SetDrawColor(175, 176, 158, 255);
		S = int(MyBuyables[CurIndex].ItemAmmoCurrent)$"/"$int(MyBuyables[CurIndex].ItemAmmoMax);
		Canvas.TextSize(S, StringWidth, StringHeight);
		Canvas.SetPos(TempX + ((AmmoBGWidth - StringWidth) / 2.0), TempY + ((Height - StringHeight) / 2.0));
		Canvas.DrawTextClipped(S);

		TempX += AmmoBGWidth + AmmoSpacing;

		Canvas.SetDrawColor(255, 255, 255, 255);
		Canvas.SetPos(TempX, TempY + ((Height - ButtonBGHeightScale * Height) / 2.0));

		if ( MyBuyables[CurIndex].ItemAmmoCurrent >= MyBuyables[CurIndex].ItemAmmoMax ||
			 (PlayerOwner().PlayerReplicationInfo.Score < MyBuyables[CurIndex].ItemFillAmmoCost && PlayerOwner().PlayerReplicationInfo.Score < MyBuyables[CurIndex].ItemAmmoCost) )
		{
			Canvas.DrawTileStretched(DisabledButtonBackground, ClipButtonWidth, ButtonBGHeightScale * Height);
			Canvas.SetDrawColor(0, 0, 0, 255);
		}
		else if ( CurIndex == MouseOverIndex && MouseOverXIndex == 1 )
		{
			Canvas.DrawTileStretched(HoverButtonBackground, ClipButtonWidth, ButtonBGHeightScale * Height);
		}
		else
		{
			Canvas.DrawTileStretched(ButtonBackground, ClipButtonWidth, ButtonBGHeightScale * Height);
			Canvas.SetDrawColor(0, 0, 0, 255);
		}

		if ( MyBuyables[CurIndex].ItemAmmoCurrent < MyBuyables[CurIndex].ItemAmmoMax )
		{
			if ( MyBuyables[CurIndex].ItemAmmoCost > MyBuyables[CurIndex].ItemFillAmmoCost )
				S = "£" @ int(MyBuyables[CurIndex].ItemFillAmmoCost);
			else S = "£" @ int(MyBuyables[CurIndex].ItemAmmoCost);
		}
		else S = "£ 0";
		Canvas.TextSize(S, StringWidth, StringHeight);
		Canvas.SetPos(TempX + ((ClipButtonWidth - StringWidth) / 2.0), TempY + ((Height - StringHeight) / 2.0));
		Canvas.DrawTextClipped(S);

		TempX += ClipButtonWidth + ButtonSpacing;

		Canvas.SetDrawColor(255, 255, 255, 255);
		Canvas.SetPos(TempX, TempY + ((Height - ButtonBGHeightScale * Height) / 2.0));

		if ( MyBuyables[CurIndex].ItemAmmoCurrent >= MyBuyables[CurIndex].ItemAmmoMax ||
			 (PlayerOwner().PlayerReplicationInfo.Score < MyBuyables[CurIndex].ItemFillAmmoCost && PlayerOwner().PlayerReplicationInfo.Score < MyBuyables[CurIndex].ItemAmmoCost) )
		{
			Canvas.DrawTileStretched(DisabledButtonBackground, FillButtonWidth, ButtonBGHeightScale * Height);
			Canvas.SetDrawColor(0, 0, 0, 255);
		}
		else if ( CurIndex == MouseOverIndex && MouseOverXIndex == 2 )
		{
			Canvas.DrawTileStretched(HoverButtonBackground, FillButtonWidth, ButtonBGHeightScale * Height);
		}
		else
		{
			Canvas.DrawTileStretched(ButtonBackground, FillButtonWidth, ButtonBGHeightScale * Height);
			Canvas.SetDrawColor(0, 0, 0, 255);
		}
		S = "£" @ int(MyBuyables[CurIndex].ItemFillAmmoCost);
		Canvas.TextSize(S, StringWidth, StringHeight);
		Canvas.SetPos(TempX + ((FillButtonWidth - StringWidth) / 2.0), TempY + ((Height - StringHeight) / 2.0));
		Canvas.DrawTextClipped(S);

		Canvas.SetDrawColor(255, 255, 255, 255);
	}
}

function float InvItemHeight( Canvas C )
{
	return (MenuOwner.ActualHeight() / 8) - 1.0;
}

defaultproperties
{
     ItemBGWidthScale=0.510000
     AmmoBGWidthScale=0.190000
     ClipButtonWidthScale=0.450000
     AmmoBGHeightScale=0.500000
     ButtonBGHeightScale=0.500000
     EquipmentBGWidthScale=0.350000
     EquipmentBGHeightScale=0.600000
     ItemBGYOffset=6.000000
     AmmoSpacing=1.000000
     ItemNameSpacing=10.000000
     ButtonSpacing=3.000000
     EquipmentBGXOffset=3.000000
     EquipmentBGYOffset=6.000000
     AmmoCostScale=3.000000
     ItemBackgroundLeft=Texture'KF_InterfaceArt_tex.Menu.Item_box_box'
     ItemBackgroundRight=Texture'KF_InterfaceArt_tex.Menu.Item_box_bar'
     SelectedItemBackgroundLeft=Texture'KF_InterfaceArt_tex.Menu.Item_box_box_Highlighted'
     SelectedItemBackgroundRight=Texture'KF_InterfaceArt_tex.Menu.Item_box_bar_Highlighted'
     DisabledItemBackgroundLeft=Texture'KF_InterfaceArt_tex.Menu.Item_box_box_Disabled'
     DisabledItemBackgroundRight=Texture'KF_InterfaceArt_tex.Menu.Item_box_bar_Disabled'
     AmmoBackground=Texture'KF_InterfaceArt_tex.Menu.Innerborder_transparent'
     ButtonBackground=Texture'KF_InterfaceArt_tex.Menu.Button'
     HoverButtonBackground=Texture'KF_InterfaceArt_tex.Menu.button_Highlight'
     DisabledButtonBackground=Texture'KF_InterfaceArt_tex.Menu.button_Disabled'
     GetItemHeight=UI_AmmoList.InvItemHeight
     FontScale=FNS_Medium
     OnPreDraw=UI_AmmoList.PreDraw
}
