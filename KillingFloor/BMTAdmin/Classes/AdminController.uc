class AdminController extends Admin;

var localized string MSG_LoadedOn;
var localized string MSG_GodOn;
var localized string MSG_GodOff;
var localized string MSG_Ghost;
var localized string MSG_Fly;
var localized string MSG_ChangeScore;
var localized string MSG_Spider;
var localized string MSG_Walk;
var localized string MSG_InvisOn;
var localized string MSG_InvisOff;
var localized string MSG_TempAdmin;
var localized string MSG_TempAdminOff;
var localized string MSG_ChangeName;
var localized string MSG_ChangeSize;
var localized string MSG_GiveItem;
var localized string MSG_Adrenaline;
var array<string> MSG_Help;
var localized string MSG_ReSpawned;
var localized string MSG_CantRespawn;
var xEmitter LeftTrail, RightTrail, HeadTrail;

var int NumDoubles;

// Added

var string Admin_Login;
var string LoggedInText,LoggedOutText;
var bool bLoginTimeCountdown;
var float LogoutTime;
var float AllowLoginTime;
var string SelectedTarget;

// Added from xban mutator

var array<string> strBanReason;
var array<string> strHelpLines;

//========================================================================================
// Really Crappy version of the admin.uc file to allow temp admins on single admin systems
//========================================================================================

function AdminEnter( PlayerController P, string Post)
{
	Log( P.PlayerReplicationInfo.PlayerName@"logged in as"@Post@"." );
	Level.Game.Broadcast( P, P.PlayerReplicationInfo.PlayerName@LoggedInText@Post@"." );
}

function AdminExit( PlayerController P )
{
	Log(P.PlayerReplicationInfo.PlayerName@"logged out.");
	Level.Game.Broadcast( P, P.PlayerReplicationInfo.PlayerName@LoggedOutText@".");
}

function DoLogin( string Username, string Password )
{
	local Mutator MyMut;

	Admin_Login = Username;
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
/*
	if ( AllowLoginTime > Level.TimeSeconds )
		return;
*/
	if ( !BMTAdminMut(MyMut).AllowLogin(Self) )
		return;

	if (Level.Game.AccessControl.AdminLogin(Outer, Username, Password))
	{
		bAdmin = true;
	    AdminEnter(Outer, BMTAdminMut(MyMut).GetAdminPost(self));
	}
/*
	if ( BMTAdminMut(MyMut).GetAdminTime(Self) > 0 )
	{
		LogoutTime = Level.TimeSeconds + float(BMTAdminMut(MyMut).GetAdminTime(Self));
		bLoginTimeCountdown = true;
	}
*/
}

function DoLoginSilent( string Username, string Password)
{
	local Mutator MyMut;

	Admin_Login = Username;
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
/*
	if ( AllowLoginTime > Level.TimeSeconds )
		return;
*/
	if ( !BMTAdminMut(MyMut).AllowLogin(Self) )
		return;
		
	if ( !BMTAdminMut(MyMut).SilentLoginEnabled(Self) )
		return;

	Super.DoLoginSilent(Username,Password);
/*
	if ( BMTAdminMut(MyMut).GetAdminTime(Self) > 0 )
	{
		LogoutTime = Level.TimeSeconds + float(BMTAdminMut(MyMut).GetAdminTime(Self));
		bLoginTimeCountdown = true;
	}
*/
}

function DoLogout()
{
	local Mutator MyMut;
	if (Level.Game.AccessControl.AdminLogout(Outer))
	{
		bAdmin = false;
		AdminExit(Outer);
		MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
		/*
		if ( BMTAdminMut(MyMut).GetAdminTime(Self) > 0 )
			AllowLoginTime = Level.TimeSeconds + float(BMTAdminMut(MyMut).GetLoginDelay(Self));
		*/
	}
}


/*
simulated function Tick(float DeltaTime)
{
/*
	if ( bLoginTimeCountdown )
	{
		if( LogoutTime < Level.TimeSeconds )
		{
			bLoginTimeCountdown = false;
			DoLogout();
		}
	}
*/
	Super.Tick(DeltaTime);
}
*/



exec function Kick(string Cmd, string Extra)
{
	local array<string> Params;
	local array<PlayerReplicationInfo> AllPRI;
	local Controller	C, NextC;
	local int i;

	local string 	strCmd;
	local string 	strNoob;
	local string 	strReasonId;
	local string	strReasonDescription;
	local Mutator MyMut;

	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( extra == "" )
		extra = SelectedTarget;


	if ( BMTAdminMut(MyMut).KickEnabled(Self) || BMTAdminMut(MyMut).BanEnabled(Self) )	// Kp = Kick, Kb = Kick/Ban
	{
		if (Cmd ~= "List")
		{
			// Get the list of players to kick by showing their PlayerID
			Level.Game.GameReplicationInfo.GetPRIArray(AllPRI);
			for (i = 0; i<AllPRI.Length; i++)
			{
				if( PlayerController(AllPRI[i].Owner) != none && AllPRI[i].PlayerName != "WebAdmin")
					ClientMessage(Right("   "$AllPRI[i].PlayerID, 3)$")"@AllPRI[i].PlayerName@" "$PlayerController(AllPRI[i].Owner).GetPlayerIDHash());
				else
					ClientMessage(Right("   "$AllPRI[i].PlayerID, 3)$")"@AllPRI[i].PlayerName);
			}
			return;
		}

		 // trying to normalize the expression

            if(Cmd ~= "Ban" || Cmd ~= "Session")
	      	Params = TokenizeString(Cmd@Extra);
	      else
	            Params = TokenizeString("kick"@Cmd@Extra);


		 if(Cmd ~= "Ban" || Cmd ~= "Session")
		 {
		 	if(Cmd ~= "Ban")
		 		strCmd = "ban ";
		 	else
		 		strCmd = "sess";

			if(Params.Length > 1)
			 	strNoob = Params[1];
			else
			{
				ClientMessage("XBanMutator: n00b expected. invalid command format");
				return;
			}
		 }
		 else
		 {
		 	strCmd = "kick";
		 	strNoob = Params[1];
		 }

		 // building reasonid and reason description.
		 // if id is missing  id = 0. if reason is missing : "no reason"
		 if(Params.Length > 2)
		 {
		 	if(IsNumeric(Params[2]))
		 	{
		 		strReasonId = Params[2];

		 		if(Params.Length > 3)
		 		{
		 			strReasonDescription =  buildString(Params,3);
		 		}
		 		else
		 		{
			 		strReasonDescription = strBanReason[int(strReasonId)];
		 		}
		 	}
		 	else
		 	{
		 		strReasonId = "5";
		 		strReasonDescription =   buildString(Params,2);
		 	}
		 }
		 else
		 {
		 	strReasonId = "0";
		 	strReasonDescription = "no reason provided";
		 }



		// go thru all Players
		for (C = Level.ControllerList; C != None; C = NextC)
		{
			NextC = C.NextController;

// debug
//			ClientMessage("+++ debug : " $ PlayerController(PlayerController(C).PlayerReplicationInfo.Owner).GetPlayerIDHash());
// end debug

			if (C != Owner && PlayerController(C) != None && C.PlayerReplicationInfo != None)
			{
					if ((IsNumeric(strNoob) && C.PlayerReplicationInfo.PlayerID == int(strNoob))
							|| MaskedCompare(C.PlayerReplicationInfo.PlayerName, strNoob))
					{
						if (Cmd ~= "Ban")
						{
							ClientMessage(Repl(Msg_PlayerBanned, "%Player%", C.PlayerReplicationInfo.PlayerName));
							Manager.BanPlayer(PlayerController(C));
							addToLog("ban ",C, strReasonId, strReasonDescription);
						}
						else if (Cmd ~= "Session")
						{
							ClientMessage(Repl(Msg_SessionBanned, "%Player%", C.PlayerReplicationInfo.PlayerName));
							Manager.BanPlayer(PlayerController(C), true);
							addToLog("sess",C, strReasonId, strReasonDescription);
						}
						else
						{
							Manager.KickPlayer(PlayerController(C));
							ClientMessage(Repl(Msg_PlayerKicked, "%Player%", C.PlayerReplicationInfo.PlayerName));
							addToLog("kick",C, strReasonId, strReasonDescription);
						}
						break;
					}
			}
		}
	}
}


exec function KickBan(string s)
{
	Kick("ban", s);
}

exec function Session(string s)
{
	Kick("Session", s);
}


exec function xList(string s)
{
	local int 	i;
	local array<string>	strarrTemp;

	for(i = 0; i < strBanReason.Length; i++)
  		strarrTemp[i] = "  " $ i $ " - " $  strBanReason[i];

	SendComplexMsg(strarrTemp , "default reason codes");

}


exec function KickHelp(string s)
{
	local int 	i;

	for(i = 0; i < strHelpLines.Length; i++)
		ClientMessage(strHelpLines[i]);

}


function bool addToLog(string strCmd, Controller cN00b, string strReasonCode, string strReasonDecription)
{
	// FILE FORMAT
	// atetime; admin name; map name; nOOb name; nOObid; kick/kickban/session; reson code;reason description;

	local string 	strDate, strAdmin, strMap, strNoobName, strNoobId;
	local string 	strStringBuilder;
	local FileLog	fileLog;
	local string 	strLogFileName;


	strDate 		= GetDate();
	strAdmin		= PlayerOwnerName;
	strMap 		= string(Level.Outer.name);
	strNoobName 	= cN00b.PlayerReplicationInfo.PlayerName;
	strNoobID		= PlayerController(cN00b).GetPlayerIDHash();

	strStringBuilder 	= strDate 				$ ";" $
					strAdmin 			$ ";" $
					strMap	 		$ ";" $
					strNoobName 		$ ";" $
					strNoobId 			$ ";" $
					strCmd			$ ";" $
					strReasonCode 		$ ";" $
					strReasonDecription	$ ";" ;


	//write to the file
	fileLog = spawn(class'FileLog');

	if(fileLog != None)
	{
		strLogFileName = "XBanMutator";

		fileLog.OpenLog(strLogFileName);
		fileLog.Logf(strStringBuilder);      		// log to XBanMutator.log
		fileLog.CloseLog();
		log("+++ XBanMutator: ##" @ strStringBuilder); 	// log to RedOrchestra.log
	}
	else
	{
  		log("++++ XBanMutator: XBanAdmin::addToLog(...) : Failed to create FileLog Object. Entry to write :" $ strStringBuilder);
  		ClientMessage("XBanMutator: could not write to the log. Entry written to RedOrchestra.log");
	}

	return true;
}


function string buildString(array<string> Params, optional int nStart)
{
	local int 		i;
	local string	strStringBuilder;

	strStringBuilder = "";

	// proofing params
	if(nStart < 1 || Params.Length < 1)
		return strStringBuilder;

	// building the string
	for(i = nStart; i < Params.Length ; i++)
		strStringBuilder =  strStringBuilder @ Params[i];

	return strStringBuilder;
}


function array<string> TokenizeString(string Params) // space delimited
{
	local array<string> splitted;
	local int p, start, i;

	i = 0;

	while (Params != "")
	{
		p = 0;

		while (Mid(Params, p, 1) == " ") p++;
		if (Mid(Params, p) == "")
			break;

		start = p;

		while (Mid(Params, p, 1) != "" && Mid(Params, p, 1) != " ")
			p++;

		splitted[i++] = Mid(Params, start, p-start);

		Params = Mid(Params, p);
	}
	return splitted;
}


function string GetDate()
{
	// returns current date in the format : yyyy.mm.dd hh:mm    <- easy to sort date format :P
	local string str;

	str = string(Level.Year) $ "." ;

	if(Level.Month < 10)
		str = str $ "0";

	str = str $ Level.Month $ ".";

	if(Level.Day < 10)
		str = str $ "0";

	str = str $ Level.Day $ " ";

	if(Level.Hour < 10)
		str = str $ "0";

	str = str $ Level.Hour $ ":";

	if(Level.Minute < 10)
		str = str $ "0";

	str = str $ Level.Minute;

	return str;

}

