//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ChatterMut extends Mutator;

var ChatterSpectator GlobalInstance;

function PostBeginPlay()
{
    AddToPackageMap();

    GlobalInstance = Spawn(class'ChatterSpectator', self);
    class'ChatterMut'.default.GlobalInstance = GlobalInstance;

}

static function AddListener(ChatterListener listener)
{
	local vector L;
    if (listener == None)
        return;
		
	L.x=-99000; L.y=-99000; L.z=-99000;
	listener.SetLocation(L); // Remove white eagle icon from center of map
	
    Instance().Listeners.Length = Instance().Listeners.Length + 1;
    Instance().Listeners[Instance().Listeners.Length-1] = listener;
}

static function bool IsLoaded()
{
    return (class'ChatterMut'.default.GlobalInstance != None);
}

static function ChatterSpectator Instance()
{
    return class'ChatterMut'.default.GlobalInstance;
}

defaultproperties
{
     GroupName="KF-Utility-Chatter"
     FriendlyName="Utility: Chatter"
     Description="Utility: Gives the ability to mutators to catch and process chat."
}
