class BMTPlayerController extends KFPlayerController;

struct VetExchangeEntry
{
	var class<KFVeterancyTypes> TWI, BMT;
};

var class<KFVeterancyTypes> DefaultVet;
var array<VetExchangeEntry> VetExchangeList;
var class<KFVeterancyTypes> OldVet;

simulated function PostBeginPlay()
{
	if (Level.NetMode != NM_DedicatedServer)
		SwitchVet(self);
	Super.PostBeginPlay();
}

simulated function SwitchVet(BMTPlayerController PC)
{
	local class<KFVeterancyTypes> Vet;
	local int i;

	OldVet = SelectedVeterancy;
	Vet = DefaultVet;

	for (i = 0; i < VetExchangeList.Length; i++)
	{
		if (OldVet == VetExchangeList[i].TWI || OldVet == VetExchangeList[i].BMT)
			Vet = VetExchangeList[i].BMT;
	}

	if (Vet != OldVet)
	{
		SelectedVeterancy = Vet;
		Log("!!! Switched current (" $ OldVet $ ") perk to BMT (" $ Vet $ ") perk");
	}
}

defaultproperties
{
     DefaultVet=Class'BMTCustomMut.WTFPerksSupportSpec'
     VetExchangeList(0)=(TWI=Class'KFMod.KFVetFieldMedic',BMT=Class'BMTCustomMut.WTFPerksFieldMedic')
}
