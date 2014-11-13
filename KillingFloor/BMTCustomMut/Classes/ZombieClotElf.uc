//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieClotElf extends ZombieCLot_XMas2;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax
//#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

simulated function PostNetBeginPlay()
{
    super.PostNetBeginPlay();
    SetHeadScale(1.5);
    SetBoneScale(3,0.75,'rarm'); //let's put some big beefy arms on there...
    SetBoneScale(2,0.75,'larm');
}

defaultproperties
{
     GrappleDuration=1.000000
     GroundSpeed=220.000000
     WaterSpeed=200.000000
     MenuName="Clot Elf"
     AmbientSound=Sound'KF_BaseClot.Clot_Idle1Loop'
}
