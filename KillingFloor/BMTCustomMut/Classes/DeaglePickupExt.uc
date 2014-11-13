class DeaglePickupExt extends DeaglePickup;

function inventory SpawnCopy(pawn Other)
{
	local Inventory I;

	for ( I = Other.Inventory; I != none; I = I.Inventory )
	{
		if ( DeagleExt(I) != none )
		{
			if( Inventory != none )
				Inventory.Destroy();
			InventoryType = Class'DualDeagleExt';
            AmmoAmount[0] += DeagleExt(I).AmmoAmount(0);
            MagAmmoRemaining += DeagleExt(I).MagAmmoRemaining;
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
     Weight=4.000000
     InventoryType=Class'BMTCustomMut.DeagleExt'
}
