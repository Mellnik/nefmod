class ForcePickup extends KFWeaponPickup;

/*
function ShowShotgunInfo(Canvas C)
{
  C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Shotgun', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}
*/

defaultproperties
{
     Weight=0.000000
     cost=500
     AmmoCost=1
     PowerValue=70
     SpeedValue=40
     RangeValue=15
     Description="The Force"
     ItemName="The Force"
     ItemShortName="Force"
     AmmoItemName="12-gauge shells"
     CorrespondingPerkIndex=11
     EquipmentCategoryID=2
     InventoryType=Class'BMTCustomMut.Force'
     PickupMessage="Use the force Luke"
     PickupSound=Sound'KF_PumpSGSnd.SG_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.Shotgun.shotgun_pickup'
     CollisionRadius=35.000000
     CollisionHeight=5.000000
}
