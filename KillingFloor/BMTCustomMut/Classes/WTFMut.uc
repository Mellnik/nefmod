class WTFMut extends Mutator;

CONST NumAllowedWeaponPickups = 1000;
var String AllowedWeaponPickups[NumAllowedWeaponPickups]; //strings are converted to lowercase in timer

function PostBeginPlay()
{
	SetTimer(1.0, false);
	Super.PostBeginPlay();
	
	/*
	//Level is a LevelInfo object
	Log("BMTCustomMut.WTFMut: About to precache custom resources...");
	
	Level.AddPrecacheMaterial(Texture'WTFTex.WTFZombies.Mauler');
	Level.AddPrecacheMaterial(Texture'WTFTex.WTFZombies.Banshee');
	Level.AddPrecacheMaterial(Texture'WTFTex.WTFZombies.Bloatzilla');
	Level.AddPrecacheMaterial(Texture'WTFTex.WTFZombies.Broodmother');
	Level.AddPrecacheMaterial(Texture'WTFTex.WTFZombies.Incinerator');
	Level.AddPrecacheMaterial(Texture'WTFTex.WTFZombies.Goreallyfast');
	Level.AddPrecacheMaterial(Texture'WTFTex.WTFZombies.IronClot');
	Level.AddPrecacheMaterial(Texture'WTFTex.WTFZombies.MeatPounder');
	
	Log("BMTCustomMut.WTFMut: Precache done!");
	*/
}

function Timer()
{
    local BMTGameType KF;
	local int i;
	local KFAmmoPickup KFAP;
	local WTFMutRandomItemSpawn WTFRandomSpawner;
	
	KF = BMTGameType(Level.Game);
	if ( KF!=None )
	{
		if( KF.KFLRules!=None )
			KF.KFLRules.Destroy();
		KF.KFLRules = Spawn(Class'WTFMutLevelRules');
		
		//I am super freakin tired of seeing a million warning/error messages about 0/0 AmmoPickups
		if ( KF.AmmoPickups.Length < 1)
		{
			KFAP = Spawn(Class'KFAmmoPickup');
			KF.AmmoPickups.Length = 1;
			KF.AmmoPickups[0]=KFAP;
		}
		//I am super freakin tired of seeing a million warning/error messages about 0/0 WeaponPickups
		if ( KF.WeaponPickups.Length < 1)
		{
			WTFRandomSpawner = Spawn(Class'BMTCustomMut.WTFMutRandomItemSpawn');
			KF.AmmoPickups.Length = 1;
			KF.WeaponPickups[0]=WTFRandomSpawner;
		}
	}
	
	//convert all the classes to lowercase so we don't have to worry about it
	for (i=0; i < NumAllowedWeaponPickups; i++)
	{
		AllowedWeaponPickups[i] = locs(AllowedWeaponPickups[i]);
	}
}

function bool CheckReplacement( Actor Other, out byte bSuperRelevant )
{
	local KFHumanPawn KFHP;
	local WTFEquipMachinePistol NineMMReplacement;
	local int i;
	
	bSuperRelevant = 0;

	if ( Other == None )
		return true;

	//more kludgefix for player's dropping a 9mm on death
	if ( Other.Class==Class'SinglePickup' )
	{
		ReplaceWith( Other, "BMTCustomMut.WTFEquipMachinePistolPickup" );
		return false;
	}
	else if ( Other.Class==Class'DualiesPickup' )
	{
		ReplaceWith( Other, "BMTCustomMut.WTFEquipMachineDualiesPickup" );
		return false;
	}
		
	if ( Other.IsA('KFRandomItemSpawn') && !Other.IsA('WTFMutRandomItemSpawn') )
	{
		ReplaceWith( Other, "BMTCustomMut.WTFMutRandomItemSpawn" );
		return false;
	}
	
	//loop through an array of stock pickups that are not being replaced
	// if it's in there, return
	// if it is not in there, AKA it is a stock KF weapon I am not replacing that some mapper put in their map...
	// replace it with a KFRandomItemSpawn
	if ( Other.IsA('KFWeaponPickup') )
	{
		for (i=0; i < NumAllowedWeaponPickups; i++)
		{
			//convert it to lower case before comparison
			if (locs(String(Other.Class)) == AllowedWeaponPickups[i])
			{
				return true;
			}
		}
		
		//not allowed, replace it with random spawner
		ReplaceWith( Other, "BMTCustomMut.WTFMutRandomItemSpawn" );
		return false;
	}
	
	//kludge fix for the machinedualies trader issue...
	if ( Other.Class==Class'Single' )
	{
		KFHP = KFHumanPawn(Single(Other).Instigator);
		if (KFHP != None)
		{
			Other.Destroy();
			NineMMReplacement = Spawn(class'WTFEquipMachinePistol');
			NineMMReplacement.GiveTo(KFHP);
			return false;
		}
	}
	
	if ( Other.IsA('KFHumanPawn') )
	{
		KFHP = KFHumanPawn(Other);
		KFHP.RequiredEquipment[0] = "BMTCustomMut.WTFKnife";
		KFHP.RequiredEquipment[1] = "BMTCustomMut.WTFEquipMachinePistol";
		KFHP.RequiredEquipment[2] = "BMTCustomMut.WTFEquipNadeWeapon";
//		KFHP.RequiredEquipment[4] = "BMTCustomMut.WTFEquipWelda";
		KFHP.RequiredEquipment[3] = "BMTCustomMut.BMTSyringeDrop";
//		KFHP.RequiredEquipment[6] = "BMTCustomMut.WTFKnife";

		return true;
	}
		
	return true;
}

