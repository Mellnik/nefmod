// Written by Marco
Class AmmoBox extends SVehicle
	Placeable
	Config(KFBox)
	CacheExempt;

#exec obj load file="Box.ukx" package="KFBox"
#exec OBJ LOAD FILE=KF_LAWSnd.uax

var Controller OwnerController;
var() globalconfig int CrateHealth;
var() globalconfig float AmmoCostScale,MoneyRefundScale,RepairValuePerHP;
var AmmoBGun WeaponOwner;
var Font HUDFontz[2];
var AmmoBoxUser UseCatcher;
var int NumUsersNow;
var bool bInitialLanded,bBoxIsOpen,bClientBoxOpen;

replication
{
	// Variables the server should send to the client.
	reliable if( Role==ROLE_Authority )
		CrateHealth,bBoxIsOpen;
	reliable if( bNetInitial && Role==ROLE_Authority )
		bInitialLanded;
}

simulated function GetAmmoCount(out float MaxAmmoPrimary, out float CurAmmoPrimary)
{
	// To make trader menu show ammo value right.
	MaxAmmoPrimary = 5;
	CurAmmoPrimary = 5;
}

final function SetOwningPlayer( Pawn Other, AmmoBGun Wep )
{
	OwnerController = Other.Controller;
	PlayerReplicationInfo = Other.PlayerReplicationInfo;
	WeaponOwner = Wep;
	AmmoBoxAI(Controller).OwnerPlayer = OwnerController;
	AmmoBoxAI(Controller).bOwnerRequired = true;
	bScriptPostRender = true;
}
simulated function PostRender2D(Canvas C, float ScreenLocX, float ScreenLocY)
{
	local string S;
	local float XL,YL;
	local vector D;

	if( Health<=0 || PlayerReplicationInfo==None )
		return; // Dead or unknown owner.
	D = C.Viewport.Actor.CalcViewLocation-Location;
	if( (vector(C.Viewport.Actor.CalcViewRotation) Dot D)>0 )
		return; // Behind the camera
	XL = VSizeSquared(D);
	if( XL>1440000.f || !FastTrace(C.Viewport.Actor.CalcViewLocation,Location) )
		return; // Beyond 1200 distance or not in line of sight.

	if( C.Viewport.Actor.PlayerReplicationInfo==PlayerReplicationInfo )
		C.SetDrawColor(0,200,0,255);
	else C.SetDrawColor(200,0,0,255);

	// Load up fonts if not yet loaded.
	if( Default.HUDFontz[0]==None )
	{
		Default.HUDFontz[0] = Font(DynamicLoadObject("ROFonts_Rus.ROArial7",Class'Font'));
		if( Default.HUDFontz[0]==None )
			Default.HUDFontz[0] = Font'Engine.DefaultFont';
		Default.HUDFontz[1] = Font(DynamicLoadObject("ROFonts_Rus.ROBtsrmVr12",Class'Font'));
		if( Default.HUDFontz[1]==None )
			Default.HUDFontz[1] = Font'Engine.DefaultFont';
	}
	if( C.ClipY<1024 )
		C.Font = Default.HUDFontz[0];
	else C.Font = Default.HUDFontz[1];

	C.Style = ERenderStyle.STY_Alpha;
	S = "Owner:"@PlayerReplicationInfo.PlayerName;
	C.TextSize(S,XL,YL);
	C.SetPos(ScreenLocX-XL*0.5,ScreenLocY-YL*2.f);
	C.DrawTextClipped(S,false);
	S = "Health:"@Max(1,float(Health)/float(CrateHealth)*100.f)@"%";
	C.TextSize(S,XL,YL);
	C.SetPos(ScreenLocX-XL*0.5,ScreenLocY-YL*0.75f);
	C.DrawTextClipped(S,false);
}
event bool EncroachingOn( actor Other )
{
	if ( Other.bWorldGeometry || Other.bBlocksTeleport )
		return true;
	if ( Pawn(Other) != None )
		return true;
	return false;
}
function UsedBy( Pawn user );
function bool TryToDrive(Pawn P)
{
	Return False;
}
simulated function PostNetReceive()
{
	bScriptPostRender = (PlayerReplicationInfo!=None);
	if( bBoxIsOpen!=bClientBoxOpen )
	{
		bClientBoxOpen = bBoxIsOpen;
		if( bBoxIsOpen )
			PlayAnim('Open');
		else PlayAnim('Close');
	}
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector HitLocation, Vector momentum, class<DamageType> damageType, optional int HitIndex )
{
	if( Level.NetMode==NM_Client || Monster(instigatedBy)==None )
		Return;

	if( (Health-=Damage)<=0 )
		Died(instigatedBy.Controller,damageType,HitLocation);
}

