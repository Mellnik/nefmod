//Weapon progress class
class WDamProgress extends SRCustomProgressInt;

function SetProgress( string S )
{
	CurrentValue = int(S);
	CheckWLevel();
}

function IncrementProgress( int Count )
{
	CurrentValue+=Count;
	CheckWLevel();
	ValueUpdated();
}

simulated function CheckWLevel();
simulated function string GetWProgress();

defaultproperties
{
     ProgressName="Weapon Damage"
}