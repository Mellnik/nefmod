//=============================================================================
// Winchester Pickup.
//=============================================================================
class M44Pickup extends KFWeaponPickup;

/*
function ShowDeagleInfo(Canvas C)
{
  C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Deagle', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}
*/

defaultproperties
{
     Weight=5.000000
     cost=3000
     BuyClipSize=20
     PowerValue=60
     SpeedValue=30
     RangeValue=95
     Description="M44 Assault rifle."
     ItemName="M44 Assault Rifle"
     ItemShortName="M44 Assault Rifle"
     AmmoItemName="M44 Ammo"
     CorrespondingPerkIndex=10
     EquipmentCategoryID=10
     InventoryType=Class'BMTCustomMut.M44'
     PickupMessage="You got the M44 Assault Rifle"
     PickupSound=Sound'KF_RifleSnd.RifleBase.Rifle_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF1945Statics.Weapons.M44'
     CollisionRadius=30.000000
     CollisionHeight=5.000000
}
