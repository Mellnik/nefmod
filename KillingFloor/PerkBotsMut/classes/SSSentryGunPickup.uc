//=============================================================================
// SentryGun Pickup.
//=============================================================================
class SSSentryGunPickup extends KFWeaponPickup;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	TweenAnim('Folded',0.01f);
}

defaultproperties
{
     Weight=1.000000
     cost=5000
     AmmoCost=5000
     BuyClipSize=1
     PowerValue=100
     SpeedValue=20
     RangeValue=50
     Description="A heavy armed machine gun sentry bot you can purchase to aid you in the combat."
     ItemName="SS sentry bot"
     ItemShortName="SS sentry bot"
     AmmoItemName="SS sentry bot"
     //showMesh=SkeletalMesh'sentrybot_turret.SentryMesh'
     CorrespondingPerkIndex=2
     EquipmentCategoryID=3
     InventoryType=Class'SSSentryGun'
     PickupMessage="You got a SS sentry bot."
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'sentrybot_turret.SentryMesh'
     CollisionRadius=22.000000
     CollisionHeight=23.000000
}
