//==================================================
// Colt Python Pickup.
//==================================================
class WColtPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=4.000000
     cost=500
     AmmoCost=30
     BuyClipSize=6
     PowerValue=100
     SpeedValue=20
     RangeValue=35
     Description="High Powerer Revolver"
     ItemName="Colt Python"
     ItemShortName="Colt"
     AmmoItemName=".345"
     CorrespondingPerkIndex=9
     EquipmentCategoryID=1
     InventoryType=Class'BMTCustomMut.WColt'
     PickupMessage="You got the Colt Python handgun"
     PickupSound=Sound'KF_9MMSnd.9mm_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'W_Colt_Python_M.WColt_Pickup'
     CollisionHeight=5.000000
}
