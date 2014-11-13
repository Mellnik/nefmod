class Tech_BioLauncherPickup extends KFWeaponPickup;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"

defaultproperties
{
     Weight=6.000000
     cost=1850
     AmmoCost=30
     BuyClipSize=6
     PowerValue=85
     SpeedValue=65
     RangeValue=75
     Description="Bio Launcher"
     ItemName="Bio Launcher"
     ItemShortName="Bio Launcher"
     AmmoItemName="Bio Launcher"
     AmmoMesh=StaticMesh'KillingFloorStatics.XbowAmmo'
     CorrespondingPerkIndex=50
     EquipmentCategoryID=2
     MaxDesireability=0.790000
     InventoryType=Class'BMTCustomMut.Tech_BioLauncher'
     PickupMessage="You Picked Up A Bio Launcher."
     PickupSound=Sound'KF_M79Snd.M79_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups2_Trip.Supers.M32_MGL_Pickup'
     Skins(0)=Texture'SentryTechTex1.Weapon_Biolauncher.BioLauncher_3rd'
     CollisionRadius=25.000000
     CollisionHeight=10.000000
}
