//=============================================================================
// Winchester Pickup.
//=============================================================================
class OutlawWinchesterPickup extends KFWeaponPickup;

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
     cost=200
     BuyClipSize=10
     PowerValue=50
     SpeedValue=35
     RangeValue=90
     Description="A Customized single-shot rifle for the Outlaw."
     ItemName="Outlaw Custom Lever Action Rifle"
     ItemShortName="Outlaw Lever Action"
     AmmoItemName="Rifle bullets"
     CorrespondingPerkIndex=9
     EquipmentCategoryID=9
     InventoryType=Class'BMTCustomMut.OutlawWinchester'
     PickupMessage="You got the Outlaw Custom Lever Action Rifle"
     PickupSound=Sound'KF_RifleSnd.RifleBase.Rifle_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.Rifle.LeverAction_pickup'
     CollisionRadius=30.000000
     CollisionHeight=5.000000
}
