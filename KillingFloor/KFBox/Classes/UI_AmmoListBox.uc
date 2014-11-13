//-----------------------------------------------------------
//
//-----------------------------------------------------------
class UI_AmmoListBox extends GUIListBoxBase;

var UI_AmmoList List;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController,MyOwner);
	List = UI_AmmoList(AddComponent(string(Class'UI_AmmoList')));
	InitBaseList(List);
}
final function GUIBuyable GetSelectedBuyable()
{
	if( List.Index>=0 && List.Index<List.MyBuyables.Length )
		return List.MyBuyables[List.Index];
	return None;
}

defaultproperties
{
}
