class BMTGameType extends KFGametype;

var int MaxCap;

var array<string>   EndGameBossClasses;

//Doom Boss Variables
var float DoomBossChance;
var bool bUseDoomBoss, bSpawnedPatriarch; // Are we using a Doom Boss?
var array<string>   DoomBossClasses;
var string DoomBossClass; // class of doom boss

var config int   MaxCarLimit;
var	  int	NumCars;
var config int   MinCarLimit;

struct OKEvents
{
     var name  MyOKevents;
};

var     array<OKEvents> RandomOKEvents;   

function bool AddBoss()
{
	if (EndGameBossClasses.length > 0)
		EndGameBossClass = EndGameBossClasses[rand(EndGameBossClasses.length)];		
	
	super.AddBoss();
	bSpawnedPatriarch=true;
}

function NotifyAddCar(){
   NumCars++;
}


function NotifyRemoveCar(){
   NumCars--;
}


function bool TooManyCars(Controller CarToRemove){
   local int CurrentInPlayLimit;

	
   
     CurrentInPlayLimit = MaxCarLimit;

	 //log("TooManyCars"@NumCars@CurrentInPlayLimit);

   if (NumCars >= CurrentInPlayLimit){ return true; }
   return false;
}


function bool NotEnoughCars(){
   local int CurrentInPlayLimit;


       CurrentInPlayLimit = MinCarLimit;
	   
	  //log("NotEnoughCars"@NumCars@CurrentInPlayLimit);


   if (NumCars < CurrentInPlayLimit){ return true; }
   return false;
}



event Tick(float DeltaTime)
{

	super.tick(deltatime);

	If (NotEnoughCars())
	{
	 	if (  RandomOKEvents.length > 0 )
		Event = RandomOKEvents[ Rand(RandomOKEvents.length ) ].MyOKEvents;
		TriggerEvent( Event, self, None );
	}
}