exec function RestartMap()
{
	local Mutator MyMut;

	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');

	if ( BMTAdminMut(MyMut).RestartMapEnabled(Self) )
		Super.RestartMap();
}

exec function NextMap()
{
	local Mutator MyMut;

	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');

	if ( BMTAdminMut(MyMut).NextMapEnabled(Self) )
		Super.NextMap();
}

exec function Map( string Cmd )
{
	local Mutator MyMut;

	if (Cmd ~= "Restart")
	{
		RestartMap();
	}
	else if (Cmd ~= "Next")
	{
		NextMap();
	}
	else if (Cmd ~= "List")
	{
		ShowCurrentMapList();
	}
	else
	{
		MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
		if ( BMTAdminMut(MyMut).SwitchEnabled(Self) )
			DoSwitch(Cmd);
	}
}

exec function Switch( string URL )
{
	local Mutator MyMut;
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	if ( BMTAdminMut(MyMut).SwitchEnabled(Self) )
		DoSwitch(URL);
}



function string ConvertIDToName(string ID)
{
	local Controller C;
	if ( Len(ID) == 1 || Len(ID) == 2 )
	{
		for( C = Level.ControllerList; C != None; C = C.nextController )
		{ 
			if( C.IsA('PlayerController') || C.IsA('xBot')) 
			{
				DebugMessage("PlayerID = "$string(PlayerController(C).PlayerReplicationInfo.PlayerID));
				if (ID == string(PlayerController(C).PlayerReplicationInfo.PlayerID))
					return PlayerController(C).PlayerReplicationInfo.PlayerName;
			}
		}
	}
	return ID;
}

exec function SetTarget(string target)
{
	SelectedTarget = ConvertIDToName(target);
}

exec function KillZeds()
{
	local Mutator MyMut;
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	if ( BMTAdminMut(MyMut).KillZedsEnabled(Self) )
		KFGameType(Level.Game).KillZeds();
}

function DropAllDroppable(pawn P, int Dur)
{
	local Inventory I;
	local int j;
	local DisarmingProj Proj;
	local Mutator myMut;

	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
	KFHumanPawn(P).MaxCarryWeight=1;
	for(j=0; j<20; j++)
		for ( I = P.Inventory; I != none; I = I.Inventory )
		{
			if ( KFWeapon(I) != none && !KFWeapon(I).bKFNeverThrow )
			{
				I.Velocity = P.Velocity;
				I.DropFrom(P.Location + VRand() * 1);
			}
			if ( KFWeapon(I) != none && KFWeapon(I).bKFNeverThrow )
			{
				P.DeleteInventory(I);
			}
		}
	Proj = Spawn(class'DisarmingProj');
	Proj.Stick(P,P.Location);
	if ( Dur < 1 )
		Dur = float(BMTAdminMut(MyMut).DisarmDuration);
	Proj.lifespan = Dur + 1.0;
}

exec function Disarm(string target, optional int Dur)
{
	local Mutator myMut;
    local Pawn p;
    local Controller C;
	
	target = ConvertIDToName(target);
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
    if(myMut != none) 
	{
    	if ( BMTAdminMut(myMut).DisarmEnabled(Self) )
		{
			if ( target == "" )
				target = SelectedTarget;
    		if (target == "all")
			{
          	  	for( C = Level.ControllerList; C != None; C = C.nextController )
				{
          	      	if( C.IsA('PlayerController') || C.IsA('xBot'))
					{
						C.Pawn.ClientMessage("You've been disarmed");
					  	ServerSay("Admin has disarmed all players.");
           				DropAllDroppable(C.Pawn,Dur);
          	  	  	}
          	  	}
          	  	return;
          	} 
			else if ( target == "" )
			{
				return;
			}
			else
			{
          		P = verifyTarget(target);
          		if (P == none)
				{
             		return;
           		}
				P.ClientMessage("You've been disarmed");
				ServerSay(P.PlayerReplicationInfo.PlayerName$" has been disarmed.");
          		DropAllDroppable(P,Dur);
       		}
        }
    }
}
/*
exec function Freeze(string target)
{
	local Mutator myMut;
    local Pawn p;
    local Controller C;
	local KFHumanPawn KFHP;
	local FreezingProj Proj;
	
	target = ConvertIDToName(target);
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
    if(myMut != none) 
	{
    	if ( BMTAdminMut(myMut).FreezeEnabled(Self) )
		{
			if ( target == "" )
				target = SelectedTarget;
    		if (target == "all")
			{
          	  	for( C = Level.ControllerList; C != None; C = C.nextController )
				{
          	      	if( C.IsA('PlayerController') || C.IsA('xBot'))
					{
						C.Pawn.ClientMessage("You've been freezed");
					  	ServerSay("Admin freezed all players.");
						KFHP = KFHumanPawn(C.Pawn);
						Proj = Spawn(class'FreezingProj');
						Proj.Stick(KFHP,KFHP.Location);
           				
          	  	  	}
          	  	}
          	  	return;
          	} 
			else if ( target == "" )
			{
				return;
			}
			else
			{
          		P = verifyTarget(target);
          		if (P == none)
				{
             		return;
           		}
				C.Pawn.ClientMessage("You've been freezed");
				ServerSay(P.PlayerReplicationInfo.PlayerName$" has been freezed.");
          		KFHP = KFHumanPawn(C.Pawn);
				Proj = Spawn(class'FreezingProj');
				Proj.Stick(KFHP,KFHP.Location);
       		}
        }
    }
}
*/

function SellWeapons(PlayerController PC, out int sum)
{
	local Inventory I,Deleted;
	local int InvQuantity;
	local Pawn P;
	local int ret;
	local int Limit;
	local BMTAdminMut MyMut;
	local class<KFWeaponPickup> KFWP;
	
	ret = KFPlayerReplicationInfo(PC.PlayerReplicationInfo).Score;
	InvQuantity = 0;
	P = PC.Pawn;
	I = P.Inventory;
	MyMut = BMTAdminMut(FindMut(Level.Game.BaseMutator, class'BMTAdminMut'));
	Limit = MyMut.ConfiscateWeaponMinimum;
	
	if ( !MyMut.bConfiscateSellWeapon )
	{
		sum = ret;
		return;
	}
		
	if ( MyMut.bConfiscateSellOnlyOnTrader && !KFGameType(Level.Game).bTradingDoorsOpen )
	{
		sum = ret;
		return;
	}
	
	while( I != None )
	{
		if ( Weapon(I) != None && !KFWeapon(I).bKFNeverThrow )
			++InvQuantity;
		I = I.Inventory;
	}
	
	I = P.Inventory;
	
	while ( InvQuantity > Limit && sum > ret )
	{
		if ( Weapon(I) != None && !KFWeapon(I).bKFNeverThrow )
		{
			//KFWP = KFWeapon(I).PickupClass;
			//ret += KFWeapon(I).PickupClass.default.cost * 0.75;
			Deleted = I;
			I = I.Inventory;
			P.DeleteInventory(Deleted);
			--InvQuantity;
		}
	}
	sum = ret;
}

exec function Confiscate(string target, optional string receiver, optional int sum)
{
	local Mutator myMut;
    local Pawn p;
    local Controller C;
	local int i;
	local Pawn Rec;
	
	target = ConvertIDToName(target);
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
    if(myMut != none) 
	{
    	if ( BMTAdminMut(myMut).ConfiscateEnabled(Self) )
		{
			if ( target == "" )
				target = SelectedTarget;
    		if (target == "all")
			{
          	  	return;
          	} 
			else if ( target == "" )
			{
				return;
			}
			else
			{
          		P = verifyTarget(target);
          		if (P == none)
				{
             		return;
           		}
				if ( receiver == "" || receiver == "all" )
				{
					if ( sum > KFPlayerReplicationInfo(PlayerController(P.Controller).PlayerReplicationInfo).Score || sum < 1 )
						sum = KFPlayerReplicationInfo(PlayerController(P.Controller).PlayerReplicationInfo).Score;

					i = -1;
					for( C = Level.ControllerList; C != None; C = C.nextController )
					{
						if( C.IsA('PlayerController') || C.IsA('xBot'))
						{
							i++;
						}
					}
					for( C = Level.ControllerList; C != None; C = C.nextController )
					{
						if( C.IsA('PlayerController') || C.IsA('xBot'))
						{
							if ( C.Pawn != P )
								KFPlayerReplicationInfo(PlayerController(C).PlayerReplicationInfo).Score +=
								sum / float(i);
						}
					}
					KFPlayerReplicationInfo(PlayerController(P.Controller).PlayerReplicationInfo).Score = 0;
					P.ClientMessage("Your money have been confiscated.");
					ServerSay(P.PlayerReplicationInfo.PlayerName$"'s money have been confiscated.");
				}
				else
				{
					Rec = verifyTarget(receiver);
					if( sum > KFPlayerReplicationInfo(PlayerController(P.Controller).PlayerReplicationInfo).Score )
					{
						SellWeapons(PlayerController(P.Controller),sum);
					}
					else if ( sum < 1 )
						sum = KFPlayerReplicationInfo(PlayerController(P.Controller).PlayerReplicationInfo).Score;
						
					KFPlayerReplicationInfo(PlayerController(P.Controller).PlayerReplicationInfo).Score = 0;
					KFPlayerReplicationInfo(PlayerController(Rec.Controller).PlayerReplicationInfo).Score += sum;
					P.ClientMessage("Your money have been confiscated.");
					ServerSay(P.PlayerReplicationInfo.PlayerName$"'s money have been confiscated.");
				}
			}
		}
	}
}

exec function AbortWave()
{
	local Mutator myMut;
	local KFGameType KFGT;
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
    if(myMut != none) 
	{
    	if ( BMTAdminMut(myMut).AbortWaveEnabled(Self) )
		{
			if ( KFGameType(Level.Game).bWaveInProgress )
			{
				KFGT = KFGameType(Level.Game);
				KFGT.KillZeds();
				KFGT.NumMonsters = 0;
				KFGT.TotalMaxMonsters = 0;
				AllMessage("Admin has aborted current wave");
			}
        }
    }
}

exec function SetNextWave(int Num)
{
	local Mutator myMut;
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
    if(myMut != none) 
	{
    	if ( BMTAdminMut(myMut).SetNextWaveEnabled(Self) )
		{
			if ( !KFGameType(Level.Game).bWaveInProgress )
			{
				KFGameType(Level.Game).WaveNum = Num+1;
				AllMessage("Admin has set next wave to " $ string(Num));
			}
		}
	}
}

exec function Anchor(string target, optional string saviorname)
{
	local Mutator myMut;
	local Controller C;
	local Pawn P,Savior;
	
	saviorname = ConvertIDToName(saviorname);
	target = ConvertIDToName(target);
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
    if(myMut != none) 
	{
    	if ( BMTAdminMut(myMut).AnchorEnabled(Self) )
		{
			if ( target == "" )
				target = SelectedTarget;
				
			if ( saviorname == "" )
				saviorname = "self";
				
			Savior = verifyTarget(saviorname);
			
			if ( target == "all" )
			{
				for( C = Level.ControllerList; C != None; C = C.nextController )
				{
          	      	if( C.IsA('PlayerController') || C.IsA('xBot'))
					{
						C.Pawn.SetLocation(Savior.Location + VRand() * 120);
						C.Pawn.ClientMessage("You've been anchored to admin.");
          	  	  	}
          	  	}
				ServerSay("Admin anchored all players to him.");
			}
			else if ( target == "" )
			{
				return;
			}
			else
			{
				P = VerifyTarget(target);
				Savior = VerifyTarget(saviorname);
				P.SetLocation(Savior.Location + VRand() * 120);
				P.ClientMessage("You've been anchored to "$Savior.PlayerReplicationInfo.PlayerName);
				ServerSay(P.PlayerReplicationInfo.PlayerName$" has been anchored to "$Savior.PlayerReplicationInfo.PlayerName);
			}
			
		}
	}
}

