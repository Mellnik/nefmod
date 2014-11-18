//=============================================================================
// PTurretPickup.
//=============================================================================
class RPTurretPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=1.000000
     cost=5000
     AmmoCost=5000
     BuyClipSize=1
     PowerValue=100
     SpeedValue=10
     RangeValue=25
     Description="A turret made by the Aperture Science."
     ItemName="Rocket Turret"
     ItemShortName="Rocket Turret"
     AmmoItemName="Rocket Turret"
     CorrespondingPerkIndex=3
     EquipmentCategoryID=3
     InventoryType=Class'RPTurret'
     PickupMessage="You got a Rocket Turret."
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'RocketPortalTurret.RTSMesh'
     Skins(0)=Combiner'RocketPortalTurret.RT_cmb'
     CollisionRadius=22.000000
     CollisionHeight=23.000000
}
