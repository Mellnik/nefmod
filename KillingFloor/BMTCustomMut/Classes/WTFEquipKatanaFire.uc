class WTFEquipKatanaFire extends KFMeleeFire;
var() array<name> FireAnims;

simulated event ModeDoFire()
{
    local int AnimToPlay;

    if(FireAnims.length > 0)
    {
        AnimToPlay = rand(FireAnims.length);
        FireAnim = FireAnims[AnimToPlay];
    }

    Super.ModeDoFire();

}

function float GetFireSpeed()
{
	local float FS;
	FS = Super(KFMeleeFire).GetFireSpeed();
	
	if (KFGameType(Level.Game) == None)
		return FS;
	
	if (KFGameType(Level.Game).bZEDTimeActive)
	{
		Log("WTFEquipKatanaFire: In ZEDTime, increasing fire speed");
		return FS * 2.0;
	}
	
	return FS;
}

defaultproperties
{
     MeleeDamage=175
     hitDamageClass=Class'BMTCustomMut.DamTypeWTFKatana'
     FireAnims(0)="fire"
     FireAnims(1)="fire2"
     FireAnims(2)="fire3"
     FireAnims(3)="fire4"
     FireAnims(4)="fire5"
     FireAnims(5)="fire6"
     WideDamageMinHitAngle=0.80
     ProxySize=0.150000
     weaponRange=95.000000
     DamagedelayMin=0.32//0.800000
     DamagedelayMax=0.32//0.800000
     FireRate=0.67 // Reduced fire speed to 0.75 in Balance Round 1, increased to 0.67 in Round 4
     BotRefireRate=0.850000
     MeleeHitSoundRefs(0)="KF_KatanaSnd.Katana_HitFlesh"
     HitEffectClass=class'AxeHitEffect'
     //bWaitForRelease=True // Turned off in Balance Round 1 to allow Auto Fire again

}
