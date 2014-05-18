//-----------------------------------------------------------
// Braindead - TW Hippy Camper Van - Texture by Arramus
//-----------------------------------------------------------
class TWHippieCampVan extends TWCampVan;

#exec OBJ LOAD FILE=..\KF_Vehicles_BD\Animations\BDVehicles.ukx
#exec OBJ LOAD FILE=..\Textures\KillingFloorTextures.utx
#exec OBJ LOAD FILE=..\KF_Vehicles_BD\Sounds\BDVehicles_A.uax
#exec obj LOAD FILE=..\KF_Vehicles_BD\StaticMeshes\BDVehicles_S.usx

defaultproperties
{
     Skins(0)=Combiner'BDVehicle_T.Vehicle.TWHipFinal'
     Skins(1)=Combiner'BDVehicle_T.Vehicle.TWHipFinal'
}
