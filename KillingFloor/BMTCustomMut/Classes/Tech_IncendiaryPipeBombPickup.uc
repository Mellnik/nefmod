class Tech_IncendiaryPipeBombPickup extends KFWeaponPickup;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechStatics.usx"

defaultproperties
{
     Weight=1.000000
     cost=1500
     AmmoCost=750
     BuyClipSize=1
     PowerValue=100
     SpeedValue=5
     RangeValue=15
     Description="An improvised proximity explosive. Blows up when enemies get close."
     ItemName="Incendiary Pipe Bomb"
     ItemShortName="Incendiary Pipe Bomb"
     AmmoItemName="Incendiary Pipe Bomb"
     CorrespondingPerkIndex=50
     EquipmentCategoryID=3
     InventoryType=Class'BMTCustomMut.Tech_IncendiaryPipeBomb'
     PickupMessage="You got the Incendiary Pipe Bomb."
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'SentryTechStatics.Weapon_IncendiaryPipeBomb.IncendiaryPipeBomb_Pickup'
     Skins(0)=Texture'SentryTechTex1.Weapon_IncendiaryPipeBomb.IncendiaryPipeBomb_3rd'
     CollisionRadius=35.000000
     CollisionHeight=5.000000
}
