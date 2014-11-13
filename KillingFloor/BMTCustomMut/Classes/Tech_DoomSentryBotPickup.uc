class Tech_DoomSentryBotPickup extends KFWeaponPickup;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"



simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	TweenAnim('Folded',0.01f);
}

defaultproperties
{
     Weight=3.000000
     cost=4500
     AmmoCost=0
     BuyClipSize=1
     PowerValue=100
     SpeedValue=20
     RangeValue=50
     Description="A heavy armed machine gun sentry bot you can purchase to aid you in the combat."
     ItemName="Doom Sentry bot"
     ItemShortName="Doom Sentry bot"
     AmmoItemName="Doom Sentry bot"
     CorrespondingPerkIndex=50
     EquipmentCategoryID=3
     InventoryType=Class'BMTCustomMut.Tech_DoomSentryBot'
     PickupMessage="You got a Doom Sentry bot."
     PickupSound=Sound'KF_AA12Snd.AA12_Pickup'
     PickupForce="AssaultRiflePickup"
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'SentryTechAnim1.Weapon_DoomSentry'
     CollisionRadius=22.000000
     CollisionHeight=23.000000
}
