class MedSentryBotNickMut extends Mutator
	config(wtf);
//--------------------------------------------------------------------------------------------------
struct NameRecord
{
	var string Hash;
	var string PlayerName;
	var string BotName;
};

var() config array<NameRecord> NameRecords;
var() config int MaxLength;
//--------------------------------------------------------------------------------------------------
function PostBeginPlay()
{
	SaveConfig();
}
//--------------------------------------------------------------------------------------------------
function string GetBotNameByPC(PlayerController PC)
{
	local int i;
	local string Hash;
	
	if (PC==none) return "";
	Hash=PC.GetPlayerIDHash();
	
	for (i=0; i < NameRecords.Length; i++)
	{
		if (Hash == NameRecords[i].Hash)
			return NameRecords[i].BotName;
	}
	return "";
}
//--------------------------------------------------------------------------------------------------
function SetBotNameByPC(PlayerController PC, string BotName)
{
	local int i;
	local bool bIn;
	local string Hash;
	local MedSentry Sentry;
	
	if (PC==none) return;
	Hash=PC.GetPlayerIDHash();
	
	for (i=0;i<NameRecords.Length;i++)
	{
		if (Hash == NameRecords[i].Hash)
		{
			NameRecords[i].BotName = Left(BotName,MaxLength);
			bIn=true;
		}
	}
	if (!bIn)
	{
		NameRecords.Insert(0,1);
		NameRecords[0].Hash=Hash;
		NameRecords[0].BotName=BotName;
		NameRecords[0].PlayerName=PC.PlayerReplicationInfo.PlayerName;
	}
	SaveConfig();
	
// refresh BotNames
	foreach DynamicActors(class'MedSentry',Sentry)
	{
		if (PlayerController(Sentry.OwnerPawn.Controller)==none) 
		{
			log("Sentry.OwnerPawn.PlayerController==none");
			continue;
		}
		for (i=0;i<NameRecords.Length;i++)
		{
			if ( NameRecords[i].Hash == PlayerController(Sentry.OwnerPawn.Controller).GetPlayerIDHash() )
			{
				Sentry.BotName=NameRecords[i].BotName;
			}
		}
	}
	
	
	PC.ClientMessage("Ok. BotName is"@Left(BotName,MaxLength));
}
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------

defaultproperties
{
     NameRecords(0)=(Hash="76561200304816588",PlayerName="Tony",botname="Lifesaver")
     MaxLength=10
}
