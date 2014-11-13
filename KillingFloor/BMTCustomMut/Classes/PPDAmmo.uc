//=============================================================================
// AK47 Ammo.
//=============================================================================
class PPDAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=71
     MaxAmmo=300
     InitialAmount=142
     PickupClass=Class'BMTCustomMut.PPDAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="PPD bullets"
}
