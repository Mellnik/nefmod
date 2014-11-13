class HK417Pickup extends KFWeaponPickup;

/*
function ShowDeagleInfo(Canvas C)
{
  C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Deagle', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}
*/

defaultproperties
{
     Weight=6.000000
     cost=3000
     BuyClipSize=20
     PowerValue=60
     SpeedValue=30
     RangeValue=95
     Description="HK-417"
     ItemName="HK-417"
     ItemShortName="HK-417"
     AmmoItemName="HK-417 Ammo"
     CorrespondingPerkIndex=3
     EquipmentCategoryID=3
     InventoryType=Class'BMTCustomMut.HK417'
     PickupMessage="You got The HK-417"
     PickupSound=Sound'HK417_A.HK417_pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'HK417_A.HK417_st'
     DrawScale=0.800000
     CollisionRadius=30.000000
     CollisionHeight=5.000000
}
