//Weapon progress class
class StingerDamProgress extends WDamProgress;

//requirements to level
simulated function CheckWLevel()
{
	//amount of damage for weapon levels
	
	if(CurrentValue>10000000)
		RepLink.StingerLevel=100;
	else if(CurrentValue>9900000)
		RepLink.StingerLevel=99;
	else if(CurrentValue>9800000)
		RepLink.StingerLevel=98;
	else if(CurrentValue>9700000)
		RepLink.StingerLevel=97;
	else if(CurrentValue>9600000)
		RepLink.StingerLevel=96;
	else if(CurrentValue>9500000)
		RepLink.StingerLevel=95;
	else if(CurrentValue>9400000)
		RepLink.StingerLevel=94;
	else if(CurrentValue>9300000)
		RepLink.StingerLevel=93;
	else if(CurrentValue>9200000)
		RepLink.StingerLevel=92;
	else if(CurrentValue>9100000)
		RepLink.StingerLevel=91;
	else if(CurrentValue>9000000)
		RepLink.StingerLevel=90;
	else if(CurrentValue>8900000)
		RepLink.StingerLevel=89;
	else if(CurrentValue>8800000)
		RepLink.StingerLevel=88;
	else if(CurrentValue>8700000)
		RepLink.StingerLevel=87;
	else if(CurrentValue>8600000)
		RepLink.StingerLevel=86;
	else if(CurrentValue>8500000)
		RepLink.StingerLevel=85;
	else if(CurrentValue>8400000)
		RepLink.StingerLevel=84;
	else if(CurrentValue>8300000)
		RepLink.StingerLevel=83;
	else if(CurrentValue>8200000)
		RepLink.StingerLevel=82;
	else if(CurrentValue>8100000)
		RepLink.StingerLevel=81;
	else if(CurrentValue>8000000)
		RepLink.StingerLevel=80;
	else if(CurrentValue>7900000)
		RepLink.StingerLevel=79;
	else if(CurrentValue>7800000)
		RepLink.StingerLevel=78;
	else if(CurrentValue>7700000)
		RepLink.StingerLevel=77;
	else if(CurrentValue>7600000)
		RepLink.StingerLevel=76;
	else if(CurrentValue>7500000)
		RepLink.StingerLevel=75;
	else if(CurrentValue>7400000)
		RepLink.StingerLevel=74;
	else if(CurrentValue>7300000)
		RepLink.StingerLevel=73;
	else if(CurrentValue>7200000)
		RepLink.StingerLevel=72;
	else if(CurrentValue>7100000)
		RepLink.StingerLevel=71;
	else if(CurrentValue>7000000)
		RepLink.StingerLevel=70;
	else if(CurrentValue>6900000)
		RepLink.StingerLevel=69;
	else if(CurrentValue>6800000)
		RepLink.StingerLevel=68;
	else if(CurrentValue>6700000)
		RepLink.StingerLevel=67;
	else if(CurrentValue>6600000)
		RepLink.StingerLevel=66;
	else if(CurrentValue>6500000)
		RepLink.StingerLevel=65;
	else if(CurrentValue>6400000)
		RepLink.StingerLevel=64;
	else if(CurrentValue>6300000)
		RepLink.StingerLevel=63;
	else if(CurrentValue>6200000)
		RepLink.StingerLevel=62;
	else if(CurrentValue>6100000)
		RepLink.StingerLevel=61;
	else if(CurrentValue>6000000)
		RepLink.StingerLevel=60;
	else if(CurrentValue>5900000)
		RepLink.StingerLevel=59;
	else if(CurrentValue>5800000)
		RepLink.StingerLevel=58;
	else if(CurrentValue>5700000)
		RepLink.StingerLevel=57;
	else if(CurrentValue>5600000)
		RepLink.StingerLevel=56;
	else if(CurrentValue>5500000)
		RepLink.StingerLevel=55;
	else if(CurrentValue>5400000)
		RepLink.StingerLevel=54;
	else if(CurrentValue>5300000)
		RepLink.StingerLevel=53;
	else if(CurrentValue>5200000)
		RepLink.StingerLevel=52;
	else if(CurrentValue>5100000)
		RepLink.StingerLevel=51;
	else if(CurrentValue>5000000)
		RepLink.StingerLevel=50;
	else if(CurrentValue>4900000)
		RepLink.StingerLevel=49;
	else if(CurrentValue>4800000)
		RepLink.StingerLevel=48;
	else if(CurrentValue>4700000)
		RepLink.StingerLevel=47;
	else if(CurrentValue>4600000)
		RepLink.StingerLevel=46;
	else if(CurrentValue>4500000)
		RepLink.StingerLevel=45;
	else if(CurrentValue>4400000)
		RepLink.StingerLevel=44;
	else if(CurrentValue>4300000)
		RepLink.StingerLevel=43;
	else if(CurrentValue>4200000)
		RepLink.StingerLevel=42;
	else if(CurrentValue>4100000)
		RepLink.StingerLevel=41;
	else if(CurrentValue>4000000)
		RepLink.StingerLevel=40;
	else if(CurrentValue>3900000)
		RepLink.StingerLevel=39;
	else if(CurrentValue>3800000)
		RepLink.StingerLevel=38;
	else if(CurrentValue>3700000)
		RepLink.StingerLevel=37;
	else if(CurrentValue>3600000)
		RepLink.StingerLevel=36;
	else if(CurrentValue>3500000)
		RepLink.StingerLevel=35;
	else if(CurrentValue>3400000)
		RepLink.StingerLevel=34;
	else if(CurrentValue>3300000)
		RepLink.StingerLevel=33;
	else if(CurrentValue>3200000)
		RepLink.StingerLevel=32;
	else if(CurrentValue>3100000)
		RepLink.StingerLevel=31;
	else if(CurrentValue>3000000)
		RepLink.StingerLevel=30;
	else if(CurrentValue>2900000)
		RepLink.StingerLevel=29;
	else if(CurrentValue>2800000)
		RepLink.StingerLevel=28;
	else if(CurrentValue>2700000)
		RepLink.StingerLevel=27;
	else if(CurrentValue>2600000)
		RepLink.StingerLevel=26;
	else if(CurrentValue>2500000)
		RepLink.StingerLevel=25;
	else if(CurrentValue>2400000)
		RepLink.StingerLevel=24;
	else if(CurrentValue>2300000)
		RepLink.StingerLevel=23;
	else if(CurrentValue>2200000)
		RepLink.StingerLevel=22;
	else if(CurrentValue>2100000)
		RepLink.StingerLevel=21;
	else if(CurrentValue>2000000)
		RepLink.StingerLevel=20;
	else if(CurrentValue>1900000)
		RepLink.StingerLevel=19;
	else if(CurrentValue>1800000)
		RepLink.StingerLevel=18;
	else if(CurrentValue>1700000)
		RepLink.StingerLevel=17;
	else if(CurrentValue>1600000)
		RepLink.StingerLevel=16;
	else if(CurrentValue>1500000)
		RepLink.StingerLevel=15;
	else if(CurrentValue>1400000)
		RepLink.StingerLevel=14;
	else if(CurrentValue>1300000)
		RepLink.StingerLevel=13;
	else if(CurrentValue>1200000)
		RepLink.StingerLevel=12;
	else if(CurrentValue>1100000)
		RepLink.StingerLevel=11;
	else if(CurrentValue>1000000)
		RepLink.StingerLevel=10;
	else if(CurrentValue>900000)
		RepLink.StingerLevel=9;
	else if(CurrentValue>800000)
		RepLink.StingerLevel=8;
	else if(CurrentValue>700000)
		RepLink.StingerLevel=7;
	else if(CurrentValue>600000)
		RepLink.StingerLevel=6;
	else if(CurrentValue>500000)
		RepLink.StingerLevel=5;		
	else if(CurrentValue>400000)
		RepLink.StingerLevel=4;	
	else if(CurrentValue>300000)
		RepLink.StingerLevel=3;
	else if(CurrentValue>200000)
		RepLink.StingerLevel=2;
	else if(CurrentValue>100000)
		RepLink.StingerLevel=1;
	else
		RepLink.StingerLevel=0;
}

