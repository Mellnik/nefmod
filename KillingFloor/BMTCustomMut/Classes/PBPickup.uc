//=============================================================================
// PB Pickup.
//=============================================================================
class PBPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=4.000000
     cost=750
     AmmoCost=15
     BuyClipSize=7
     PowerValue=65
     SpeedValue=35
     RangeValue=60
     Description="50 Cal AE handgun. A powerful personal choice for personal defense."
     ItemName="PB"
     ItemShortName="PB"
     AmmoItemName=".300 JHP Ammo"
     CorrespondingPerkIndex=2
     EquipmentCategoryID=1
     InventoryType=Class'BMTCustomMut.PB'
     PickupMessage="You got the PB"
     PickupSound=Sound'KF_HandcannonSnd.50AE_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'PB3rd.PB3rd'
     CollisionHeight=5.000000
}
