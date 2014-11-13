//=============================================================================
// M44 Rifle Ammo.
//=============================================================================
class M44Ammo extends KFAmmunition;

#EXEC OBJ LOAD FILE=InterfaceContent.utx

defaultproperties
{
     AmmoPickupAmount=20
     MaxAmmo=200
     InitialAmount=80
     PickupClass=Class'BMTCustomMut.M44AmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=338,Y1=40,X2=393,Y2=79)
     ItemName="M44 Ammo"
}
