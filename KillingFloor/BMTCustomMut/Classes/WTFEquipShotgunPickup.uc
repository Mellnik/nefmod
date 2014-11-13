class WTFEquipShotgunPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=8.000000
     cost=1000
     BuyClipSize=8
     PowerValue=85
     SpeedValue=40
     RangeValue=15
     Description="A rugged 12-gauge pump action shotgun. "
     ItemName="WTF Shotgun"
     ItemShortName="WTF Shotgun"
     AmmoItemName="12-gauge shells"
     CorrespondingPerkIndex=1
     EquipmentCategoryID=2
     InventoryType=Class'BMTCustomMut.WTFEquipShotgun'
     PickupMessage="You got the Shotgun."
     PickupSound=Sound'KF_PumpSGSnd.SG_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.Shotgun.shotgun_pickup'
     CollisionRadius=35.000000
     CollisionHeight=5.000000
}
