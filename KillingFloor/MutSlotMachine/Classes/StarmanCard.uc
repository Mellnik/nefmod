Class StarmanCard extends SlotCard;

var() config float StarmanTime;

static function float ExecuteCard( Pawn Target )
{
	Target.Spawn(Class'StarmanClient',Target);
	PlayerController(Target.Controller).ReceiveLocalizedMessage(Class'StarmanMessage');
	return Default.StarmanTime+1;
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	PlayInfo.AddSetting(default.CardGroup,"StarmanTime",Default.Class.Name$"-Time",1,0, "Text", "8;1.00:999.00");
}
static function string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "StarmanTime":	return "How long starman mode stays on.";
	}
	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
     StarmanTime=30.000000
     Desireability=0.100000
     CardMaterial=Texture'KillingFloor2HUD.Perk_Icons.Hud_Perk_Star_Gold'
}
