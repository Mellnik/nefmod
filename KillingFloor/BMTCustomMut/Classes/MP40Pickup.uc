//=============================================================================
// MP7M Pickup.
//=============================================================================
class MP40Pickup extends KFWeaponPickup;

defaultproperties
{
     Weight=5.000000
     cost=500
     AmmoCost=10
     BuyClipSize=20
     PowerValue=22
     SpeedValue=95
     RangeValue=45
     Description="German 9mm Sub Machine Gun"
     ItemName="MP40"
     ItemShortName="MP40"
     AmmoItemName="9mm Parabellum Ammo"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=10
     EquipmentCategoryID=10
     InventoryType=Class'BMTCustomMut.mp40'
     PickupMessage="You got the MP40"
     PickupSound=Sound'KF_MP7Snd.MP7_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF1945Statics.Weapons.mp40'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
