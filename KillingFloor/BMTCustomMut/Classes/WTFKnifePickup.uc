//=============================================================================
// Knife Pickup.
//=============================================================================
class WTFKnifePickup extends KFWeaponPickup;

#exec OBJ LOAD FILE=WTFTex2.utx Package=BMTCustomMut

/*
function ShowKnifeInfo(Canvas C)
{
    C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Knife', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}
*/

defaultproperties
{
     Weight=0.000000
     cost=50
     PowerValue=5
     SpeedValue=60
     RangeValue=-20
     Description="-BMT- Combat Knife."
     ItemName="-BMT- Combat Knife"
     ItemShortName="-BMT- Combat Knife"
     CorrespondingPerkIndex=4
     InventoryType=Class'BMTCustomMut.WTFKnife'
     PickupMessage="You got the -BMT- Combat Knife."
     PickupSound=None
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.melee.Knife_pickup'
	 Skins(0)=Texture'WTFTex2.Knife_3rd'
     CollisionHeight=5.000000
}
