class LilithKissPickup extends KFWeaponPickup;

function ShowDualiesInfo(Canvas C)
{
	C.SetPos((C.SizeX - C.SizeY) / 2,0);
	C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Dualies', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}

defaultproperties
{
     Weight=12.000000
     cost=4500
     BuyClipSize=20
     PowerValue=75
     SpeedValue=80
     RangeValue=45
     Description="Specially modified automatic shotguns, given as a gift for Valentine's Day."
     ItemName="Lilith's Kisses"
     ItemShortName="Lilith's Kisses"
     AmmoItemName="12-Gauge Shells"
     AmmoMesh=StaticMesh'KillingFloorStatics.DualiesAmmo'
     CorrespondingPerkIndex=1
     EquipmentCategoryID=1
     InventoryType=Class'BMTCustomMut.LilithKiss'
     PickupMessage="You found Lilith's Kisses."
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'LilithKiss_SM.lilith_pickup'
     CollisionHeight=5.000000
}
