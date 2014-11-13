//=============================================================================
// AK47 Pickup.
//=============================================================================
class PPDPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=6.000000
     cost=650
     AmmoCost=35
     BuyClipSize=71
     PowerValue=35
     SpeedValue=100
     RangeValue=40
     Description="Standard issue military rifle. Equipped with an integrated 2X scope."
     ItemName="PPD-40"
     ItemShortName="PPD-40"
     AmmoItemName="7.62mm Ammo"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=10
     EquipmentCategoryID=10
     InventoryType=Class'BMTCustomMut.PPD'
     PickupMessage="You got the PPD-40"
     PickupSound=Sound'KF_AK47Snd.AK47_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF1945Statics.Weapons.ppd40'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
