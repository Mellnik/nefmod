class WTFZombiesMetalClot extends ZombieClot;

/*
#exec OBJ LOAD FILE=PlayerSounds.uax
#exec OBJ LOAD FILE=KF_Freaks_Trip.ukx
#exec OBJ LOAD FILE=KF_Specimens_Trip_T.utx
*/

#exec OBJ LOAD FILE=WTFTex.utx

simulated function ZombieCrispUp()
{
	bAshen = true;
	bCrispified = true;

    SetBurningBehavior();

	if ( Level.NetMode == NM_DedicatedServer || class'GameInfo'.static.UseLowGore() )
	{
		Return;
	}

	// Metal Clot doesn't show skin changes from burns for right now
	/*
	Skins[0]=Texture 'PatchTex.Common.ZedBurnSkin';
	Skins[1]=Texture 'PatchTex.Common.ZedBurnSkin';
	Skins[2]=Texture 'PatchTex.Common.ZedBurnSkin';
	Skins[3]=Texture 'PatchTex.Common.ZedBurnSkin';
	*/
}

defaultproperties
{
     HeadHealth=510.000000
     GroundSpeed=150.000000
     WaterSpeed=150.000000
     HealthMax=510.000000
     Health=510
     MenuName="Metal Clot"
     Skins(0)=Texture'WTFTex.WTFZombies.IronClot'
     Mass=500.000000
}