exec function SetTraderTime(int Time)
{
	local Mutator MyMut;
	local KFGameType KFGT;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( BMTAdminMut(myMut).SetTraderTimeEnabled(Self) )
	{
		KFGT = KFGameType(Level.Game);
		KFGT.WaveCountDown = Time;
	}
}

exec function ConfigurableSummon( string ClassName, optional string target, optional int HitPoints, optional int HeadHitPoints, optional int Speed,
								  optional int MeleeDamage, optional int ScreamDamage, optional int BleedOutDur )
{
	local class<actor> NewClass;
	local vector SpawnLoc;
	local Mutator myMut;
	local Pawn p;
	local KFMonster Mon;
	local Actor A;
	local int i;

    p = verifyTarget(target);
	
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none)
	{
        if (BMTAdminMut(myMut).ConfigurableSummonEnabled(Self))
		{
        	log( "Fabricate " $ ClassName );
			NewClass = class<actor>( DynamicLoadObject( ClassName, class'Class' ) );
        	if( NewClass!=None )
        	{
        		if ( P != None )
        			SpawnLoc = P.Location;
        		else
        			SpawnLoc = Location;
        		A = Spawn( NewClass,,,SpawnLoc + 72 * Vector(Rotation) + vect(0,0,1) * 15 );
				if ( A.IsA('KFMonster') )
				{
					Mon = KFMonster(A);
					if ( HitPoints > 0 )
					{
						Mon.health = HitPoints;
						Mon.healthmax = HitPoints;
					}
					if ( HeadHitPoints > 0 )
						Mon.headhealth = HeadHitPoints;
					if ( Speed > 0 )
					{
						Mon.GroundSpeed = float(Speed);
						Mon.WaterSpeed = float(Speed);
					}
					if ( MeleeDamage > 0 )
						Mon.MeleeDamage = MeleeDamage;
					if ( ScreamDamage > 0 )
						Mon.ScreamDamage = ScreamDamage;
					if ( BleedOutDur > 0 )
						Mon.BleedOutDuration = BleedOutDur;
				}
        	}
    	}
	}
}

exec function StunZeds(optional int Dur)
{
	local Mutator MyMut;
	local Controller C;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	log("StunZeds called");
	
	if ( true )// (BMTAdminMut(MyMut).StunZedsEnabled(Self) )
	{
		for( C = Level.ControllerList; C != None; C = C.nextController )
		{
           	if( C.IsA('KFMonsterController') )
			{		
				KFMonsterController(C).GotoState('NoGoal');
				KFMonsterController(C).Pawn.Acceleration=vect(0,0,0);
			}
		}
	}
}

exec function UnStunZeds()
{
	local Controller C;
	local Mutator MyMut;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( true )// (BMTAdminMut(MyMut).StunZedsEnabled(Self) )
	{
		for( C = Level.ControllerList; C != None; C = C.nextController )
		{
           	if( C.IsA('KFMonsterController') )
			{		
				KFMonsterController(C).GotoState('Hunting');				
			}
		}
	}
}
/*
exec function GiveWeap(string target, string weap)
{
	local Mutator MyMut;
	local Controller C;
	local Pawn P;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( BMTAdminMut(MyMut).GiveWeapEnabled(Self) )
	{
		if ( target == "" )
			target = SelectedTarget;
		if ( target == "all" )
		{
			for( C = Level.ControllerList; C != None; C = C.nextController )
			{
				if( C.IsA('PlayerController') || C.IsA('xBot'))
				{
					C.Pawn.GiveWeapon(weap);
					AllMessage("Admin has given weapon to all players.");
				}
			}
		}
		else if ( target == "" )
		{
			return;
		}
		else
		{
			P = VerifyTarget(target);
			if ( P != none )
			{
				P.GiveWeapon(weap);
				P.ClientMessage("Admin has given weapon to " $ P.Controller.PlayerReplicationInfo.PlayerName);
			}
		}
	}
}
*/
function FullAmmo (Pawn P)
{
	local Inventory Inv;
	
	for( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory )
	if ( Weapon(Inv)!=None )
	{
		Weapon(Inv).MaxOutAmmo();
	}
}

exec function RestoreAmmo(string target)
{
	local Mutator MyMut;
	local Controller C;
	local Pawn P;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( BMTAdminMut(MyMut).RestoreAmmoEnabled(Self) )
	{
		if ( target == "" )
			target = SelectedTarget;
		if ( target == "all" )
		{
			for( C = Level.ControllerList; C != None; C = C.nextController )
			{
				if( C.IsA('PlayerController') || C.IsA('xBot'))
				{
					FullAmmo(C.Pawn);
					AllMessage("Admin has restored ammo to everyone.");
				}
			}
		}
		else if ( target == "" )
		{
			return;
		}
		else
		{
			P = VerifyTarget(target);
			if ( P != none )
			{
				FullAmmo(P);
				P.ClientMessage("Admin has restored" $ P.Controller.PlayerReplicationInfo.PlayerName $ "'s ammo.");
			}
		}
	}
}

exec function NoCollision(string target)
{
	local Mutator MyMut;
	local Controller C;
	local Pawn P;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( BMTAdminMut(MyMut).NoCollisionEnabled(Self) )
	{
		if ( target == "" )
			target = SelectedTarget;
		if ( target == "all" )
		{
			for( C = Level.ControllerList; C != None; C = C.nextController )
			{
				if( C.IsA('PlayerController') || C.IsA('xBot'))
				{
					C.Pawn.bBlockActors = false;
					AllMessage("Admin has turned collision off to all players.");
				}
			}
		}
		else if ( target == "" )
		{
			return;
		}
		else
		{
			P = VerifyTarget(target);
			if ( P != none )
			{
				P.bBlockActors = false;
				P.ClientMessage("Admin has turned" $ P.Controller.PlayerReplicationInfo.PlayerName $ "'s collision off.");
			}
		}
	}
}

exec function Collision(string target)
{
	local Mutator MyMut;
	local Controller C;
	local Pawn P;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( BMTAdminMut(MyMut).NoCollisionEnabled(Self) )
	{
		if ( target == "" )
			target = SelectedTarget;
		if ( target == "all" )
		{
			for( C = Level.ControllerList; C != None; C = C.nextController )
			{
				if( C.IsA('PlayerController') || C.IsA('xBot'))
				{
					C.Pawn.bBlockActors = true;
					AllMessage("Admin has turned collision on to all players.");
				}
			}
		}
		else if ( target == "" )
		{
			return;
		}
		else
		{
			P = VerifyTarget(target);
			if ( P != none )
			{
				P.bBlockActors = true;
				P.ClientMessage("Admin has turned" $ P.Controller.PlayerReplicationInfo.PlayerName $ "'s collision on.");
			}
		}
	}
}

function NullAmmo(Pawn P)
{
	local Inventory Inv;
	
	for( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory )
	if ( Weapon(Inv)!=None )
	{
		Weapon(Inv).ConsumeAmmo(0,10000,true);
		Weapon(Inv).ConsumeAmmo(1,10000,true);
	}
}

exec function RemoveAmmo(string target)
{
	local Mutator MyMut;
	local Controller C;
	local Pawn P;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( BMTAdminMut(MyMut).RemoveAmmoEnabled(Self) )
	{
		if ( target == "" )
			target = SelectedTarget;
		if ( target == "all" )
		{
			for( C = Level.ControllerList; C != None; C = C.nextController )
			{
				if( C.IsA('PlayerController') || C.IsA('xBot'))
				{
					NullAmmo(C.Pawn);
					AllMessage("Admin has removed everyone's ammo.");
				}
			}
		}
		else if ( target == "" )
		{
			return;
		}
		else
		{
			P = VerifyTarget(target);
			if ( P != none )
			{
				NullAmmo(P);
				P.ClientMessage("Admin has removed" $ P.Controller.PlayerReplicationInfo.PlayerName $ "'s ammo.");
			}
		}
	}
}

// Сокращения

exec function ST(string target)
{
	SetTarget(target);
}

exec function KZ()
{
	KillZeds();
}

exec function DA(string target, optional int Dur)
{
	Disarm(target,dur);
}

exec function Conf(string target, optional string receiver, optional int sum)
{
	Confiscate(target,receiver,sum);
}

exec function Abort()
{
	AbortWave();
}

exec function NextW(int Num)
{
	SetNextWave(Num);
}

exec function STT(int Time)
{
	SetTraderTime(Time);
}

exec function CS( string ClassName, optional string target, optional int HitPoints, optional int HeadHitPoints, optional int Speed,
								  optional int MeleeDamage, optional int ScreamDamage, optional int BleedOutDur )
{
	ConfigurableSummon(ClassName,target,HitPoints,HeadHitPoints,Speed,MeleeDamage,ScreamDamage,BleedOutDur);
}

exec function SZ(optional int Dur)
{
	StunZeds(Dur);
}

exec function SZOff()
{
	UnStunZeds();
}

exec function ResA(string target)
{
	RestoreAmmo(target);
}

exec function NoCol(string target)
{
	NoCollision(target);
}

exec function Col(string target)
{
	Collision(target);
}

exec function RemA(string target)
{
	RemoveAmmo(target);
}

function AllMessage(string Mes)
{
	local Controller C;

	for( C = Level.ControllerList; C != None; C = C.nextController )
	{
        if( C.IsA('PlayerController') || C.IsA('xBot'))
		{
			C.Pawn.ClientMessage(Mes);
        }
    }
}

function DebugMessage(string Mes)
{
	local Mutator MyMut;
	
	MyMut = FindMut(Level.Game.BaseMutator, class'BMTAdminMut');
	
	if ( !BMTAdminMut(MyMut).bDebug )
		return;

	AllMessage(mes);
}

//=======================================================
//finds the mutator of a given class starting from the given Mutator
//original text from admincheats
function Mutator findMut(Mutator M, class MC){
   if (M.Class ==  MC)
      return M;
   else if (M != None)
              return findMut(M.NextMutator,MC);
        else
            return None;
}

//Gives back the Pawn associated with a player name 
function Pawn findPlayerByName(string PName)
{ 
   	local Controller C; 
   	local int namematch;
	
	if ( Caps(PName) == "SELF" )
	{
		DebugMessage("comparison started. " $ "PlayerName =" $ PlayerReplicationInfo.PlayerName);
		PName = Self.PlayerReplicationInfo.PlayerName;
		return Self.Pawn;
	}
	
	PName = ConvertIDToName(PName);
        
   	for( C = Level.ControllerList; C != None; C = C.nextController )
	{ 
    	if( C.IsA('PlayerController') || C.IsA('xBot')) 
		{
        	If (Len(C.PlayerReplicationInfo.PlayerName) >= 3 && Len(PName) < 3) {
            	Log("Must be longer than 3 characters");
           	} else {
           		namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(PName)); 
              	if (namematch >=0) { 
                	return C.Pawn; 
           		}
        	}
     	} 
    } 
    return none;
}

//Verify that the target of our functions exists
//If no target is specified, apply the function to ourselves
//original text from admincheats
function Pawn verifyTarget(string target)
{
    local Pawn p;
	
    p = findPlayerByName(target);
       if (p == None)
          ClientMessage(target $" is not currently in the game." );
       return p;
}

//Verify that the target of our functions exists
//If no target is specified, apply the function to ourselves
//original text from admincheats
function Controller verifyCont(string target)
{
	local Controller C;
	local int namematch;
	
	target = ConvertIDToName(target);
	
	if (target == ""){
       return c;
    }else{
    	for( C = Level.ControllerList; C != None; C = C.nextController ) {
       		if( C.IsA('PlayerController') || C.IsA('xBot')) {
       			namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
        		if (namematch < 0) { 
          			ClientMessage(target $" is not currently in the game." );
       				return C;
          		}
       		}
    	} 
	}
}

