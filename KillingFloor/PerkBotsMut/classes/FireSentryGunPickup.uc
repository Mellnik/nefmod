//=============================================================================
// SentryGun Pickup.
//=============================================================================
class FireSentryGunPickup extends KFWeaponPickup;

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
     ItemName="Fire sentry bot"
     ItemShortName="Fire sentry bot"
     AmmoItemName="Fire sentry bot"
     //showMesh=SkeletalMesh'sentrybot_turret.SentryMesh'
     CorrespondingPerkIndex=5
     EquipmentCategoryID=3
     InventoryType=Class'FireSentryGun'
     PickupMessage="You got a Fire sentry bot."
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'sentrybot_turret.SentryMesh'
     CollisionRadius=22.000000
     CollisionHeight=23.000000
}
