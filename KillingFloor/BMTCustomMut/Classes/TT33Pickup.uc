//=============================================================================
// TT33 Pickup.
//=============================================================================
class TT33Pickup extends KFWeaponPickup;

defaultproperties
{
     Weight=3.000000
     cost=500
     AmmoCost=16
     BuyClipSize=12
     PowerValue=50
     SpeedValue=45
     RangeValue=60
     Description="A Soviet pistol produced in large numbers from 1930 onward."
     ItemName="TT33"
     ItemShortName="TT33"
     AmmoItemName="7.62mm Ammo"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=7
     EquipmentCategoryID=7
     InventoryType=Class'BMTCustomMut.tt33'
     PickupMessage="You got the TT33"
     PickupSound=Sound'KF_AK47Snd.AK47_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF1945Statics.Weapons.tt33'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
