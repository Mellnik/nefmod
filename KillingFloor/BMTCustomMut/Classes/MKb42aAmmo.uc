//=============================================================================
// MKb42 Ammo.
//=============================================================================
class MKb42aAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=30
     MaxAmmo=300
     InitialAmount=120
     PickupClass=Class'BMTCustomMut.MKb42aAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="MKb42 bullets"
}
