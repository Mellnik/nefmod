class ForceAmmo extends Ammunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

//TODO: ForceAmmoPickup?

defaultproperties
{
     MaxAmmo=500
     InitialAmount=500
     PickupClass=Class'KFMod.CrossbowAmmoPickup'
     IconCoords=(X1=4,Y1=350,X2=110,Y2=395)
     ItemName="Force Fuel.."
}
