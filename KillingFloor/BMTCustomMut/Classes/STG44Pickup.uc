//=============================================================================
// AK47 Pickup.
//=============================================================================
class STG44Pickup extends KFWeaponPickup;

defaultproperties
{
     Weight=6.000000
     cost=700
     AmmoCost=10
     BuyClipSize=30
     PowerValue=40
     SpeedValue=80
     RangeValue=50
     Description="Standard issue military rifle. Equipped with an integrated 2X scope."
     ItemName="STG44"
     ItemShortName="STG44"
     AmmoItemName="7.62mm Ammo"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=7
     EquipmentCategoryID=7
     InventoryType=Class'BMTCustomMut.stg44'
     PickupMessage="You got the STG44"
     PickupSound=Sound'KF_AK47Snd.AK47_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF1945Statics.Weapons.stg44'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
