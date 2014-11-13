class Tech_MachinePistolPickup extends KFWeaponPickup;

#exec obj load file="SentryTechTex1.utx"



function inventory SpawnCopy( pawn Other )
{
	local Inventory I;

	For( I=Other.Inventory; I!=None; I=I.Inventory )
	{
		if( MachinePistol(I)!=None )
		{
			if( Inventory!=None )
				Inventory.Destroy();
			InventoryType = Class'Tech_MachineDualies';
			I.Destroyed();
			I.Destroy();
			return Super.SpawnCopy(Other);
		}
	}
	InventoryType = Default.InventoryType;
	Return Super.SpawnCopy(Other);
}

defaultproperties
{
     Weight=1.000000
     cost=150
     AmmoCost=10
     BuyClipSize=30
     PowerValue=20
     SpeedValue=50
     RangeValue=35
     Description="A Machine Pistol."
     ItemName="Machine Pistol"
     ItemShortName="Machine Pistol"
     AmmoItemName="9mm Rounds"
     AmmoMesh=StaticMesh'KillingFloorStatics.DualiesAmmo'
     CorrespondingPerkIndex=50
     EquipmentCategoryID=1
     InventoryType=Class'BMTCustomMut.Tech_MachinePistol'
     PickupMessage="You got the Machine Pistol"
     PickupSound=Sound'KF_9MMSnd.9mm_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.pistol.9mm_Pickup'
     Skins(0)=Texture'SentryTechTex1.Weapon_MachinePistol.MachinePistol_3rd'
     CollisionHeight=5.000000
}
