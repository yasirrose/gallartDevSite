<!--  Kill extra output.  -->
<cfsilent>
	<cfparam name="form.fname" default="">	
	<cfparam name="form.lname" default="">						
	<cfparam name="form.email" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.otherphone" default="">
	<cfparam name="form.referral" default="">
	<cfparam name="form.list" default="">
	<cfparam name="form.comments" default="">
	<cfparam name="form.captchaError" default="0">
	<cfparam name="form.errorMsg" default="">
 	<cfparam name="form.errorPhone" default="0">
	<cfparam name="FORM.captcha" type="string" default="" />
 
	<cfparam name="FORM.captcha_check" type="string" default="" />
 
	<cftry>
		<cfparam name="FORM.submitted" type="numeric" default="0" />
 
		<cfcatch>
			<cfset FORM.submitted=0 />
		</cfcatch>
	</cftry>
 
	<!--  Set a flag to see if this user is a bot or not.  -->
	<cfset blnIsBot=true />
	<cfset phoneError=false />
 
	<!--  Check to see if the form has been submitted. --> 
	
	<cfif FORM.submitted>

		<cfset errorMsg="" />

		<cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[
			]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
			   <cfset errorMsg=errorMsg & "Please enter your phone number in the format (xxx) xxx-xxxx <br/>" />
		   </cfif>

			<cfif errorMsg NEQ "">
				<cfset phoneError=true />

			<cfelse>

				<cftry>
		 
					<!-- - Decrypt the check value.  -->
					<cfset strCaptcha=Decrypt( FORM.captcha_check, "gallart-is-the-best" , "CFMX_COMPAT" , "HEX" ) />

					<cfif (strCaptcha EQ FORM.captcha)>

						<cfset blnIsBot=false />
		 
					</cfif>

					<cfcatch>

						<cfset blnIsBot=true />
		 
					</cfcatch>
				</cftry>

			</cfif>
 
	</cfif>

	<cfset arrValidChars=ListToArray( "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
												 "2,3,4,5,6,7,8,9" ) />
 
	<!--  Now, shuffle the array.  -->
	<cfset CreateObject( "java" , "java.util.Collections" ).Shuffle( arrValidChars ) />

												<cfset strCaptcha=( arrValidChars[ 1 ] & arrValidChars[ 2 ] ) />

												<cfset FORM.captcha_check=Encrypt( strCaptcha,"gallart-is-the-best", "CFMX_COMPAT" , "HEX" ) />
 
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<!-- - get autoemail content  -->
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
<!--- <script language="JavaScript" src="http://#server_name#/js/utils.js"></script> --->
<script language="JavaScript" src="./js/utils.js"></script>
				<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
				<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
				<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
				<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</cfoutput>

<link href="stylesheet_.css" rel="stylesheet" type="text/css">

<!-- BEGIN ROBLY WIDGET CODE -->
<script type='text/javascript'>
  var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
  (function (w, d, p, s, s2) {
	w[p] = w[p] || function () { (w[p].q = w[p].q || []).push(arguments) };
    s = d.createElement('script'); s.async = 1; s.src = '//s3.amazonaws.com/roblyimages/accounts/20559/forms/29541/signup_popup.js';
    s2 = d.getElementsByTagName('script')[0]; s2.parentNode.insertBefore(s, s2);
  })(window, document, 'Robly');
