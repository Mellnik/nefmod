//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieClot_XMas2 extends ZombieClot;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

defaultproperties
{
     MoanVoice=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_Talk'
     MeleeAttackHitSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_HitPlayer'
     JumpSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_Jump'
     DetachedArmClass=Class'BMTCustomMut.SeveredArmClot_XMas'
     DetachedLegClass=Class'BMTCustomMut.SeveredLegClot_XMas'
     DetachedHeadClass=Class'BMTCustomMut.SeveredHeadClot_XMas'
     HitSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_Pain'
     DeathSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_Death'
     ChallengeSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_Challenge'
     ChallengeSound(1)=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_Challenge'
     ChallengeSound(2)=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_Challenge'
     ChallengeSound(3)=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_Challenge'
     MenuName="Christmas Clot"
     AmbientSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.clot.Clot_IdleLoop'
     Mesh=SkeletalMesh'KF_Freaks_Trip_Xmas.Clot_Elf'
     Skins(0)=Combiner'KF_Specimens_Trip_XMAS_T.Clot_Elf.Clot_Elf_cmb'
}
