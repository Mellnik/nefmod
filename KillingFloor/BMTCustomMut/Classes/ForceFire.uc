//=============================================================================
// Shotgun Fire
//=============================================================================
class ForceFire extends KFMeleeFire;



var() array<name> FireAnims;
var float InjectDelay;
var float HealeeRange;
var float PushForce;
var vector PushAdd; 

simulated function Timer()
{
	local Actor HitActor;
	local vector StartTrace, EndTrace, HitLocation, HitNormal;
	local rotator PointRot;
	local int MyDamage;
	local bool bBackStabbed;
	local vector PushForceVar;

	// Changed to remove the random in Balance Round 5
	MyDamage = MeleeDamage;

        Weapon.ConsumeAmmo(ThisModeNum, AmmoPerFire);

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

        //Instigator.ClearStayingDebugLines();
        //Instigator.DrawStayingDebugLine( StartTrace, EndTrace,0, 255, 0);

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
				bBackStabbed = true;

				MyDamage*=2; // Backstab >:P
			}

			if( (KFMonster(HitActor)!=none) )
			{
			//	log(VSize(Instigator.Velocity));

				KFMonster(HitActor).bBackstabbed = bBackStabbed;

                HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;
	        PushForceVar = (PushForce * Normal(KFMonster(HitActor).Location - Instigator.Location)) + PushAdd;
                KFMonster(HitActor).AddVelocity(PushForceVar);


           	if(MeleeHitSounds.Length > 0)
            	{
            		Weapon.PlaySound(MeleeHitSounds[Rand(MeleeHitSounds.length)],SLOT_None,MeleeHitVolume,,,,false);
            	}

				if(VSize(Instigator.Velocity) > 300 && KFMonster(HitActor).Mass <= Instigator.Mass)
				{
				    KFMonster(HitActor).FlipOver();
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

/*
Function Timer()
{


    Weapon.ConsumeAmmo(ThisModeNum, AmmoPerFire);

    super.timer();

}
*/

function bool AllowFire()
{

        return Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire;

        super.allowfire();
}


event ModeDoFire()
{
    local int AnimToPlay;

    if(FireAnims.length > 0)
    {
        AnimToPlay = rand(FireAnims.length);
        FireAnim = FireAnims[AnimToPlay];
    }

	Load = 0;
	Super.ModeDoFire(); // We don't consume the ammo just yet.	
}


function PlayFiring()
{
	if ( Weapon.Mesh != None )
	{
		if ( FireCount > 0 )
		{
			if ( Weapon.HasAnim(FireLoopAnim) )
			{
				Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
			}
			else
			{
				Weapon.PlayAnim(FireAnim, FireAnimRate, 0.0);
			}
		}
		else
		{
			Weapon.PlayAnim(FireAnim, FireAnimRate, 0.0);
		}
	}
    Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,Default.FireAnimRate/FireAnimRate,false);
    ClientPlayForceFeedback(FireForce);  // jdf

    FireCount++;
}

defaultproperties
{
     FireAnims(0)="Fire"
     FireAnims(1)="Fire"
     FireAnims(2)="Fire"
     FireAnims(3)="Fire"
     InjectDelay=0.100000
     PushForce=860.000000
     PushAdd=(Z=150.000000)
     ProxySize=0.150000
     weaponRange=300.000000
     DamagedelayMin=0.010000
     DamagedelayMax=0.010000
     hitDamageClass=Class'BMTCustomMut.DamTypeLightSaberProgress'
     HitEffectClass=None
     FireRate=0.150000
     AmmoClass=Class'BMTCustomMut.ForceAmmo'
     AmmoPerFire=50
     BotRefireRate=0.850000
}
