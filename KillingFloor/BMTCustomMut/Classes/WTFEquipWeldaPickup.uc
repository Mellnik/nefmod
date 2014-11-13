class WTFEquipWeldaPickup extends KFWeaponPickup;

#exec obj load file="..\StaticMeshes\NewPatchSM.usx"

defaultproperties
{
     cost=500
     Description="A deadly weapon."
     ItemName="Welda profession"
     ItemShortName="Welda profession"
     InventoryType=Class'BMTCustomMut.WTFEquipWelda'
     PickupMessage="The Legend of Welda Begins..."
}
