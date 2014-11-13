class ZombieSuperCrawler extends ZombieCrawler;

simulated function PostBeginPlay() {
    super.PostBeginPlay();
    PounceSpeed= Rand(221)+330;
    MeleeRange= Rand(41)+50;
}

/**
 * Copied from ZombieCrawler.Bump() but changed damage type
 * to be the new poison damage type
 */
event Bump(actor Other) {
    if(bPouncing && KFHumanPawn(Other)!=none ) {
        KFHumanPawn(Other).TakeDamage(((MeleeDamage - (MeleeDamage * 0.05)) + (MeleeDamage * (FRand() * 0.1))), 
                self ,self.Location,self.velocity, Class'BMTCustomMut.DamTypeCrawlerPoison');
        if (KFHumanPawn(Other).Health <=0) {
            KFHumanPawn(Other).SpawnGibs(self.rotation, 1);
        }
        bPouncing=false;
    }
}

defaultproperties
{
     ZombieDamType(0)=Class'BMTCustomMut.DamTypeCrawlerPoison'
     ZombieDamType(1)=Class'BMTCustomMut.DamTypeCrawlerPoison'
     ZombieDamType(2)=Class'BMTCustomMut.DamTypeCrawlerPoison'
     GroundSpeed=190.000000
     WaterSpeed=175.000000
     MenuName="Super Crawler"
}