defaultproperties
{
     AllowedWeaponPickups(0)="BMTCustomMut.MP7MPickupExt"
     AllowedWeaponPickups(1)="BMTCustomMut.WTFEquipShotgunPickup"
     AllowedWeaponPickups(2)="BMTCustomMut.WTFEquipBoomStickPickup"
     AllowedWeaponPickups(3)="BMTCustomMut.WTFLawPickup"
     AllowedWeaponPickups(4)="BMTCustomMut.WTFEquipAFS12Pickup"
     AllowedWeaponPickups(5)="BMTCustomMut.WTFEquipMachinePistolPickup"
     AllowedWeaponPickups(6)="BMTCustomMut.WTFEquipMachineDualiesPickup"
     AllowedWeaponPickups(7)="BMTCustomMut.DeaglePickupExt"
     AllowedWeaponPickups(8)="BMTCustomMut.DualDeaglePickupExt"
     AllowedWeaponPickups(9)="BMTCustomMut.Winchester2Pickup"
     AllowedWeaponPickups(10)="BMTCustomMut.WTFEquipCrossbowPickup"
     AllowedWeaponPickups(11)="KFMod.M14EBRPickup"
     AllowedWeaponPickups(12)="BMTCustomMut.WTFEquipBulldogPickup"
     AllowedWeaponPickups(13)="BMTCustomMut.WTFEquipAK48SPickup"
     AllowedWeaponPickups(14)="BMTCustomMut.WTFEquipSCAR19Pickup"
     AllowedWeaponPickups(15)="KFMod.KnifePickup"
     AllowedWeaponPickups(16)="KFMod.MachetePickup"
     AllowedWeaponPickups(17)="BMTCustomMut.WTFEquipFireAxePickup"
     AllowedWeaponPickups(18)="BMTCustomMut.WTFEquipChainsawPickup"
     AllowedWeaponPickups(19)="BMTCustomMut.WTFEquipKatanaPickup"
     AllowedWeaponPickups(20)="BMTCustomMut.WTFFlamerPickup"
     AllowedWeaponPickups(21)="BMTCustomMut.PipeBomb2Pickup"
     AllowedWeaponPickups(22)="BMTCustomMut.M79CFPickup"
     AllowedWeaponPickups(23)="BMTCustomMut.WTFEquipUM32Pickup"
     AllowedWeaponPickups(24)="BMTCustomMut.WTFEquipFlaregunPickup"
     AllowedWeaponPickups(25)="BMTCustomMut.WTFEquipLethalInjectionPickup"
     AllowedWeaponPickups(26)="BMTCustomMut.WTFEquipSelfDestructPickup"
     AllowedWeaponPickups(27)="BMTCustomMut.SA80Pickup"
     AllowedWeaponPickups(28)="BMTCustomMut.WTFEquipBanHammerPickup"
     AllowedWeaponPickups(29)="BMTCustomMut.WTFEquipGlowstickPickup"
     AllowedWeaponPickups(30)="BMTCustomMut.WTFEquipSawedOffShotgunPickup"
     AllowedWeaponPickups(31)="BMTCustomMut.WColtPickup"
     AllowedWeaponPickups(32)="BMTCustomMut.OutlawWinchesterPickup"
     AllowedWeaponPickups(33)="BMTCustomMut.OutlawDualDeaglePickup"
     AllowedWeaponPickups(34)="BMTCustomMut.OutlawDeaglePickup"
     AllowedWeaponPickups(35)="BMTCustomMut.OutlawSinglePickup"
     AllowedWeaponPickups(36)="BMTCustomMut.OutlawDualiesPickup"
     AllowedWeaponPickups(37)="BMTCustomMut.M41APickup"
//     AllowedWeaponPickups(38)="BMTCustomMut.ShieldPickup"
     AllowedWeaponPickups(39)="BMTCustomMut.ThompsonPickup"
     AllowedWeaponPickups(40)="BMTCustomMut.M249Pickup"
     AllowedWeaponPickups(41)="BMTCustomMut.HK417Pickup"
     AllowedWeaponPickups(42)="BMTCustomMut.B94Pickup"
//     AllowedWeaponPickups(43)="BMTCustomMut."
     AllowedWeaponPickups(44)="KFMod.KatanaPickup"
     AllowedWeaponPickups(45)="BMTCustomMut.sekiraPickup"
     AllowedWeaponPickups(46)="BMTCustomMut.BMTSyringeDropPickup"
     AllowedWeaponPickups(47)="BMTCustomMut.WelderPickup"
     AllowedWeaponPickups(48)="BMTCustomMut.WTFKnifePickup"
     AllowedWeaponPickups(49)="BMTCustomMut.litesaberPickup"
     AllowedWeaponPickups(50)="BMTCustomMut.ForcePickup"
//     AllowedWeaponPickups(51)="BMTCustomMut."
//     AllowedWeaponPickups(52)="BMTCustomMut."
     AllowedWeaponPickups(53)="BMTCustomMut.DualFRevolverPickup"
     AllowedWeaponPickups(54)="BMTCustomMut.FRevolverPickup"
     AllowedWeaponPickups(55)="BMTCustomMut.ScytheaPickup"
//     AllowedWeaponPickups(56)="BMTCustomMut."
     AllowedWeaponPickups(57)="BMTCustomMut.MKb42aPickup"
//     AllowedWeaponPickups(58)="BMTCustomMut."
//     AllowedWeaponPickups(59)="BMTCustomMut."
     AllowedWeaponPickups(60)="BMTCustomMut.HealingKatanaPickup"
     AllowedWeaponPickups(61)="KFMod.M4Pickup"
     AllowedWeaponPickups(62)="KFMod.DeaglePickup"
     AllowedWeaponPickups(63)="KFMod.ShotgunPickup"
     AllowedWeaponPickups(64)="KFMod.BoomStickPickup"
     AllowedWeaponPickups(65)="KFMod.LAWPickup"
     AllowedWeaponPickups(66)="BMTCustomMut.AA12ExtPickup"
     AllowedWeaponPickups(67)="BMTCustomMut.CrossbowExtPickup"
     AllowedWeaponPickups(68)="KFMod.BullpupPickup"
     AllowedWeaponPickups(69)="KFMod.AK47Pickup"
     AllowedWeaponPickups(70)="KFMod.SCARMK17Pickup"
     AllowedWeaponPickups(71)="KFMod.AxePickup"
     AllowedWeaponPickups(72)="KFMod.ChainsawPickup"
     AllowedWeaponPickups(73)="KFMod.FlameThrowerPickup"
     AllowedWeaponPickups(74)="KFMod.Mac10Pickup"
     AllowedWeaponPickups(75)="KFMod.PipeBombPickup"
     AllowedWeaponPickups(76)="KFMod.M79Pickup"
     AllowedWeaponPickups(77)="KFMod.M32Pickup"
     AllowedWeaponPickups(78)="KFMod.ClaymoreSwordPickup"
     AllowedWeaponPickups(79)="KFMod.Dual44MagnumPickup"
     AllowedWeaponPickups(80)="KFMod.HuskgunPickup"
     AllowedWeaponPickups(81)="BMTCustomMut.BizonPickup"
     AllowedWeaponPickups(82)="KFMod.MP5MPickup"
     AllowedWeaponPickups(83)="KFMod.BenelliPickup"
     AllowedWeaponPickups(84)="KFMod.Magnum44Pickup"
     AllowedWeaponPickups(85)="KFMod.MK23Pickup"
     AllowedWeaponPickups(86)="KFMod.DualMK23Pickup"
     AllowedWeaponPickups(87)="BMTCustomMut.FnFalAPickup2"
     AllowedWeaponPickups(88)="BMTCustomMut.M7A3MPickupExt"
//     AllowedWeaponPickups(89)="BMTCustomMut."
     AllowedWeaponPickups(90)="BMTCustomMut.KSGPickup"
     AllowedWeaponPickups(91)="BMTCustomMut.P90Pickup"
     AllowedWeaponPickups(92)="BMTCustomMut.UMP45Pickup"
//     AllowedWeaponPickups(93)="BMTCustomMut.PTurretPickup"
     AllowedWeaponPickups(94)="BMTCustomMut.MedSentryGunPickup"
//     AllowedWeaponPickups(95)="BMTCustomMut."
     AllowedWeaponPickups(96)="BMTCustomMut.G43ScopePickup"
     AllowedWeaponPickups(97)="BMTCustomMut.MP40Pickup"
     AllowedWeaponPickups(98)="BMTCustomMut.PPDPickup"
     AllowedWeaponPickups(99)="BMTCustomMut.STG44Pickup"
     AllowedWeaponPickups(100)="BMTCustomMut.TT33Pickup"
     AllowedWeaponPickups(101)="BMTCustomMut.ZEDGunPickupA"
//     AllowedWeaponPickups(102)="BMTCustomMut."
     AllowedWeaponPickups(103)="BMTCustomMut.KrissMPickupA"
     AllowedWeaponPickups(104)="KFMod.SyringePickup"
     AllowedWeaponPickups(105)="BMTCustomMut.Tech_AdvancedWelderPickup"
     AllowedWeaponPickups(106)="BMTCustomMut.Tech_BioLauncherPickup"
     AllowedWeaponPickups(107)="BMTCustomMut.Tech_DoomSentryBotPickup"
//     AllowedWeaponPickups(108)="BMTCustomMut."
//     AllowedWeaponPickups(109)="BMTCustomMut."
     AllowedWeaponPickups(110)="BMTCustomMut.Tech_HL_BlueGravityGunPickup"
     AllowedWeaponPickups(111)="BMTCustomMut.Tech_HL_BugBaitPickup"
     AllowedWeaponPickups(112)="BMTCustomMut.Tech_HL_GravityGunPickup"
     AllowedWeaponPickups(113)="BMTCustomMut.Tech_HL_RPGPickup"
     AllowedWeaponPickups(114)="BMTCustomMut.Tech_IncendiaryPipeBombPickup"
     AllowedWeaponPickups(115)="BMTCustomMut.Tech_M7A3MPickup"
     AllowedWeaponPickups(116)="BMTCustomMut.Tech_MachineDualiesPickup"
     AllowedWeaponPickups(117)="BMTCustomMut.Tech_MachinePistolPickup"
     AllowedWeaponPickups(118)="BMTCustomMut.Tech_PipeBombPickup"
     AllowedWeaponPickups(119)="BMTCustomMut.Tech_PlasmaCutterPickup"
     AllowedWeaponPickups(120)="BMTCustomMut.Tech_ShockRiflePickup"
     AllowedWeaponPickups(121)="BMTCustomMut.Tech_USCMSentryPickup"
     AllowedWeaponPickups(122)="BMTCustomMut.Tech_HL2WeaponPickup"
//     AllowedWeaponPickups(123)="BMTCustomMut."
     AllowedWeaponPickups(124)="BMTCustomMut.FM32Pickup"
     AllowedWeaponPickups(125)="BMTCustomMut.XMk5Pickup"
     AllowedWeaponPickups(126)="BMTCustomMut.XMV850Pickup"
     AllowedWeaponPickups(127)="BMTCustomMut.LilithKissPickup"
     AllowedWeaponPickups(128)="KFMod.M4203Pickup"
     AllowedWeaponPickups(129)="BMTCustomMut.PBPickup"
     AllowedWeaponPickups(130)="BMTCustomMut.M44Pickup"
     AllowedWeaponPickups(131)="BMTCustomMut.MK23PickupExt"
     AllowedWeaponPickups(132)="BMTCustomMut.DualMK23PickupExt"
     AllowedWeaponPickups(133)="BMTCustomMut.ProtectaPickup"
     AllowedWeaponPickups(134)="BMTCustomMut.StingerPickup"
//     AllowedWeaponPickups(135)="BMTCustomMut."
     AllowedWeaponPickups(136)="BMTCustomMut.Glock18Pickup"
//     AllowedWeaponPickups(137)="BMTCustomMut."
     AllowedWeaponPickups(138)="BMTCustomMut.P90DTPickup"
     AllowedWeaponPickups(139)="BMTCustomMut.P57LLIPickup"
     bAddToServerPackages=True
     GroupName="KF-BMTMut"
     FriendlyName="BMTV1.0: BMTMut"
     Description="BMT's Custom perks, equipment, zeds, and maps."
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
