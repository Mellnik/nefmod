class ChatListener extends ChatterListener;

var ChatMutator Mutator;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
function string GetValue(string Message)
{
	local string S1,S2;
	if (!Divide(Message, " ", S1, S2))
	{
		if (!Divide(Message, "=", S1, S2))
		{
			S2=Right(Message,Len(Message)-InStr(Message," "));
			if (S2=="")
			{
				S2=Right(Message,Len(Message)-InStr(Message,"="));
			}
		}
	}
	if (S1!="")
		return S2;
	else 
		return "";
}
//--------------------------------------------------------------------------------------------------
function OnMessage(coerce string Message, name Type, PlayerReplicationInfo PRI)
{
	local string tStr;
	local MedSentryBotNickMut nMut;
	local bool bSuccess;
	
	if (PRI==none) return;
	if (PlayerController(PRI.Owner)==none) {return;};
	
	if(string(Type) ~= "say"
		|| string(Type) ~= "sayteam"
		|| string(Type) ~= "teamsay")
	{
		tStr = GetValue(Message);
		if (tStr!="")
		{
			if ( InStr(Caps(Message),Caps("!b")) == 0)
			{
				if (Len(tStr)>0)
				{
					foreach DynamicActors(class'MedSentryBotNickMut',nMut)
					{
						nMut.SetBotNameByPC(PlayerController(PRI.Owner),tStr);
						bSuccess=true;
					}
				}
				if (!bSuccess)
					PlayerController(PRI.Owner).ClientMessage("UnSuccessful :( 'MedSentryBotNickMut' not found");
			}
		}
	}
}
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------

defaultproperties
{
}
