class SentryTimer extends Actor
	Config(PerkBots);
	
var SSSentry S;
var int Countdown;

function Timer()
{
	Countdown--;
	if (Countdown<=0)
	{
		S.Died(none, none, vect(0,0,0));
		Destroy();
	}
}