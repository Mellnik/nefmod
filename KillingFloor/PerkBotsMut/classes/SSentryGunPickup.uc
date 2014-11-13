//=============================================================================
// SentryGun Pickup.
//=============================================================================
class SSentryGunPickup extends KFWeaponPickup;

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
     ItemName="Support sentry bot"
     ItemShortName="Support sentry bot"
     AmmoItemName="Support sentry bot"
     //showMesh=SkeletalMesh'sentrybot_turret.SentryMesh'
     CorrespondingPerkIndex=1
     EquipmentCategoryID=3
     InventoryType=Class'SSentryGun'
     PickupMessage="You got a Support sentry bot."
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'sentrybot_turret.SentryMesh'
     CollisionRadius=22.000000
     CollisionHeight=23.000000
}
