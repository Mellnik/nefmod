//-----------------------------------------------------------
// Braindead - Mini Cooper - Purple Mini skin by Arramus
//-----------------------------------------------------------
class MiniPurp extends MiniR;

#exec OBJ LOAD FILE=..\KF_Vehicles_BD\Animations\BDVehicles.ukx
#exec OBJ LOAD FILE=..\KF_Vehicles_BD\Textures\BDVehicle_T.utx
#exec OBJ LOAD FILE=..\KF_Vehicles_BD\Sounds\BDVehicles_A.uax
#exec obj LOAD FILE=..\KF_Vehicles_BD\StaticMeshes\BDVehicles_S.usx

defaultproperties
{
     Skins(0)=Combiner'BDVehicle_T.Vehicle.miniPFinal'
     Skins(2)=Texture'BDVehicle_T.Vehicle.miniinteriorPkUV'
     Skins(3)=Texture'BDVehicle_NP.Arr73'
}
