Class AdrenalineCard extends SlotCard;

#exec AUDIO IMPORT FILE="Sounds\ComboActivated.wav" NAME="AdrenalineOn" GROUP="FX"

var() config float AdrenalineTime;

static function float ExecuteCard( Pawn Target )
{
	Target.PlaySound(Sound'AdrenalineOn',SLOT_None,2);
	Target.Spawn(Class'AdrenalineClient');
	PlayerController(Target.Controller).ReceiveLocalizedMessage(Class'AdrenalineMessage');
	return Default.AdrenalineTime;
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	PlayInfo.AddSetting(default.CardGroup,"AdrenalineTime",Default.Class.Name$"-Time",1,0, "Text", "8;1.00:999.00");
}
static function string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "AdrenalineTime":	return "How long the adrenaline stays on.";
	}
	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
     AdrenalineTime=60.000000
     CardMaterial=Texture'KillingFloorHUD.Achievements.Achievement_35'
}
