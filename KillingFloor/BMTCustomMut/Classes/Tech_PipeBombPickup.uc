class Tech_PipeBombPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=1.000000
     cost=3750
     AmmoCost=1875
     BuyClipSize=1
     PowerValue=100
     SpeedValue=10
     RangeValue=45
     Description="A highly explosive pipe bomb.. don't be anywhere near this when it goes off. Blows up when enemies get close."
     ItemName="SentryTech Extreme PipeBomb"
     ItemShortName="SentryTech Extreme PipeBomb"
     AmmoItemName="SentryTech Extreme PipeBomb"
     CorrespondingPerkIndex=50
     EquipmentCategoryID=3
     InventoryType=Class'BMTCustomMut.Tech_PipeBombExplosive'
     PickupMessage="You got the PipeBomb proximity explosive."
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups2_Trip.Supers.Pipebomb_Pickup'
     CollisionRadius=35.000000
     CollisionHeight=5.000000
}
