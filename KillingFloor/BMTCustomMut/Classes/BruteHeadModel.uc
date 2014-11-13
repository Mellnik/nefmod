Class BruteHeadModel extends Actor;

var xPawn OwnerPawn;
var bool bDying;
var StaticMesh Models[10];
var vector RelativePos[10];
var rotator RelativeRot[10];

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    if(xPawn(Owner) != none)
        OwnerPawn = xPawn(Owner);
    SetTimer(1,True);
}

simulated function Timer()
{
    if(OwnerPawn == none)
        Destroy();

    if(OwnerPawn != none && OwnerPawn.IsInState('Dying') && !bDying)
    {
        bTearOff = true;
        bDying = true;
        LifeSpan = 10;
        bUnlit = true;
        DetachFromBone(Owner);
    }
}

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'NetskyHats.Brutehead'
     bDramaticLighting=True
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     DrawScale=0.250000
     bHardAttach=True
     bNoRepMesh=True
}
