<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="getRequests" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from requests
	order by datestamp desc
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
		<td valign="top" width="727" height="100%" style="padding-right: 200px;">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td align="center" style="padding-top: 10px;">
						<h4>REQUESTS</h4>
					</td>
				</tr>
				<tr>
					<td style="padding-top: 10px;">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td colspan="3" align="center" style="padding-bottom: 10px;">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td align="center">
												<span style="font-size: 12px; color: ##ff0000;">Thank you for submitting your request.</span><br><br>
												Click <a href="requests_submit.cfm?xss=#xss#">HERE</a> to submit another request for our ART WANTED page, or <a href="requests.cfm?xss=#xss#">HERE</a> view our request list.
											</td>
										</tr>
									</table>
								</td>
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
</cfoutput>
<cfinclude template="frmxss.cfm">

</body>
</html>