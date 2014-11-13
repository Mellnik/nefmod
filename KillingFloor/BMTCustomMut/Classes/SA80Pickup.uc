class SA80Pickup extends KFWeaponPickup;

#exec OBJ LOAD FILE=WTFStaticMeshes.usx

simulated function RenderPickupImage(Canvas C)
{
  C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Bullpup', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}

defaultproperties
{
     Weight=7.000000
	 cost=1000
     BuyClipSize=10
     PowerValue=100
     SpeedValue=60
     RangeValue=100
     Description="A deadly weapon."
     ItemName="SA80 Sniper Rifle"
     ItemShortName="SA80 Sniper Rifle"
     AmmoItemName="SA80 Ammo"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=2
     EquipmentCategoryID=3
     InventoryType=Class'BMTCustomMut.SA80'
     PickupMessage="You got the SA80 Sniper Rifle"
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'WTFStaticMeshes.SA80.SA80Pickup'
     DrawScale=0.400000
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