//================================================
//Make Target a Temp Admin
exec function TempAdmin(string target){
	local Mutator myMut;
    local Controller C; 
    local int namematch;
    local Pawn p;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    
    if (myMut != none) {
    	if (BMTAdminMut(myMut).TempAdminEnabled(Self)) {
          	
          	if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  		  	if (C.playerreplicationinfo.bAdmin != TRUE){
          	  		  		PlayerController(C).ClientMessage(MSG_TempAdmin);
          	  		  		C.playerreplicationinfo.bAdmin = true;
          	  		  		if (pawn != none){
          	  		  			C.Pawn.PlayTeleportEffect(true, true);
          	  		  		}
                      	}
          	  	  	}
          	  	}
          	  	return;
          	} else if (target == ""){
          		P = verifyTarget(target);
        		P.ClientMessage(MSG_TempAdmin);
        		P.PlayTeleportEffect(true, true);
                p.playerreplicationinfo.bAdmin = true;
        		return;
        	} else {
        		
        		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					PlayerController(C).ClientMessage(MSG_TempAdmin);
          	  		  		C.playerreplicationinfo.bAdmin = true;
          	  		  		if (pawn != none){
          	  		  			C.Pawn.PlayTeleportEffect(true, true);
          	  		  		}
          				}
          			}
          		}
				return;
       		}
   		}
	}
}

//================================================
//Remove Target Temp Admin abilities
exec function TempAdminOff(string target){
    local Mutator myMut;
    local Controller C;
    local string A;
    local int i;
	local int namematch;
	local int adminmatch;
	local Pawn p;
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none) {
    	if (BMTAdminMut(myMut).TempAdminEnabled(Self)) {
          	
          	if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  			for (i = 0; i < class'BMTAdminMut'.default.SuperAdmin.Length; i++) {
          	  				A = (class'BMTAdminMut'.default.SuperAdmin[i]);
  		  	  				adminmatch = InStr( Caps(A), Caps(C.PlayerReplicationInfo.PlayerName));
  		  	  				if (adminmatch >=0) { 
          	    				ClientMessage("~AdminPlus: Trying to Disable a SuperAdmin is not allowed");
          	  				} else {
          	  					PlayerController(C).ClientMessage(MSG_TempAdminOff);
		  	  					C.playerreplicationinfo.bAdmin = false;
		  	  					if (pawn != none){
          	  		  			C.Pawn.PlayTeleportEffect(true, true);
          	  		  			}
		  	  				}
		  	  			}
          	  	  	}
          	  	}
          	  	return;
          	} else if (target == ""){
          		P = verifyTarget(target);
        		P.ClientMessage("Use AdminLogout to exit Admin mode");
		  	  	//P.playerreplicationinfo.bAdmin = false;
        		return;
        	} else {
           		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					for (i = 0; i < class'BMTAdminMut'.default.SuperAdmin.Length; i++) {
          	  					A = (class'BMTAdminMut'.default.SuperAdmin[i]);
  		  	  					adminmatch = InStr( Caps(A), Caps(C.PlayerReplicationInfo.PlayerName));
  		  	  					if (adminmatch >=0) { 
          	    					ClientMessage("~AdminPlus: Trying to Disable a SuperAdmin is not allowed!");
          	    					//return;
          	    				}
          	  				}		
          	  				PlayerController(C).ClientMessage(MSG_TempAdminOff);
		  	  				C.playerreplicationinfo.bAdmin = false;
		  	  				if (pawn != none){
          	  		  			C.Pawn.PlayTeleportEffect(true, true);
          	  		  		}
          				}
          			}
          		}
       		}
   	}
	}
}

//Slap that guys bothering you and do 1 point of damage from him
exec function Slap(string target){
	local Mutator myMut;
    local Pawn p;
    local Controller C;
    //local int i;
	local int namematch;
	local int iSlapDmg;
	//local int iMom;
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).SlapEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
    		iSlapDmg = (class'BMTAdminMut'.default.iSlapDamage);
    		//iMom = (class'BMTAdminMut'.default.iMomentum);
    		if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  		  	C.Pawn.ClientMessage("You've been Pimp slapped");
					  	ServerSay(Pawn.PlayerReplicationInfo.PlayerName$ " PimpSlaps " $ C.PlayerReplicationInfo.PlayerName $ " like a bitch!");
           				//Slap... but don't kill
           				if (C.Pawn.Health > 1){
           					C.Pawn.TakeDamage(iSlapDmg,Pawn,Vect(100000,100000,100000),Vect(100000,100000,100000),class'DamageType');
           					C.Pawn.PlayTeleportEffect(true, true);
           				}
          	  	  	}
          	  	}
          	  	return;
          	} else if (target == ""){
        		P = verifyTarget(target);
        		P.ClientMessage("You've been Pimp slapped!");
				ServerSay(Pawn.PlayerReplicationInfo.PlayerName$ " PimpSlaps Himself like a bitch!");
           		//Slap... but don't kill
           		if (P.Health > 1){
           			P.TakeDamage(iSlapDmg,Pawn,Vect(100000,100000,100000),Vect(100000,100000,100000),class'DamageType');
           			P.PlayTeleportEffect(true, true);
           		}
        		return;
        	} else {
          		P = verifyTarget(target);
          		if (P == none){
             		return;
           		}
          		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					C.Pawn.ClientMessage("You've been Pimp slapped!");
					  		ServerSay(Pawn.PlayerReplicationInfo.PlayerName$ " PimpSlaps " $ C.Pawn.PlayerReplicationInfo.PlayerName $ " like a bitch!");
           					//Slap... but don't kill
           					if (C.Pawn.Health > 1){
           						C.Pawn.TakeDamage(iSlapDmg,Pawn,Vect(100000,100000,100000),Vect(100000,100000,100000),class'DamageType');
           						C.Pawn.PlayTeleportEffect(true, true);
           					}
          				}
          			}
          		}
       		}
        }
    }
}

//================================================
//Change Player's Name
exec function ChangeName(string target, string NewName){
    local Mutator myMut;
	local Controller C;
	local int namematch;
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none) {
    	if (BMTAdminMut(myMut).ChangeNameEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
        	if (NewName != ""){
        		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					PlayerController(C).ClientMessage(MSG_ChangeName);
							C.playerreplicationinfo.PlayerName = NewName;
          				}
          			}
          		}
          	} else {
          		ClientMessage("You must enter a new name for the player");
          	}
        }
    }
}
//Change Player's Name
//================================================
function ReSpawnRoutine(PlayerController C)
{
	if (C.PlayerReplicationInfo != None && !C.PlayerReplicationInfo.bOnlySpectator && C.PlayerReplicationInfo.bOutOfLives)
	{
		Level.Game.Disable('Timer');
		C.PlayerReplicationInfo.bOutOfLives = false;
		C.PlayerReplicationInfo.NumLives = 0;
		C.PlayerReplicationInfo.Score = Max(KFGameType(Level.Game).MinRespawnCash, int(C.PlayerReplicationInfo.Score));
		C.GotoState('PlayerWaiting');
		C.SetViewTarget(C);
		C.ClientSetBehindView(false);
		C.bBehindView = False;
		C.ClientSetViewTarget(C.Pawn);
		Invasion(Level.Game).bWaveInProgress = false;
		C.ServerReStartPlayer();
		Invasion(Level.Game).bWaveInProgress = true;
		Level.Game.Enable('Timer');
		C.ClientMessage(MSG_ReSpawned);
	}
}

function ReSpawnRoutine2(PlayerController C, Controller Savior)
{
	local vector SpawnLoc;

	if (C.PlayerReplicationInfo != None && !C.PlayerReplicationInfo.bOnlySpectator && C.PlayerReplicationInfo.bOutOfLives)
	{
		C.Level.Game.Disable('Timer');
		C.PlayerReplicationInfo.bOutOfLives = false;
		C.PlayerReplicationInfo.NumLives = 0;
		C.PlayerReplicationInfo.Score = Max(KFGameType(C.Level.Game).MinRespawnCash, int(C.PlayerReplicationInfo.Score));
		C.GotoState('PlayerWaiting');
		C.SetViewTarget(C);
		C.ClientSetBehindView(false);
		C.bBehindView = False;
		C.ClientSetViewTarget(C.Pawn);
		Invasion(C.Level.Game).bWaveInProgress = false;
		C.ServerReStartPlayer();
		Invasion(C.Level.Game).bWaveInProgress = true;
		C.Level.Game.Enable('Timer');
		SpawnLoc = vect(0,0,0);
		SpawnLoc.X = 80 - FRand() * 160;
		SpawnLoc.Y = 80 - FRand() * 160;
		SpawnLoc = SpawnLoc + Savior.Pawn.Location;
		SpawnLoc.Z += 20;
		C.Pawn.SetLocation(SpawnLoc);
	}
}

//================================================
exec function ReSpawn(string target, string savior)
{
    local Mutator myMut;
	local Controller C;
	local int namematch;
	local PlayerController Sv;
		
	log("ReSpawn"@target@savior);
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdmin.BMTAdminMut');
    if (true) // ( BMTAdminMut(myMut).RespawnEnabled(Self) )
	{		
		if(target=="" || savior=="")
		{
			log("MISSED RESPAWN PARAMS");
			return;
		}
		
		for( C = Level.ControllerList; C != None; C = C.nextController )
		{
			if( C.IsA('PlayerController'))
			{
				if(C.PlayerReplicationInfo.PlayerName~=savior)
				{
					if(C.Pawn==none)
					{
						log("SAVIOUR DEAD");
						return;
					}
					else
					{
						Sv = PlayerController(C);
						break;
					}
				}
			}
		}
		
		if(Sv==None)
		{
			log("SAVIOR NOT FOUND!");
			return;
		}
		
		for( C = Level.ControllerList; C != None; C = C.nextController )
		{
			if( C.IsA('PlayerController') || C.IsA('xBot') )
			{
				if (C.PlayerReplicationInfo.PlayerName~=target)
				{
					if(C.Pawn!=none)
					{
						log("TARGET ALIVE");
						return;
					}
					else
					{
						ReSpawnRoutine2(PlayerController(C), Sv);
						break;
					}
				}
			}
		}
		
		if(C==None)
		{
			log("TARGET NOT FOUND!");
			return;
		}
    }
}
//================================================
//Send a Private Message to a player
exec function PrivMessage(string target, string APMessage){
    local Mutator myMut;
	local Controller C;
	local int namematch;
	local int v;
	local Pawn P;
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none) {
    	if (BMTAdminMut(myMut).PrivMessageEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
        	v = 0;
        	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    if( C.IsA('PlayerController') || C.IsA('xBot')) 
				{
          			P = VerifyTarget(target);
          			v++;
          			PlayerController(P.Controller).ClientMessage("Private Message from Admin: "$APMessage);
          		}
          	}
          	if (v == 0){
          			ClientMessage(target$" is not in the game");
          	}
        }
    }       
}

exec function PM (string target, String PMMessage){
	PrivMessage(target, PMMessage);
}
exec function GI (string item, String ItemName){
	GiveItem(item, ItemName);
}
exec function CN (string target, String NewName){
	ChangeName(target, NewName);
}
exec function SG ( float gr){
	SetGravity(gr);
}
exec function CL1 ( string target ){
	CustomLoaded1(target);
}
exec function CL2 ( string target ){
	CustomLoaded2(target);
}
exec function CL3 ( string target ){
	CustomLoaded3(target);
}

