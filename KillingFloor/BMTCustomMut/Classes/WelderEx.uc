//-----------------------------------------------------------
//
//-----------------------------------------------------------
class WelderEx extends Welder
	Config(WeldArmor);

var() config string WeldTryMsg;
var() config string WeldTryMsgOwner;
var() config float WeldTrySpeechDist;
var() config float WeldMsgDelay;
var bool bTurret;

var float WeldMsgTime;
var KFHumanPawn prevCachedHealeeFar;

replication
{
	reliable if(Role < ROLE_Authority)
		WantWeldMsg, sLog;
}
simulated function sLog(string msg)
{
	log(msg);
}
simulated function WantWeldMsg(KFHumanPawn CachedHealee)
{
	CachedHealee.ClientMessage(Repl(WeldTryMsg,"%player%",KFPawn(Owner).PlayerReplicationInfo.PlayerName),'CriticalEvent');
}

simulated function Fire(float F)
{
	if (WeldFireEx(FireMode[FireModeArray]).CanFindHealee(true)			// можем найти дальнего игрока
		&& !WeldFireEx(FireMode[FireModeArray]).CanFindHealee(false))	// ближних игроков нет
	{
		if(	/* WelderEx(KFHumanPawn(Owner).Weapon)!=none && */
			( WeldFireEx(FireMode[FireModeArray]).CachedHealeeFar!=prevCachedHealeeFar	// сменилась цель
			|| (WeldMsgTime+WeldMsgDelay < Level.TimeSeconds)) )								// или прошло время
		{
			WantWeldMsg(WeldFireEx(FireMode[FireModeArray]).CachedHealeeFar);
			if (WeldFireEx(FireMode[FireModeArray]).CachedHealeeFarDist < WeldTrySpeechDist)
				PlayerController(KFPawn(Owner).Controller).Speech('AUTO', 5, WeldFireEx(FireMode[FireModeArray]).CachedHealeeFar.PlayerReplicationInfo.PlayerName);			
			KFPawn(Owner).ClientMessage(Repl(WeldTryMsgOwner,"%player%",WeldFireEx(FireMode[FireModeArray]).CachedHealeeFar.PlayerReplicationInfo.PlayerName));
				
			WeldMsgTime=Level.TimeSeconds;
			prevCachedHealeeFar=WeldFireEx(FireMode[FireModeArray]).CachedHealeeFar;
		}
	}
	super.Fire(F);
}
simulated function Tick(float dt)
{
	local KFDoorMover LastDoorHitActor;
	if (FireMode[0].bIsFiring)
		FireModeArray = 0;
	else if (FireMode[1].bIsFiring)
		FireModeArray = 1;
	else
		bJustStarted = true;
				
	if ( Level.NetMode!=NM_Client
		&& KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none
		&& KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
	{
		//WeldFireEx(FireMode[FireModeArray]).CanFindHealee(true);
		WeldFireEx(FireMode[FireModeArray]).CanFindTurret();
	}
	
	if((WeldFire(FireMode[FireModeArray]).LastHitActor != none
		&& VSize(WeldFire(FireMode[FireModeArray]).LastHitActor.Location - Owner.Location) <= (weaponRange * 1.5) )

		|| (WeldFireEx(FireMode[FireModeArray]).CachedHealee != none
		&& VSize(WeldFireEx(FireMode[FireModeArray]).CachedHealee.Location - Owner.Location) <= (weaponRange * 1.5))
		

		
		|| (WeldFireEx(FireMode[FireModeArray]).CachedTurret != none
		&& VSize(WeldFireEx(FireMode[FireModeArray]).CachedTurret.Location - Owner.Location) <= (weaponRange * 1.5)	))
	{
		bNoTarget = false;
		bTurret = false;

		if(WeldFireEx(FireMode[FireModeArray]).CachedHealee != none)
		    ScreenWeldPercent = WeldFireEx(FireMode[FireModeArray]).CachedHealee.ShieldStrength;
		else if(WeldFireEx(FireMode[FireModeArray]).CachedTurret != none)
		{
			ScreenWeldPercent = WeldFireEx(FireMode[FireModeArray]).CachedTurret.Health*100/WeldFireEx(FireMode[FireModeArray]).CachedTurret.TurretHealth;
			bTurret=true;
		}
		
		else
//          ScreenWeldPercent = ((WeldFire(FireMode[FireModeArray]).LastHitActor.WeldStrength) / (WeldFire(FireMode[FireModeArray]).LastHitActor.MaxWeld)) * 100;
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
	else if ((WeldFireEx(FireMode[FireModeArray]).LastHitActor == none
			&& WeldFireEx(FireMode[FireModeArray]).CachedTurret == none
			&& WeldFireEx(FireMode[FireModeArray]).CachedHealee == none
			&& WeldFireEx(FireMode[FireModeArray]).CachedHealeeFar == none)
			|| WeldFire(FireMode[FireModeArray]).LastHitActor != none
			&& VSize(WeldFire(FireMode[FireModeArray]).LastHitActor.Location - Owner.Location) > (weaponRange * 1.5) && !bNoTarget  )
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
simulated event RenderTexture(ScriptedTexture Tex)
{
	local int SizeX,  SizeY;

	Tex.DrawTile(0,0,Tex.USize,Tex.VSize,0,0,256,256,Texture'KillingFloorWeapons.Welder.WelderScreen',BackColor);   // Draws the tile background

	if(!bNoTarget && ScreenWeldPercent > 0 )
	{
		// Err for now go with a name in black letters
		NameColor.R=(255 - (ScreenWeldPercent * 2));
		NameColor.G=(0 + (ScreenWeldPercent * 2.55));
		NameColor.B=(20 + ScreenWeldPercent);
		NameColor.A=255;
		Tex.TextSize(ScreenWeldPercent@"%",NameFont,SizeX,SizeY); // get the size of the players name
		// if (!bTurret)
			Tex.DrawText( (Tex.USize - SizeX) * 0.5, 85,ScreenWeldPercent@"%", NameFont, NameColor);
		// else
			// Tex.DrawText( (Tex.USize - SizeX) * 0.5, 85,ScreenWeldPercent@"HP", NameFont, NameColor);
		Tex.TextSize("Integrity:",NameFont,SizeX,SizeY);
		Tex.DrawText( (Tex.USize - SizeX) * 0.5, 50,"Integrity:", NameFont, NameColor);
	}
	else
	{
		NameColor.R=255;
		NameColor.G=255;
		NameColor.B=255;
		NameColor.A=255;
		Tex.TextSize("-",NameFont,SizeX,SizeY); // get the size of the players name
		Tex.DrawText( (Tex.USize - SizeX) * 0.5, 85,"-", NameFont, NameColor);
		Tex.TextSize("Integrity:",NameFont,SizeX,SizeY);
		Tex.DrawText( (Tex.USize - SizeX) * 0.5, 50,"Integrity:", NameFont, NameColor);
	}
}

simulated function SuperMaxOutAmmo()
{
	if ( bNoAmmoInstances )
	{
		if ( AmmoClass[0] != None )
			AmmoCharge[0] = 10000;
		if ( (AmmoClass[1] != None) && (AmmoClass[0] != AmmoClass[1]) )
			AmmoCharge[1] = 10000;
		return;
	}
	if ( Ammo[0] != None )
		Ammo[0].AmmoAmount = 10000;
	if ( Ammo[1] != None )
		Ammo[1].AmmoAmount = 10000;
}

defaultproperties
{
     WeldTryMsg="%player% Welding Your Amour!"
     WeldTryMsgOwner="%player% Weld Complete"
     WeldTrySpeechDist=150.000000
     WeldMsgDelay=1.000000
     FireModeClass(0)=Class'BMTCustomMut.WeldFireEx'
     ItemName="-BMT- Multi-Welder"
}
