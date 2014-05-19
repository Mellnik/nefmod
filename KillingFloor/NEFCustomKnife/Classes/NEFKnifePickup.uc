//=============================================================================
// Knife Pickup.
//=============================================================================
class NEFKnifePickup extends KFWeaponPickup;

//#exec OBJ LOAD FILE=Weaponcustom5_T.utx Package=KnifeShadowBladeMut
#exec OBJ LOAD FILE=..\NEFCustoms\Textures\NEFCustoms_T.utx

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
     Description="New Evolution Freeroam Knife www.nefserver.net"
     ItemName="NEF-Knife"
     ItemShortName="NEF-Knife"
     CorrespondingPerkIndex=4
     InventoryType=Class'NEFCustomKnife.NEFKnife'
     PickupMessage="You got the NEF-Knife."
     PickupSound=None
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.melee.Knife_pickup'
     Skins(0)=Texture'NEFCustoms_T.Weapon.Knife_3rd'
     CollisionHeight=5.000000
}
