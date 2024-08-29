<!--- Kill extra output. --->
<cfsilent>
	<cfparam name="form.fname" default="">
	<cfparam name="form.lname" default="">
	<cfparam name="form.comments" default="">
	<cfparam name="form.email" default="">
	<cfparam name="form.cellphone" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.businessphone" default="">
	<cfparam name="form.otherphone" default="">
	<cfparam name="form.website" default="">
	<cfparam name="form.list" default="">
	<cfparam name="form.captchaError" default="0">
	<cfparam name="form.errorMsg" default="">
 	<cfparam name="form.errorPhone" default="0">
	<cfparam
		name="FORM.captcha"	type="string"	default=""	/>

	<cfparam
		name="FORM.captcha_check"	type="string" default="" />

	<cftry>
		<cfparam
			name="FORM.submitted"	type="numeric"	default="0"	/>

		<cfcatch>
			<cfset FORM.submitted = 0 />
		</cfcatch>
	</cftry>

	<!--- Set a flag to see if this user is a bot or not. --->
	<cfset blnIsBot = true />
	<cfset phoneError = false />

	<!--- Check to see if the form has been submitted. --->

	<cfif FORM.submitted>

			<cfset errorMsg = "" />

			<cfif len(form.cellphone) AND NOT isValid("regex",form.cellphone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = "Please enter your cell phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>
			<cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = errorMsg & "Please enter your home phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>
			<cfif len(form.businessphone) AND NOT isValid("regex",form.businessphone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = errorMsg & "Please enter your business phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>

			<cfif errorMsg NEQ "">
				<cfset phoneError = true />

			<cfelse>




				<cftry>

					<!--- Decrypt the check value. --->
					<cfset strCaptcha = Decrypt( FORM.captcha_check, "gallart-is-the-best", "CFMX_COMPAT", "HEX"	) />

					<cfif (strCaptcha EQ FORM.captcha)>

						<cfset blnIsBot = false />

					</cfif>

					<cfcatch>

						<cfset blnIsBot = true />

					</cfcatch>
				</cftry>

			</cfif>

	</cfif>

	<cfset arrValidChars = ListToArray(
		"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
		"2,3,4,5,6,7,8,9"
		) />

	<!--- Now, shuffle the array. --->
	<cfset CreateObject( "java", "java.util.Collections"	).Shuffle(	arrValidChars )	/>

	<cfset strCaptcha = (
		arrValidChars[ 1 ] &
		arrValidChars[ 2 ]
		) />

	<cfset FORM.captcha_check = Encrypt( strCaptcha,"gallart-is-the-best", "CFMX_COMPAT", "HEX" ) />

</cfsilent>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

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

<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<cfoutput>
<form method="post" action="#script_name#?xss=#xss#" name="errorFrm">
	<input type="Hidden" name="fname">
	<input type="Hidden" name="lname">
	<input type="Hidden" name="email">
	<input type="Hidden" name="cellphone">
	<input type="Hidden" name="phone">
	<input type="Hidden" name="businessphone">
	<input type="Hidden" name="otherphone">
	<input type="Hidden" name="website">
	<input type="Hidden" name="comments">
	<input type="Hidden" name="errorMsg">
	<input type="Hidden" name="captchaError" value="0">
	<input type="Hidden" name="errorPhone" value="0">
</form>
</cfoutput>
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
		<td valign="top" width="627" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr height="100%">
					<td height="100%" valign="top" align="center">
						<cfif FORM.submitted>
							<!--- Check for a bot. --->
							<cfif phoneError>
								<cfoutput>
									<script language="JavaScript">
										document.errorFrm.fname.value = '#form.fname#'
										document.errorFrm.lname.value = '#form.lname#'
										document.errorFrm.email.value = '#form.email#'
										document.errorFrm.cellphone.value = '#form.cellphone#'
										document.errorFrm.phone.value = '#form.phone#'
										document.errorFrm.businessphone.value = '#form.businessphone#'
										document.errorFrm.otherphone.value = '#form.otherphone#'
										document.errorFrm.website.value = '#form.website#'
										document.errorFrm.comments.value = '#form.comments#'
										document.errorFrm.errorMsg.value = '#errorMsg#'
										document.errorFrm.errorPhone.value = '1'
										document.errorFrm.submit();
									</script>
			 					</cfoutput>
							<cfelseif blnIsBot>
			 					<cfoutput>
									<script language="JavaScript">
										document.errorFrm.fname.value = '#form.fname#'
										document.errorFrm.lname.value = '#form.lname#'
										document.errorFrm.email.value = '#form.email#'
										document.errorFrm.cellphone.value = '#form.cellphone#'
										document.errorFrm.phone.value = '#form.phone#'
										document.errorFrm.businessphone.value = '#form.businessphone#'
										document.errorFrm.otherphone.value = '#form.otherphone#'
										document.errorFrm.website.value = '#form.website#'
										document.errorFrm.comments.value = '#form.comments#'
										document.errorFrm.errorMsg.value = '#errorMsg#'
										document.errorFrm.captchaError.value = '1'
										document.errorFrm.submit();
									</script>
			 					</cfoutput>

							<cfelse>

								<cftry>
									<cfquery name="addgLead" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
										INSERT into leads
										(
											fname,
											lname,
											notes,
											email,
											cellphone,
											phone,
											businessphone,
											otherphone,
											website,
											maillist
										)
										values
										(
											'#form.fname#',
											'#form.lname#',
											'#form.comments#',
											'#form.email#',
											'#form.cellphone#',
											'#form.phone#',
											'#form.businessphone#',
											'#form.otherphone#',
											'#form.website#',
											'#form.list#'
										)
									</cfquery>

								<cfcatch type="Any">Sorry - we have encountered a processing error.  Please try again.<cfabort></cfcatch>
								</cftry>



<cftry>
<!--- <cfdump var='#cgi#' label='cgi' expand=0 abort=1> --->

								<cfmail server="#servername#" username="gallart@onlinegalleryart.com"
	password="re3objeC!P" to="#emailsupport#" cc="#emailsupportcc#"  from="#form.email#" subject="GallArt.com <> Buying & Selling Fine Art <> Guest Registry Form" type="HTML">
									<font style="font-size: 10pt; font-family: Arial;">
									Client Information:
									<br><br>
									Name: #form.fname# #form.lname#<br>
									Email Address: #form.email#<br>
									Cell Phone: #form.cellphone#<br>
									Home Phone: #form.phone#<br>
									Business Phone: #form.businessphone#<br>
									Phone Outside the US: #form.otherphone#<br>
									Website: #form.website#<br>
									Comments: #form.comments#<br>
									<br><br>
									</font>
								</cfmail>


<cfcatch>
<cfdump var='#cfcatch#' label='cfcatch' expand=0 abort=1>
</cfcatch>
</cftry>


								<table border="0" cellpadding="0" cellspacing="0" width="90%">
									<tr>
										<td colspan="2">
										<br><b>Thank you <cfoutput>#form.fname# #form.lname#</cfoutput>. <br><br> Your Email has been sent to the respective personnel. <br><br>   We hope that your visit has been a pleasant experience so far.</b><br>
										</td>
									</tr>
								</table>
							</cfif>
						<cfelse>
						<cfoutput>
					<cfform ACTION="#script_name#?xss=#xss#" METHOD="POST" name="guestFrm"> 


						<input type="hidden" name="submitted" value="1" />
						<input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
						<table border="0" cellpadding="3" cellspacing="0" width="98%">
						<tr>
							<td colspan="2" style="padding-top: 10px;">
								<h4>GUEST LIST</h4>
								<cfif FORM.captchaError EQ 1>
									<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span><br><br>
								</cfif>
								<cfif FORM.errorPhone EQ 1>
									<span style="color: ##ff0000; font-weight: bold;">
										#form.errorMsg#
									</span><br><br>
								</cfif>
								Please sign our Guest Book for upcoming shows and information, and to be placed on our Mailing List.
							</td>
						</tr>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>FIRST NAME</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="fname" value="#form.fname#" required="Yes" MESSAGE="Please fill in your first name."></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>LAST NAME</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="lname" value="#form.lname#" required="Yes" MESSAGE="Please fill in your last name."></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>E-MAIL ADDRESS</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="email" value="#form.email#" required="Yes" MESSAGE="Please fill in a proper email address." validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$"></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>CELL PHONE (xxx) xxx-xxxx</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="cellphone" value="#form.cellphone#" required="No" MESSAGE="Please fill in your cell phone with a proper number." mask="(999) 999-9999"></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>HOME PHONE (xxx) xxx-xxxx</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="phone" value="#form.phone#" required="No" MESSAGE="Please fill in your home phone with a proper number." mask="(999) 999-9999"></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>BUSINESS PHONE (xxx) xxx-xxxx</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="businessphone" value="#form.businessphone#" required="No" MESSAGE="Please fill in your business phone with a proper number." mask="(999) 999-9999"></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>PHONE NUMBER OUTSIDE THE US<b></FONT><br><cfinput type="text" size=40 maxsize=50 name="otherphone" value="#form.otherphone#" required="No" ></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>WEBSITE</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="website" value="#form.website#" required="No" MESSAGE="Please fill in your website."></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>COMMENTS</b></FONT><br><TEXTAREA NAME="comments" ROWS=10 COLS=35>#form.comments#</TEXTAREA></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD>
								<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low"	fonts="verdana,arial,times new roman,courier,tahoma" fontsize="28"	/>
							<br><br>
							<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>Please enter the characters in the image above:</b></FONT><br><br>
							<cfinput type="text" name="captcha" required="true" message="Please enter the characters in the image.">

							</TD>
							<td width="75">&nbsp;</td>
						</TR>
	<!--spacer starts-->
	   				 	<tr><td colspan="2"><br></td></tr>
	<!--spacer ends-->
						<TR>
							<TD><input type="Image" src="images/send.gif" style="border: none;"><br>
							<input style="background:url(images/reset.gif) no-repeat; width: 87px; height: 30px; border: none; cursor: pointer;" type="reset" value="" /></TD>
							<td width="75">&nbsp;</td>
						</TR>

						</table>
						</cfform>
						</cfoutput>
					</td>
					<td width="207" height="100%" bgcolor="ffffff" valign="top"><br>

					</td>
				</tr>



			</table>
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

<cfinclude template="frmxss.cfm">

</body>
</html>
