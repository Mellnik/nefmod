class CorLogMut extends Mutator
	config(CorLogMut);

var config bool bSafeWriting;

var	CLBroadcastHandler	CLBHandler;
var	FileLog				CurrentLog;

simulated function PostBeginPlay()
{
	local KFGameType KFGT;
	local BroadcastHandler BH;
	
	Super.PostBeginPlay();
	
	KFGT = KFGameType(Level.Game);
	BH=KFGT.BroadcastHandler;
	
	while ( BH != none )
	{
		if ( BH.NextBroadcastHandler == none )
		{
			CLBHandler = Spawn(class'CLBroadcastHandler',Self);
			CLBHandler.MutatorOwner = Self;
			BH.NextBroadcastHandler = CLBHandler;
			break;
		}
		BH = BH.NextBroadcastHandler;
	}
	
	CurrentLog = Spawn(class'FileLog');
	CurrentLog.OpenLog(GetCurrentDay() $ " chat",,false);
	CurrentLog.Logf("Started at map : " $ GetCurrentMap());
	
	if ( bSafeWriting )
	{
		CurrentLog.CloseLog();
	}
}

function Destroyed()
{
	Super.Destroyed();
	
	if ( !bSafeWriting )
	{
		CurrentLog.CloseLog();
	}
}

function LogMessage(PlayerReplicationInfo SenderPRI, string Mess)
{
	Mess = ConvertString(Mess);
	
	if ( bSafeWriting )
	{
		CurrentLog.OpenLog(GetCurrentDay() $ " chat",,false);
	}
	
	CurrentLog.Logf(GetOnlyTime() $ " " $ SenderPRI.PlayerName $ ": " $ Mess);
	
	if ( bSafeWriting )
	{
		CurrentLog.CloseLog();
	}
}

function string ConvertString(string CurString)
{
	local string Ret,Sym;
	
	while ( CurString != "" )
	{
		Sym = Left(CurString,1);
		Sym = ReplaceCharacter(Sym);
		CurString = Mid(CurString,1);
		Ret = Ret $ Sym;
	}
	
	return Ret;
}

function string ReplaceCharacter(string C)
{
	local int Code;
	
	Code = Asc(C);
	
	if ( Code >= 1040 )
	{
		Code -= 848;
	}
	
	C = Chr(Code);
	
	return C;
}

function string GetCurrentDay()
{
	local string monthS, dayS;
	
	if(Level.Month<10)
		monthS=0$Level.Month;
	else
		monthS=string(Level.Month);

	if(Level.Day<10)
		dayS=0$Level.Day;
	else
		dayS=string(Level.Day);
		
	return Level.Year $ "." $ monthS $ "." $ dayS;
}

function string GetCurrentTime() //  на основе функции от Flame
{
	local string monthS, dayS, hourS, minuteS;

	if(Level.Month<10)
		monthS=0$Level.Month;
	else
		monthS=string(Level.Month);

	if(Level.Day<10)
		dayS=0$Level.Day;
	else
		dayS=string(Level.Day);

	if(Level.Hour<10)
		hourS=0$Level.Hour;
	else
		hourS=string(Level.Hour);

	if(Level.Minute<10)
		minuteS=0$Level.Minute;
	else
		minuteS=string(Level.Minute);

	return Level.Year$"."$monthS$"."$dayS$" "$hourS$":"$minuteS;
}

function string GetOnlyTime()
{
	local string hourS, minuteS, secondS;
	
	if(Level.Hour<10)
		hourS=0$Level.Hour;
	else
		hourS=string(Level.Hour);

	if(Level.Minute<10)
		minuteS=0$Level.Minute;
	else
		minuteS=string(Level.Minute);
		
	if(Level.second<10)
		secondS=0$Level.Second;
	else
		secondS=string(Level.Second);
		
	return hourS $ ":" $ minuteS $ ":" $ secondS;
}

function string GetCurrentMap()
{
	local string MapName;
	local int a, b;
	
	MapName = Level.GetLocalURL();

	a = InStr(MapName, "/");
	if (a < 0) a = 0;
	else a++;

	b = InStr(MapName, "?");
	if (b < 0 ) b = Len(MapName);

	return Mid(MapName, a, b - a);
}

defaultproperties
{
     bSafeWriting=True
     GroupName="KF-CorrespondenceLog"
     FriendlyName="Correspondence Log Mutator"
     Description="Creates log of in-game chat."
}