//================================================
//Change Player's Head Size
exec function HeadSize(string target,float newHeadSize){
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none) {
       	if (BMTAdminMut(myMut).ChangeSizeEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
          	if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  		  	if(pawn != none){
          	  		  		C.Pawn.ClientMessage(MSG_ChangeSize);
					  		C.Pawn.headscale = newHeadSize;
					  		C.Pawn.PlayTeleportEffect(true, true);
					  	}
          	  	  	}
          	  	}
          	  	return;
          	} else if (target == ""){
        		P = verifyTarget(target);
        		P.ClientMessage(MSG_ChangeSize);
        		P.PlayTeleportEffect(true, true);
				P.headscale = newHeadSize;
        		return;
        	} else {
          		P = verifyTarget(target);
          		if (P == none){
             		return;
           		}
          		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					if(pawn != none){
          						C.Pawn.ClientMessage(MSG_ChangeSize);
								C.Pawn.headscale = newHeadSize;
								C.Pawn.PlayTeleportEffect(true, true);
					  		}
          				}
          			}
          		}
       		}
   		}
	}
}



//================================================
//Change Player's Size
exec function PlayerSize(string target,float newPlayerSize)
{
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;
    local float oldsize;
	
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none) 
	{
       	if (BMTAdminMut(myMut).ChangeSizeEnabled(Self))
		{
         	if ( target == "" )
				target = SelectedTarget;
         	oldsize = C.Pawn.DrawScale;
         	if (newPlayerSize == 0 || newPlayerSize > 5)
			{
         		ClientMessage("PlayerSize Cannot be 0 or greater than 5, causes game to crash");
         		return;
         	}
          	
          	if (target == "all") 
			{
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) 
				{
          	      	if( C.IsA('PlayerController') || C.IsA('xBot')) 
					{
          	  		  	if ((newPlayerSize < oldsize) || (oldsize == 0))
						{
         					C.Pawn.SetDrawScale((P.DrawScale * 0) + 1);
         				}
					  	if (C.pawn != none)
						{	
					  		C.Pawn.SetDrawScale(C.Pawn.DrawScale * newPlayerSize);
							C.Pawn.SetCollisionSize(C.Pawn.CollisionRadius * newPlayerSize, C.Pawn.CollisionHeight * newPlayerSize);
							C.Pawn.BaseEyeHeight *= newPlayerSize;
							C.Pawn.EyeHeight     *= newPlayerSize;
							C.Pawn.PlayTeleportEffect(true, true);
							//C.Pawn.bCanCrouch = False;
							//C.Pawn.CrouchHeight  *= newPlayerSize;
							//C.Pawn.CrouchRadius  *= newPlayerSize;
						}
          	  	  	}
          	  	}
          	  	return;
          	} 
			else if (target == "")
			{
				return;
        	} 
			else 
			{
          		P = verifyTarget(target);
          		if (P == none)
				{
             		return;
           		}
          		
          		P.ClientMessage(MSG_ChangeSize);
				if ((newPlayerSize < oldsize) || (oldsize == 0))
				{
         			P.SetDrawScale((P.DrawScale * 0) + 1);
         		}
				P.SetDrawScale(C.Pawn.DrawScale * newPlayerSize);
				P.SetCollisionSize(C.Pawn.CollisionRadius * newPlayerSize, C.Pawn.CollisionHeight * newPlayerSize);
				P.BaseEyeHeight *= newPlayerSize;
				P.EyeHeight     *= newPlayerSize;
				P.PlayTeleportEffect(true, true);			
       		}
   		}
	}
}


//================================================
//Put Target In God Mode
exec function GodOn(string target)
{
    local Mutator myMut;
    local Controller C;
    local int namematch;
	local Pawn P;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none) 
	{
       	if (BMTAdminMut(myMut).GodEnabled(Self))
		{
          	if ( target == "" )
				target = SelectedTarget;
          	if (target == "all") 
			{
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController') || C.IsA('xBot'))
					{
          	  		  	C.bGodMode = true;
                		PlayerController(C).ClientMessage(MSG_GodOn);
                		C.Pawn.PlayTeleportEffect(true, true);
          	  	  	}
          	  	}
          	  	ServerSay("Everyone is in God mode");
          	  	return;
          	}
			else if (target == "")
			{
        		target = PlayerReplicationInfo.PlayerName;
				Self.bGodMode = true;
          		Self.ClientMessage(MSG_GodOn);
                Self.Pawn.PlayTeleportEffect(true, true);
                return;
            }
			else
			{
          		P = verifyTarget(target);
				if ( P != none )
				{
				}
				else
				{
					return;
				}
          		PlayerController(P.Controller).bGodMode = true;
                PlayerController(P.Controller).ClientMessage(MSG_GodOn);
                P.PlayTeleportEffect(true, true);
                ServerSay(C.PlayerReplicationInfo.PlayerName$ " is in God mode");
       		}
   		}
	}
}

//Take Target Out Of God Mode
exec function GodOff(string target){
    local Mutator myMut;
    local Controller C;
    local int namematch;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none) {
       	if (BMTAdminMut(myMut).GodEnabled(Self))
		{
          	if ( target == "" )
				target = SelectedTarget;
          	if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  			C.bGodMode = false;
                		PlayerController(C).ClientMessage(MSG_GodOff);
                		C.Pawn.PlayTeleportEffect(true, true);
          	  	  	}
          	  	}
          	  	ServerSay("All Players are out of God Mode");
          	  	return;
          	} else if (target == ""){
           		target = PlayerReplicationInfo.PlayerName;
          		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          			namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          			if (namematch >=0) {
		       			C.bGodMode = false;
                		PlayerController(C).ClientMessage(MSG_GodOff);
                		C.Pawn.PlayTeleportEffect(true, true);
                	}
                }
                ServerSay(target$ " is out of God mode");
        		return;
        	} else {          
          		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					if ( C.bGodMode == false){
       							return;
          					}
          					C.bGodMode = false;
                			PlayerController(C).ClientMessage(MSG_GodOff);
                			ServerSay(C.PlayerReplicationInfo.PlayerName$ " is out of God Mode");
                			C.Pawn.PlayTeleportEffect(true, true);
          				}
          			}
          		}
       		}
   		}
	}
}


//================================================
//Change a Player's Score
exec function ChangeScore(string target, float newScoreValue){
    local Mutator myMut;
    local Controller C;
    local int namematch;
	
	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none) {
       	if (BMTAdminMut(myMut).ChangeScoreEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
          	if (newScoreValue < 0){
          		ClientMessage("You must enter a New Positive Score");
          		return;
          	}
          	if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  		  	C.PlayerReplicationInfo.Score = newScoreValue;
          	  		  	PlayerController(C).ClientMessage(MSG_ChangeScore);
          	  	  	}
          	  	}
          	  	ServerSay("All Scores have been set to "$newScoreValue);
          	  	return;
          	} else if (target == ""){
        		target = PlayerReplicationInfo.PlayerName;
          		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          			namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          			if (namematch >=0) {
		       			C.PlayerReplicationInfo.Score = newScoreValue;
                		PlayerController(C).ClientMessage(MSG_ChangeScore);
                		ServerSay(target$ "'s Score has been set to "$newScoreValue);
                	}
                }
        		return;
        	} else {
          		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					C.PlayerReplicationInfo.Score = newScoreValue;
                			PlayerController(C).ClientMessage(MSG_ChangeScore);
                			ServerSay(C.PlayerReplicationInfo.PlayerName$ "'s Score has been set to "$newScoreValue);
          				}
          			}
          		}
       		}
   		}
	}
}

exec function ResetScore (string target)
{
	ChangeScore(target, 0.0);
}

//=================================================
exec function SloMo( float T ){
    local Mutator myMut;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).SloMoEnabled(Self))
		{
	    	ServerSay("Game Speed has been set to "$T);
	    	ClientMessage("Use 'Slomo 1' to return to normal");
	    	Level.Game.SetGameSpeed(T);
	    	
		}
    }
}

//=================================================
exec function SetGravity( float F ){
    local Mutator myMut;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).SetGravityEnabled(Self)) 
		{
			ServerSay("Gravity has been set to "$F);
	    	ClientMessage("Use 'SetGrav -950' to return to normal");
			PhysicsVolume.Gravity.Z = F;
        }
    }
}

//================================================
//Make Target Invisible
exec function InvisOn(string target, optional float invamount){
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;
	
	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).InvisEnabled(Self)) 
		{
       		if ( target == "" )
				target = SelectedTarget;
       		if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	       	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  		  	C.Pawn.bHidden = true;
						C.Pawn.Visibility = invamount;
        				C.Pawn.ClientMessage(MSG_InvisOn);
          	  	  	}
          	  	}
          	  	return;
         	} else if (target == ""){
        		P = verifyTarget(target);
        		P.bHidden = true;
				P.Visibility = invamount;
        		P.ClientMessage(MSG_InvisOn);
        		return;
        	} else {	
         		P = verifyTarget(target);
         		if (P == none){
             		return;
           		}
         		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					C.Pawn.bHidden = true;
							C.Pawn.Visibility = invamount;
        					C.Pawn.ClientMessage(MSG_InvisOn);
          				}
          			}
          		}
    		}
    	}
	}
}

//================================================
//Make Target Able To Be Seen (Undo Invisibility)
exec function InvisOff(string target){
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;

	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).InvisEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
			if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  		  	C.Pawn.bHidden = false;
						C.Pawn.Visibility = C.Pawn.default.visibility;
        				C.Pawn.ClientMessage(MSG_InvisOff);
          	  	  	}
          	  	}
          	  	return;
        	} else if (target == ""){
        		P = verifyTarget(target);
        		P.bHidden = false;
				P.Visibility = P.default.visibility;
        		P.ClientMessage(MSG_InvisOff);
        		return;
        	} else {
	       		P = verifyTarget(target);
	       		if (P == none){
             		return;
           		}
	       		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					C.Pawn.bHidden = false;
							C.Pawn.Visibility = C.Pawn.default.visibility;
        					C.Pawn.ClientMessage(MSG_InvisOff);
          				}
          			}
          		}
    		}
  		}
	}
}

//================================================
//Put Target In Ghost Mode
exec function Ghost(string target){
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none){
    	if (BMTAdminMut(myMut).GhostEnabled(Self))
		{
        	if ( target == "" )
				target = SelectedTarget;
        	if (target == "all"){
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ){
          	      	if( C.IsA('PlayerController')) {
          	  		  	C.Pawn.bAmbientCreature=true;
        				C.Pawn.UnderWaterTime = -1.0;
						C.Pawn.SetCollision(false, false, false);
						C.Pawn.bCollideWorld = false;
						C.Pawn.controller.GotoState('PlayerFlying');
        				C.Pawn.ClientMessage(MSG_Ghost);
        				C.Pawn.PlayTeleportEffect(true, true);
        				ClientMessage("Use 'Admin Walk' to return players to normal");
          	  	  	}
          	  	}
          	  	return;
         	} else if (target == ""){
        		P = verifyTarget(target);
        		P.bAmbientCreature=true;
        		P.UnderWaterTime = -1.0;
				P.SetCollision(false, false, false);
				P.bCollideWorld = false;
				P.controller.GotoState('PlayerFlying');
        		P.ClientMessage(MSG_Ghost);
        		P.PlayTeleportEffect(true, true);
        		ClientMessage("Use 'Admin Walk' to return players to normal");
        		return;
        	} else {  
         		P = verifyTarget(target);
         		if (P == none){
             		return;
           		}
         		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0){ 
          					C.Pawn.bAmbientCreature=true;
        					C.Pawn.UnderWaterTime = -1.0;
							C.Pawn.SetCollision(false, false, false);
							C.Pawn.bCollideWorld = false;
							C.Pawn.controller.GotoState('PlayerFlying');
        					C.Pawn.ClientMessage(MSG_Ghost);
        					C.Pawn.PlayTeleportEffect(true, true);
        					ClientMessage("Use 'Admin Walk' to return players to normal");
          				}
          			}
          		}
    		}
  		}
	}
}


