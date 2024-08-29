<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="getBio" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from bios
	WHERE pk_bios = #url.bioId#
</cfquery>

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
<cfoutput>
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="##000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" valign="top" height="37" bgcolor="##000000">
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
		<td valign="top" width="727" height="100%" align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="80%">
				<tr>
					<td align="center" style="padding-top: 10px;">
                    	<cfparam name="artistName" default="#getBio.artist#">
                        <cfif find(',',getBio.artist)><cfset artistName = "#listlast(getBio.artist,',')# #listfirst(getBio.artist,',')#" /></cfif>
						<h4>ARTIST BIO: #artistName#</h4>
					</td>
				</tr>
				<tr>
					<td style="padding-top: 10px;">
						#getBio.bio#
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
</cfoutput>
<cfinclude template="frmxss.cfm">

</body>
</html>