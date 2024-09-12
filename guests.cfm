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
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
</cfoutput>

<cfinclude template="meta.cfm">

<link href="stylesheet_.css" rel="stylesheet" type="text/css">
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
<div class="main-container registration-page">
	<div id="Table_01">
		<div class="header-section">
			<div class="top-header">
				<cfinclude template="top_.cfm">
			</div>
			<div class="navbar-section">
				<cfinclude template="navbar_.cfm">
			</div>
		</div>
		<div class="inner-section">
			<div class="container-fluid">
				<div class="main-content">
					<div class="mobile-sidebar-logo">
						<div class="sidebar-Icon">
							<i class="fas fa-bars"></i>
						</div>
					</div>
					<div class="sidebar web-sidebar-modal">	
						<cfinclude template="left_.cfm">
					</div>
					<div class="content-section">
						<div class="bottom-content-sec">
							<div class="banner-section">
								<div class="art-work-content">
									<div class="bottom-content">
										<div class="user-registrations guests-page">
											<div class="user-content">
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
														<cfmail server="#servername#" username="gallart@onlinegalleryart.com" password="re3objeC!P" to="#emailsupport#" cc="#emailsupportcc#"  from="#form.email#" subject="GallArt.com <> Buying & Selling Fine Art <> Guest Registry Form" type="HTML">
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
														<div>
															<p><br><b>Thank you <cfoutput>#form.fname# #form.lname#</cfoutput>. <br><br> Your Email has been sent to the respective personnel. <br><br>   We hope that your visit has been a pleasant experience so far.</b><br></p>
														</div>
													</cfif>
												<cfelse>
												<cfoutput>
													<cfform ACTION="#script_name#?xss=#xss#" METHOD="POST" name="guestFrm"> 
														<input type="hidden" name="submitted" value="1" />
														<input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
														<div class="top-heading">
															<h3>GUEST LIST</h3>
															<cfif FORM.captchaError EQ 1>
																<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span>
															</cfif>
															<cfif FORM.errorPhone EQ 1>
																<span style="color: ##ff0000; font-weight: bold;">
																	#form.errorMsg#
																</span>
															</cfif>
															<p>Please sign our Guest Book for upcoming shows and information, and to be placed on our Mailing List.</p>
														</div>
														<div class="input-form">
															<div class="input-field">
																<label><b>FIRST NAME</b></label>
																<cfinput type="text" size=40 maxsize=50 name="fname" value="#form.fname#" required="Yes" MESSAGE="Please fill in your first name.">
															</div>
															<div class="input-field">
																<label><b>LAST NAME</b></label>
																<cfinput type="text" size=40 maxsize=50 name="lname" value="#form.lname#" required="Yes" MESSAGE="Please fill in your last name.">
															</div>
															<div class="input-field">
																<label><b>E-MAIL ADDRESS</b></label>
																<cfinput type="text" size=40 maxsize=50 name="email" value="#form.email#" required="Yes" MESSAGE="Please fill in a proper email address." validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$">
															</div>
															<div class="input-field">
																<label><b>CELL PHONE (xxx) xxx-xxxx</b></label>
																<cfinput type="text" size=40 maxsize=50 name="cellphone" value="#form.cellphone#" required="No" MESSAGE="Please fill in your cell phone with a proper number." mask="(999) 999-9999">
															</div>
															<div class="input-field">
																<label><b>HOME PHONE (xxx) xxx-xxxx</b></label>
																<cfinput type="text" size=40 maxsize=50 name="phone" value="#form.phone#" required="No" MESSAGE="Please fill in your home phone with a proper number." mask="(999) 999-9999">
															</div>
															<div class="input-field">
																<label><b>BUSINESS PHONE (xxx) xxx-xxxx</b></label>
																<cfinput type="text" size=40 maxsize=50 name="businessphone" value="#form.businessphone#" required="No" MESSAGE="Please fill in your business phone with a proper number." mask="(999) 999-9999">
															</div>
															<div class="input-field">
																<label><b>PHONE NUMBER OUTSIDE THE US<b></label>
																<cfinput type="text" size=40 maxsize=50 name="otherphone" value="#form.otherphone#" required="No" >
															</div>
															<div class="input-field">
																<label><b>WEBSITE</b></label>
																<cfinput type="text" size=40 maxsize=50 name="website" value="#form.website#" required="No" MESSAGE="Please fill in your website.">
															</div>
															<div class="input-field">
																<label><b>COMMENTS</b></label>
																<TEXTAREA NAME="comments" ROWS=10 COLS=35>#form.comments#</TEXTAREA>
															</div>
															<div class="input-field">
																<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low"	fonts="verdana,arial,times new roman,courier,tahoma" fontsize="28"	/>
																<br><br>
																<label><b>Please enter the characters in the image above:</b></label>
																<cfinput type="text" name="captcha" required="true" message="Please enter the characters in the image.">
															</div>
															<div class="input-button">
																<button type="button" class="SeeMore">Send</button>
																<button type="button" class="SeeMore">Reset</button>
															</div>
														</div>
														</cfform>
														</cfoutput>
													</cfif>
											</div>
										</div>	
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<tr>
	<td colspan="2" valign="baseline">
		<cfinclude template="footer_.cfm">
	</td>
</tr>

<cfinclude template="frmxss.cfm">

</body>
</html>
