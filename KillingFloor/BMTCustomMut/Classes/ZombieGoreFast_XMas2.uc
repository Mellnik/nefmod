//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieGoreFast_XMas2 extends ZombieGorefast;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

defaultproperties
{
     MoanVoice=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Talk'
     MeleeAttackHitSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_HitPlayer'
     JumpSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Jump'
     DetachedArmClass=Class'BMTCustomMut.SeveredArmGorefast_XMas'
     DetachedLegClass=Class'BMTCustomMut.SeveredLegGorefast_XMas'
     DetachedHeadClass=Class'BMTCustomMut.SeveredHeadGorefast_XMas'
     HitSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Pain'
     DeathSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Death'
     ChallengeSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Challenge'
     ChallengeSound(1)=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Challenge'
     ChallengeSound(2)=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Challenge'
     ChallengeSound(3)=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Challenge'
     MenuName="Christmas Gorefast"
     AmbientSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.GoreFast.Gorefast_Idle'
     Mesh=SkeletalMesh'KF_Freaks_Trip_Xmas.GingerFast'
     Skins(0)=Combiner'KF_Specimens_Trip_XMAS_T.GingerFast.GingerFast_cmb'
}
