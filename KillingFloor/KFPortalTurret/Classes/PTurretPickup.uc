//=============================================================================
// PTurretPickup.
//=============================================================================
class PTurretPickup extends KFWeaponPickup;

defaultproperties
{
	Weight=1.000000
	cost=3000
	AmmoCost=3000
	BuyClipSize=1
	PowerValue=100
	SpeedValue=10
	RangeValue=25
	Description="A turret made by the Aperture Science."
	ItemName="Sentry Turret"
	ItemShortName="Sentry Turret"
	AmmoItemName="Sentry Turret"
	InventoryType=Class'PTurret'
	PickupMessage="You got a Sentry bot."
	PickupForce="AssaultRiflePickup"
	StaticMesh=StaticMesh'PTurretMesh'
	CollisionRadius=22
	CollisionHeight=23
	PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
	EquipmentCategoryID=3
	CorrespondingPerkIndex=3
	Skins(0)=Texture'Turret_01_inactive'
}