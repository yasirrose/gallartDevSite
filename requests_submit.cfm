<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfif isDefined('request_proc')>

	<cfquery name="insertRequest" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    INSERT into requests
		(
			title,
			artist,
			fk_users,
			fk_request_status
		)
		values
		(
			'#form.title#',
			'#form.artist#',
			#session.sellerinfo.pk_users#,
			'1'
		)
	</cfquery>
	
	<cfquery name="findUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    SELECT * from users
		WHERE pk_users = #session.sellerinfo.pk_users#
	</cfquery>
	
	<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#emailsupport#" cc="#emailsupportcc#"  from="info@gallart.com" subject="Gallery Art  - REQUEST submitted" type="HTML">
		<font style="font-size: 10pt; font-family: Arial;">
		<strong>#session.sellerinfo.fname# #session.sellerinfo.lname#</strong> has submitted a REQUEST on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
		Title: #form.title#<br>
		Artist: #form.artist#<br><br>
		Seller email: #session.sellerinfo.email#<br><br>		
		Please review it in Admin, and approve or delete.
		<br><br>
	</cfmail>
	
	<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#session.sellerinfo.email#" from="info@gallart.com" subject="Gallery Art  - REQUEST Submission" type="HTML">
		<font style="font-size: 10pt; font-family: Arial;">
		Thank you, #session.sellerinfo.fname# #session.sellerinfo.lname#, for submitting your listing to our REQUEST page at www.gallart.com. <br><br>
		Thanks,<br><br>
		Gallery Art
		<br><br>
	</cfmail>
	
	<cflocation url="requests_thanks.cfm?xss=#xss#" addtoken="No">

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
		<td valign="top" width="627" height="100%">
			<table cellspacing="0" cellpadding="0" border="0" width="500">
				<tr>
					<td align="center" style="padding-top: 10px;">
						<h4>SUBMIT REQUEST FOR ART</h4>
					</td>
				</tr>
				<cfif not isDefined('session.sellerinfo.fname')>
				<tr>
					<td style="padding-top: 10px;">
						You must be a registered member in order to submit a request.  Please login below or click <a href="requests_registration.cfm?xss=#xss#">HERE </a> to register:<br><br>
					</td>
				</tr>
				<tr>
					<td style="padding-top: 10px;">
						<cfinclude template="requests_login.cfm">
					</td>
				</tr>
				<cfelse>
				<tr>
					<td style="padding-top: 10px;">
						Please enter the name of the piece you would like to have listed, and the Artist of the piece.  Both fields are required.  Your listing is subject to approval by Gallery Art.<br><br>
						<table cellspacing="0" cellpadding="5" border="0" width="300">
							<cfform method="POST" action="#script_name#?#query_string#">
							<tr>
								<td>
									Title of Piece:
								</td>
								<td>
									<cfinput type="Text" name="title" required="Yes" message="You must enter a title.">
								</td>
							</tr>
							<tr>
								<td>
									Artist:
								</td>
								<td>
									<cfinput type="Text" name="artist" required="Yes" message="You must enter an artist.">
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="Submit" value="Submit" name="request_proc" class="pinkSubmit">
								</td>
							</tr>
							</cfform>
						</table>
					</td>
				</tr>
				</cfif>
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