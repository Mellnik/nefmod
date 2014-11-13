class Tech_MachinePistolAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=InterfaceContent.utx

defaultproperties
{
     AmmoPickupAmount=30
     MaxAmmo=240
     InitialAmount=100
     PickupClass=Class'BMTCustomMut.Tech_MachinePistolAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=413,Y1=82,X2=457,Y2=125)
     ItemName="Machine Pistol bullets"
}
