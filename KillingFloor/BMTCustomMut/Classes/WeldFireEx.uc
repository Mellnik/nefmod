//-----------------------------------------------------------
//
//-----------------------------------------------------------
class WeldFireEx extends WeldFire
    Config(WeldArmor);
var	KFHumanPawn		CachedHealee, CachedHealeeFar;
var float CachedHealeeFarDist;
var	Tech_USCMSentryGun	CachedTurret;

var	float			weldingValue;
var	float			weldingValueT;

var() config int CashSupport10, CashSupport, CashUsual;
var() config float DivShield, DivShieldSupport, DivTurret, DivTurretSupport;
var() config int ShieldRestoreAmount;
var() config float WantWeldMsgDistance;
//----------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------
simulated function bool AllowFire()
{
	local KFDoorMover WeldTarget;
	WeldTarget = GetDoor();
	
	if ( WeldTarget == none
		&& !CanFindHealee(false)
		//&& !CanFindHealee(true) 
		&& !CanFindTurret() )
	{
		/* 
		if ( KFPlayerController(Instigator.Controller) != none )
		{
			KFPlayerController(Instigator.Controller).CheckForHint(54);

			if ( FailTime + 0.5 < Level.TimeSeconds )
			{
				
				PlayerController(Instigator.Controller).ClientMessage(NoWeldTargetMessage, 'CriticalEvent');
				FailTime = Level.TimeSeconds;
			}
			
		}
		*/
		return false;
	}
	if(WeldTarget != none && WeldTarget.bDisallowWeld)
	{
		if( PlayerController(Instigator.controller)!=None )
			PlayerController(Instigator.controller).ClientMessage(CantWeldTargetMessage, 'CriticalEvent');
	    return false;
    }
    return Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire ;
}
//----------------------------------------------------------------------------------------------------------------------------
// Can we find someone to heal
function bool CanFindHealee(bool bFar)
{
	local KFHumanPawn Healtarget;
	Healtarget = GetHealee(bFar);
	if ( ( Healtarget == none ) || ( Healtarget.ShieldStrength == 100 ) || ( Healtarget.ShieldStrength == 0 ) )
	{
		if (!bFar)
			CachedHealee = none;
		else if (bFar)
			CachedHealeeFar = none;	
		return false;
	}
		
	if (!bFar)
		CachedHealee = Healtarget;
	else if (bFar)
		CachedHealeeFar = HealTarget;
		
    return true;
}
//----------------------------------------------------------------------------------------------------------------------------
function bool CanFindTurret()
{
	local Tech_USCMSentryGun Healtarget;
	Healtarget = GetTurret();
	if (( Healtarget == none )
		|| (Healtarget.bIsCurrentlyFlipped)
		|| (Healtarget.Health == Healtarget.TurretHealth)
		|| (Healtarget.Health == 0))
	{
		CachedTurret = none;
		return false;
	}	
	CachedTurret = Healtarget;
    return true;
}

//----------------------------------------------------------------------------------------------------------------------------
function KFHumanPawn GetHealee(bool bFar)
{
	local KFHumanPawn KFHP, BestKFHP;
	local vector Dir;
	local float TempDot, BestDot;
	local float TempDist, BestDist;
	local float TempDistDot, BestDistDot;
	local vector Dummy,End,Start;

	Dir = vector(Instigator.GetViewRotation());
	if (!bFar)
	{
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
	}
	else if (bFar)
	{
		foreach Instigator.VisibleCollidingActors(class'KFHumanPawn', KFHP, WantWeldMsgDistance)
		{
			if( KFHumanPawn(Instigator) == KFHP )
			{
				continue;
			}
			if( KFHP.ShieldStrength < 100 
				&& KFHP.ShieldStrength > 0
				&& KFHP != none)
			{
				TempDot = Dir dot (KFHP.Location - Instigator.Location);
				TempDist = VSize(Instigator.Location-KFHP.Location);
				if (TempDot>TempDist)
					TempDistDot=TempDot-TempDist;
				else
					TempDistDot=TempDist-TempDot;
/*if (KFPlayerReplicationInfo(KFHumanPawn(Instigator).OwnerPRI).PlayerName=="Telo")
{
	log("TempDot"@TempDot@"TempDist"@TempDist@"TempDistDot"@TempDistDot@"Name"@KFPlayerReplicationInfo(KFHP.OwnerPRI).PlayerName);
}*/
				if ( TempDot > 0.7f && TempDistDot<35.0f )
				{
					if (BestKFHP==none)
					{
						BestKFHP = KFHP;
						BestDot = TempDot;
						BestDist = TempDist;
						BestDistDot = TempDistDot; // не знаю нужно ли, сделал для будущего
					}
					else
					{
						if (TempDist <= BestDist)
						{
							if ( (TempDist == BestDist) && (TempDot < BestDot) )
								continue;
							BestKFHP = KFHP;
							BestDot = TempDot;
							BestDist = TempDist;
							BestDistDot = TempDistDot; // не знаю нужно ли, сделал для будущего
						}
					}
					CachedHealeeFarDist = BestDist;
				}
			}
		}
	}
    Start = Instigator.Location+Instigator.EyePosition();
	End = Start+vector(Instigator.GetViewRotation())*weaponRange;
    Instigator.bBlockHitPointTraces = false;
	Instigator.Trace(Dummy,Dummy,End,Start,True);
	return BestKFHP;
}
//----------------------------------------------------------------------------------------------------------------------------
function Tech_USCMSentryGun GetTurret()
{
	local Tech_USCMSentryGun KFPT, BestKFPT;
	local vector Dir;
	local float TempDot, BestDot;
	local vector Dummy,End,Start;

	Dir = vector(Instigator.GetViewRotation());
	
	foreach Instigator.VisibleActors(class'Tech_USCMSentryGun', KFPT,80.0)
	{
		if ( KFPT.Health < KFPT.TurretHealth )
		{
			TempDot = Dir dot (KFPT.Location - Instigator.Location);
			if ( TempDot > 34.0 && TempDot > BestDot )
			{
				BestKFPT = KFPT;
				BestDot = TempDot;
				//log("2TempDot:"@TempDot$", BestDot"@BestDot);
			}
		}
	}
    Start = Instigator.Location+Instigator.EyePosition();
	End = Start+vector(Instigator.GetViewRotation())*weaponRange;
    Instigator.bBlockHitPointTraces = false;
	Instigator.Trace(Dummy,Dummy,End,Start,True);
	return BestKFPT;
}

