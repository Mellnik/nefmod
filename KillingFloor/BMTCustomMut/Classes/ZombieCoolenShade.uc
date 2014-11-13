// Zombie Monster for KF Invasion gametype
class ZombieCoolenShade extends ZombieShade;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax
//#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_CIRCUS.uax

defaultproperties
{
     MeleeDamage=3
     MenuName="Koolen Shade"
     Mesh=SkeletalMesh'KF_Freaks_Trip_CIRCUS.crawler_CIRCUS'
     Skins(0)=Combiner'KF_Specimens_Trip_CIRCUS_T.crawler_CIRCUS.crawler_CIRCUS_CMB'
}
