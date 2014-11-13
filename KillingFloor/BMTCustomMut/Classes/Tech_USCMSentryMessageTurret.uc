class Tech_USCMSentryMessageTurret extends LocalMessage;

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
     Message(0)="Can't deploy sentry turret here"
     Message(1)="Sentry turret deployed"
     Message(2)="Sentry turret destroyed"
     bIsUnique=True
     bFadeMessage=True
     Lifetime=8
     DrawColor=(B=0,G=170,R=0)
     StackMode=SM_Down
     PosY=0.800000
}