//================================================
//Put Target In Fly Mode
exec function Fly(string target){
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;

	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
        if (BMTAdminMut(myMut).FlyEnabled(Self))
		{
	    	if ( target == "" )
				target = SelectedTarget;
	    	if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController')) {
          	  		  	C.Pawn.bAmbientCreature=false;
						C.Pawn.UnderWaterTime = C.Pawn.Default.UnderWaterTime;
						C.Pawn.SetCollision(true, true , true);
						C.Pawn.bCollideWorld = true;
						C.Pawn.controller.GotoState('PlayerFlying');
        				C.Pawn.ClientMessage(MSG_Fly);
        				C.Pawn.PlayTeleportEffect(true, true);
        				ClientMessage("Use 'Admin Walk' to return players to normal");
          	  	  	}
          	  	}
          	  	return;
         	} else if (target == ""){
        		P = verifyTarget(target);
        		P.bAmbientCreature=false;
				P.UnderWaterTime = P.Default.UnderWaterTime;
				P.SetCollision(true, true , true);
				P.bCollideWorld = true;
				P.controller.GotoState('PlayerFlying');
        		P.ClientMessage(MSG_Fly);
        		P.PlayTeleportEffect(true, true);
        		ClientMessage("Use 'Admin Walk' to return players to normal");
        		return;
        	} else {
         		P = verifyTarget(target);
         		if (P == none){
             		return;
           		}
         		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					C.Pawn.bAmbientCreature=false;
							C.Pawn.UnderWaterTime = C.Pawn.Default.UnderWaterTime;
							C.Pawn.SetCollision(true, true , true);
							C.Pawn.bCollideWorld = true;
							C.Pawn.controller.GotoState('PlayerFlying');
        					C.Pawn.ClientMessage(MSG_Fly);
        					C.Pawn.PlayTeleportEffect(true, true);
        					ClientMessage("Use 'Admin Walk' to return players to normal");
          				}
          			}
          		}
    		}
   		}
  	}
}

//================================================
//Put Target In Spider Mode
exec function Spider(string target){
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).SpiderEnabled(Self))
		{
        	if ( target == "" )
				target = SelectedTarget;
        	if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if ( C.IsA('PlayerController')) {
          	  		  	C.Pawn.bAmbientCreature=false;        
						C.Pawn.UnderWaterTime = C.Pawn.Default.UnderWaterTime;
						C.Pawn.SetCollision(true, true , true);
						C.Pawn.bCollideWorld = true;
						C.Pawn.JumpZ = 0.0;
						xPawn(C.Pawn).bflaming = true;
						C.Pawn.controller.GotoState('PlayerSpidering');
        				C.Pawn.ClientMessage(MSG_Spider);
        				C.Pawn.PlayTeleportEffect(true, true);
        				ClientMessage("Use 'Admin Walk' to return players to normal");
          	  	  	}
          	  	}
          	  	return;
         	} else if (target == ""){
        		P = verifyTarget(target);
        		P.bAmbientCreature=false;        
				P.UnderWaterTime = P.Default.UnderWaterTime;
				P.SetCollision(true, true , true);
				P.bCollideWorld = true;
				P.bCanJump = False;
				P.controller.GotoState('PlayerSpidering');
        		P.ClientMessage(MSG_Spider);
        		P.PlayTeleportEffect(true, true);
        		ClientMessage("Use 'Admin Walk' to return players to normal");
        		return;
        	} else {
         		P = verifyTarget(target);
         		if (P == none){
             		return;
           		}
         		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          			if( C.IsA('PlayerController')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					C.Pawn.bAmbientCreature=false;        
							C.Pawn.UnderWaterTime = C.Pawn.Default.UnderWaterTime;
							C.Pawn.SetCollision(true, true , true);
							C.Pawn.bCollideWorld = true;
							C.Pawn.bCanJump = False;
							C.Pawn.controller.GotoState('PlayerSpidering');
        					C.Pawn.ClientMessage(MSG_Spider);
        					C.Pawn.PlayTeleportEffect(true, true);
        					ClientMessage("Use 'Admin Walk' to return players to normal");
        				}
          			}
          		}
    		}
  		}
	}
}
//================================================
//Put Target In Walk Mode
exec function Walk(string target){
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;
			
	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none)
	{	
		if ( target == "" )
				target = SelectedTarget;
		if (target == "all") {
        	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          		if( C.IsA('PlayerController')) {
          	  		C.Pawn.bAmbientCreature=false;
					C.Pawn.UnderWaterTime = C.Pawn.Default.UnderWaterTime;
					C.Pawn.SetCollision(true, true , true);
					C.Pawn.SetPhysics(PHYS_Walking);
					C.Pawn.bCollideWorld = true;
					C.Pawn.bCanJump = true;
					C.Pawn.controller.GotoState('PlayerWalking');
        			C.Pawn.ClientMessage(MSG_Walk);
          	  	}
          	}
          	return;
        } else if (target == ""){
        	P = verifyTarget(target);
        	P.bAmbientCreature=false;
			P.UnderWaterTime = P.Default.UnderWaterTime;
			P.SetCollision(true, true , true);
			P.SetPhysics(PHYS_Walking);
			P.bCollideWorld = true;
			P.bCanJump = true;
			P.controller.GotoState('PlayerWalking');
        	P.ClientMessage(MSG_Walk);
        	return;
        } else {
        	P = verifyTarget(target);
        	if (P == none){
             		return;
           		}
        	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    if( C.IsA('PlayerController')) {
          			namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          			if (namematch >=0) { 
          				C.Pawn.bAmbientCreature=false;
						C.Pawn.UnderWaterTime = C.Pawn.Default.UnderWaterTime;
						C.Pawn.SetCollision(true, true , true);
						C.Pawn.SetPhysics(PHYS_Walking);
						C.Pawn.bCollideWorld = true;
						C.Pawn.bCanJump = true;
						C.Pawn.controller.GotoState('PlayerWalking');
        				C.Pawn.ClientMessage(MSG_Walk);
          			}
          		}
          	}
    	}
  	}
}
//================================================
exec function Summon( string ClassName )
{
	local class<actor> NewClass;
	local vector SpawnLoc;
	local Mutator myMut;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
        if (BMTAdminMut(myMut).SummonEnabled(Self)) 
		{
        	NewClass = class<actor>( DynamicLoadObject( ClassName, class'Class' ) );
        	if( NewClass!=None )
        	{
        		if ( Pawn != None )
        			SpawnLoc = Pawn.Location;
        		else
        			SpawnLoc = Location;
        		Spawn( NewClass,,,SpawnLoc + 72 * Vector(Rotation) + vect(0,0,1) * 15 );
        	}
    	}
	}
}

//================================================
exec function AdvancedSummon( string ClassName, string target)
{
	local class<actor> NewClass;
	local vector SpawnLoc;
	local Mutator myMut;
	local Pawn p;

         p = verifyTarget(target);
         if (p == None){
            ClientMessage(target $" is not on the game.");
            return;

    }
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
        if (BMTAdminMut(myMut).AdvancedSummonEnabled(Self)) 
		{
        	log( "Fabricate " $ ClassName );
        	NewClass = class<actor>( DynamicLoadObject( ClassName, class'Class' ) );
        	if( NewClass!=None )
        	{
        		if ( P != None )
        			SpawnLoc = P.Location;
        		else
        			SpawnLoc = Location;
        		Spawn( NewClass,,,SpawnLoc + 72 * Vector(Rotation) + vect(0,0,1) * 15 );
        	}
    	}
	}
}

//================================================
exec function Teleport(){
    local Mutator myMut;
	local actor HitActor;
	local vector HitNormal, HitLocation;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
        if (BMTAdminMut(myMut).TeleportEnabled(Self))
		{
			HitActor = Trace(HitLocation, HitNormal, ViewTarget.Location + 10000 * vector(Rotation),ViewTarget.Location, true);
			if ( HitActor == None ){
				HitLocation = ViewTarget.Location + 10000 * vector(Rotation);
			} else {
				HitLocation = HitLocation + ViewTarget.CollisionRadius * HitNormal;
			}
			ViewTarget.SetLocation(HitLocation);
			ViewTarget.PlayTeleportEffect(false,true);
		}
	}
}

//================================================

