//================================================================================
// MedSentryGunPickup.
//================================================================================

class MedSentryGunPickup extends KFWeaponPickup;

simulated function PostBeginPlay ()
{
  Super.PostBeginPlay();
  TweenAnim('Folded',0.01);
}

defaultproperties
{
     Weight=1.000000
     cost=20000
     AmmoCost=0
     BuyClipSize=1
     SpeedValue=20
     RangeValue=50
     Description="A sentry bot that heals everyone as much as possible."
     ItemName="Medic Healing Bot"
     ItemShortName="Medic Healing Bot"
     AmmoItemName="Med Sentry Ammo"
     CorrespondingPerkIndex=50
     EquipmentCategoryID=5
     InventoryType=Class'BMTCustomMut.MedSentryGun'
     PickupMessage="You have picked up Medic Healing Bot!"
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     DrawType=DT_Mesh
     CollisionRadius=22.000000
     CollisionHeight=23.000000
}
