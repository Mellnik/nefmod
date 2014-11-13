/*-------------------------------------------------------------
	RTFM OF GTFO (c) r1v3t visit http://kfpub.com
-------------------------------------------------------------*/
class WeldFireMix extends WeldFire;
var             KFHumanPawn    CachedHealee;
var float WeldRate, WeldModifier;

simulated function bool AllowFire()
{
	local KFDoorMover WeldTarget;
	WeldTarget = GetDoor();

	// Can't use welder, if no door.
	if ( WeldTarget == none && !CanFindHealee())
	{
		if ( KFPlayerController(Instigator.Controller) != none )
		{
			KFPlayerController(Instigator.Controller).CheckForHint(54);

			if ( FailTime + 0.5 < Level.TimeSeconds )
			{
				PlayerController(Instigator.Controller).ClientMessage(NoWeldTargetMessage, 'CriticalEvent');
				
				FailTime = Level.TimeSeconds;
			}

		}
		return false;
	}
	if(WeldTarget != none && WeldTarget.bDisallowWeld)
	{
		if( PlayerController(Instigator.controller)!=None )
		{
			PlayerController(Instigator.controller).ClientMessage(CantWeldTargetMessage, 'CriticalEvent');
			
			}

	    return false;
    }

    return Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire ;

}
//can find target to heal
function bool CanFindHealee()
{
    local KFHumanPawn Healtarget;
    local KFPlayerReplicationInfo KFPRI;
    KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
    Healtarget = GetHealee();
    CachedHealee = Healtarget;

    // Can't use syringe if we can't find a target
    if ( Healtarget == none )
    {
        return false;
    }

    // Can't use syringe if our target is already being healed to full health.
    if ( Healtarget.ShieldStrength == 100 )
    {
        return false;
    }
    if ( Healtarget.ShieldStrength <= 0 )
    {
        return true;

    }


}
function KFHumanPawn GetHealee()
{
	local KFHumanPawn KFHP, BestKFHP;
	local vector Dir;
	local float TempDot, BestDot;
	local vector Dummy,End,Start;

	Dir = vector(Instigator.GetViewRotation());

	foreach Instigator.VisibleCollidingActors(class'KFHumanPawn', KFHP, 80.0)
	{
		if ( KFHP.ShieldStrength < 100 )
		{
			TempDot = Dir dot (KFHP.Location - Instigator.Location);
			if ( TempDot > 0.7 && TempDot > BestDot )
			{
				BestKFHP = KFHP;
				BestDot = TempDot;
			}
		}
	}

    Start = Instigator.Location+Instigator.EyePosition();
	End = Start+vector(Instigator.GetViewRotation())*weaponRange;
    Instigator.bBlockHitPointTraces = false;
	Instigator.Trace(Dummy,Dummy,End,Start,True);
	return BestKFHP;
}

simulated function Timer()
{
	local Actor HitActor;
	local vector StartTrace, EndTrace, HitLocation, HitNormal,AdjustedLocation;
	local rotator PointRot;
	local int MyDamage;
	
	
	If( !KFWeapon(Weapon).bNoHit )
	{
		MyDamage = MeleeDamage + Rand(MeleeDamage);

		if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
		{
			MyDamage = float(MyDamage) * KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.GetWeldSpeedModifier(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo));
		}
		PointRot = Instigator.GetViewRotation();
		StartTrace = Instigator.Location + Instigator.EyePosition();

		if( AIController(Instigator.Controller)!=None && Instigator.Controller.Target!=None )
		{
			EndTrace = StartTrace + vector(PointRot)*weaponRange;
			Weapon.bBlockHitPointTraces = false;
			HitActor = Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);
            Weapon.bBlockHitPointTraces = Weapon.default.bBlockHitPointTraces;

			if( HitActor==None )
			{
				EndTrace = Instigator.Controller.Target.Location;
    			Weapon.bBlockHitPointTraces = false;
				HitActor = Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);
                Weapon.bBlockHitPointTraces = Weapon.default.bBlockHitPointTraces;
			}
			if( HitActor==None )
				HitLocation = Instigator.Controller.Target.Location;
			HitActor = Instigator.Controller.Target;
		}
		else
		{
			EndTrace = StartTrace + vector(PointRot)*weaponRange;
            Weapon.bBlockHitPointTraces = false;
            HitActor = Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);
            Weapon.bBlockHitPointTraces = Weapon.default.bBlockHitPointTraces;
		}

		LastHitActor = KFDoorMover(HitActor);

		if( LastHitActor!=none && Level.NetMode!=NM_Client )
		{
			AdjustedLocation = Hitlocation;
			AdjustedLocation.Z = (Hitlocation.Z - 0.15 * Instigator.collisionheight);

			HitActor.TakeDamage(MyDamage, Instigator, HitLocation , vector(PointRot),hitDamageClass);
			Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace));
		}
		else if(CachedHealee !=none && Instigator != none && Level.NetMode!=NM_Client)
        {
           AdjustedLocation = Hitlocation;
		   AdjustedLocation.Z = (Hitlocation.Z - 0.15 * Instigator.collisionheight);
		   Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace)); 			
			
			if(CachedHealee.ShieldStrength < 0 && KFPlayerController(CachedHealee.Controller).SelectedVeterancy != class'KFVetSupportSpec')
		    	WeldArmor(CachedHealee, float(MyDamage)/(WeldRate*WeldModifier));
		    else
				WeldArmor(CachedHealee, float(MyDamage)/WeldRate);
        }
        else if (HitActor == none)
        {
          CachedHealee = none;
        }
	}
}

function bool WeldArmor(KFHumanPawn CachedHealeeM, float value)
{
  local float weldingValue;
  local int intValue;
  weldingValue = 1;
  weldingValue += value;
  intValue = int(weldingValue);  
  if(intValue>0)
  {
      CachedHealeeM.ShieldStrength += intValue;

      if(CachedHealeeM.ShieldStrength > 100)
          CachedHealeeM.ShieldStrength = 100;
      weldingValue -= intValue;
      return true;
  }
  return false;
}

defaultproperties
{
     WeldRate=12.500000
     WeldModifier=4.000000
     NoWeldTargetMessage="You must target someone to weld"
     CantWeldTargetMessage="You cannot weld this door or repair armor."
}
