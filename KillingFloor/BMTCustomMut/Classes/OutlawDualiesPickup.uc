//=============================================================================
// Dualies Pickup.
//=============================================================================
class OutlawDualiesPickup extends KFWeaponPickup;

function ShowDualiesInfo(Canvas C)
{
	C.SetPos((C.SizeX - C.SizeY) / 2,0);
	C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Dualies', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}

defaultproperties
{
     Weight=4.000000
     cost=150
     AmmoCost=10
     BuyClipSize=30
     PowerValue=35
     SpeedValue=85
     RangeValue=35
     Description="A pair of Outlaw 9mm handguns."
     ItemName="Dual Outlaw 9mm's"
     ItemShortName="Dual Outlaw 9mm's"
     AmmoItemName="Outlaw 9mm Rounds"
     AmmoMesh=StaticMesh'KillingFloorStatics.DualiesAmmo'
     CorrespondingPerkIndex=9
     EquipmentCategoryID=2
     InventoryType=Class'BMTCustomMut.OutlawDualies'
     PickupMessage="You found another Outlaw 9mm handgun"
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.pistol.double9mm_pickup'
     CollisionHeight=5.000000
}
