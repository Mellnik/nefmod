//=============================================================================
// AmmoBGun.
//=============================================================================
class AmmoBGun extends KFWeapon
	Config(KFBox);

var AmmoBox CurrentBox;
var bool bBeingDestroyed; // We've thrown the last bomb and this explosive is about to be destroyed
var bool bBoxDeployed;

replication
{
	// Variables the server should send to the client.
	reliable if( Role==ROLE_Authority && bNetOwner )
		bBoxDeployed;
}

simulated function Weapon WeaponChange( byte F, bool bSilent )
{
	if ( InventoryGroup==F && !bBoxDeployed )
		return self;
	else if ( Inventory == None )
		return None;
	else return Inventory.WeaponChange(F,bSilent);
}

function PlayIdle();

function bool CanAttack(Actor Other)
{
	return !bBoxDeployed; // Always ready to fire if not deployed yet.
}

simulated event RenderOverlays( Canvas Canvas )
{
	local rotator R;
	local vector HL,HN,End;

	if( bBoxDeployed )
		return;
	R.Yaw = Instigator.Rotation.Yaw;
	End = vector(R)*(Instigator.CollisionRadius+70.f)+Instigator.Location;
	if( Instigator.Trace(HL,HN,End,Instigator.Location,false,vect(36,36,26))!=None )
		End = HL;
	SetLocation( End );
	R.Yaw-=16384;
	SetRotation( R );
	bDrawingFirstPerson = true;
	Canvas.DrawActor(self, false, false);
	bDrawingFirstPerson = false;
}

simulated function ClientReload()
{
}
exec function ReloadMeNow()
{
}

simulated function AnimEnd(int channel);

simulated function Destroyed()
{
	if( Role < ROLE_Authority )
	{
		// Hack to switch to another weapon on the client when we throw the AmmoBox bot is destroyed.
		if( Instigator != none && Instigator.Controller != none && Instigator.Weapon==Self )
		{
			bBeingDestroyed = true;
			Instigator.SwitchToLastWeapon();
		}
	}
	if( Level.NetMode!=NM_Client && CurrentBox!=None )
	{
		CurrentBox.WeaponOwner = None;
		if( Instigator!=None && Instigator.Health>0 ) // Sold on trader.
			CurrentBox.KilledBy(None);
		CurrentBox = None;
	}
	super.Destroyed();
}

simulated function bool PutDown()
{
	if( bBeingDestroyed )
	{
		Instigator.ChangedWeapon();
		return true;
	}
	else return super.PutDown();
}

// need to figure out modified rating based on enemy/tactical situation
simulated function float RateSelf()
{
	if( bBeingDestroyed || bBoxDeployed )
		CurrentRating = -2;
	else CurrentRating = 50.f;
	return CurrentRating;
}

simulated event ClientStartFire(int Mode)
{
	if ( Pawn(Owner).Controller.IsInState('GameEnded') || Pawn(Owner).Controller.IsInState('RoundEnded') )
		return;
	ServerStartFire(Mode);
}

simulated event ClientStopFire(int Mode)
{
	ServerStopFire(Mode);
}

function bool BotFire(bool bFinished, optional name FiringMode)
{
	if ( bBoxDeployed )
		return false;
	ServerStartFire(0);
	return true;
}

event ServerStartFire(byte Mode)
{
	local rotator R;
	local vector Spot;

	if ( (Instigator != None) && (Instigator.Weapon != self) )
	{
		if ( Instigator.Weapon == None )
			Instigator.ServerChangedWeapon(None,self);
		else
			Instigator.Weapon.SynchronizeWeapon(self);
		return;
	}

	if( CurrentBox==None )
	{
		R.Yaw = Instigator.Rotation.Yaw;
		Spot = vector(R)*(Instigator.CollisionRadius+70.f)+Instigator.Location;
		if( FastTrace(Spot,Instigator.Location) )
		{
			CurrentBox = Spawn(Class'AmmoBox',,,Spot,R);
			if( CurrentBox!=None )
			{
				if( PlayerController(Instigator.Controller)!=None )
					PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'AmmoMessage',1);
				CurrentBox.SetOwningPlayer(Instigator,Self);
				bBoxDeployed = true;
				SellValue = 10; // No refunds after deployed.
				if( ThirdPersonActor!=None )
				{
					InventoryAttachment(ThirdPersonActor).bFastAttachmentReplication = false;
					ThirdPersonActor.bHidden = true;
				}
				return;
			}
		}
		if( PlayerController(Instigator.Controller)!=None )
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'AmmoMessage',0);
	}
}

function AttachToPawn(Pawn P)
{
	Super.AttachToPawn(P);
	if( bBoxDeployed && ThirdPersonActor!=None )
	{
		InventoryAttachment(ThirdPersonActor).bFastAttachmentReplication = false;
		ThirdPersonActor.bHidden = true;
	}
}

function ServerStopFire(byte Mode)
{
}

static function PreloadAssets(Inventory Inv, optional bool bSkipRefCount);
static function bool UnloadAssets();

defaultproperties
{
     MagCapacity=1
     HudImage=Texture'KFBox.Skins.I_AmmoBox'
     SelectedHudImage=Texture'KFBox.Skins.I_AmmoBox'
     Weight=2.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'KFBox.Skins.I_AmmoBox'
     FireModeClass(0)=Class'KFMod.NoFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bCanThrow=False
     Description="An ammo crate that work as a store where you can buy ammunition from during wave."
     Priority=10
     InventoryGroup=5
     GroupOffset=6
     PickupClass=Class'KFBox.AmmoBPickup'
     BobDamping=6.000000
     AttachmentClass=Class'KFBox.AmmoBAttachment'
     ItemName="Ammo box"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'KFBox.Pickup.AmmoBoxSM'
     DrawScale=1.500000
     AmbientGlow=35
}
