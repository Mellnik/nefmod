class UMP45Ammo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=25
     MaxAmmo=250
     InitialAmount=75
     PickupClass=Class'BMTCustomMut.UMP45AmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="UMP45 .45 ACP Ammo"
}
