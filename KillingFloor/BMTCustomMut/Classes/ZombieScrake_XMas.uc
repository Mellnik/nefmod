//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieScrake_XMas extends ZombieScrake;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax
#exec OBJ LOAD FILE=KF_BaseScrake_Xmas.uax

simulated function SpawnExhaustEmitter()
{
}

simulated function UpdateExhaustEmitter()
{
}

defaultproperties
{
     SawAttackLoopSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Chainsaw_Impale'
     ChainSawOffSound=Sound'KF_BaseScrake_Xmas.Chainsaw.Scrake_Chainsaw_Idle'
     MoanVoice=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Talk'
     MeleeAttackHitSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Chainsaw_HitPlayer'
     JumpSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Jump'
     DetachedArmClass=Class'BMTCustomMut.SeveredArmScrake_XMas'
     DetachedLegClass=Class'BMTCustomMut.SeveredLegScrake_XMas'
     DetachedHeadClass=Class'BMTCustomMut.SeveredHeadScrake_XMas'
     DetachedSpecialArmClass=Class'BMTCustomMut.SeveredArmScrakeSaw_XMas'
     HitSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Pain'
     DeathSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Death'
     ChallengeSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Challenge'
     ChallengeSound(1)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Challenge'
     ChallengeSound(2)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Challenge'
     ChallengeSound(3)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Scrake.Scrake_Challenge'
     MenuName="Christmas Scrake"
     AmbientSound=Sound'KF_BaseScrake_Xmas.Chainsaw.Scrake_Chainsaw_Idle'
     Mesh=SkeletalMesh'KF_Freaks_Trip_Xmas.ScrakeFrost'
     Skins(0)=Shader'KF_Specimens_Trip_XMAS_T.ScrakeFrost.scrake_frost_shdr'
}
