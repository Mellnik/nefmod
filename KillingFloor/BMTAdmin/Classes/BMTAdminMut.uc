class BMTAdminMut extends Mutator
	config (BMTAdmins);   


var() globalconfig	array<string>	WeaponBase1;
var() globalconfig	array<string>	WeaponBase2;
var() globalconfig	array<string>	WeaponBase3;
var() globalconfig	array<string>	MonName;
var() globalconfig	array<string>	MonAbbr;
var() array<string>	SuperAdmin;
var int iSlapDamage;

var globalconfig	bool			bDebug;

var					array<int>		AdminTime, AdminLoginDelay;

var() globalconfig	array<string>	AdminPostName;
var globalconfig	int				DisarmDuration,ConfiscateWeaponMinimum;
var globalconfig	bool			bConfiscateSellWeapon,bConfiscateSellOnlyOnTrader;

var() globalconfig	array<string>	Admin_Nickname,Admin_Username,Admin_ID;

var() globalconfig	array<bool>		bAllowUseOtherNames, bAllowSilentLogin, bAllowKick, bAllowSession, bAllowBan, bAllowRestartMap, bAllowNextMap,
									bAllowSwitch,bAllowKillZeds,bAllowDisarm,/*bAllowFreeze,*/bAllowConfiscate,bAllowAbortWave,bAllowSetNextWave,
									bAllowAnchor,bAllowSetTraderTime,bAllowConfigurableSummon,bAllowStunZeds,/*bAllowGiveWeap,*/bAllowRestoreAmmo,
									bAllowNoCollision,bAllowRemoveAmmo,bAllowRespawn;

var() globalconfig	array<bool>		bAllowSummon, bAllowSlap, bAllowCombos, bAllowChangeScore,
									bAllowSetGravity, bAllowPrivMessage, bAllowChangeSize, bAllowGiveItem, bAllowLoaded, bAllowGod, bAllowGhost,
									bAllowCustomLoaded, bAllowFly, bAllowInvis, bAllowFatality,/*bAllowTempAdmin,*/ bAllowCauseEvent, bAllowDNO,
									bAllowSpider, bAllowSloMo, bAllowChangeName, bAllowAdvancedSummon, bAllowTeleport;
									

var()	localized	string			SummonDisplayText, SlapDisplayText, CombosDisplayText, PrivMessageDisplayText, ChangeScoreDisplayText,
									SetGravityDisplayText, ChangeSizeDisplayText, GiveItemDisplayText, LoadedDisplayText, CustomLoadedDisplayText,
									GodDisplayText, GhostDisplayText, FlyDisplayText, InvisDisplayText, FatalityDisplayText, ChangeNameDisplayText,
									TempAdminDisplayText, TempAdminOffDisplayText, CauseEventDisplayText, DNODisplayText, SpiderDisplayText,
									SloMoDisplayText, AdvancedSummonDisplayText, TeleportDisplayText;

event PreBeginPlay(){
    Super.PreBeginPlay();
    Level.Game.AccessControl.AdminClass = class'AdminController';
    Level.Game.bAllowMPGameSpeed = true;
}

function int GetAdminTime(AdminController AC)
{
	local int i;
	for (i=0; i<Admin_ID.Length; i++)
		if ( AC.Admin_Login == Admin_Username[i] )
		break;
	if ( i >= Admin_ID.Length )
		return 1;
	return AdminTime[i];
}

function int GetLoginDelay(AdminController AC)
{
	local int i;
	for (i=0; i<Admin_ID.Length; i++)
		if ( AC.Admin_Login == Admin_Username[i] )
		break;
	if ( i >= Admin_ID.Length )
		return 1;
	return AdminLoginDelay[i];
}

function string GetAdminPost(AdminController AC)
{
	local int i;
	for (i=0; i<Admin_ID.Length; i++)
		if ( AC.Admin_Login == Admin_Username[i] )
		break;
	if ( i >= Admin_ID.Length )
		return "";
	return AdminPostName[i];
}

function bool AllowToExecuteCommand(AdminController AC, array<bool> bAllow)
{
	local int i;
	for (i=0; i<Admin_ID.Length; i++)
		if ( AC.GetPlayerIDHash() == Admin_ID[i] && ( AC.PlayerReplicationInfo.PlayerName == Admin_NickName[i] || bAllowUseOtherNames[i] )
			&& AC.Admin_Login == Admin_Username[i] )
		break;
	if ( i >= Admin_ID.Length )
		return false;
	return bAllow[i];
}

function bool SilentLoginEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowSilentLogin);
}

