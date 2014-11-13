//=============================================================================
// TT33 Ammo.
//=============================================================================
class TT33Ammo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=24
     MaxAmmo=144
     InitialAmount=72
     PickupClass=Class'BMTCustomMut.TT33AmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="TT33 bullets"
}
