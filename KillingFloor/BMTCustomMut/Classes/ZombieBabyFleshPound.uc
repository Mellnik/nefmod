// Zombie Monster for KF Invasion gametype
class ZombieBabyFleshPound extends ZombieFleshPound;

defaultproperties
{
     RageDamageThreshold=50
     MoanVoice=SoundGroup'CAKESounds3.BABY_Fp_snd.BabyFP_Talk'
     MeleeDamage=15
     JumpSound=SoundGroup'CAKESounds3.BABY_Fp_snd.BabyFP_Jump'
     bMeleeStunImmune=False
     ColOffset=(Z=32.500000)
     ColHeight=20.000000
     PlayerCountHealthScale=0.150000
     HeadHealth=110.000000
     PlayerNumHeadHealthScale=0.150000
     bBoss=False
     HitSound(0)=SoundGroup'CAKESounds3.BABY_Fp_snd.BabyFP_Pain'
     DeathSound(0)=SoundGroup'CAKESounds3.BABY_Fp_snd.BabyFP_Death'
     ChallengeSound(0)=SoundGroup'CAKESounds3.BABY_Fp_snd.BabyFP_Challenge'
     ChallengeSound(1)=SoundGroup'CAKESounds3.BABY_Fp_snd.BabyFP_Challenge'
     ChallengeSound(2)=SoundGroup'CAKESounds3.BABY_Fp_snd.BabyFP_Challenge'
     ChallengeSound(3)=SoundGroup'CAKESounds3.BABY_Fp_snd.BabyFP_Challenge'
     ScoringValue=60
     GroundSpeed=150.000000
     WaterSpeed=140.000000
     HealthMax=800.000000
     Health=100
     MenuName="Baby Fleshpound"
     DrawScale=0.355000
     PrePivot=(Z=20.000000)
     CollisionHeight=30.000000
}