</script>
<!-- END ROBLY WIDGET CODE -->

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<div class="main-container registration-page">
	<cfoutput>
	<form method="post" action="#script_name#?xss=#xss#" name="errorFrm">
		<input type="Hidden" name="fname">
		<input type="Hidden" name="lname">
		<input type="Hidden" name="email">
		<input type="Hidden" name="phone">
		<input type="Hidden" name="otherphone">
		<input type="Hidden" name="referral">
		<input type="Hidden" name="list">
		<input type="Hidden" name="comments">
		<input type="Hidden" name="errorMsg">
		<input type="Hidden" name="captchaError" value="0">
		<input type="Hidden" name="errorPhone" value="0">
	</form>
	</cfoutput>
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
					<!--- <div class="sidebar web-sidebar-modal">
						<cfinclude template="left_.cfm">
					</div> --->
					<div class="content-section">
						<div class="bottom-content-sec">
							<div class="banner-section">
								<div class="art-work-content">

									<div aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                          <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Home</a></li>
                                          <li class="breadcrumb-item active" aria-current="page">Mailing List</li>
                                        </ol>
                                    </div>

									<div class="bottom-content">
										<div class="user-registrations mailing-page quotes-page">	
						<cfif FORM.submitted>	
							<!--  Check for a bot. -->
							<cfif phoneError>
								<cfoutput>
									<script language="JavaScript">
										document.errorFrm.fname.value = '#form.fname#'
										document.errorFrm.lname.value = '#form.lname#'
										document.errorFrm.email.value = '#form.email#'
										document.errorFrm.phone.value = '#form.phone#'
										document.errorFrm.otherphone.value = '#form.otherphone#'
										document.errorFrm.referral.value = '#form.referral#'
										document.errorFrm.list.value = '#form.list#'
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
										document.errorFrm.phone.value = '#form.phone#'
										document.errorFrm.otherphone.value = '#form.otherphone#'
										document.errorFrm.referral.value = '#form.referral#'
										document.errorFrm.list.value = '#form.list#'
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
											phone,
											otherphone,
											maillist
										)
										values
										(
											'#form.fname#',
											'#form.lname#', 
											'#form.comments#', 
											'#form.email#', 
											'#form.phone#', 
											'#form.otherphone#', 
											'#form.list#'
										)
									</cfquery>
									
									<cfcatch type="Any">Sorry - we have encountered a processing error. Please try again.<cfabort>
									</cfcatch>
								</cftry> 
								<cfif len(form.this_upload)>
									<cffile action="UPLOAD" filefield="this_upload" destination="#ExpandPath('.')#\uploads\"
															nameconflict="MAKEUNIQUE">
								</cfif>
								<cfmail server="#servername#" username="gallart@onlinegalleryart.com" password="re3objeC!P" to="#emailsupport#"
														cc="#emailsupportcc#" from="#form.email#" subject="GallArt.com <> Buying & Selling Fine Art <> Guest Registry Form"
														type="HTML">
									<font style="font-size: 10pt; font-family: Arial;">
									Client Information:
									<br><br>
									Name: #form.fname# #form.lname#<br>
									Email Address: #form.email#<br>
									Phone: #form.phone#<br>
									Phone Outside the US: #form.otherphone#<br>
									Where did you hear about us? #form.referral#<br>
									Questions / Comments:<br>
									#form.comments#
									<br><br>
									<cfif len(form.this_upload)>
									This Customer has uploaded a file to the server: <a href="https://#server_name#/uploads/#cffile.ServerFile#"
									target="_blank">[CLICK]</a> to view.
									</cfif>
									<br><br>
									</font>
								</cfmail>									
								<p><b>Thank you <cfoutput>#form.fname# #form.lname#</cfoutput>. <br><br> Your Email has been
									sent to the respective personnel. <br><br> We hope that your visit has been a pleasant
									experience so far.</b>
								</p>
							</cfif>
						<cfelse>	
						<cfoutput>	
						<CFFORM ACTION="#script_name#" METHOD="POST" enctype="multipart/form-data">	
						<input type="hidden" name="submitted" value="1" />
						<input type="hidden" name="captcha_check" value="#FORM.captcha_check#" />
						<div class="top-heading">
							<h3>MAILING LIST</h3>
							<cfoutput>
								<p align="justify">Please enter your name into our Guest Registry, and receive discounts,
									information, and notices about #companyname#. All information is kept confidential, and used
									for our site alone.</p>
							</cfoutput>
						</div>
						<cfif FORM.captchaError EQ 1>
							<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE
								EXACTLY AS YOU SEE THEM</span><br><br>
						</cfif>
								<cfif FORM.errorPhone EQ 1>
									<span style="color: ##ff0000; font-weight: bold;">
										#form.errorMsg#
									</span><br><br>
								</cfif>
								<p>Please sign our Guest Book for upcoming shows and information, and to be placed on our Mailing List.</p>
								<div class="input-form">
									<div class="input-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>FIRST NAME</b></FONT></label>
										<cfinput type="text" size=40 maxsize=50 name="fname" value="#form.fname#" required="Yes" MESSAGE="Please fill in your first name.">
									</div>
									<div class="input-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>LAST NAME</b></FONT></label>
										<cfinput type="text" size=40 maxsize=50 name="lname" value="#form.lname#" required="Yes" MESSAGE="Please fill in your last name.">
									</div>
									<div class="input-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>E-MAIL ADDRESS</b></FONT></label>
										<cfinput type="text" size=40 maxsize=50 name="email" value="#form.email#" required="Yes" MESSAGE="Please fill in your email address.">
									</div>
									<div class="input-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>HOME PHONE (xxx) xxx-xxxx</b></FONT></label>
										<cfinput type="text" size=40 maxsize=50 name="phone" value="#form.phone#" required="No" MESSAGE="Please fill in your home phone with a proper number." mask="(999) 999-9999">
									</div>
									<div class="input-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>PHONE NUMBER OUTSIDE THE US</b></FONT></label>
										<cfinput type="text" size=40 maxsize=50 name="otherphone" value="#form.otherphone#" required="No">
									</div>
									<div class="input-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>HOW DID YOU HEAR ABOUT US?</b></FONT></label>
										<TEXTAREA NAME="referral" ROWS=5 COLS=35>#form.referral#</TEXTAREA>
									</div>
									<div class="input-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>WOULD YOU LIKE TO KNOW ABOUT OUR
												SPECIALS?</b></FONT></label>
										<cfif form.list EQ "1">
											<div class="checkbox">
												<div class="checkbox-field">
													<input type="radio" name="list" value="1" checked>Yes Please <input type="radio" name="list"
													value="0">
													<label>No Thank You</label>
												</div>
											</div>
												<cfelseif form.list EQ "0">
											<div class="checkbox">
												<div class="checkbox-field">
													<input type="radio" name="list" value="1">Yes Please <input type="radio" name="list" value="0" checked>
													<label>No Thank You</label>
												</div>
											</div>
												<cfelse>
											<div class="checkbox">
												<div class="checkbox-field">
													<input type="radio" name="list" value="1" checked>
													<label>Yes Please</label>
												</div>
												<div class="checkbox-field">
													<label><input type="radio" name="list" value="0"></label>
													<label>No Thank You</label>
												</div>	 
											</div>
										</cfif>
									</div>
									<div class="input-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>QUESTIONS OR COMMENTS</b></FONT></label>
										<TEXTAREA NAME="comments" ROWS=10 COLS=35>#form.comments#</TEXTAREA>
									</div>
									<div class="choose-field">
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>UPLOAD IMAGE:</b></FONT></label>
										<input type="file" name="this_upload">
									</div>
									<div class="input-field">
										<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low" fonts="verdana,arial,times new roman,courier,tahoma"
										fontsize="28" />
										<label><FONT face="verdana,arial,helvetica" color="000000"><b>Please enter the characters in
												the image above:</b></FONT></label>
										<cfinput type="text" name="captcha" required="true" message="Please enter the characters in the image.">
									</div>
									<div class="input-button">
										<button type="submit" class="SeeMore">Send</button>
										<button type="reset" class="SeeMore">Reset</button>
									</div>
					</div>
					</cfform>	
				</cfoutput>
							<cfoutput>
								<font face="verdana, arial, helvetica">

							</cfoutput>
</font>		
		</div>
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
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer_.cfm">
		</td>
	</tr>
<cfinclude template="frmxss.cfm">

</body>

</html>