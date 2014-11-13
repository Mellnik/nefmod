class MK23PickupExt extends MK23Pickup;

function inventory SpawnCopy( pawn Other )
{
	local Inventory I;

	For( I=Other.Inventory; I!=None; I=I.Inventory )
	{
		if( MK23Ext(I)!=None )
		{
			if( Inventory!=None )
				Inventory.Destroy();
			InventoryType = class'DualMK23Ext';
			AmmoAmount[0] += MK23Ext(I).AmmoAmount(0);
			MagAmmoRemaining += MK23Ext(I).MagAmmoRemaining;
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
     InventoryType=Class'BMTCustomMut.MK23Ext'
}
