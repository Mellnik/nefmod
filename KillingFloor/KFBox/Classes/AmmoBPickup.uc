//=============================================================================
// AmmoBPickup.
//=============================================================================
class AmmoBPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=2.000000
     cost=5000
     AmmoCost=5000
     BuyClipSize=1
     Description="An ammo crate that work as a store where you can buy ammunition from during wave."
     ItemName="Ammunition crate"
     ItemShortName="Ammo box"
     AmmoItemName="Ammo box"
     CorrespondingPerkIndex=1
     EquipmentCategoryID=3
     InventoryType=Class'KFBox.AmmoBGun'
     PickupMessage="You got an Ammunition Crate."
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KFBox.Pickup.AmmoBoxSM'
     DrawScale=1.500000
     CollisionRadius=22.000000
     CollisionHeight=23.000000
}
