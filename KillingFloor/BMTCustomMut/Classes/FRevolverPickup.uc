//=============================================================================
// FlareRevolverPickup
//=============================================================================
// Killing Floor Source
// Copyright (C) 2012 Tripwire Interactive LLC
// - IJC Weapon Development
//=============================================================================
class FRevolverPickup extends KFWeaponPickup;

function inventory SpawnCopy( pawn Other )
{
	local Inventory I;

	for ( I = Other.Inventory; I != none; I = I.Inventory )
	{
		if ( FRevolver(I) != none )
		{
			if( Inventory != none )
				Inventory.Destroy();
			InventoryType = Class'DualFRevolver';
            AmmoAmount[0] += FRevolver(I).AmmoAmount(0);
            MagAmmoRemaining += FRevolver(I).MagAmmoRemaining;
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
     Weight=2.000000
     cost=500
     AmmoCost=13
     BuyClipSize=6
     PowerValue=60
     SpeedValue=40
     RangeValue=65
     Description="Flare Revolver. A classic wild west revolver modified to shoot fireballs!"
     ItemName="Flare Revolver"
     ItemShortName="Flare Revolver"
     AmmoItemName="Liquid Gas Cartridges"
     CorrespondingPerkIndex=5
     EquipmentCategoryID=1
     InventoryType=Class'BMTCustomMut.FRevolver'
     PickupMessage="You got the Flare Revolver"
     PickupSound=Sound'KF_RevolverSnd.foley.WEP_Revolver_Foley_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_IJC_Halloween_Weps.flaregun_pickup'
     CollisionHeight=5.000000
}
