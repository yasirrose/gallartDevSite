<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<link href="stylesheet.css" rel="stylesheet" type="text/css">
<cfif parameterexists(form.from)>
<cfif form.to gt "">
<cfmail server="onlinegalleryart.com" to="#form.to#" from="#form.from#" Subject="This is something that I thought you'd like to see">
#form.comments#
To see the item, go here: #form.dest#
</cfmail>
<cfquery name="checkemail" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
select email from leads
where email = '#form.to#'
</cfquery>
<Cfif checkemail.recordcount lt 1>
<cfquery name="addemails" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
insert into leads (email)
			values('#form.to#')
</cfquery>
</cfif>
</cfif>
<SCRIPT LANGUAGE="JavaScript">
var seconds;
seconds = 2;

function autolog() {
    window.close();
}

setTimeout('autolog()',(1000*seconds));
</SCRIPT>
<form>
<table cellpadding="0" cellspacing="0" border="0" width="420">
<tr>
	<td align="Center"><br><br><font face="verdana, arial, helvetica" size="2"><b>We have sent your message. Thank You.</b></font>
	</td>
</tr>
<tr>
	<td align="center"><br><br><br><br><br><INPUT TYPE='BUTTON' VALUE='Close' onClick='window.close()'>
	</td>
</tr>
</table>
</form>
<cfelse>
<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
SELECT path as pathstring, substring(path, 1, PATINDEX('%:%', path)-1) as ccat, *
FROM products
where uid  = '#pid#' and active = 1
</cfquery>
<html>
<head>
	<title>Send to a Friend</title>
</head>

<body bgcolor="ffffff">
<form action="efriend.cfm" method="post">
<cfoutput query="productinfo" maxrows="1">
<input type="hidden" name="dest" value="http://#sitename#/item.cfm?pid=#pid#">
<table cellpadding="0" cellspacing="0" border="0" width="420">
<tr>
	<td>To:
	</td>
	<td><input type="text" name="to" size="45">
	</td>
</tr>
<tr>
	<td>From:
	</td>
	<td><input type="text" name="from" size="45">
	</td>
</tr>

<Tr>
	<td colspan="2"><textarea cols="45" rows="4" name="comments" wrap="soft">I thought you would like to see this!</textarea></td>
</tr>

<tr>
	<td colspan="2" align="Center">
	<input type="submit" value="Send">
	</td>
</tr>
<tr>
	<td colspan="2" align="Center"><br><br>
	<img src="#imageurl#" alt="#name#" border="0">
	</td>
</tr>
<tr>
	<td colspan="2" align="center">http://www.#sitename#/item.cfm?pid=#pid#</td>
</tr>
</cfoutput>
</table>
</cfif>

</body>
</html>
