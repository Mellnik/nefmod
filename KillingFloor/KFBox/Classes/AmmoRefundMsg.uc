Class AmmoRefundMsg extends Projectile;

var int TotalDosh;

replication
{
	reliable if(Role == ROLE_Authority)
		TotalDosh;
}

function PostBeginPlay()
{
	if( Level.NetMode!=NM_Client && Level.GetLocalPlayerController()!=Owner )
		bScriptPostRender = false;
}
function Touch(Actor Other);

simulated function PostRender2D(Canvas C, float ScreenLocX, float ScreenLocY)
{
	local string S;
	local float XL,YL;
	local vector D;

	D = C.Viewport.Actor.CalcViewLocation-Location;
	if( (vector(C.Viewport.Actor.CalcViewRotation) Dot D)>0 )
		return; // Behind the camera
	XL = VSizeSquared(D);
	if( XL>1440000.f || !FastTrace(C.Viewport.Actor.CalcViewLocation,Location) )
		return; // Beyond 1200 distance or not in line of sight.

	C.DrawColor = Class'Hud'.Default.GoldColor;
	C.Font = C.MedFont;
	S = "+£"$TotalDosh;
	C.TextSize(S,XL,YL);
	C.SetPos(ScreenLocX-(XL*0.5),ScreenLocY-(YL*0.5));
	C.DrawTextClipped(S,false);
	C.DrawColor = Class'Hud'.Default.WhiteColor;
}

defaultproperties
{
     bScriptPostRender=True
     DrawType=DT_None
     bOnlyRelevantToOwner=True
     bReplicateInstigator=False
     bNetInitialRotation=False
     LifeSpan=4.000000
     Velocity=(Z=20.000000)
     bCollideActors=False
     bCollideWorld=False
}
