class WTFEquipGlowstickPickup extends M79Pickup;

#exec OBJ LOAD FILE=Asylum_SM.usx
#exec OBJ LOAD FILE=Asylum_T.utx

defaultproperties
{
     Weight=0.000000
     cost=100
     PowerValue=0
     Description="A deadly weapon."
     ItemName="WTF Glowstick"
     ItemShortName="WTF Glowstick"
     InventoryType=Class'BMTCustomMut.WTFEquipGlowstick'
     PickupMessage="You got the WTF Glowstick."
     StaticMesh=StaticMesh'Asylum_SM.Lighting.glow_sticks_green_pile'
     DrawScale=2.000000
}
