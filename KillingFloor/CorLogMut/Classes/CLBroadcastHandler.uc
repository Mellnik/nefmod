class CLBroadcastHandler extends BroadcastHandler;

var CorLogMut MutatorOwner;

var PlayerReplicationInfo	LastPRI;
var	string					LastMessage;
var	float					LastMessageTime;

function BroadcastText( PlayerReplicationInfo SenderPRI, PlayerController Receiver, coerce string Msg, optional name Type )
{
	if ( NextBroadcastHandler != None )
	{
		NextBroadcastHandler.BroadcastText( SenderPRI, Receiver, Msg, Type );
	}
	else
	{
		Receiver.TeamMessage( SenderPRI, Msg, Type );
	}
	
	if ( LastPRI == SenderPRI && LastMessage == Msg && Level.TimeSeconds - LastMessageTime <= 1.00 )
	{
	}
	else
	{
		MutatorOwner.LogMessage(SenderPRI,Msg);
	}
		
	LastPRI = SenderPRI;
	LastMessage = Msg;
	LastMessageTime = Level.TimeSeconds;
}

defaultproperties
{
}