simulated function Destroyed()
{
	if( Controller!=None )
		Controller.Destroy();
	if( Driver!=None )
		Driver.Destroy();
	if( UseCatcher!=None )
		UseCatcher.Destroy();
	Super.Destroyed();
}
event PostBeginPlay()
{
	Super.PostBeginPlay();
	if ( (ControllerClass != None) && (Controller == None) )
		Controller = spawn(ControllerClass);
	if ( Controller != None )
		Controller.Possess(self);
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	if ( bDeleteMe || Level.bLevelChange || Level.Game == None )
		return; // already destroyed, or level is being cleaned up

	if( WeaponOwner!=None )
	{
		if( PlayerController(OwnerController)!=None )
			PlayerController(OwnerController).ReceiveLocalizedMessage(Class'AmmoMessage',2);
		WeaponOwner.CurrentBox = None;
		WeaponOwner.Destroy();
		WeaponOwner = None;
	}
	if ( Controller != None )
	{
		Controller.bIsPlayer = False;
		Level.Game.Killed(Killer, Controller, self, damageType);
		Controller.Destroy();
	}

	TriggerEvent(Event, self, None);

	// remove powerup effects, etc.
	RemovePowerups();
	Spawn(Class'PanzerfaustHitConcrete_simple');
	PlaySound(Sound'Rocket_Explode',SLOT_Pain,2.5f,,800.f);

	Destroy();
}
simulated function int GetTeamNum()
{
	Return 0;
}
simulated event SetInitialState()
{
	Super(Actor).SetInitialState();
}
simulated event DrivingStatusChanged();
event TakeWaterDamage(float DeltaTime);

simulated function PreBeginPlay()
{
	TweenAnim('Open',0.001f);
	if( Level.NetMode!=NM_DedicatedServer )
	{
		if( Rand(2)==1 )
			Skins[1] = Texture'ammocrate_grenade';
	}
	Health = CrateHealth;
	Super.PreBeginPlay();
}

simulated final function bool MoveDown( float Distance )
{
	local vector Ex,HL,HN,End;

	Ex.X = CollisionRadius;
	Ex.Y = CollisionRadius;
	Ex.Z = CollisionHeight;
	End = Location;
	End.Z+=Distance;

	if( Trace(HL,HN,End,Location,false,Ex)!=None )
	{
		MoveSmooth(HL-Location);
		return false;
	}
	else return MoveSmooth(End-Location);
}
simulated final function SetFloorOrientation()
{
	local vector X,Y,Z;
	local rotator R;
	local vector Ex,HL,HN;

	Ex.X = CollisionRadius;
	Ex.Y = CollisionRadius;
	Ex.Z = CollisionHeight;
	if( Trace(HL,HN,Location-vect(0,0,10),Location,true,Ex)==None )
		HN = vect(0,0,1);

	R.Yaw = Rotation.Yaw;
	if( HN.Z>0.997f || HN.Z<=0.2f )
	{
		SetRotation(R);
		return;
	}

	// Fast dummy method for making it adjust to ground direction.
	GetAxes(R,X,Y,Z);
	X = Normal(X-HN*(X Dot HN));
	Y = Normal(Y-HN*(Y Dot HN));
	Z = (X Cross Y);
	SetRotation(OrthoRotation(X,Y,Z));
}
simulated function Tick( float Delta )
{
	if( !bInitialLanded )
	{
		if( !MoveDown(-700.f*Delta) )
		{
			SetFloorOrientation();
			bInitialLanded = true;
			
			if( Level.NetMode!=NM_Client && UseCatcher==None )
				UseCatcher = Spawn(Class'AmmoBoxUser',Self);
		}
	}
	Super.Tick(Delta);
}

function UserStatus( bool bAdded )
{
	if( bAdded )
	{
		if( ++NumUsersNow==1 )
		{
			bBoxIsOpen = true;
			if( Level.NetMode!=NM_DedicatedServer )
				PlayAnim('Open');
		}
	}
	else if( --NumUsersNow==0 )
	{
		bBoxIsOpen = false;
		if( Level.NetMode!=NM_DedicatedServer )
			PlayAnim('Close');
	}
}

defaultproperties
{
     CrateHealth=400
     AmmoCostScale=3.000000
     MoneyRefundScale=0.100000
     RepairValuePerHP=3.000000
     VehicleMass=0.350000
     Team=0
     VehicleNameString="AmmoBox"
     bCanBeBaseForPawns=False
     Health=400
     MenuName="Ammo Box"
     ControllerClass=Class'KFBox.AmmoBoxAI'
     bStasis=False
     Physics=PHYS_None
     NetUpdateFrequency=18.000000
     Mesh=SkeletalMesh'KFBox.AmmoCreateMesh'
     DrawScale=1.500000
     Skins(0)=Texture'KFBox.Skins.ammocrate_smg1'
     Skins(1)=Texture'KFBox.Skins.ammocrate_smg1'
     CollisionRadius=36.000000
     CollisionHeight=25.000000
     bCollideWorld=True
     bNetNotify=True
}
