Class SRCustomProgressFloat extends SRCustomProgress
	Abstract;

var float CurrentValue;

replication
{
	reliable if( Role==ROLE_Authority && bNetOwner )
		CurrentValue;
}

simulated function string GetProgress()
{
	return string(CurrentValue);
}

simulated function int GetProgressInt()
{
	return CurrentValue;
}

function SetProgress( string S )
{
	CurrentValue = float(S);
}

function IncrementProgress( int Count )
{
	CurrentValue+=Count;
	if((CurrentValue+Count)<0 || (CurrentValue+Count)>2000000000)
		CurrentValue=2000000000;
	ValueUpdated();
}

defaultproperties
{
}