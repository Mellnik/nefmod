class ZombieMrFreeze extends ZombieHusk_XMas;

simulated function PostNetBeginPlay()
	{
    super.PostNetBeginPlay();
    SetBoneScale(1,1.75,'rarm'); //let's put some big beefy arms on there...
    SetBoneScale(2,1.75,'larm');
	
	SetBoneScale(7,1.5,'rshoulder');
    SetBoneScale(8,1.5,'lshoulder');
}

defaultproperties
{
     ColRadius=35.000000
     ColHeight=50.000000
     OnlineHeadshotOffset=(X=22.000000,Y=5.000000,Z=100.000000)
     OnlineHeadshotScale=2.000000
     MeleeRange=42.500000
     MenuName="Mr Freeze"
     DrawScale=1.387500
     PrePivot=(Z=20.000000)
}
