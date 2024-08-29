<cfquery name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT top 10 * FROM PRODUCTS
	WHERE  Active = 1 and family = '1'
	order by newid()
</cfquery>
Applet=PicStrip
&Width=75
&Height=75
&PageBgColor=F0F0FF
&Accelerate=Yes
&AlignTops=Yes
&BgColor=F0F0FF
&BorderColor=F0F0FF
&BorderWidth=0
&ChangeDirection=Yes
&ClickDown=Yes
&DefaultTarget=_self
&FocusTint=Yes
&HotSpotWidth=40
&LoadProgressBorderColor=525461
&LoadProgressFillColor=B0B7E3
&LoadTextColor=000000
&LoadText=Loading images...
&MaskWidth=25
&Name=PicStrip
&ScrollAmount=15
&ScrollDelay=10
&ScrollFromMouse=Yes
&ShowMasks=Yes
&ShowVersion=No
&Spacing=10
&StartScrollFrom=Right
&Testmode=No
&TintColor=FFFFFF
&Transparent=No
&TransparentScrollAmount=55
&TransparentScrollDelay=10

<cfoutput query="data">
&Image#currentrow#=#imageurl#&URL#currentrow#=item.cfm?pid=#uid#&xss=#xss#&Message1=test
</cfoutput>