//----------------------------------------------------------------------------------------------------------------------------
simulated function Timer()
{
	local Actor HitActor;
	local vector StartTrace, EndTrace, HitLocation, HitNormal,AdjustedLocation;
	local rotator PointRot;
	local float MyDamage; // int was
	
	If( !KFWeapon(Weapon).bNoHit )
	{
		MyDamage = MeleeDamage + Rand(MeleeDamage);

		if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
		{
			//log("myDamage:"@MyDamage);
			MyDamage = MyDamage * KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.GetWeldSpeedModifier(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo));
			//log("myDamage*spd:"@MyDamage);
			//log("weldSpeedModifier:"@KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.GetWeldSpeedModifier(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo)));
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

			HitActor.TakeDamage(int(MyDamage), Instigator, HitLocation , vector(PointRot),hitDamageClass);
			Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace));
		}
		else if(CachedHealee !=none && Instigator != none && Level.NetMode!=NM_Client)
        {
			AdjustedLocation = Hitlocation;
			AdjustedLocation.Z = (Hitlocation.Z - 0.15 * Instigator.collisionheight);
			Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace));            

			if((KFPlayerController(Instigator.Controller).SelectedVeterancy == class'KFVetSupportSpec')
				|| (KFPlayerController(Instigator.Controller).SelectedVeterancy == class'WTFPerksSupportSpec'))
			{
				WeldArmor(CachedHealee, MyDamage/DivShieldSupport); //12.5
				if(CachedHealee.ShieldStrength < 0)
					KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).Score+=CashSupport10;
				else
					KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).Score+=CashSupport;
			}
			else
			{
				WeldArmor(CachedHealee, MyDamage/DivShield); // 50f
				KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).Score+=CashUsual;
			}
		}
		else if(CachedTurret != none && Instigator != none && Level.NetMode!=NM_Client)
		{
			AdjustedLocation = Hitlocation;
			AdjustedLocation.Z = (Hitlocation.Z - 0.15 * Instigator.collisionheight);
			Spawn(class'KFWelderHitEffect',,, AdjustedLocation, rotator(HitLocation - StartTrace));  
			
			if( (KFPlayerController(Instigator.Controller).SelectedVeterancy == class'KFVetSupportSpec')
				|| (KFPlayerController(Instigator.Controller).SelectedVeterancy == class'WTFPerksSupportSpec'))
				WeldArmorT(CachedTurret,MyDamage/DivTurretSupport);
			else
				WeldArmorT(CachedTurret,MyDamage/DivTurret);
		}
	
        else if (HitActor == none)
        {
          CachedHealee = none;
		  CachedTurret = none;
        }
	}
}
//----------------------------------------------------------------------------------------------------------------------------
function bool WeldArmor(KFHumanPawn CachedHealeeM, float value)
{
//	local float weldingValue;
	local int intValue;
//	weldingValue = 1;
	weldingValue += value;
	//log("weldValue:"@value@"summaryWeld"@weldingValue);
	intValue = int(weldingValue);
	if(intValue>0 
		&& CachedHealeeM.ShieldStrength < 100
		&& CachedHealeeM.ShieldStrength >= 0)
	{
		CachedHealeeM.ShieldStrength += intValue;
		if (CachedHealeeM.ShieldStrength > 100)
			CachedHealeeM.ShieldStrength = 100;
		weldingValue -= intValue;
		return true;
	}
	return false;
}
//----------------------------------------------------------------------------------------------------------------------------
function bool WeldArmorT(Tech_USCMSentryGun CachedTurretM, float value)
{
//	local float weldingValue;
	local int intValue;
//	weldingValue = 1;
	weldingValue += value;
//	log("weldValue:"@value);	
	intValue = int(weldingValue);
	if( (intValue>0)
		&& (!CachedTurretM.bIsCurrentlyFlipped)
		&& (CachedTurretM.Health<CachedTurretM.TurretHealth)
		&& (CachedTurretM.Health>0))	
	{
		CachedTurretM.Health += intValue;
		if (CachedTurretM.Health > CachedTurretM.TurretHealth)
			CachedTurretM.Health = CachedTurretM.TurretHealth;
		weldingValue -= intValue;
		return true;
	}
	return false;
}

//----------------------------------------------------------------------------------------------------------------------------
function bool IsDistanceLessThan(vector a, vector b, float distance)
{
   return (VSizeSq(a-b) < distance**2 );
}
//----------------------------------------------------------------------------------------------------------------------------
static final function float VSizeSq(vector A)
{
  return Square(A.X) + Square(A.Y) + Square(A.Z);
}
//----------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------

defaultproperties
{
     CashSupport10=30
     CashSupport=15
     CashUsual=3
     DivShield=6.600000
     DivShieldSupport=6.600000
     DivTurret=2.000000
     DivTurretSupport=1.000000
     WantWeldMsgDistance=1250.000000
}
