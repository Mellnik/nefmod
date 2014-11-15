class TurretMessage extends LocalMessage;

var localized string Message[3];

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject )
{
	
	return Default.Message[Switch];
}

defaultproperties
{
	DrawColor=(R=170,G=170,B=170,A=255)
	bFadeMessage=True
	bIsUnique=True
	FontSize=0
	PosY=0.8
	Lifetime=4
	StackMode=SM_Down

	Message(0)="Can't deploy sentry turret here"
	Message(1)="Sentry turret deployed"
	Message(2)="Sentry turret destroyed"
}