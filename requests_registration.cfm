<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<!--- get autoemail content --->
<cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from pages
	WHERE pk_pages = 6
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

<cfif isDefined('proc_reg')>

<cfquery name="CheckDups" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		select pk_users from users where email =  <cfqueryparam value="#trim(form.email)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>

	<cfif CheckDups.recordcount gt 0>
		<script language="JavaScript">
			alert('The email you selected is taken. If you are already a member please log in.');
			history.go(-1);
		</script>
		<cfabort>
	</cfif>
	
	<cfif form.password neq form.password2>
		<script language="JavaScript">
			alert('Password missmatch. Please retype your password.');
			history.go(-1);
		</script>
		<cfabort>
	</cfif>
	
	<cflock name="insertuser" timeout="10">
	
	<cfquery name="insertUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		INSERT into users
		(
			fname,
			lname,
			email,
			password
		)
		values
		(
			<cfqueryparam value="#form.fname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
			<cfqueryparam value="#form.lname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
			<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
			<cfqueryparam value="#form.password#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		)
	</cfquery>
	
	<!--- getting the last input UID --->
	<cfquery name="lastUID" datasource="#dsource#" username="#uname#" password="#pword#">
		SELECT @@identity as uid FROM users
	</cfquery>
	
	<cfset session.sellerinfo.pk_users = lastUID.uid>
	<cfset session.sellerinfo.fname = form.fname>
	<cfset session.sellerinfo.lname = form.lname>
	<cfset session.sellerinfo.login = 1 />
	
	</cflock>
	
	<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#emailsupport#" cc="#emailsupportcc#"  from="#form.email#" subject="GallArt.com <> Buying & Selling Fine Art <> New Member Registration <> Requests" type="HTML">
		<font style="font-size: 10pt; font-family: Arial;">
		<strong>#form.fname# #form.lname#</strong> registered as a new Member on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
		<br><br>
	</cfmail>
	
	<cfmail server="#servername#" to="#form.email#" from="Gallery Art <#emailsupport#>" subject="Gallery Art - Welcome New Member" type="HTML">
		<font style="font-size: 10pt; font-family: Arial;">
		Thank you, #form.fname# #form.lname# for registering as a Member at www.gallart.com. <br><br>
		Your password is:<br>
		#form.password#<br><br>
		Please keep it in a safe place.<br><br>
		You are now ready to list your requests!<br><br>
		#getPages.page_content#
		<br><br>
	</cfmail>
	
	<cflocation url="requests_submit.cfm?xss=#xss#&newmember=1" addtoken="No">
	
<cfelse>


<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="#000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" valign="top" height="37" bgcolor="#000000">
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
		<td valign="top" width="727" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr height="100%">
					<td height="100%" valign="top" style="padding-top: 10px;">	
						<h4>SUBMIT A REQUEST FOR ART ON GALLERYART.COM</h4>
						<cfif isDefined('session.sellerinfo')>
							<div align="center">You are already a member.  Please click <a href="requests_submit.cfm?xss=#xss#">HERE</a> to login and submit your request.</div>
						<cfelse>
						<cfform method="POST" action="#script_name#?#query_string#">
						<cfoutput>
						<table cellpadding="2" cellspacing="0" border="0" width="450">
							<tr>
								<Td colspan="2">
									Fill out the form below in order to become a member of Gallery Art.  You can then submit a request for art on our ART WANTED list.
								</td>
							</tr> 
							<tr>
								<Td colspan="2" align="Center" style="padding-top: 12px;">
									<h5 style="color: ##dd3a7d">REGISTRATION FORM</h5>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="5" border="0" width="100%">
										<tr class="#this_row()#">
											<td><b>Name</b> <i>(First Last)</i>
											</td>
											<td><cfinput type="text" name="fname" size="20" required="Yes" message="Please enter your first name.">&nbsp;<cfinput type="text" name="lname" size="30" required="Yes" message="Please enter your last name.">
											</td>
										</tr>
										<tr class="#this_row()#">
											<td><b>Email</b>
											</td>
											<td><cfinput type="text" name="Email" size="45" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Please enter a proper email." >
											</td>
										</tr>
										<tr class="#this_row()#">
											<td><b>Create a Password</b>
											</td>
											<td><cfinput type="password" name="password" size="20" required="Yes" message="Please enter a password.">
											</td>
										</tr>
										<tr class="#this_row()#">
											<td><b>Re-enter Password</b>
											</td>
											<td><cfinput type="password" name="password2" size="20" required="Yes" message="Please re-enter your password.">
											</td>
										</tr>
										<tr class="#this_row()#">
											<td colspan="2" align="center">
												<input type="Submit" name="proc_reg" value="CLICK  to Become A Member" class="pinkSubmit">								
											</td>
										</tr>
									
									</table>
								
								</td>
							</tr>
						</table>
						</cfoutput>
						</cfform>
						</cfif>
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

</cfif>
<cfinclude template="frmxss.cfm">

</body>
</html>