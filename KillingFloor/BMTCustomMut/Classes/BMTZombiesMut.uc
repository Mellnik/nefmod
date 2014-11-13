class BMTZombiesMut extends Mutator;

//NormalSquad Mods
//also used to mod special squads
const NS_NUM_NEW = 40;
var String NSOld[NS_NUM_NEW];
var String NSNew[NS_NUM_NEW];
var Float NSChance[NS_NUM_NEW];

function PostBeginPlay()
{
	SetTimer(5.0,False);
	Super.PostBeginPlay();
}

function Timer()
{
	local KFGameType KF;
	local byte squad,squadMem,replaceCounter,i,ii;
	local class<KFMonster> MC;
		
	KF = KFGameType(Level.Game);
	if ( KF!=None )
	{
		KF.EndGameBossClass="BMTCustomMut.ZombieBossSantatriarch";
		
		//normal squads
		for( squad=0; squad<KF.InitSquads.Length; squad++)
		{
			for( squadMem=0; squadMem < KF.InitSquads[squad].MSquad.Length; squadMem++ )
			{
				for (replaceCounter=0; replaceCounter < NS_NUM_NEW; replaceCounter++)
				{
					if ( String(KF.InitSquads[squad].MSquad[squadMem]) == NSOld[replaceCounter] && FRand() <= NSChance[replaceCounter])
					{
						MC = Class<KFMonster>(DynamicLoadObject(NSNew[replaceCounter],Class'Class'));
						KF.InitSquads[squad].MSquad[squadMem]=MC;
					}
				}
			}
		}
	
		//special squads
		for (i=0;i<KF.SpecialSquads.Length;i++)
		{
			for (ii=0; ii<KF.SpecialSquads[i].ZedClass.Length;ii++)
			{
				for (replaceCounter=0; replaceCounter < NS_NUM_NEW; replaceCounter++)
				{
					if (KF.SpecialSquads[i].ZedClass[ii]== NSOld[replaceCounter] && FRand() <= NSChance[replaceCounter])
						KF.SpecialSquads[i].ZedClass[ii]=NSNew[replaceCounter];
				}
			}
		}
	}
	
	//Destroy();
}

defaultproperties
{
     NSOld(0)="BMTCustomMut.ZombieClotCake"
     NSOld(1)="BMTCustomMut.ZombieClotCake"
     NSOld(2)="BMTCustomMut.ZombieCrawlerCake"
     NSOld(3)="BMTCustomMut.ZombieCrawlerCake"
     NSOld(4)="BMTCustomMut.ZombieCrawlerCake"
     NSOld(5)="BMTCustomMut.ZombieCrawlerCake"
     NSOld(6)="BMTCustomMut.ZombieBloatCake"
     NSOld(7)="BMTCustomMut.ZombieHuskCake"
     NSOld(8)="BMTCustomMut.ZombieGorefastCake"
     NSOld(9)="BMTCustomMut.ZombieScrakeCake"
     NSOld(10)="BMTCustomMut.ZombieStalkerCake"
     NSOld(11)="BMTCustomMut.ZombieSirenCake"
     NSOld(12)="BMTCustomMut.ZombieFleshPoundCake"
     NSNew(0)="BMTCustomMut.ZombieClotElf"
     NSNew(1)="BMTCustomMut.ZombieShiver"
     NSNew(2)="BMTCustomMut.ZombieGiantReindeer"
     NSNew(3)="BMTCustomMut.ZombieCoolenShade"
     NSNew(4)="BMTCustomMut.WTFZombiesLeaper"
     NSNew(5)="BMTCustomMut.ZombieBrute"
     NSNew(6)="BMTCustomMut.WTFZombiesBloatzilla"
     NSNew(7)="BMTCustomMut.WTFZombiesIncinerator"
     NSNew(8)="BMTCustomMut.ZombiePunyGingerfast"
     NSNew(9)="BMTCustomMut.WTFZombiesMauler"
     NSNew(10)="BMTCustomMut.WTFZombiesBanshee"
     NSNew(11)="BMTCustomMut.WTFZombiesBanshee"
     NSNew(12)="BMTCustomMut.ZombieFleshCracker"
     NSChance(0)=0.250000
     NSChance(1)=0.250000
     NSChance(3)=0.450000
     NSChance(4)=0.450000
     NSChance(5)=0.550000
     NSChance(6)=0.100000
     NSChance(7)=0.450000
     NSChance(8)=0.600000
     NSChance(9)=0.300000
     NSChance(10)=0.150000
     NSChance(11)=0.050000
     NSChance(12)=0.450000
     bAddToServerPackages=True
     GroupName="KF-BMT-Zombies-Mut"
     FriendlyName="BMTZ V1.0: BMT-Zombies-Mut"
     Description="BMT's custom assortment of zombies."
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