function bool AllowLogin(AdminController AC)
{
	local int i;
	for (i=0; i<Admin_ID.Length; i++)
		if ( AC.GetPlayerIDHash() == Admin_ID[i] && ( AC.PlayerReplicationInfo.PlayerName == Admin_NickName[i] || bAllowUseOtherNames[i] )
			&& AC.Admin_Login == Admin_Username[i] )
		break;
	if ( i >= Admin_ID.Length )
		return false;
	return true;
}

function bool KickEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowKick);
}

function bool SessionEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowSession);
}

function bool BanEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowBan);
}

function bool RestartMapEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowRestartMap);
}

function bool NextMapEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowNextMap);
}

function bool SwitchEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowSwitch);
}

function bool KillZedsEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowKillZeds);
}

function bool DisarmEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowDisarm);
}
/*
function bool FreezeEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowFreeze);
}
*/
function bool ConfiscateEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowConfiscate);
}

function bool AbortWaveEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowAbortWave);
}

function bool SetNextWaveEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowSetNextWave);
}

function bool AnchorEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowAnchor);
}

function bool SetTraderTimeEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowSetTraderTime);
}

function bool ConfigurableSummonEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowConfigurableSummon);
}

function bool StunZedsEnabled(AdminController AC)
{
	return false;
	return AllowToExecuteCommand(AC,bAllowStunZeds);
}
/*
function bool GiveWeapEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowGiveWeap);
}
*/
function bool RestoreAmmoEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowRestoreAmmo);
}

function bool NoCollisionEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowNoCollision);
}

function bool RemoveAmmoEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowRemoveAmmo);
}

function bool RespawnEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowRespawn);
}

function bool SummonEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowSummon);
}

function bool LoadedEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowLoaded);
}

function bool CustomLoadedEnabled(AdminController AC)
{
	return AllowToExecuteCommand(AC,bAllowCustomLoaded);
}

function bool GiveItemEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowGiveItem);
}

function bool ChangeScoreEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowChangeScore);
}

function bool GhostEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowGhost);
}

function bool GodEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowGod);
}

function bool FlyEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowFly);
}

function bool InvisEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowInvis);
}

function bool FatalityEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowFatality);
}

function bool TempAdminEnabled(AdminController AC)
{
	return false;
//	return AllowToExecuteCommand(AC,bAllowTempAdmin);
}

function bool ChangeNameEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowChangeName);
}

function bool ChangeSizeEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowChangeSize);
}

function bool CauseEventEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowCauseEvent);
}

function bool DNOEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowDNO);
}

function bool SpiderEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowSpider);
}

function bool SloMoEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowSloMo);
}

function bool CombosEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowCombos);
}

function bool SlapEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowSlap);
}

function bool SetGravityEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowSetGravity);
}

function bool AdvancedSummonEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowAdvancedSummon);
}

function bool TeleportEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowTeleport);
}

function bool PrivMessageEnabled(AdminController AC){
  return AllowToExecuteCommand(AC,bAllowPrivMessage);
}

defaultproperties
{
     iSlapDamage=1
     bDebug=True
     AdminPostName(0)="Server Administrator"
     AdminPostName(1)="Game Moderator"
     AdminPostName(2)="Main Administrator"
     AdminPostName(3)="Server Administrator"
     AdminPostName(4)="Server Administrator"
     AdminPostName(5)="Server Administrator"
     AdminPostName(6)="Server Administrator"
     AdminPostName(7)="Server Administrator"
     AdminPostName(8)="Server Administrator"
     AdminPostName(9)="Server Administrator"
     AdminPostName(10)="Server Administrator"
     SummonDisplayText="Summon"
     SlapDisplayText="Slap"
     CombosDisplayText="Instant Combos"
     PrivMessageDisplayText="Private Messages"
     ChangeScoreDisplayText="Reset Score"
     SetGravityDisplayText="Change Gravity (default = -950)"
     ChangeSizeDisplayText="Head size Change"
     GiveItemDisplayText="GiveItem"
     LoadedDisplayText="Loaded"
     CustomLoadedDisplayText="CustomLoaded"
     GodDisplayText="God Mode"
     GhostDisplayText="Ghost"
     FlyDisplayText="Fly"
     InvisDisplayText="Invisiblity"
     FatalityDisplayText="Fatality!"
     ChangeNameDisplayText="Change Players names"
     TempAdminDisplayText="Temporary Admin."
     TempAdminOffDisplayText="Disable Temporary Admin."
     CauseEventDisplayText="Cause Event"
     DNODisplayText="Disable Next Objective"
     SpiderDisplayText="Spider"
     SloMoDisplayText="SloMo"
     AdvancedSummonDisplayText="Advanced Summon"
     TeleportDisplayText="Teleport"
     GroupName="KF-BMTAdmin"
     FriendlyName="BMTAdmin"
     Description="BMTAdmin"
}
