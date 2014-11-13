//=============================================================================
// AK47 Pickup.
//=============================================================================
class P90Pickup extends KFWeaponPickup;

defaultproperties
{
     Weight=7.000000
     cost=3250
     AmmoCost=36
     BuyClipSize=50
     PowerValue=38
     SpeedValue=80
     RangeValue=35
     Description="Standard issue military submachine gun."
     ItemName="P90 Submachine Gun"
     ItemShortName="P90"
     AmmoItemName="5.57 NATO Ammo"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=3
     EquipmentCategoryID=3
     InventoryType=Class'BMTCustomMut.P90'
     PickupMessage="You got the P90"
     PickupSound=Sound'KF_AK47Snd.AK47_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'P90_SM.P90'
     DrawScale=0.400000
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
