<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

<link href="stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="800" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="800" height="125" valign="top">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="800" valign="top" height="37">
			<cfinclude template="navbar.cfm">
		</td>
	</tr>
	<tr height="100%">
		<td valign="top" width="173" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr height="100%">
					<td valign="top" height="100%">	
						<cfinclude template="left.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" width="627" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr height="100%">
					<td height="100%" valign="top" align="center" style="padding-top: 10px;">
						<table border="0" cellpadding="0" cellspacing="0" width="480">
							<tr bgcolor="FFFF99">
								<td colspan="2" align="center"><br><img src="/img/events.jpg" width="492" height="154" alt="" border="0"></td>
							</tr>
							<tr bgcolor="FFFF99">
								<td colspan="2" align="center"><a href="http://www.onlinegalleryart.com"><font face="times, arial" size="10"><b>Gallery Art Presents:</b></a><br></font></td>
							</tr>
							<tr bgcolor="FFFF99">
								<td colspan="2" align="center"><font face="times, arial" size="6"><b>Your Party!!</b></font><br></td>
							</tr>
							<tr bgcolor="FFFF99">
								<td colspan="2" align="center"><font face="arial" size="3"><b>   <br>   </b><br><br><font size="2"> </font><br><br><br>Promenade Shops in Aventura<br>20633 Biscayne Blvd.<br>Aventura, Florida  33180<br>Gallart.com</font><br><br></td>
							</tr>	
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>