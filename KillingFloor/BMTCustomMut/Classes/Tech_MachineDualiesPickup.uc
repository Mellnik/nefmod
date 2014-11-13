class Tech_MachineDualiesPickup extends KFWeaponPickup;


#exec obj load file="SentryTechTex1.utx"


function ShowDualiesInfo(Canvas C)
{
	C.SetPos((C.SizeX - C.SizeY) / 2,0);
	C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Dualies', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}

defaultproperties
{
     Weight=3.000000
     cost=300
     AmmoCost=10
     BuyClipSize=30
     PowerValue=20
     SpeedValue=50
     RangeValue=35
     Description="A deadly weapon."
     ItemName="Machine Dualies"
     ItemShortName="Machine Dualies"
     AmmoItemName="9mm Rounds"
     AmmoMesh=StaticMesh'KillingFloorStatics.DualiesAmmo'
     CorrespondingPerkIndex=50
     EquipmentCategoryID=1
     InventoryType=Class'BMTCustomMut.Tech_MachineDualies'
     PickupMessage="You got 2x Machine Pistols."
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.pistol.double9mm_pickup'
     Skins(0)=Texture'SentryTechTex1.Weapon_MachinePistol.MachinePistol_3rd'
     CollisionHeight=5.000000
}
