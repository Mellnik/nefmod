//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieFleshPound_XMas2 extends ZombieFleshPound;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

// changes colors on Device (notified in anim)
simulated function DeviceGoRed()
{
	Skins[2]=Shader'KFCharacters.FPRedBloomShader';
}

simulated function DeviceGoNormal()
{
	Skins[2]=Shader'KFCharacters.FPAmberBloomShader';
}

defaultproperties
{
     MoanVoice=SoundGroup'KF_EnemiesFinalSnd_Xmas.Fleshpound.FP_Talk'
     MeleeAttackHitSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Fleshpound.FP_HitPlayer'
     JumpSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Fleshpound.FP_Jump'
     DetachedArmClass=Class'BMTCustomMut.SeveredArmPound_XMas'
     DetachedLegClass=Class'BMTCustomMut.SeveredLegPound_XMas'
     DetachedHeadClass=Class'BMTCustomMut.SeveredHeadPound_XMas'
     HitSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Fleshpound.FP_Pain'
     DeathSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Fleshpound.FP_Death'
     MenuName="Christmas Flesh Pound"
     AmbientSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Fleshpound.FP_Idle'
     Mesh=SkeletalMesh'KF_Freaks_Trip_Xmas.NutPound'
     Skins(0)=Combiner'KF_Specimens_Trip_XMAS_T.NutPound.NutPound_cmb'
     Skins(1)=FinalBlend'KF_Specimens_Trip_XMAS_T.NutPound.nutpound_hair_fb'
     Skins(2)=Shader'KFCharacters.FPAmberBloomShader'
}
