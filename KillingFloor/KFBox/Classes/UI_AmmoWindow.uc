Class UI_AmmoWindow extends FloatingWindow;

var AmmoReplication RepNotify;
var transient UI_AmmoWindow TempNewMenu;
var	automated UI_AmmoListBox InvSelect;
var automated GUIImage InvBG;
var automated GUIButton AutoFillButton,ExitButton,RepairCrate;

function Opened(GUIComponent Sender)
{
	Class'UI_AmmoWindow'.Default.TempNewMenu = Self;
    Super.Opened(Sender);
}
function bool NotifyLevelChange()
{
	RepNotify = None;
	bPersistent = false;
	return true;
}
function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController,MyOwner);
	SetTimer(0.5, true);
	InvSelect.SetPosition(InvBG.WinLeft + 10.f / float(Controller.ResX),
						  InvBG.WinTop + 65.f / float(Controller.ResY),
						  InvBG.WinWidth - 20.f / float(Controller.ResX),
						  InvBG.WinHeight - 70.f / float(Controller.ResY),
						  true);
	InvSelect.List.OnBuyClipClick = BuyClipClick;
	InvSelect.List.OnFillAmmoClick = FillAmmoClick;
}
function Closed( GUIComponent Sender, bool bCancelled )
{
	Class'UI_AmmoWindow'.Default.TempNewMenu = None;
	if( RepNotify!=None )
	{
		RepNotify.ActiveWindow = None; // To prevent game from opening main menu.
		RepNotify.ServerClosedMenu();
	}
	RepNotify = None;
	Super.Closed(Sender, bCancelled);
}
function Timer()
{
	InvSelect.List.UpdateMyBuyables();
	AutoFillButton.Caption = Class'KFTab_BuyMenu'.Default.AutoFillString $ " (£ " $ int(InvSelect.List.AutoFillCost)$")";

	if ( int(InvSelect.List.AutoFillCost) < 1 )
		AutoFillButton.DisableMe();
	else AutoFillButton.EnableMe();
	
	if( RepNotify!=None && RepNotify.Box!=None && RepNotify.Box.Health<RepNotify.Box.CrateHealth )
	{
		RepairCrate.EnableMe();
		RepairCrate.Caption = Class'KFBuyMenuInvList'.Default.RepairString$" (£ "$RepNotify.GetRepairValue()$")";
	}
	else
	{
		RepairCrate.DisableMe();
		RepairCrate.Caption = Class'KFBuyMenuInvList'.Default.RepairString;
	}
}
function BuyClipClick(GUIBuyable Buyable)
{
	if( RepNotify!=None )
		RepNotify.ServerBuyAmmo(Buyable.ItemAmmoClass,true);
}
function FillAmmoClick(GUIBuyable Buyable)
{
	if( RepNotify!=None )
		RepNotify.ServerBuyAmmo(Buyable.ItemAmmoClass,false);
}
function bool InternalOnClick(GUIComponent Sender)
{
	switch( Sender )
	{
	case AutoFillButton:
		if ( RepNotify!=None )
			DoFillAllAmmo();
		break;
	case ExitButton:
		Controller.RemoveMenu(Self);
		break;
	case RepairCrate:
		if ( RepNotify!=None )
			RepNotify.ServerRepairCrate();
		break;
	}
	return true;
}

// Fills the ammo of all weapons in the inv to the max
function DoFillAllAmmo()
{
    local byte Pass;
	local Inventory CurInv;
	local KFWeapon Weap;
	local float MaxAmmo,CurAmmo;

	for ( Pass=0; Pass<3; Pass++ )
    {
		for ( CurInv=PlayerOwner().Pawn.Inventory; CurInv!=none; CurInv=CurInv.Inventory )
		{
			if ( !CurInv.IsA('KFWeapon') || CurInv.IsA('Welder') || CurInv.IsA('Syringe') || CurInv.IsA('KFMeleeGun') )
				continue;
			 // We do not want to set the priority on grenades, so let's just buy one every other buy cycle
            if ( Pass<2 && (CurInv.IsA('Frag') || CurInv.IsA('PipeBombExplosive')) )
				continue;

			Weap = KFWeapon(CurInv);
			if( Weap.GetAmmoClass(0)==None )
				continue;
			Weap.GetAmmoCount(MaxAmmo, CurAmmo);
			if( int(MaxAmmo)>int(CurAmmo) )
				RepNotify.ServerBuyAmmo(Weap.GetAmmoClass(0),false);

			if ( Weap.bHasSecondaryAmmo )
			{
				Weap.GetSecondaryAmmoCount(MaxAmmo, CurAmmo);
				if( int(MaxAmmo)>int(CurAmmo) )
					RepNotify.ServerBuyAmmo(Weap.GetAmmoClass(1),false);
			}
		}
	}
    InvSelect.List.Index = -1;
}

defaultproperties
{
     Begin Object Class=UI_AmmoListBox Name=InventoryBox
         OnCreateComponent=InventoryBox.InternalOnCreateComponent
         WinTop=0.003371
         WinLeft=0.004500
         WinWidth=0.336905
         WinHeight=0.752000
     End Object
     InvSelect=UI_AmmoListBox'KFBox.UI_AmmoWindow.InventoryBox'

     Begin Object Class=GUIImage Name=Inv
         Image=Texture'KF_InterfaceArt_tex.Menu.Thick_border_Transparent'
         ImageStyle=ISTY_Stretched
         Hint="The items in your inventory"
         WinTop=0.080000
         WinLeft=0.010000
         WinWidth=0.650000
         WinHeight=0.890000
     End Object
     InvBG=GUIImage'KFBox.UI_AmmoWindow.Inv'

     Begin Object Class=GUIButton Name=AutoFill
         Caption="Auto Fill Ammo"
         Hint="Fills Up All Weapons"
         WinTop=0.750000
         WinLeft=0.660000
         WinWidth=0.330000
         WinHeight=0.080000
         RenderWeight=0.450000
         OnClick=UI_AmmoWindow.InternalOnClick
         OnKeyEvent=AutoFill.InternalOnKeyEvent
     End Object
     AutoFillButton=GUIButton'KFBox.UI_AmmoWindow.AutoFill'

     Begin Object Class=GUIButton Name=Exit
         Caption="Exit Ammo Menu"
         Hint="Close The Ammo Menu"
         WinTop=0.850000
         WinLeft=0.660000
         WinWidth=0.330000
         WinHeight=0.080000
         RenderWeight=0.450000
         OnClick=UI_AmmoWindow.InternalOnClick
         OnKeyEvent=Exit.InternalOnKeyEvent
     End Object
     ExitButton=GUIButton'KFBox.UI_AmmoWindow.Exit'

     Begin Object Class=GUIButton Name=RepairIt
         Caption="Repair"
         Hint="Fully repair this crate"
         WinTop=0.150000
         WinLeft=0.660000
         WinWidth=0.330000
         WinHeight=0.080000
         RenderWeight=0.450000
         OnClick=UI_AmmoWindow.InternalOnClick
         OnKeyEvent=RepairIt.InternalOnKeyEvent
     End Object
     RepairCrate=GUIButton'KFBox.UI_AmmoWindow.RepairIt'

     WindowName="Ammunition box"
     bResizeWidthAllowed=False
     bResizeHeightAllowed=False
     bPersistent=True
     bAllowedAsLast=True
     WinTop=0.200000
     WinLeft=0.200000
     WinWidth=0.600000
     WinHeight=0.600000
}
