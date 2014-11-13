//=============================================================================
// Deagle Pickup.
//=============================================================================
class OutlawDeaglePickup extends KFWeaponPickup;

/*
function ShowDeagleInfo(Canvas C)
{
  C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Deagle', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}
*/

function inventory SpawnCopy( pawn Other )
{
	local Inventory I;

	For( I=Other.Inventory; I!=None; I=I.Inventory )
	{
		if( Deagle(I)!=None )
		{
			if( Inventory!=None )
				Inventory.Destroy();
			InventoryType = Class'OutlawDualDeagle';
			I.Destroyed();
			I.Destroy();
			Return Super.SpawnCopy(Other);
		}
	}
	InventoryType = Default.InventoryType;
	Return Super.SpawnCopy(Other);
}

defaultproperties
{
     Weight=3.000000
     cost=500
     AmmoCost=15
     BuyClipSize=9
     PowerValue=65
     SpeedValue=35
     RangeValue=60
     Description="50 Cal AE handgun. A powerful personal choice for personal defense."
     ItemName="Outlaw Deagle"
     ItemShortName="Outlaw Deagle"
     AmmoItemName=".300 JHP Ammo"
     CorrespondingPerkIndex=9
     EquipmentCategoryID=9
     InventoryType=Class'BMTCustomMut.OutlawDeagle'
     PickupMessage="You got the Outlaw Handcannon"
     PickupSound=Sound'KF_HandcannonSnd.50AE_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.pistol.deagle_pickup'
     CollisionHeight=5.000000
}
