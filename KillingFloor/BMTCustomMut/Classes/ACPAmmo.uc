//=============================================================================
// MK23 Ammo.
//=============================================================================
class ACPAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=InterfaceContent.utx

defaultproperties
{
     AmmoPickupAmount=24
     MaxAmmo=144
     InitialAmount=72
     PickupClass=Class'BMTCustomMut.ACPAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=338,Y1=40,X2=393,Y2=79)
     ItemName="MK23 bullets"
}
