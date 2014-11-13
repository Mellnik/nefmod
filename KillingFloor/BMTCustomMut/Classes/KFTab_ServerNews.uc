class KFTab_ServerNews extends KFTab_BaseNews;

var automated GUISectionBackground	i_BGSec;
var automated GUIScrollTextBox lb_Text;

var bool bReceivedRules;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;

	Super.InitComponent(MyController, MyOwner);

    lb_Text.OnDraw = OnLabelDraw;
   	for(i=Class'BMTCustomMut'.Default.News.Length; i> 0; i--)
   	{
   	  lb_Text.AddText(Class'BMTCustomMut'.Default.News[i]);
   	}
   	//lb_Text.AddText(" ");
   	lb_Text.MyScrollBar.GripPos = 0;
   	lb_Text.MyScrollBar.CurPos = 0;
   	lb_Text.MyScrollBar.MyList.SetTopItem(0);
   	lb_Text.MyScrollBar.AlignThumb();
   	OnShow = Shown;
   	//Canvas.Font = Font(DynamicLoadObject(class'HUDKillingFloor'.default.MenuFontArrayNames[2], class'Font'));

}
function bool OnLabelDraw(Canvas c)
{
	C.Style = 1;
	C.Font = class'ROHUD'.Static.GetSmallMenuFont(C);
	return false;
}

function Shown()
{
	lb_Text.MyScrollBar.GripPos = 0;
	lb_Text.MyScrollBar.CurPos = 0;

   	lb_Text.MyScrollBar.MyList.SetTopItem(0);
   	lb_Text.MyScrollBar.AlignThumb();
}

defaultproperties
{
     Begin Object Class=GUISectionBackground Name=BGSec
         bFillClient=True
         Caption="Server News"
         WinTop=0.018000
         WinLeft=0.019240
         WinWidth=0.961520
         WinHeight=0.798982
         OnPreDraw=BGSec.InternalPreDraw
     End Object
     i_BGSec=GUISectionBackground'BMTCustomMut.KFTab_ServerNews.BGSec'

     Begin Object Class=GUIScrollTextBox Name=InfoText
         bNoTeletype=True
         CharDelay=0.002500
         EOLDelay=0.000000
         OnCreateComponent=InfoText.InternalOnCreateComponent
         WinTop=0.052000
         WinLeft=0.030000
         WinWidth=0.945000
         WinHeight=0.760000
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
     End Object
     lb_Text=GUIScrollTextBox'BMTCustomMut.KFTab_ServerNews.InfoText'

}
