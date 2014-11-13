class Tech_AdvancedWelderPickup extends KFWeaponPickup;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"

#exec obj load file="..\StaticMeshes\NewPatchSM.usx"

defaultproperties
{
     Weight=0.000000
     cost=1000
     ItemName="Advanced Welder"
     CorrespondingPerkIndex=50
     InventoryType=Class'BMTCustomMut.Tech_AdvancedWelder'
     PickupMessage="You got the Advanced Welder."
     PickupSound=Sound'Inf_Weapons_Foley.Misc.AmmoPickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KF_pickups_Trip.equipment.welder_pickup'
     Skins(0)=Texture'SentryTechTex1.Weapon_AdvancedWelder.AdvancedWelder_3rd'
     CollisionHeight=5.000000
}
