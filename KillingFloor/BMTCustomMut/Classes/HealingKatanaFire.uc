//-----------------------------------------------------------
//
//-----------------------------------------------------------
class HealingKatanaFire extends KFMeleeFire;

var() array<name> FireAnims;
var int HealAmount;
var float RewardMultiplier;

var()   sound   ExplosionSound; // Healing Sound
var		string	ExplosionSoundRef;

simulated function PostBeginPlay()
{
	if ( FireSound == none )
	{
		PreloadAssets(self);
		PreloadAssetsB(self);
	}

	super.PostBeginPlay();
}

simulated event ModeDoFire()
{
    local int AnimToPlay;

    if(FireAnims.length > 0)
    {
        AnimToPlay = rand(FireAnims.length);
        FireAnim = FireAnims[AnimToPlay];
    }

    Super.ModeDoFire();

}

simulated function Timer()
{
    local Actor HitActor;
    local vector StartTrace, EndTrace, HitLocation, HitNormal;
    local rotator PointRot;
    local int MyDamage;
    local KFPlayerReplicationInfo KFPRI;
    local int AmountHealed;
    local int TotalAmountHealed;
    local int TotalReward;
    local KFHumanPawn HTarget;
    
    KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
    
    // Changed to remove the random in Balance Round 5
    MyDamage = MeleeDamage;

    If( !KFWeapon(Weapon).bNoHit )
    {
        // Changed to remove the random in Balance Round 6
        MyDamage = MeleeDamage;
        StartTrace = Instigator.Location + Instigator.EyePosition();

        if( Instigator.Controller!=None && PlayerController(Instigator.Controller)==None && Instigator.Controller.Enemy!=None )
        {
            PointRot = rotator(Instigator.Controller.Enemy.Location-StartTrace); // Give aimbot for bots.
        }
        else
        {
            PointRot = Instigator.GetViewRotation();
        }

        EndTrace = StartTrace + vector(PointRot)*weaponRange;
        HitActor = Instigator.Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);

        if (HitActor!=None)
        {
            ImpactShakeView();

            if( HitActor.IsA('ExtendedZCollision') && HitActor.Base != none &&
                HitActor.Base.IsA('KFMonster') )
            {
                HitActor = HitActor.Base;
            }

            if ( (HitActor.IsA('KFMonster') || HitActor.IsA('KFHumanPawn')) && KFMeleeGun(Weapon).BloodyMaterial!=none )
            {
                Weapon.Skins[KFMeleeGun(Weapon).BloodSkinSwitchArray] = KFMeleeGun(Weapon).BloodyMaterial;
                Weapon.texture = Weapon.default.Texture;
            }
            if( Level.NetMode==NM_Client )
            {
                Return;
            }

            if( HitActor.IsA('Pawn') && !HitActor.IsA('Vehicle')
             && (Normal(HitActor.Location-Instigator.Location) dot vector(HitActor.Rotation))>0 ) // Fixed in Balance Round 2
            {
                MyDamage*=2; // Backstab >:P
            }

            if( (KFMonster(HitActor)!=none) )
            {
            //  log(VSize(Instigator.Velocity));

                HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;

                if(MeleeHitSounds.Length > 0)
                {
                    Weapon.PlaySound(MeleeHitSounds[Rand(MeleeHitSounds.length)],SLOT_None,MeleeHitVolume,,,,false);
                }

                if(VSize(Instigator.Velocity) > 300 && KFMonster(HitActor).Mass <= Instigator.Mass)
                {
                    KFMonster(HitActor).FlipOver();
                }

            }
            else if( (KFHumanPawn(HitActor)!=none) && KFPRI.ClientVeteranSkill == class'WTFPerksFieldMedic')
            {
            HTarget = KFHumanPawn(HitActor);
            if (HTarget.Health > 0 && HTarget.Health < 100)
                {
                AmountHealed = Min(HealAmount, 100 - HTarget.Health);
                HTarget.GiveHealth(HealAmount, HTarget.HealthMax);                
				Spawn(Class'KFMod.HealingFX',,, HitLocation, rotator(HitNormal));
                Weapon.PlaySound(ExplosionSound,,2.0);

                TotalAmountHealed += AmountHealed;
                TotalReward += int((float(AmountHealed) / HTarget.HealthMax) * RewardMultiplier);
                }
            if (KFPRI != none)
                {
                KFPRI.Score += TotalReward;
                KFPRI.ThreeSecondScore += TotalReward;

                if (KFSteamStatsAndAchievements(KFPRI.SteamStatsAndAchievements) != none)
                KFSteamStatsAndAchievements(KFPRI.SteamStatsAndAchievements).AddDamageHealed(5, true);
                }                
            }
            else
            {
                HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;
                Spawn(HitEffectClass,,, HitLocation, rotator(HitLocation - StartTrace));
                //if( KFWeaponAttachment(Weapon.ThirdPersonActor)!=None )
                //  KFWeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(HitActor,HitLocation,HitNormal);

                //Weapon.IncrementFlashCount(ThisModeNum);
            }
        }
    }
}

static function PreloadAssetsB(optional HealingKatanaFire Spawned)
{

	default.ExplosionSound = sound(DynamicLoadObject(default.ExplosionSoundRef, class'Sound', true));

	if ( Spawned != none )
	{
		Spawned.ExplosionSound = default.ExplosionSound;
	}
}

static function bool UnloadAssets()
{
	local int i;

	default.FireSound = none;
	default.ReloadSound = none;
	default.NoAmmoSound = none;
	default.ExplosionSound = none;
	
	for ( i = 0; i < default.MeleeHitSoundRefs.Length; i++ )
	{
		default.MeleeHitSounds[i] = none;
	}

	return true;
}

defaultproperties
{
     FireAnims(0)="Fire"
     FireAnims(1)="Fire2"
     FireAnims(2)="fire3"
     FireAnims(3)="Fire4"
     FireAnims(4)="Fire5"
     FireAnims(5)="Fire6"
     HealAmount=10
     RewardMultiplier=40.000000
     ExplosionSoundRef="KF_MP7Snd.MP7_DartImpact"
     MeleeDamage=135
     ProxySize=0.150000
     weaponRange=105.000000
     DamagedelayMin=0.320000
     DamagedelayMax=0.320000
     hitDamageClass=Class'BMTCustomMut.DamTypeHealingKatana'
     MeleeHitSounds(0)=SoundGroup'KF_KatanaSnd.Katana_HitFlesh'
     HitEffectClass=Class'KFMod.AxeHitEffect'
     FireRate=0.670000
     BotRefireRate=0.850000
}