//Hud display info
simulated function string GetWProgress()
{
	local string s;
	
	s=string(CurrentValue);
	
	if(CurrentValue>10000000)
		s="MaxLevel";
	else if(CurrentValue>9800000)
		s$="/9900000";
	else if(CurrentValue>9700000)
		s$="/9800000";
	else if(CurrentValue>9600000)
		s$="/9700000";
	else if(CurrentValue>9500000)
		s$="/9600000";
	else if(CurrentValue>9400000)
		s$="/9500000";
	else if(CurrentValue>9300000)
		s$="/9400000";
	else if(CurrentValue>9200000)
		s$="/9300000";
	else if(CurrentValue>9100000)
		s$="/9200000";
	else if(CurrentValue>9000000)
		s$="/9100000";
	else if(CurrentValue>8900000)
		s$="/9000000";
	else if(CurrentValue>8800000)
		s$="/8900000";
	else if(CurrentValue>8700000)
		s$="/8800000";
	else if(CurrentValue>8600000)
		s$="/8700000";
	else if(CurrentValue>8500000)
		s$="/8600000";
	else if(CurrentValue>8400000)
		s$="/8500000";
	else if(CurrentValue>8300000)
		s$="/8400000";
	else if(CurrentValue>8200000)
		s$="/8300000";
	else if(CurrentValue>8100000)
		s$="/8200000";
	else if(CurrentValue>8000000)
		s$="/8100000";
	else if(CurrentValue>7900000)
		s$="/8000000";
	else if(CurrentValue>7800000)
		s$="/7900000";
	else if(CurrentValue>7700000)
		s$="/7800000";
	else if(CurrentValue>7600000)
		s$="/7700000";
	else if(CurrentValue>7500000)
		s$="/7600000";
	else if(CurrentValue>7400000)
		s$="/7500000";
	else if(CurrentValue>7300000)
		s$="/7400000";
	else if(CurrentValue>7200000)
		s$="/7300000";
	else if(CurrentValue>7100000)
		s$="/7200000";
	else if(CurrentValue>7000000)
		s$="/7100000";
	else if(CurrentValue>6900000)
		s$="/7000000";
	else if(CurrentValue>6800000)
		s$="/6900000";
	else if(CurrentValue>6700000)
		s$="/6800000";
	else if(CurrentValue>6600000)
		s$="/6700000";
	else if(CurrentValue>6500000)
		s$="/6600000";
	else if(CurrentValue>6400000)
		s$="/6500000";
	else if(CurrentValue>6300000)
		s$="/6400000";
	else if(CurrentValue>6200000)
		s$="/6300000";
	else if(CurrentValue>6100000)
		s$="/6200000";
	else if(CurrentValue>6000000)
		s$="/6100000";
	else if(CurrentValue>5900000)
		s$="/6000000";
	else if(CurrentValue>5800000)
		s$="/5900000";
	else if(CurrentValue>5700000)
		s$="/5800000";
	else if(CurrentValue>5600000)
		s$="/5700000";
	else if(CurrentValue>5500000)
		s$="/5600000";
	else if(CurrentValue>5400000)
		s$="/5500000";
	else if(CurrentValue>5300000)
		s$="/5400000";
	else if(CurrentValue>5200000)
		s$="/5300000";
	else if(CurrentValue>5100000)
		s$="/5200000";
	else if(CurrentValue>5000000)
		s$="/5100000";
	else if(CurrentValue>4900000)
		s$="/5000000";
	else if(CurrentValue>4800000)
		s$="/4900000";
	else if(CurrentValue>4700000)
		s$="/4800000";
	else if(CurrentValue>4600000)
		s$="/4700000";
	else if(CurrentValue>4500000)
		s$="/4600000";
	else if(CurrentValue>4400000)
		s$="/4500000";
	else if(CurrentValue>4300000)
		s$="/4400000";
	else if(CurrentValue>4200000)
		s$="/4300000";
	else if(CurrentValue>4100000)
		s$="/4200000";
	else if(CurrentValue>4000000)
		s$="/4100000";
	else if(CurrentValue>3900000)
		s$="/4000000";
	else if(CurrentValue>3800000)
		s$="/3900000";
	else if(CurrentValue>3700000)
		s$="/3800000";
	else if(CurrentValue>3600000)
		s$="/3700000";
	else if(CurrentValue>3500000)
		s$="/3600000";
	else if(CurrentValue>3400000)
		s$="/3500000";
	else if(CurrentValue>3300000)
		s$="/3400000";
	else if(CurrentValue>3200000)
		s$="/3300000";
	else if(CurrentValue>3100000)
		s$="/3200000";
	else if(CurrentValue>3000000)
		s$="/3100000";
	else if(CurrentValue>2900000)
		s$="/3000000";
	else if(CurrentValue>2800000)
		s$="/2900000";
	else if(CurrentValue>2700000)
		s$="/2800000";
	else if(CurrentValue>2600000)
		s$="/2700000";
	else if(CurrentValue>2500000)
		s$="/2600000";
	else if(CurrentValue>2400000)
		s$="/2500000";
	else if(CurrentValue>2300000)
		s$="/2400000";
	else if(CurrentValue>2200000)
		s$="/2300000";
	else if(CurrentValue>2100000)
		s$="/2200000";
	else if(CurrentValue>2000000)
		s$="/2100000";
	else if(CurrentValue>1900000)
		s$="/2000000";
	else if(CurrentValue>1800000)
		s$="/1900000";
	else if(CurrentValue>1700000)
		s$="/1800000";
	else if(CurrentValue>1600000)
		s$="/1700000";
	else if(CurrentValue>1500000)
		s$="/1600000";
	else if(CurrentValue>1400000)
		s$="/1500000";
	else if(CurrentValue>1300000)
		s$="/1400000";
	else if(CurrentValue>1200000)
		s$="/1300000";
	else if(CurrentValue>1100000)
		s$="/1200000";
	else if(CurrentValue>1000000)
		s$="/1100000";
	else if(CurrentValue>900000)
		s$="/1000000";
	else if(CurrentValue>800000)
		s$="/900000";
	else if(CurrentValue>700000)
		s$="/800000";
	else if(CurrentValue>600000)
		s$="/700000";
	else if(CurrentValue>500000)
		s$="/600000";
	else if(CurrentValue>400000)
		s$="/500000";
	else if(CurrentValue>300000)
		s$="/400000";
	else if(CurrentValue>200000)
		s$="/300000";
	else if(CurrentValue>100000)
		s$="/200000";
	else
		s$="/100000";
	
	return s;
}


defaultproperties
{
     ProgressName="Stinger Weapon Damage"
}