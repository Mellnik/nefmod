//=============================================================================
// AK47 Pickup.
//=============================================================================
class M41APickup extends KFWeaponPickup;

defaultproperties
{
     Weight=6.000000
     cost=1600
     AmmoCost=100
     BuyClipSize=99
     PowerValue=45
     SpeedValue=85
     RangeValue=70
     Description="The M41A Pulse Rifle from the movie Aliens."
     ItemName="M41A"
     ItemShortName="M41A"
     AmmoItemName="M41A 10 mm caseless ammunition"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=7
     EquipmentCategoryID=4
     InventoryType=Class'BMTCustomMut.M41AAssaultRifle'
     PickupMessage="You got the M41A"
     PickupSound=Sound'M41ASnd.Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'M41A_SM.M41APickup'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
