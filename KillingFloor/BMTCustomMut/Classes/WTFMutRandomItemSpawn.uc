class WTFMutRandomItemSpawn extends KFRandomItemSpawn;

var() class<Pickup> CommonItems[6];
var() class<Pickup> RareItems[10];
var() class<Pickup> RarestItems[13];

simulated function PostBeginPlay()
{
	local int i;

	if ( Level.NetMode!=NM_Client )
	{
		SetRandPowerUp();
	}
	
	if ( Level.NetMode != NM_DedicatedServer )
	{
		for ( i=0; i< ArrayCount(CommonItems); i++ )
			CommonItems[i].static.StaticPrecache(Level);
			
		for ( i=0; i< ArrayCount(RareItems); i++ )
			RareItems[i].static.StaticPrecache(Level);
			
		for ( i=0; i< ArrayCount(RarestItems); i++ )
			RarestItems[i].static.StaticPrecache(Level);
	}

	if ( KFGameType(Level.Game) != none )
	{
		KFGameType(Level.Game).WeaponPickups[KFGameType(Level.Game).WeaponPickups.Length] = self;
		DisableMe();
	}

	SetLocation(Location - vect(0,0,1)); // adjust because reduced drawscale
}

function SetRandPowerUp()
{
	local float r;
	local int RarestItemsLastIndex, RareItemsLastIndex, CommonItemsLastIndex;
	
	RarestItemsLastIndex = ArrayCount(RarestItems) - 1;
	RareItemsLastIndex = ArrayCount(RareItems) - 1;
	CommonItemsLastIndex = ArrayCount(CommonItems) - 1;
	
	r = FRand();
	
	if (r < 0.05)
		PowerUp = RarestItems[rand(RarestItemsLastIndex)]; //rarest items 5% of the time
	else if (r < 0.2)
		PowerUp = RareItems[rand(RareItemsLastIndex)]; //rare items 20% of the time
	else
		PowerUp = CommonItems[rand(CommonItemsLastIndex)]; //rest of the time common items
	
}

function int GetWeightedRandClass();

function TurnOn()
{
	SetRandPowerUp();
	
	if( myPickup != none )
		myPickup.Destroy();

	SpawnPickup();
	SetTimer(InitialWaitTime+InitialWaitTime*FRand(), false);
}

defaultproperties
{
     CommonItems(0)=Class'BMTCustomMut.WTFEquipShotgunPickup'
     CommonItems(1)=Class'BMTCustomMut.WTFEquipMachineDualiesPickup'
     CommonItems(2)=Class'KFMod.WinchesterPickup'
     CommonItems(3)=Class'BMTCustomMut.WTFEquipBulldogPickup'
     CommonItems(4)=Class'KFMod.MachetePickup'
     CommonItems(5)=Class'BMTCustomMut.WTFEquipFlaregunPickup'
     RareItems(0)=Class'BMTCustomMut.WTFEquipBoomStickPickup'
     RareItems(1)=Class'BMTCustomMut.DeaglePickupExt'
     RareItems(2)=Class'BMTCustomMut.WTFEquipCrossbowPickup'
     RareItems(3)=Class'BMTCustomMut.WTFEquipAK48SPickup'
     RareItems(4)=Class'BMTCustomMut.WTFEquipFireAxePickup'
     RareItems(5)=Class'BMTCustomMut.WTFFlamerPickup'
     RareItems(6)=Class'BMTCustomMut.M79CFPickup'
     RareItems(7)=Class'BMTCustomMut.MP7MPickupExt'
     RareItems(8)=Class'BMTCustomMut.WTFEquipLethalInjectionPickup'
     RareItems(9)=Class'BMTCustomMut.MP5PickupExtend'
     RarestItems(0)=Class'BMTCustomMut.WTFLawPickup'
     RarestItems(1)=Class'BMTCustomMut.WTFEquipAFS12Pickup'
     RarestItems(2)=Class'KFMod.M14EBRPickup'
     RarestItems(3)=Class'BMTCustomMut.WTFEquipSCAR19Pickup'
     RarestItems(4)=Class'BMTCustomMut.WTFEquipChainsawPickup'
     RarestItems(5)=Class'BMTCustomMut.WTFEquipKatanaPickup'
     RarestItems(6)=Class'BMTCustomMut.PipeBomb2Pickup'
     RarestItems(7)=Class'BMTCustomMut.WTFEquipUM32Pickup'
     RarestItems(8)=Class'BMTCustomMut.WTFEquipSelfDestructPickup'
     RarestItems(9)=Class'BMTCustomMut.B94Pickup'
     RarestItems(10)=Class'BMTCustomMut.Tech_AdvancedWelderPickup'
     RarestItems(11)=Class'BMTCustomMut.Tech_DoomSentryBotPickup'
     RarestItems(12)=Class'BMTCustomMut.Tech_USCMSentryPickup'
}
