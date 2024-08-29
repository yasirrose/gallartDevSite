<HTML>
<HEAD>
	<TITLE>Example #2</TITLE>
	<link rel="stylesheet" type="text/css" href="doc.css">
</HEAD>

<BODY>

<CENTER>
<TABLE WIDTH="90%" BORDER="0">
<TR>
<TD>

<!--HEADING START-->
<div class="head">PicStrip Example #2</div>
<!--HEADING END-->
<br><br>

<SCRIPT LANGUAGE="JavaScript"><!--
function PicStrip_DoFSCommand(command, args){
if (command == "status") window.status = args;
}// --></SCRIPT> <SCRIPT LANGUAGE="VBScript"><!--
on error resume next
Sub PicStrip_FSCommand(ByVal command, ByVal args) call PicStrip_DoFSCommand(command, args)
end sub
--></SCRIPT>


<center>
<OBJECT CLASSID="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
CODEBASE="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
WIDTH="400" HEIGHT="100" id="PicStrip">
<PARAM NAME="flashvars" value="Copyright=(c) Cool Focus [www.coolfocus.com]">
<PARAM NAME="movie" VALUE="PicStrip.swf?datafile=PicStrip2.inf"> <PARAM NAME="menu" VALUE="false"> <PARAM NAME="quality" VALUE="best"> <PARAM NAME="scale" VALUE="noscale"> <PARAM NAME="salign" VALUE="LT"> <PARAM NAME="bgcolor" VALUE="#F0F0FF"> <PARAM NAME="wmode" VALUE="window"> 
<EMBED src="PicStrip.swf?datafile=picstrip_datafile.cfm" flashvars="Copyright=(c) Cool Focus [www.coolfocus.com]" menu="false" quality="best" scale="noscale" salign="LT" bgcolor="#6A6D7C"  WIDTH="400" HEIGHT="100" WMODE="window" BGCOLOR="#F0F0FF" SWLIVECONNECT="TRUE" NAME="PicStrip" TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"></EMBED>
</OBJECT>
</center>

<p><br><br>

Testing

<br><br>
</TD>
</TR>
</TABLE>
</CENTER>
</BODY>
</HTML>
