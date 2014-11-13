class ALLPerkGunAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=100
     MaxAmmo=1000
     InitialAmount=200
     PickupClass=Class'BMTCustomMut.ALLPerkGunAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="ALLPerkGun bullets"
}
