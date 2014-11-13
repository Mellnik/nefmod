class KFWeaponPickupFix extends KFWeaponPickup;

function Destroyed()
{
	if ( bDropped && class<Weapon>(Inventory.Class) != none )
	{
		if ( BMTGameType(Level.Game) != none )
		{
			BMTGameType(Level.Game).WeaponDestroyed(class<Weapon>(Inventory.Class));
		}
	}

	super.Destroyed();
}

defaultproperties
{
}
