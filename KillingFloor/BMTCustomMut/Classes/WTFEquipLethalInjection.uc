class WTFEquipLethalInjection extends KFMeleeGun;

#exec OBJ LOAD FILE=WTFTex.utx

defaultproperties
{
     weaponRange=90.000000
     HudImage=Texture'KillingFloorHUD.WeaponSelect.syring_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.Syringe'
     Weight=1.000000
     bConsumesPhysicalAmmo=False
     StandardDisplayFOV=85.000000
     MeshRef="KF_Weapons_Trip.Syringe_Trip"
     SkinRefs(0)="WTFTex.Lethalinjection.Lethalinjection"
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipLethalInjectionFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     AIRating=-2.000000
     AmmoCharge(0)=500
     AmmoClass(0)=Class'BMTCustomMut.WTFEquipLethalInjectionAmmo'
     Description="A deadly weapon"
     DisplayFOV=85.000000
     Priority=6
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.WTFEquipLethalInjectionPickup'
     BobDamping=8.000000
     AttachmentClass=Class'BMTCustomMut.WTFEquipLethalInjectionAttachment'
     IconCoords=(X1=169,Y1=39,X2=241,Y2=77)
     ItemName="Lethal Injection"
     AmbientGlow=2
}
