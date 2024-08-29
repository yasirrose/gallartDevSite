<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
	group by path
	order by path
</CFQUERY>

<cfparam name="success" default="false">
<cfparam name="msg" default="">

<cfif isDefined('proc_pw')>

	<cfquery name="findUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT * from users
		where email = '#form.email#'
	</cfquery>
	
	<cfif findUser.recordcount>
		<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#findUser.email#" from="onli16@onlinegalleryart.com" subject="Gallery Art Password Retrieval" type="HTML">
			<font style="font-size: 10pt; font-family: Arial;">
			Your Gallery Art Password is:
			<br><br>
			#findUser.password#
			<br><br>
			Please keep in a safe place.
			<br><br>
			Thank you from Gallery Art.
			</font>
		</cfmail>	

		<cfset success = "true" />		
		<cfset msg = "Your password has been emailed to you." />
		
	<cfelse>
	
		<cfset msg = "That email address is not in our system.  Please try again." />
	
	</cfif>

</cfif>

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
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34565365-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!-- BEGIN ROBLY WIDGET CODE -->
<script type='text/javascript'>
  var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
  (function(w, d, p, s, s2) {
    w[p] = w[p] || function() { (w[p].q = w[p].q || []).push(arguments) };
    s = d.createElement('script'); s.async = 1; s.src = '//s3.amazonaws.com/roblyimages/accounts/20559/forms/29541/signup_popup.js';
    s2 = d.getElementsByTagName('script')[0]; s2.parentNode.insertBefore(s, s2);
  })(window, document, 'Robly');
</script>
<!-- END ROBLY WIDGET CODE -->

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
			<table cellspacing="0" cellpadding="5" border="0" width="100%">
				<tr>
					<td align="center" style="padding-top: 10px;">
						<strong>FORGOT PASSWORD</strong>
					</td>
				</tr>
				<tr>
					<td align="center" style="padding-top: 10px;">
					<cfoutput>
						<cfif success eq "false">
						
							<cfif len(msg)><strong>#msg#</strong></cfif>
							
							<table cellspacing="0" cellpadding="5" border="0" width="100%">
								<form method="post" action="#script_name#">
								<tr>
									<td align="center">
										Enter your email address below, and we will email your password to you:
									</td>
								</tr>
								<tr>
									<td align="center">
										<input type="Text" name="email" size="40">
									</td>
								</tr>
								<tr>
									<td align="center">
										<input type="Submit" value="Send My Password" name="proc_pw">
									</td>
								</tr>
								</form>
							</table>
							
						<cfelse>
						
							<cfif len(msg)><strong>#msg#</strong></cfif>
						
						</cfif>
					</cfoutput>
						
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer_user.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>