exec function GiveItem(string ItemName, string target)
{
    local Inventory Inv;
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn p;
    local string ItemOnly;
    local int PeriodLoc;
    //local Weapon myWeapon;
  
   	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
       	if (BMTAdminMut(myMut).GiveItemEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
			PeriodLoc = Instr(ItemName, ".");
			ItemOnly = Right(ItemName, PeriodLoc);
			if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController')){
          	  			if (ItemName == "adrenaline"){
							C.Pawn.controller.adrenaline = 100;
							C.Pawn.ClientMessage("You Have been given Full Adrenaline!");
            			} else {
                			C.Pawn.GiveWeapon(ItemName);
                			C.Pawn.PlayTeleportEffect(true, true);
                			C.Pawn.ClientMessage("You Have been given the gift of: "$ItemOnly);
                			AllAmmo(C.Pawn);
            				For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ) {
                				if ( Weapon(Inv) != None ) {
       								Weapon(Inv).Loaded();
       	    					}
       	    				}
       	    		    }
          	  	  	}
          	  	}
          	  	return;
            } else if (target == ""){
            	P = verifyTarget(target);
        		if (ItemName == "adrenaline"){
					P.controller.adrenaline = 100;
					P.ClientMessage("You Have been given Full Adrenaline!");
            	} else {
                	P.GiveWeapon(ItemName);
                	P.PlayTeleportEffect(true, true);
                	P.ClientMessage("You Have been given the gift of: "$ItemOnly);
                	AllAmmo(P);
            		For ( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory ) {
                		if ( Weapon(Inv) != None ) {
     						Weapon(Inv).Loaded();
       	    			}
       	    		}
       	    	}
        		return;
        	} else {
        		P = verifyTarget(target);
        		if (P == none){
             		return;
           		}
	        	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					if (ItemName == "adrenaline"){
								C.Pawn.controller.adrenaline = 100;
								C.Pawn.ClientMessage("You Have been given Full Adrenaline!");
            				} else {
                				C.Pawn.GiveWeapon(ItemName);
                				C.Pawn.PlayTeleportEffect(true, true);
                				C.Pawn.ClientMessage("You Have been given the gift of: "$ItemOnly);
                				AllAmmo(C.Pawn);
            					For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ) {
                					if ( Weapon(Inv) != None ) {
     									Weapon(Inv).Loaded();
       	    						}
       	    					}
       	    		    	}
          				}
          			}
             	}
       		}
   		}
	}
}
//=============================================
exec function Loaded(string target){
	local Inventory Inv;
    local Mutator myMut;
    local Controller C;
    local int namematch;
    local Pawn P;

	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).LoadedEnabled(Self))
		{
            if ( target == "" )
				target = SelectedTarget;
            if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController')){
          	  			AllWeapons(C.Pawn);
            			AllAmmo(C.Pawn);
            			C.Pawn.ClientMessage ("You have been given All Default Weapons!");
            			C.Pawn.PlayTeleportEffect(true, true);
            			For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ) {
                			if ( Weapon(Inv) != None ) {
        						Weapon(Inv).Loaded();
        					}
        				}	
          	  	  	}
          	  	}
          	  	ServerSay("Everyone has been Loaded!");
          	  	return;
        	} else if (target == ""){
        		P = verifyTarget(target);
        		AllWeapons(P);
            	AllAmmo(P);
            	P.ClientMessage ("You have been given All Default Weapons!");
            	P.PlayTeleportEffect(true, true);
            	ServerSay(target$ " has been Loaded!");
            	For ( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory ) {
                	if ( Weapon(Inv) != None ) {
        				Weapon(Inv).Loaded();
        			}
        		}
        		return;
        	} else {
            	P = verifyTarget(target);
            	if (P == none){
             		return;
           		}
            	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >= 0) {
          					AllWeapons(C.Pawn);
            				AllAmmo(C.Pawn);
            				C.Pawn.ClientMessage ("You have been given All Default Weapons!");
            				C.Pawn.PlayTeleportEffect(true, true);
            				For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ) {
                				if ( Weapon(Inv) != None ) {
        							Weapon(Inv).Loaded();
        						}
        					}	
          				}
          			}
            	}
            	ServerSay(C.PlayerReplicationInfo.PlayerName$ " has been Loaded!");
            	return;
       		}
   		}
	}
}
//=============================================
exec function CustomLoaded1(string target){
	local Inventory Inv;
    local Mutator myMut;
    local int i;
    local string M;
    local Controller C;
    local int namematch;
    local Pawn P;
            
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).CustomLoadedEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
			if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController')) {
          	  		  	for (i = 0; i < class'BMTAdminMut'.default.WeaponBase1.Length; i++) {
  					  		M = (class'BMTAdminMut'.default.WeaponBase1[i]);
  					  		C.Pawn.Giveweapon(M);
            		  	}
	    			  	AllAmmo(C.Pawn);
	    			  	C.Pawn.ClientMessage ("You have been given Custom Weapons Pack 1!");
	    			  	C.Pawn.PlayTeleportEffect(true, true);
                	  	For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ){
                			if ( Weapon(Inv) != None ){
        						Weapon(Inv).Loaded();
        					}
        			  	}	
          	  	  	}
          	  	}
          	  	return;
        	} else if (target == ""){
        		P = verifyTarget(target);
        		if (P == none){
             		return;
           		}
        		for (i = 0; i < class'BMTAdminMut'.default.WeaponBase1.Length; i++) {
  					M = (class'BMTAdminMut'.default.WeaponBase1[i]);
  					p.Giveweapon(M);
            	}
	    		AllAmmo(p);
	    		P.ClientMessage ("You have been given Custom Weapons Pack 1!");
	    		P.PlayTeleportEffect(true, true);
                For ( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory ){
                	if ( Weapon(Inv) != None ){
        				Weapon(Inv).Loaded();
        			}
        		}
        		return;
        	} else {
        		P = verifyTarget(target);
        		if (P == none){
             		return;
           		}
          		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					for (i = 0; i < class'BMTAdminMut'.default.WeaponBase1.Length; i++) {
  					  			M = (class'BMTAdminMut'.default.WeaponBase1[i]);
  					  			C.Pawn.Giveweapon(M);
            		  		}
	    			  		AllAmmo(C.Pawn);
	    			  		C.Pawn.ClientMessage ("You have been given Custom Weapons Pack 1!");
	    			  		C.Pawn.PlayTeleportEffect(true, true);
	    			  		For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ){
                				if ( Weapon(Inv) != None ){
        							Weapon(Inv).Loaded();
        			 			}
          					}
          				}
            		}
       			}
   			}
		}
	}
}
//=============================================
exec function CustomLoaded2(string target){
	local Inventory Inv;
    local Mutator myMut;
    local int i;
    local string M;
    local Controller C;
    local int namematch;
    local Pawn P;
            
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
    	if (BMTAdminMut(myMut).CustomLoadedEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
			if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController')) {
          	  		  	for (i = 0; i < class'BMTAdminMut'.default.WeaponBase2.Length; i++) {
  					  		M = (class'BMTAdminMut'.default.WeaponBase2[i]);
  					  		C.Pawn.Giveweapon(M);
            		  	}
	    			  	AllAmmo(C.Pawn);
	    			  	C.Pawn.ClientMessage ("You have been given Custom Weapons Pack 2!");
	    			  	C.Pawn.PlayTeleportEffect(true, true);
	    			  	For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ){
                			if ( Weapon(Inv) != None ){
        						Weapon(Inv).Loaded();
        					}
        			  	}	
          	  	  	}
          	  	}
          	  	return;
        	} else if (target == ""){
        		P = verifyTarget(target);
        		if (P == none){
             		return;
           		}
        		for (i = 0; i < class'BMTAdminMut'.default.WeaponBase2.Length; i++) {
  					M = (class'BMTAdminMut'.default.WeaponBase2[i]);
  					p.Giveweapon(M);
            	}
	    		AllAmmo(P);
	    		P.ClientMessage ("You have been given Custom Weapons Pack 2!");
	    		P.PlayTeleportEffect(true, true);
	    		For ( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory ){
                	if ( Weapon(Inv) != None ){
        				Weapon(Inv).Loaded();
        			}
        		}
        		return;
        	} else {
        		P = verifyTarget(target);
        		if (P == none){
             		return;
           		}
	            for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					for (i = 0; i < class'BMTAdminMut'.default.WeaponBase2.Length; i++) {
  					  			M = (class'BMTAdminMut'.default.WeaponBase2[i]);
  					  			C.Pawn.Giveweapon(M);
            		  		}
	    			  		AllAmmo(C.Pawn);
	    			  		C.Pawn.ClientMessage ("You have been given Custom Weapons Pack 2!");
	    			  		C.Pawn.PlayTeleportEffect(true, true);
	    			  		For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ){
                				if ( Weapon(Inv) != None ){
        							Weapon(Inv).Loaded();
        			 			}
          					}
          				}
            		}
       			}
       		}
   		}
	}
}
//=============================================
exec function CustomLoaded3(string target){
	local Inventory Inv;
    local Mutator myMut;
    local int i;
    local string M;
    local Controller C;
    local int namematch;
    local Pawn P;
            
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
        if (BMTAdminMut(myMut).CustomLoadedEnabled(Self))
		{
			if ( target == "" )
				target = SelectedTarget;
			if (target == "all") {
          	  	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	      	if( C.IsA('PlayerController')) {
          	  		  	for (i = 0; i < class'BMTAdminMut'.default.WeaponBase3.Length; i++) {
  					  		M = (class'BMTAdminMut'.default.WeaponBase3[i]);
  					  		C.Pawn.Giveweapon(M);
            		  	}
	    			  	AllAmmo(C.Pawn);
	    			  	C.Pawn.ClientMessage ("You have been given Custom Weapons Pack 3!");
	    			  	C.Pawn.PlayTeleportEffect(true, true);
	    			  	For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ){
                			if ( Weapon(Inv) != None ){
        						Weapon(Inv).Loaded();
        					}
        			  	}	
          	  	  	}
          	  	}
          	  	return;
        	} else if (target == ""){
        		P = verifyTarget(target);
        		if (P == none){
             		return;
           		}
        		for (i = 0; i < class'BMTAdminMut'.default.WeaponBase3.Length; i++) {
  					M = (class'BMTAdminMut'.default.WeaponBase3[i]);
  					p.Giveweapon(M);
            	}
	    		AllAmmo(P);
	    		P.ClientMessage ("You have been given Custom Weapons Pack 3!");
	    		P.PlayTeleportEffect(true, true);
	    		For ( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory ){
                	if ( Weapon(Inv) != None ){
        				Weapon(Inv).Loaded();
        			}
        		}
        		return;
        	} else {
        		P = verifyTarget(target);
        		if (P == none){
             		return;
           		}
            	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					for (i = 0; i < class'BMTAdminMut'.default.WeaponBase3.Length; i++) {
  					  			M = (class'BMTAdminMut'.default.WeaponBase3[i]);
  					  			C.Pawn.Giveweapon(M);
            		  		}
	    			  		AllAmmo(C.Pawn);
	    			  		C.Pawn.ClientMessage ("You have been given Custom Weapons Pack 3!");
	    			  		C.Pawn.PlayTeleportEffect(true, true);
                	  		For ( Inv=C.Pawn.Inventory; Inv!=None; Inv=Inv.Inventory ){
                				if ( Weapon(Inv) != None ){
        							Weapon(Inv).Loaded();
        			 			}
          					}
          				}
            		}
       			}
       		}
   		}
	}
}

function AllAmmo(Pawn P){
	local Inventory Inv;
	for( Inv=P.Inventory; Inv!=None; Inv=Inv.Inventory )
		if ( Weapon(Inv)!=None )
			Weapon(Inv).SuperMaxOutAmmo();

    P.Controller.AwardAdrenaline( 999 );
}

function AllWeapons(pawn P)
{
	if ((P == None) || (Vehicle(P) != None) )
		return;
	
	P.GiveWeapon("KFMod.Axe");
	P.GiveWeapon("KFMod.Bullpup");
	P.GiveWeapon("KFMod.Chainsaw");
	P.GiveWeapon("KFMod.Crossbow");
	P.GiveWeapon("KFMod.Deagle");
	P.GiveWeapon("KFMod.Single");
	P.GiveWeapon("KFMod.Shotgun");
	P.GiveWeapon("KFMod.Flamethrower");
	P.GiveWeapon("KFMod.Nade");
	P.GiveWeapon("KFMod.Machete");
	P.GiveWeapon("KFMod.Syringe");
	P.GiveWeapon("KFMod.Welder");
	P.GiveWeapon("KFMod.Winchester");
	P.GiveWeapon("KFMod.LAW");
	P.GiveWeapon("KFMod.Knife");
}

//=========================================================================
exec function CauseEvent( name EventName ){
    local Mutator myMut;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
        if (BMTAdminMut(myMut).CauseEventEnabled(Self))
		{
       		TriggerEvent( EventName, Pawn, Pawn);
        }
    }
}

//=========================================================================
exec function DNO(){
    local Mutator myMut;

    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
        if (BMTAdminMut(myMut).DNOEnabled(Self))
		{
			Level.Game.DisableNextObjective();
        }
    }
}

function help_list(Controller C)
{
	local int i;
	local BMTAdminMut MyMut;
	
	MyMut = BMTAdminMut(FindMut(Level.Game.BaseMutator, class'BMTAdminMut'));
	
	if ( !MyMut.AllowLogin(Self) )
		return;
// Всегда выводится

	for(i=0; i<11; i++)
		PlayerController(C).ClientMessage(MSG_Help[i]);
	
// Список доступных команд
	if ( MyMut.KickEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[11]);
	if ( MyMut.SessionEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[12]);
	if ( MyMut.BanEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[13]);
	if ( MyMut.RestartMapEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[14]);
	if ( MyMut.NextMapEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[15]);

		PlayerController(C).ClientMessage(MSG_Help[16]);
	if ( MyMut.SwitchEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[17]);

		PlayerController(C).ClientMessage(MSG_Help[18]);

		PlayerController(C).ClientMessage(MSG_Help[19]);
	if ( MyMut.DisarmEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[20]);
	if ( MyMut.ConfiscateEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[21]);
	if ( MyMut.AbortWaveEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[22]);
	if ( MyMut.SetNextWaveEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[23]);
	if ( MyMut.AnchorEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[24]);
	if ( MyMut.SetTraderTimeEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[25]);
	if ( MyMut.ConfigurableSummonEnabled(Self) )
	{
		PlayerController(C).ClientMessage(MSG_Help[26]);
		PlayerController(C).ClientMessage(MSG_Help[27]);
		PlayerController(C).ClientMessage(MSG_Help[28]);
	}
/*
	if ( MyMut.StunZedsEnabled(Self) )
	{
		PlayerController(C).ClientMessage(MSG_Help[29]);
		PlayerController(C).ClientMessage(MSG_Help[30]);
	}
*/
	if ( MyMut.RestoreAmmoEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[31]);
	if ( MyMut.NoCollisionEnabled(Self) )
	{
		PlayerController(C).ClientMessage(MSG_Help[32]);
		PlayerController(C).ClientMessage(MSG_Help[33]);
	}
	if ( MyMut.RemoveAmmoEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[34]);
		

	if ( MyMut.GodEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[35]);
	if ( MyMut.InvisEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[36]);
	if ( MyMut.LoadedEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[37]);
	if ( MyMut.GhostEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[38]);
	if ( MyMut.FlyEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[39]);
	if ( MyMut.SpiderEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[40]);

		PlayerController(C).ClientMessage(MSG_Help[41]);
	if ( MyMut.FatalityEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[42]);
	if ( MyMut.SlapEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[43]);
	if ( MyMut.CustomLoadedEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[44]);
	if ( MyMut.ChangeNameEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[45]);
	if ( MyMut.ChangeSizeEnabled(Self) )
	{
		PlayerController(C).ClientMessage(MSG_Help[46]);
		PlayerController(C).ClientMessage(MSG_Help[47]);
	}
	if ( MyMut.GiveItemEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[48]);
	if ( MyMut.SummonEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[49]);
	if ( MyMut.AdvancedSummonEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[50]);
	if ( MyMut.ChangeScoreEnabled(Self) )
	{
		PlayerController(C).ClientMessage(MSG_Help[51]);
		PlayerController(C).ClientMessage(MSG_Help[52]);
	}
	if ( MyMut.RespawnEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[53]);
	if ( MyMut.SetGravityEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[54]);
	if ( MyMut.TeleportEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[55]);
	if ( MyMut.PrivMessageEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[56]);
	if ( MyMut.DNOEnabled(Self) )
		PlayerController(C).ClientMessage(MSG_Help[57]);
		
	
}
//=========================================================================
exec function Help(string target){
    local Mutator myMut;
	local Controller C;
	local int namematch;
	   
    myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if (myMut != none)
	{
       	if (target == "")
		{
       		target = PlayerReplicationInfo.PlayerName;
          	for( C = Level.ControllerList; C != None; C = C.nextController ) {
          		namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          		if (namematch >=0) {
        			help_list(C);
        			return;
    			}
			}
		} else {
			for( C = Level.ControllerList; C != None; C = C.nextController ) {
          		if( C.IsA('PlayerController') || C.IsA('xBot')) {
          			namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          			if (namematch >=0) {
          				help_list(C);
          			}
          		}
          	}
        }
	}
}
//====================
//====================
//==Disabled at work==
//====================
//====================

