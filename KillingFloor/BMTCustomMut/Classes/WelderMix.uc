/*-------------------------------------------------------------
	RTFM OF GTFO (c) r1v3t visit http://kfpub.com
-------------------------------------------------------------*/
class WelderMix extends Welder;
simulated function Tick(float dt)
{
	local KFDoorMover LastDoorHitActor;
	if (FireMode[0].bIsFiring)
		FireModeArray = 0;
	else if (FireMode[1].bIsFiring)
		FireModeArray = 1;
	else
		bJustStarted = true;

	if ((WeldFire(FireMode[FireModeArray]).LastHitActor != none && VSize(WeldFire(FireMode[FireModeArray]).LastHitActor.Location - Owner.Location) <= (weaponRange * 1.5) )
	|| WeldFireMix(FireMode[FireModeArray]).CachedHealee != none && VSize(WeldFireMix(FireMode[FireModeArray]).CachedHealee.Location - Owner.Location) <= (weaponRange * 1.5))
	{
		bNoTarget = false;
		if(WeldFireMix(FireMode[FireModeArray]).CachedHealee != none)
		    ScreenWeldPercent = WeldFireMix(FireMode[FireModeArray]).CachedHealee.ShieldStrength;
		else
            ScreenWeldPercent = (LastDoorHitActor.WeldStrength / LastDoorHitActor.MaxWeld) * 100;

        if( ScriptedScreen==None )
			InitMaterials();
		ScriptedScreen.Revision++;
		if( ScriptedScreen.Revision>10 )
			ScriptedScreen.Revision = 1;

		if ( Level.Game != none && Level.Game.NumPlayers > 1 && bJustStarted && Level.TimeSeconds - LastWeldingMessageTime > WeldingMessageDelay )
		{
			if ( FireMode[0].bIsFiring )
			{
				bJustStarted = false;
				LastWeldingMessageTime = Level.TimeSeconds;
				if( Instigator != none && Instigator.Controller != none && PlayerController(Instigator.Controller) != none )
				{
				    PlayerController(Instigator.Controller).Speech('AUTO', 0, "");
				}
			}
			else if ( FireMode[1].bIsFiring )
			{
				bJustStarted = false;
				LastWeldingMessageTime = Level.TimeSeconds;
				if( Instigator != none && Instigator.Controller != none && PlayerController(Instigator.Controller) != none )
				{
				    PlayerController(Instigator.Controller).Speech('AUTO', 1, "");
				}
			}
		}
	}
	else if ((WeldFireMix(FireMode[FireModeArray]).LastHitActor == none && WeldFireMix(FireMode[FireModeArray]).CachedHealee == none)
    || WeldFire(FireMode[FireModeArray]).LastHitActor != none && VSize(WeldFire(FireMode[FireModeArray]).LastHitActor.Location - Owner.Location) > (weaponRange * 1.5) && !bNoTarget  )
	{
		if( ScriptedScreen==None )
			InitMaterials();
		ScriptedScreen.Revision++;
		if( ScriptedScreen.Revision>10 )
			ScriptedScreen.Revision = 1;
		bNoTarget = true;
		if( ClientState != WS_Hidden && Level.NetMode != NM_DedicatedServer && Instigator != none && Instigator.IsLocallyControlled() )
		{
		  PlayIdle();
		}
	}
	if ( AmmoAmount(0) < FireMode[0].AmmoClass.Default.MaxAmmo)
	{
		AmmoRegenCount += (dT * AmmoRegenRate );
		ConsumeAmmo(0, -1*(int(AmmoRegenCount)));
		AmmoRegenCount -= int(AmmoRegenCount);
	}
}

defaultproperties
{
     FireModeClass(0)=Class'BMTCustomMut.WeldFireMix'
     FireModeClass(1)=Class'BMTCustomMut.UnWeldFireMix'
}
