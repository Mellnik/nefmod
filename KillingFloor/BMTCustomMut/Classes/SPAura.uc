class SPAura extends Emitter;

#exec obj load file="Aura_SM.usx" package="BMTCustomMut"

var MeshEmitter SM;
var KFHumanPawn PawnOwner;

simulated function BeginPlay()
{
	PawnOwner = KFHumanPawn(Owner);
	SM = MeshEmitter(Emitters[0]);
	LastRenderTime = Level.TimeSeconds;
	bHidden=true;
	Tick(0);
}

simulated function Tick( float Delta )
{
	local rotator r;
	local vector x,l,y,z;
	
	if(KFPlayerController(PawnOwner.Controller)!=None && SRPlayerReplicationInfo(PawnOwner.PlayerReplicationInfo).buffed==1)
		bHidden=false;
	else
		bHidden=true;
	
	r=PawnOwner.Rotation;
	getaxes(r,x,y,z);
		
	l=PawnOwner.Location;
	l.z-=55;
	SetLocation(l);
	SetRotation(rot(0,0,1));	
}

defaultproperties
{
Begin Object Class=MeshEmitter Name=SpriteEmitter0
	StaticMesh=StaticMesh'aura'
    //FadeOut=True
    //FadeIn=True
    UniformSize=True
    ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
    //ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
    //FadeOutStartTime=0.235000
    //FadeInEndTime=0.235000
    CoordinateSystem=PTCS_Relative
    MaxParticles=1
    Name="my"
	DrawStyle=PTDS_Regular
    StartLocationRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000))
    StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
    Texture=Texture'22CharTex.GibletsSkin'
	InitialParticlesPerSecond=1.000000
    //StartVelocityRange=(Z=(Min=550.000000,Max=550.000000))
End Object
     Emitters(0)=MeshEmitter'SPAura.SpriteEmitter0'

     bNoDelete=False  
	DrawScale=1.0
	bOwnerNoSee=True
}
