//=============================================================================
// Single Pickup.
//=============================================================================
class OutlawSinglePickup extends KFWeaponPickup;

function inventory SpawnCopy( pawn Other )
{
	local Inventory I;

	For( I=Other.Inventory; I!=None; I=I.Inventory )
	{
		if( Single(I)!=None )
		{
			if( Inventory!=None )
				Inventory.Destroy();
			InventoryType = Class'Dualies';
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
     Weight=0.000000
     cost=0
     AmmoCost=10
     BuyClipSize=30
     PowerValue=20
     SpeedValue=50
     RangeValue=35
     Description="A Outlaw 9mm handgun."
     ItemName="Outlaw 9mm Pistol"
     ItemShortName="Outlaw 9mm Pistol"
     AmmoItemName="Outlaw 9mm Rounds"
     AmmoMesh=StaticMesh'KillingFloorStatics.DualiesAmmo'
     CorrespondingPerkIndex=9
     EquipmentCategoryID=2
     InventoryType=Class'BMTCustomMut.OutlawSingle'
     PickupMessage="You got the Outlaw 9mm handgun"
     PickupSound=Sound'KF_9MMSnd.9mm_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.pistol.9mm_Pickup'
     CollisionHeight=5.000000
}