//================================================
//Instantly do 10,000 points of damage to a given player.
exec function fatality(string target){
    local Mutator myMut;
    local Controller C;
	local int namematch;
	local Pawn p;
	
	myMut = findMut(Level.Game.BaseMutator, class'BMTAdminMut');
    if(myMut != none) {
        if (BMTAdminMut(myMut).fatalityEnabled(Self))
		{
		   	if ( target == "" )
				target = SelectedTarget;
		   	if (target == "all") {
        		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          			if( C.IsA('PlayerController') || C.IsA('xBot')) {
          	  			C.Pawn.Controller.bGodMode = false;
        				PlayerController(C).Suicide();
          	  	  	}
          	  	}
          	  	ServerSay("An Admin turned everyone into ashes!");
          	  	return;
        	} else if (target == ""){
        		P = verifyTarget(target);
        		if (P == none){
             		return;
           		}
        		P.Controller.bGodMode = false;
        		ServerSay(P.PlayerReplicationInfo.PlayerName $" turned himself into ashes!");
        		PlayerController(P.Controller).Suicide();
        		return;
        	} else {
          		P = verifyTarget(target);
          		if (P == none){
             		return;
           		}
          		for( C = Level.ControllerList; C != None; C = C.nextController ) {
          	    	if( C.IsA('PlayerController') || C.IsA('xBot')) {
          				namematch = InStr( Caps(C.PlayerReplicationInfo.PlayerName), Caps(target)); 
          				if (namematch >=0) { 
          					C.Pawn.Controller.bGodMode = false;
        					ServerSay("An Admin turned " $ C.PlayerReplicationInfo.PlayerName $ " into ashes!");
        					PlayerController(C).Suicide();
          				}
          			}
          		}
     		}
  		}
	}
}


//=========================================================================

defaultproperties
{
     MSG_LoadedOn="You Have Been Loaded with KF Weapons"
     MSG_GodOn="You are in God mode."
     MSG_GodOff="You are no longer in God Mode."
     MSG_Ghost="You are now no clipping."
     MSG_Fly="You are now flying."
     MSG_ChangeScore="Admin has changed the scores."
     MSG_Spider="Spider Mode Activated."
     MSG_Walk="You are now walking normal again."
     MSG_InvisOn="Invisability On."
     MSG_InvisOff="Invisability Off."
     MSG_TempAdmin="You can now Log in as a Temporary Admin. Just type: adminlogin in the console."
     MSG_TempAdminOff="You are no longer Logged In as an Admin."
     MSG_ChangeName="Admin has changed your name."
     MSG_ChangeSize="Admin has changed your size."
     MSG_GiveItem="You have been given an item by the Admin."
     MSG_Adrenaline="You have been given Full Adrenaline!"
     MSG_Help(0)="This is a list of commands available to you"
     MSG_Help(1)="Always put the word admin before the command. For example: admin ghost"
     MSG_Help(2)="Ghost / Walk / Spider / Fly off for bots"
     MSG_Help(3)="Most of the commands can be executed for the other players by name, a partial name, and"
     MSG_Help(4)="by game ID, (consisting of one or two digits, ID, you can see the game from the menu voting kick)"
     MSG_Help(5)="if the goal of the team - all command applies to all players, if the goal - self applies to you"
     MSG_Help(6)="team SetTarget (or ST) chooses a target for the next command"
     MSG_Help(7)="after applying SetTarget can call the command without the names of the players, and it will be applied to the goal set by the team SetTarget"
     MSG_Help(8)="Examples: Admin Loaded body, Admin Ghost Senator, Admin Godon All, Admin RestoreAmmo self, Admin Disarm 2"
     MSG_Help(9)="--------------------------------------------------------------------------------"
     MSG_Help(10)="In brackets <> are parameters that you can not enter"
     MSG_Help(11)="kick playername - Kicks specific player from the game"
     MSG_Help(12)="kick session playername - Kicks specific player from the map"
     MSG_Help(13)="kickban playername - Kicks and bans specific player"
     MSG_Help(14)="restartmap - Restarts the map"
     MSG_Help(15)="nextmap - Changes map to next map in rotation"
     MSG_Help(16)="map list - Lists maps"
     MSG_Help(17)="switch command - server executes the command"
     MSG_Help(18)="settarget playername - Sets target to specific player - ST"
     MSG_Help(19)="killzeds - Kills all currentsly spawned zeds - KZ"
     MSG_Help(20)="disarm player <dur> - Disarm specific player for set duration - DA"
     MSG_Help(21)="confiscate player1 player2 sum - Takes money from player one and gives to player 2 - CONF"
     MSG_Help(22)="abortwave - ending the current wave. acts only during wave.- ABORT"
     MSG_Help(23)="setnextwave num - number of the next wave will be num. Valid only during the break.- NEXTW"
     MSG_Help(24)="anchor player1 player2 - Teleports player1 to player2"
     MSG_Help(25)="settradertime sec - Sets trader time left in seconds - STT"
     MSG_Help(26)="configurablesummon classname <player> <hp> <headhp> <speed> <meleedamage> <screamdamage> <bleeldoutdur> - Custom Zed Spawning,"
     MSG_Help(27)="on the position of the player player, with x equal hp, xn equal to the head headhp, running speed equal to the speed, short-range damage meleedamage,"
     MSG_Help(28)="damage from crying screamdamage, which, when tearing off the head does not die within bleedoutdur. - CS"
     MSG_Help(29)="stunzeds <dur> - Stuns all zeds for set duration - SZ"
     MSG_Help(30)="unstunzeds - Releases zeds from stun - SZOFF"
     MSG_Help(31)="restoreammo player - player gets full ammo to all weapons. - RESA"
     MSG_Help(32)="nocollision player - player doesn't run into other players and objects - NOCOL"
     MSG_Help(33)="collision player - player collision restored - COL"
     MSG_Help(34)="removeammo player - Take ammo from specific player - REMA"
     MSG_Help(35)="GodOn / Godoff - Godmode        | Ex:  'admin GodOn all' Ex:  'admin GodOff Brock' "
     MSG_Help(36)="InvisOn / InvisOff - Invisability    | Ex: 'admin InvisOn Brock'"
     MSG_Help(37)="Loaded - Loaded             | Ex:  'admin Loaded all'"
     MSG_Help(38)="Ghost - No clipping | Ex:  'admin ghost Jakob'"
     MSG_Help(39)="Fly - Flymode                  | Ex:  'admin fly Jak'"
     MSG_Help(40)="Spider - Spidermode | Ex:  'admin spider Luna'"
     MSG_Help(41)="Walk - Walkmode     | Ex:  'admin walk all'"
     MSG_Help(42)="Fatality - Death | Ex: 'admin fatality Mudak'"
     MSG_Help(43)="Slap <target_nick> - Slaps target for default amount"
     MSG_Help(44)="CustomLoaded1,2,3 - Spawns custom loadout .ini"
     MSG_Help(45)="ChangeName <old_name> <new_name> - Changename playername playernewname"
     MSG_Help(46)="HeadSize <target_name> <size> - Change player headsize 1-5"
     MSG_Help(47)="PlayerSize <target_name> <size> - Change player size 1-5"
     MSG_Help(48)="GiveItem [weaponclass] - Gives specific item"
     MSG_Help(49)="Summon <class> - Spawns a specific zed"
     MSG_Help(50)="AdvancedSummon <class> <target_name> - Spawns a zed to specific player"
     MSG_Help(51)="ChangeScore	<target_nick> <new_score_value> - Changes current score of specific player"
     MSG_Help(52)="ResetScore - Sets scores to 0"
     MSG_Help(53)="Respawn target savior - Respawns target player"
     MSG_Help(54)="SetGravity <gravity> - Sets gravity (default -950)"
     MSG_Help(55)="Teleport - Teleports to cursor"
     MSG_Help(56)="PrivMessage/PM - Send a private message"
     MSG_Help(57)="DNO - Disable Next Objective In Assault Games"
     MSG_ReSpawned="You have been respawned"
     MSG_CantRespawn="Can not respawn during trader"
     LoggedInText="logged in as"
     LoggedOutText="gave up extended abilities"
     strBanReason(0)="no description"
     strBanReason(1)="TK"
     strBanReason(2)="offensive name"
     strBanReason(3)="exploiting"
     strBanReason(4)="spawn killing"
     strBanReason(5)="other"
     strHelpLines(0)="XBanMutator Help  v 0.2"
     strHelpLines(1)="========================================================"
     strHelpLines(2)=" "
     strHelpLines(3)="usage:"
     strHelpLines(4)="      admin <command> <n00b> [reason_id] [reason_description]"
     strHelpLines(5)=" "
     strHelpLines(6)="<command>::="
     strHelpLines(7)="      xkick    - kick the n00b"
     strHelpLines(8)="      xsession  - kick/ban for the session"
     strHelpLines(9)="      xkickban - ban the n00b"
     strHelpLines(10)="      xhelp    - display this help oO"
     strHelpLines(11)="      xlist    - display the reason table"
     strHelpLines(12)=" "
     strHelpLines(13)="<noob>::="
     strHelpLines(14)="      - player name or player id"
     strHelpLines(15)=" "
     strHelpLines(16)="[reason_id]::="
     strHelpLines(17)="      the id identifying the reason why the n00b was kicked/banned."
     strHelpLines(18)="      see the reason table (xlist command). If it is not provided"
     strHelpLines(19)="       it will be filled with 5 (other)."
     strHelpLines(20)=" "
     strHelpLines(21)="[reason_description]:="
     strHelpLines(22)="      a text describing the reason. if it is not provided the default"
     strHelpLines(23)="      text for the reason_id will be automatically assigned."
     strHelpLines(24)=" "
     strHelpLines(25)="========================================================"
}
