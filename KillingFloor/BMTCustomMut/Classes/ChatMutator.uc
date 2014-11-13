class ChatMutator extends Mutator;

var ChatListener Listener;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
function PostBeginPlay()
{
	SetTimer(1.0, true);
}
//--------------------------------------------------------------------------------------------------
function Timer()
{
    // We need to wait until the ChatterMut is loaded :)
    if ((class'ChatterMut'.static.IsLoaded()) && (Listener == None))
    {
        Listener = Spawn(class'ChatListener', self);
        Listener.Mutator = self;
        class'ChatterMut'.static.AddListener(Listener);
		SetTimer(1.0, false);
    }

}
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------

defaultproperties
{
}
