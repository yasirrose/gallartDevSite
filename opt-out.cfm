<cfparam name="errormsg" default="0" />

<cftry>
	<cfquery name="qOptouts" datasource="#dsource#">
		SELECT * from optout
		WHERE email = '#url.email#'
	</cfquery>
	
	<cfif qOptouts.recordcount EQ 0>
		<cfquery name="optout" datasource="#dsource#">
			INSERT INTO optout
			(email)
			values
			('#url.email#')
		</cfquery>
	</cfif>
	<cfcatch type="any"><cfset errormsg = 1 /></cfcatch>
</cftry>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><cfoutput>#companyname# - #titletext#</cfoutput></title>
<cfinclude template="meta.cfm">
<link href="stylesheet.css" rel="stylesheet" type="text/css">

</head>

<body bgcolor="ffffff" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="#000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" height="125" valign="top">
			<div align="center" style="font-size: 14px; padding: 20px;">
				<cfif errormsg EQ 0>
					You have been deleted from our mailing list.<br><br>
					Thank you, GALLART.COM.
				<cfelse>
					Sorry -- there was an error in processing.  Your name has not been deleted from our mailing list.
				</cfif>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" width="800" height="125" valign="top" align="center">
			<INPUT TYPE='BUTTON' VALUE='Close' onClick='window.close()'>
		</td>
	</tr>
</table>


</body>
</html>
