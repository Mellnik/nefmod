//=============================================================================
// Shotgun Fire
//=============================================================================
class ForceAltFire extends KFMeleeFire;

simulated function Timer()
{
	local Actor HitActor;
	local vector StartTrace, EndTrace, HitLocation, HitNormal;
	local rotator PointRot;
	local int MyDamage;
	local bool bBackStabbed;

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

		KFMonster(HitActor).SetAnimAction('Headloss');
		KFMonster(HitActor).Velocity = vect(0,0,0);
		KFMonster(HitActor).GroundSpeed *= 0;
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

function PlayFiring()
{
	if ( Weapon.Mesh != None )
	{
		if ( FireCount > 0 )
		{
			if ( Weapon.HasAnim(FireLoopAnim) )
				Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
			else Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
		}
	}
	else Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
	Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,Default.FireAnimRate/FireAnimRate,false);
	ClientPlayForceFeedback(FireForce);  // jdf
	FireCount++;
}

defaultproperties
{
     weaponRange=400.000000
     DamagedelayMin=0.100000
     DamagedelayMax=0.100000
     hitDamageClass=Class'BMTCustomMut.DamTypeLightSaberProgress'
     ImpactShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ImpactShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ImpactShakeRotTime=0.000000
     ImpactShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ImpactShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ImpactShakeOffsetTime=0.000000
     MeleeHitSounds(0)=Sound'PatchSounds.WelderFire'
     TransientSoundVolume=1.800000
     PreFireAnim="Start_Choke"
     FireLoopAnim="Choke"
     FireEndAnim="End_Choke"
     FireRate=0.100000
     AmmoClass=Class'BMTCustomMut.ForceAmmo'
     AmmoPerFire=10
}
