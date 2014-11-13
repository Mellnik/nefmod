class Tech_AdvancedWelder extends Welder;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"




var float       IntegrityDisplayRangeMultiplier;


simulated function Actor GetCurrentTarget(int FireModeIndex)
{
    local Tech_AdvancedWelderFire AWFire;
    local Actor Result;

    Result = WeldFire(FireMode[FireModeIndex]).LastHitActor;
    if (Result != none)
        return Result;

    AWFire = Tech_AdvancedWelderFire(FireMode[FireModeIndex]);
    if (AWFire != none)
    {
        if (AWFire.CachedHealee != none)
            return AWFire.CachedHealee;
        else
            return AWFire.OtherTarget;
    }

    return none;
}

simulated function float GetIntegrityPercentage(Actor Other)
{
    local KFDoorMover DoorTarget;
    local KFHumanPawn PlayerTarget;
    local Pawn PawnTarget;

    DoorTarget = KFDoorMover(Other);
    if (DoorTarget != none)
        return (DoorTarget.WeldStrength / DoorTarget.MaxWeld) * 100.0f;

    PlayerTarget = KFHumanPawn(Other);
    if (PlayerTarget != none)
        return PlayerTarget.ShieldStrength;

    // This one's for turrets
    PawnTarget = Pawn(Other);
    if (PawnTarget != none)
        return (PawnTarget.Health / PawnTarget.HealthMax) * 100.0f;

    return 32202.0f; // Testing value (looks vaguely like "error"; yes, it's lame, but it's temporary)
}

simulated function TriggerScriptedScreenUpdate()
{
    if (ScriptedScreen == none)
        InitMaterials();

    ++ScriptedScreen.Revision;
    if (ScriptedScreen.Revision > 10)
        ScriptedScreen.Revision = 1;
}

simulated function Tick(float dt)
{
    local Actor CurrentTarget;
    local int IntegrityDisplayRangeSq;

    if (FireMode[0].bIsFiring)
        FireModeArray = 0;
    else if (FireMode[1].bIsFiring)
        FireModeArray = 1;
    else
        bJustStarted = true;

    CurrentTarget = GetCurrentTarget(FireModeArray);
    // Might move this into its own property in a bit
    IntegrityDisplayRangeSq = int(weaponRange * IntegrityDisplayRangeMultiplier);
    IntegrityDisplayRangeSq *= IntegrityDisplayRangeSq;

    // Weld integrity screen update and voice cues
    if (CurrentTarget != none && VSizeSquared(CurrentTarget.Location - Owner.Location) <= IntegrityDisplayRangeSq)
    {
        bNoTarget = false;
        ScreenWeldPercent = GetIntegrityPercentage(CurrentTarget);
        TriggerScriptedScreenUpdate();

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
    else if (!bNoTarget) // Previously had a target, but no longer
    {
        bNoTarget = true;
        TriggerScriptedScreenUpdate();

        if( ClientState != WS_Hidden && Level.NetMode != NM_DedicatedServer && Instigator != none && Instigator.IsLocallyControlled() )
        {
          PlayIdle();
        }
    }

    // Ammo recharge
    if ( AmmoAmount(0) < FireMode[0].AmmoClass.Default.MaxAmmo)
    {
        AmmoRegenCount += (dT * AmmoRegenRate );
        ConsumeAmmo(0, -1*(int(AmmoRegenCount)));
        AmmoRegenCount -= int(AmmoRegenCount);
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
     IntegrityDisplayRangeMultiplier=5.000000
     AmmoRegenRate=100.000000
     bKFNeverThrow=False
     FireModeClass(0)=Class'BMTCustomMut.Tech_AdvancedWelderFire'
     FireModeClass(1)=Class'BMTCustomMut.Tech_AdvancedWelderUnWeldFire'
     Priority=6
     PickupClass=Class'BMTCustomMut.Tech_AdvancedWelderPickup'
     AttachmentClass=Class'BMTCustomMut.Tech_AdvancedWelderAttachment'
     ItemName="Tech Advanced Welder"
     Skins(0)=Texture'SentryTechTex1.Weapon_AdvancedWelder.AdvancedWelder_diff'
}
