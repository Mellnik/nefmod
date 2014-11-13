class StingerPickup extends KFWeaponPickup;

#exec OBJ LOAD FILE=Stinger_A.ukx
#exec OBJ LOAD FILE=Stinger_Snd.uax
#exec OBJ LOAD FILE=Stinger_SM.usx
#exec OBJ LOAD FILE=Stinger_T.utx

defaultproperties
{
     Weight=12.000000
     cost=5000
     AmmoCost=75
     BuyClipSize=175
     PowerValue=90
     SpeedValue=100
     RangeValue=65
     Description="Shut up and kill'em."
     ItemName="Stinger Minigun"
     ItemShortName="Stinger Minigun"
     AmmoItemName="7.62x51mm Ammo"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=51
     EquipmentCategoryID=3
     InventoryType=Class'BMTCustomMut.Stinger'
     PickupMessage="Its Time to Kill!"
     PickupSound=Sound'Stinger_Snd.Stinger.StingerTakeOut'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'Stinger_SM.UT3StingerPickup'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