defaultproperties
{
     LongWaves(0)=(WaveMaxMonsters=40,WaveDifficulty=1.000000)
     LongWaves(1)=(WaveMaxMonsters=42,WaveDifficulty=1.000000)
     LongWaves(2)=(WaveMaxMonsters=44,WaveDifficulty=1.000000)
     LongWaves(3)=(WaveMaxMonsters=46,WaveDifficulty=1.000000)
     LongWaves(4)=(WaveMaxMonsters=48,WaveDifficulty=1.000000)
     LongWaves(5)=(WaveMaxMonsters=50,WaveDifficulty=1.000000)
     LongWaves(6)=(WaveMaxMonsters=55,WaveDifficulty=1.000000)
     LongWaves(7)=(WaveMaxMonsters=60,WaveDifficulty=1.000000)
     LongWaves(8)=(WaveMaxMonsters=70,WaveDifficulty=1.000000)
     LongWaves(9)=(WaveMaxMonsters=80,WaveDifficulty=1.000000)
     MonsterCollection=Class'BMTCustomMut.BMTMonstersCollection'
     StartingCash=1000
     MinRespawnCash=1000
     StartingCashBeginner=1000
     StartingCashNormal=1000
     StartingCashHard=1000
     StartingCashSuicidal=1000
     StartingCashHell=1000
     MinRespawnCashBeginner=1000
     MinRespawnCashNormal=1000
     MinRespawnCashHard=1000
     MinRespawnCashSuicidal=1000
     MinRespawnCashHell=1000
     StandardMonsterSquads(0)="8A2P"
     StandardMonsterSquads(1)="8A1G1Q"
     StandardMonsterSquads(2)="4B"
     StandardMonsterSquads(3)="8B"
     StandardMonsterSquads(4)="6A1G1R"
     StandardMonsterSquads(5)="4D"
     StandardMonsterSquads(6)="6A2C"
     StandardMonsterSquads(7)="4A4C"
     StandardMonsterSquads(8)="4A6B2C"
     StandardMonsterSquads(9)="2A6C"
     StandardMonsterSquads(10)="6A2C2H"
     StandardMonsterSquads(11)="6A2B4D2G2H"
     StandardMonsterSquads(12)="6A2E"
     StandardMonsterSquads(13)="4A2E"
     StandardMonsterSquads(14)="4A6C2E"
     StandardMonsterSquads(15)="4B6D2G4H"
     StandardMonsterSquads(16)="8A2C"
     StandardMonsterSquads(17)="8A"
     StandardMonsterSquads(18)="8D"
     StandardMonsterSquads(19)="8C"
     StandardMonsterSquads(20)="12B"
     StandardMonsterSquads(21)="4B4C4D2H"
     StandardMonsterSquads(22)="4A4B4C4H"
     StandardMonsterSquads(23)="2F"
     StandardMonsterSquads(24)="2I"
     StandardMonsterSquads(25)="4A2C2I"
     StandardMonsterSquads(26)="4I"
     StandardMaxZombiesOnce=40
     KFHints(0)="Aiming for the head gives bonus damage. If you score a critical headshot, you can remove a Specimen's head, rendering them unable to use special abilities, and increasing any further damage they take."
     KFHints(1)="While you can use your medical syringe to heal yourself, you can heal more times and for more if used on teammates!!"
     KFHints(2)="The Fleshpound and MeatPounder, Shooting them with small weapons just makes them mad. They are weaker against explosives but strong against all other weapon types!!"
     KFHints(3)="Patriarch addendum: Did we forget to brief you? Yes, it seems he can cloak when he needs to heal or when chasing. Luckily, only three times in his short, angry life luckily!"
     KFHints(4)="The Patriarch. This is the Big One. Chain-gun. Rockets. And vicious up close, too....so vicious he will send you flying on hit!!"
     KFHints(5)="The Scrake... Yes, that IS a chainsaw he's carrying...  His brother the Mauler is much stronger and twice as fast!"
     KFHints(6)="The Crawlers and Leapers are an interesting attempt to merge human and arachnid genes. Sort-of worked, too - these little nasties have a habit of appearing in all sorts of strange places and jumping all over you!"
     KFHints(9)="Bloat and Bloatzilla will explode in a shower of acidic goop when they die. Keep your distance when taking them down."
     KFHints(10)="The Stalker and Banshee will be largely cloaked and very hard to see, until they are close enough to gut you. Listen carefully for them."
     KFHints(12)="The Gorefast - tends to live up to its name, so watch out for it speeding in towards you. Beware his brother the Goreallyfast as he is twice as fast as the Gorefast!"
     KFHints(13)="The Clot and MetalClot are not that dangerous - but they do have a nasty habit of grappling you and not letting you get away, so keep them at a distance."
     KFHints(14)="The Siren and Banshee's are real screamers. Very nasty. They're screams actually hurt and pull you in - and they'll destroy grenades and rockets in mid-air and pipe bombs on the ground!"
     KFHints(15)="If you have any suggestions for our servers please visit our forums at http://forum.nefserver.net"
     MonsterSquad(0)="8A2P"
     MonsterSquad(1)="8A1G1Q"
     MonsterSquad(2)="4B"
     MonsterSquad(3)="8B"
     MonsterSquad(4)="6A1G1R"
     MonsterSquad(5)="4D"
     MonsterSquad(6)="6A2C"
     MonsterSquad(7)="4A4C"
     MonsterSquad(8)="4A6B2C"
     MonsterSquad(9)="2A6C"
     MonsterSquad(10)="6A2C2H"
     MonsterSquad(11)="6A2B4D2G2H"
     MonsterSquad(12)="6A2E"
     MonsterSquad(13)="4A2E"
     MonsterSquad(14)="4A6C2E"
     MonsterSquad(15)="4B6D2G4H"
     MonsterSquad(16)="8A2C"
     MonsterSquad(17)="8A"
     MonsterSquad(18)="8D"
     MonsterSquad(19)="8C"
     MonsterSquad(20)="12B"
     MonsterSquad(21)="4B4C4D2H"
     MonsterSquad(22)="4A4B4C4H"
     MonsterSquad(23)="2F"
     MonsterSquad(24)="2I"
     MonsterSquad(25)="4A2C2I"
     MonsterSquad(26)="4I"
     DefaultPlayerName="NEF: Server Guest"
     GameName="BMT-KF"
     Description="A modified KillingFloor GameType, Contains Custom Perks, Custom Zeds, Custom Weapons, and WTF Mobs. -Created By LasVegasPunk"
	 TimeBetweenWavesBeginner=70
     TimeBetweenWavesNormal=70
     TimeBetweenWavesHard=70
     TimeBetweenWavesSuicidal=70
     TimeBetweenWavesHell=70
	 KFGameLength=3
	 NumRounds=10
	 MaxTeamSize=50
	 ZEDTimeDuration=1.0
     ZedTimeSlomoScale=0.1
	 bForceRespawn=True
	 
	 MaxCarLimit=6
     MinCarLimit=3
     RandomOKEvents(0)=(MyOKevents="OK0")
     RandomOKEvents(1)=(MyOKevents="OK1")
     RandomOKEvents(2)=(MyOKevents="OK2")
     RandomOKEvents(3)=(MyOKevents="OK3")
     RandomOKEvents(4)=(MyOKevents="OK4")
     RandomOKEvents(5)=(MyOKevents="OK5")
     RandomOKEvents(6)=(MyOKevents="OK6")
     RandomOKEvents(7)=(MyOKevents="OK7")
     RandomOKEvents(8)=(MyOKevents="OK8")
     RandomOKEvents(9)=(MyOKevents="OK9")
     RandomOKEvents(10)=(MyOKevents="OK10")
     RandomOKEvents(11)=(MyOKevents="OK11")
     RandomOKEvents(12)=(MyOKevents="OK12")
     RandomOKEvents(13)=(MyOKevents="OK13")
     RandomOKEvents(14)=(MyOKevents="OK14")
     RandomOKEvents(15)=(MyOKevents="OK15")
     RandomOKEvents(16)=(MyOKevents="OK16")
     RandomOKEvents(17)=(MyOKevents="OK17")
     RandomOKEvents(18)=(MyOKevents="OK18")
     RandomOKEvents(19)=(MyOKevents="OK19")
     RandomOKEvents(20)=(MyOKevents="OK20")
     RandomOKEvents(21)=(MyOKevents="OK21")
     RandomOKEvents(22)=(MyOKevents="OK22")
     RandomOKEvents(23)=(MyOKevents="OK23")
     RandomOKEvents(24)=(MyOKevents="OK24")
     RandomOKEvents(25)=(MyOKevents="OK25")
     RandomOKEvents(26)=(MyOKevents="OK26")
     RandomOKEvents(27)=(MyOKevents="OK27")
     RandomOKEvents(28)=(MyOKevents="OK28")
     RandomOKEvents(29)=(MyOKevents="OK29")
}
