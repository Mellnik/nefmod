//=============================================================================
// AK47 Ammo.
//=============================================================================
class P90Ammo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=50
     MaxAmmo=450
     InitialAmount=150
     PickupClass=Class'BMTCustomMut.P90AmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="P90 bullets"
}
