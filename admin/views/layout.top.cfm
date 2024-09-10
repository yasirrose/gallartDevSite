<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Gallart - Admin</title>
<link REL="STYLESHEET" TYPE="text/css" HREF="css/main.css">
<script src="scripts/functions.js" type="text/javascript"></script>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr>
		<td height="100%" align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" bgcolor="#ffffff">
			 	<tr>
					<td colspan="2" valign="top">
						<div class="ScreenOnly">
							<cfinclude template="menu.cfm">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding: 5px 0px 0px 10px;">
						<div class="ScreenOnly">
							<cfoutput><span class="header" style="text-transform: uppercase;">:: #listfirst(url.event,'.')# MODULE</span></cfoutput>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" valign="top" height="100%" style="padding: 5px 0px 0px 10px;">

