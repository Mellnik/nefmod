Class MetalPattyMut extends Mutator config(MetalPatty);

var() globalconfig string BossClassName;

function PreBeginPlay()
{
	AddToPackageMap();
	KFGameType(Level.Game).KFGameLength=3;
	KFGameType(Level.Game).EndGameBossClass = BossClassName;
}

function Timer()
{
	Destroy();
}

defaultproperties
{
     BossClassName="MetalPatty.MetalPatty"
     bAddToServerPackages=True
     GroupName="KF_MetalPatty"
     FriendlyName="MetalPatty"
     Description="MetalPatty"
     bAlwaysRelevant=True
}
