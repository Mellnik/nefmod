//-----------------------------------------------------------
//
//-----------------------------------------------------------
class HealingKatanaPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=1.000000
     cost=1000
     PowerValue=60
     SpeedValue=60
     RangeValue=-21
     Description="An incredibly sharp Katana."
     ItemName="Healing Katana"
     ItemShortName="Healing Katana"
     EquipmentCategoryID=1
     InventoryType=Class'BMTCustomMut.HealingKatana'
     PickupMessage="You got the Healing Katana."
     PickupSound=Sound'KF_AxeSnd.Axe_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.melee.Katana_pickup'
     CollisionRadius=27.000000
     CollisionHeight=5.000000
}
