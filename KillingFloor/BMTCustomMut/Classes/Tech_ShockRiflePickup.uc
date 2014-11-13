class Tech_ShockRiflePickup extends KFWeaponPickup;


#exec obj load file="SentryTechTex1.utx"


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
     cost=1500
     AmmoCost=45
     BuyClipSize=10
     PowerValue=50
     SpeedValue=35
     RangeValue=90
     Description="A rugged and reliable single-shot rifle."
     ItemName="Shock Rifle"
     ItemShortName="Shock Rifle"
     AmmoItemName="Shock Rifle"
     CorrespondingPerkIndex=50
     EquipmentCategoryID=2
     InventoryType=Class'BMTCustomMut.Tech_ShockRifle'
     PickupMessage="You got the Shock Rifle"
     PickupSound=Sound'KF_RifleSnd.RifleBase.Rifle_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.Rifle.LeverAction_pickup'
     Skins(0)=Texture'SentryTechTex1.Weapon_ShockRifle.ShockRifle_3rd'
     CollisionRadius=30.000000
     CollisionHeight=5.000000
}
