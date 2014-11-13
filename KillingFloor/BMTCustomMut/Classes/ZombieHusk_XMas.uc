//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieHusk_XMas extends ZombieHusk;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

defaultproperties
{
     MoanVoice=SoundGroup'KF_EnemiesFinalSnd_Xmas.Husk.Husk_Talk'
     MeleeAttackHitSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Bloat.Bloat_HitPlayer'
     JumpSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Husk.Husk_Jump'
     DetachedArmClass=Class'BMTCustomMut.SeveredArmHusk_XMas'
     DetachedLegClass=Class'BMTCustomMut.SeveredLegHusk_XMas'
     DetachedHeadClass=Class'BMTCustomMut.SeveredHeadHusk_XMas'
     DetachedSpecialArmClass=Class'BMTCustomMut.SeveredArmHusk_XMas'
     HitSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Husk.Husk_Pain'
     DeathSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Husk.Husk_Death'
     ChallengeSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Husk.Husk_Challenge'
     ChallengeSound(1)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Husk.Husk_Challenge'
     ChallengeSound(2)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Husk.Husk_Challenge'
     ChallengeSound(3)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Husk.Husk_Challenge'
     MenuName="Christmas Husk"
     AmbientSound=Sound'KF_BaseHusk_Xmas.Husk_IdleLoop'
     Mesh=SkeletalMesh'KF_Freaks2_Trip_XMas.JackFrost'
     Skins(0)=Shader'KF_Specimens_Trip_XMAS_T_Two.Husk_Snowman.husk_snowman_shdr'
}
