class WTFEquipKatanaFireB extends KFMeleeFire;

function float GetFireSpeed()
{
	local float FS;
	FS = Super(KFMeleeFire).GetFireSpeed();
	
	if (KFGameType(Level.Game) == None)
		return FS;
		
	if (KFGameType(Level.Game).bZEDTimeActive)
	{
		Log("WTFEquipKatanaFireB: In ZEDTime, increasing fire speed");
		return FS * 2.0;
	}
	
	return FS;
}

defaultproperties
{
     MeleeDamage=250
     hitDamageClass=Class'BMTCustomMut.DamTypeWTFKatana'
	 WideDamageMinHitAngle=0.65
	 ProxySize=0.150000
	 weaponRange=95.000000
	 DamagedelayMin=0.65//0.800000
	 DamagedelayMax=0.65//0.800000
	 FireRate=1.000
	 FireAnim="HardAttack"
	 BotRefireRate=0.850000
	 MeleeHitSoundRefs(0)="KF_AxeSnd.Axe_HitFlesh" 
     HitEffectClass=class'AxeHitEffect'
 	 bWaitForRelease=True

}
