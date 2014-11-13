//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieCrawler_XMas extends ZombieCrawler;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

defaultproperties
{
     MoanVoice=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Talk'
     MeleeAttackHitSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_HitPlayer'
     JumpSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Jump'
     DetachedArmClass=Class'BMTCustomMut.SeveredArmCrawler_XMas'
     DetachedLegClass=Class'BMTCustomMut.SeveredLegCrawler_XMas'
     DetachedHeadClass=Class'BMTCustomMut.SeveredHeadCrawler_XMas'
     HitSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Pain'
     DeathSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Death'
     ChallengeSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Acquire'
     ChallengeSound(1)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Acquire'
     ChallengeSound(2)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Acquire'
     ChallengeSound(3)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Acquire'
     MenuName="Christmas Crawler"
     AmbientSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Crawler.Crawler_Idle'
     Mesh=SkeletalMesh'KF_Freaks_Trip_Xmas.RainDeer'
     Skins(0)=Combiner'KF_Specimens_Trip_XMAS_T.ReinDeer.ReinDeer_cmb'
}
