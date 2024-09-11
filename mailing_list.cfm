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
							<div class="sidebar web-sidebar-modal">
								<cfinclude template="left_.cfm">
							</div>
							<div class="content-section">
								<div class="bottom-content-sec">
									<div class="banner-section">
										<div class="art-work-content">
											<div class="bottom-content">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr height="100%">
														<td height="100%" valign="top" align="center">
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
																						This Customer has uploaded a file to the server: <a href="http://#server_name#/uploads/#cffile.ServerFile#"
																						 target="_blank">[CLICK]</a> to view.
																					</cfif>
																					<br><br>
																				</font>
																			</cfmail>

																			<table border="0" cellpadding="0" cellspacing="0" width="90%">
																				<tr>
																					<td colspan="2">
																						<br><b>Thank you <cfoutput>#form.fname# #form.lname#</cfoutput>. <br><br> Your Email has been
																							sent to the respective personnel. <br><br> We hope that your visit has been a pleasant
																							experience so far.</b><br>
																					</td>
																				</tr>
																			</table>
																</cfif>
																<cfelse>
																	<cfoutput>
																		<CFFORM ACTION="#script_name#" METHOD="POST" enctype="multipart/form-data">
																			<input type="hidden" name="submitted" value="1" />
																			<input type="hidden" name="captcha_check" value="#FORM.captcha_check#" />
																			<table border="0" cellpadding="3" cellspacing="0" width="90%">
																				<tr>
																					<td colspan="2" style="padding-top: 10px;">
																						<h4>MAILING LIST</h4>
																						<cfoutput>
																							<p align="justify">Please enter your name into our Guest Registry, and receive discounts,
																								information, and notices about #companyname#. All information is kept confidential, and used
																								for our site alone.</p>
																						</cfoutput>
																					</td>
																				</tr>
																				<tr>
																					<td colspan="2" style="padding-top: 10px;">
																						<cfif FORM.captchaError EQ 1>
																							<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE
																								EXACTLY AS YOU SEE THEM</span><br><br>
																						</cfif>
																						<cfif FORM.errorPhone EQ 1>
																							<span style="color: ##ff0000; font-weight: bold;">
																								#form.errorMsg#
																							</span><br><br>
																						</cfif>
																						Please sign our Guest Book for upcoming shows and information, and to be placed on our Mailing
																						List.
																					</td>
																				</tr>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>FIRST NAME</b></FONT><br>
																						<cfinput type="text" size=40 maxsize=50 name="fname" value="#form.fname#" required="Yes" MESSAGE="Please fill in your first name.">
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>LAST NAME</b></FONT><br>
																						<cfinput type="text" size=40 maxsize=50 name="lname" value="#form.lname#" required="Yes" MESSAGE="Please fill in your last name.">
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>E-MAIL ADDRESS</b></FONT><br>
																						<cfinput type="text" size=40 maxsize=50 name="email" value="#form.email#" required="Yes" MESSAGE="Please fill in your email address.">
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>HOME PHONE (xxx) xxx-xxxx</b></FONT><br>
																						<cfinput type="text" size=40 maxsize=50 name="phone" value="#form.phone#" required="No" MESSAGE="Please fill in your home phone with a proper number."
																						 mask="(999) 999-9999">
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>PHONE NUMBER OUTSIDE THE US<b></FONT><br>
																						<cfinput type="text" size=40 maxsize=50 name="otherphone" value="#form.otherphone#" required="No">
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>HOW DID YOU HEAR ABOUT US?</b></FONT><br><TEXTAREA
																						 NAME="referral" ROWS=5 COLS=35>#form.referral#</TEXTAREA>
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>WOULD YOU LIKE TO KNOW ABOUT OUR
																								SPECIALS?</b><br>
																							<cfif form.list EQ "1">
																								<input type="radio" name="list" value="1" checked>Yes Please <input type="radio" name="list"
																								 value="0">No Thank You
																								<cfelseif form.list EQ "0">
																									<input type="radio" name="list" value="1">Yes Please <input type="radio" name="list" value="0"
																									 checked>No Thank You
																									<cfelse>
																										<input type="radio" name="list" value="1" checked>Yes Please <input type="radio" name="list"
																										 value="0">No Thank You
																							</cfif>
																						</font>
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>QUESTIONS OR COMMENTS</b></FONT><br><TEXTAREA
																						 NAME="comments" ROWS=10 COLS=35>#form.comments#</TEXTAREA>
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>UPLOAD IMAGE:</b></FONT><br><input
																						 type="file" name="this_upload" style="font-size: 8pt;">
																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<TR>
																					<TD>
																						<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low" fonts="verdana,arial,times new roman,courier,tahoma"
																						 fontsize="28" />
																						<br><br>
																						<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>Please enter the characters in
																								the image above:</b></FONT><br><br>
																						<cfinput type="text" name="captcha" required="true" message="Please enter the characters in the image.">

																					</TD>
																					<td width="75">&nbsp;</td>
																				</TR>
																				<tr>
																					<td colspan="2"><br><br></td>
																				</tr>

																				<TR>
																					<TD><input type="Image" src="images/send.gif" style="border: none;"><br>
																						<input style="background:url(images/reset.gif) no-repeat; width: 87px; height: 30px; border: none;"
																						 type="reset" value="" /></TD>
																					<td width="75">&nbsp;</td>
																				</TR>

																			</table>
																			<br><br>
																		</cfform>
																	</cfoutput>
														</td>
														<td width="207" height="100%" bgcolor="ffffff" valign="top"><br>
															<cfoutput>
																<font face="verdana, arial, helvetica" size="-2">

															</cfoutput>
															</font>
														</td>
													</tr>



												</table>
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