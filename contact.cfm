<!--- Kill extra output. --->
<cfsilent>
	<cfparam name="form.fname" default="">
	<cfparam name="form.lname" default="">
	<cfparam name="form.name" default="">
	<cfparam name="form.comments" default="">
	<cfparam name="form.email" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.phoneType" default="">
	<cfparam name="form.otherphone" default="">
	<cfparam name="form.list" default="">
	<cfparam name="form.captchaError" default="0">
	<cfparam name="form.errorMsg" default="">
	<cfparam name="form.errorPhone" default="0">

	<cfparam name="FORM.captcha"	type="string"	default=""	/>

	<cfparam name="FORM.captcha_check"	type="string" default="" />

	<cftry>
	   <cfparam name="FORM.submitted"	type="numeric"	default="0"	/>

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

	   <!--- <cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
			<cfset errorMsg = "Please enter your phone number in the format (xxx) xxx-xxxx <br/>" />
		</cfif> --->

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
	   </cfoutput>

	   <cfinclude template="meta.cfm">

	   <link href="/stylesheet_.css" rel="stylesheet" type="text/css">
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

	   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	   <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

	</head>
	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	   <div class="main-container registration-page">
		  <cfoutput>
			 <form method="post" action="#script_name#" name="errorFrm">
				<input type="Hidden" name="fname">
				<input type="Hidden" name="lname">
				<input type="Hidden" name="name">
				<input type="Hidden" name="email">
				<input type="Hidden" name="phone">
				<input type="Hidden" name="otherphone">
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
										<li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
										<li class="breadcrumb-item active" aria-current="page">Contact Us</li>
									 </ol>
								  </div>

								  <div class="bottom-content">
									 <div class="user-registrations quotes-page contact-page">
										<cfif FORM.submitted>

											<cfset apikey="6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">

											<cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post">
												<cfhttpparam type="formField" name="secret" value="#apikey#">
												<cfhttpparam type="formField" name="response" value="#FORM['g-recaptcha-response']#">
												<cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
											</cfhttp>
													
											<cfset captchaResponse = DeserializeJSON(cfhttp.FileContent)>

										   <!--- Check for a bot. --->
										   <cfif phoneError>
											  <cfoutput>
												 <script language="JavaScript">
													document.errorFrm.fname.value = '#form.fname#'
													document.errorFrm.lname.value = '#form.lname#'
													document.errorFrm.name.value = '#form.name#'
													document.errorFrm.email.value = '#form.email#'
													document.errorFrm.phone.value = '#form.phone#'
													document.errorFrm.phone.value = '#form.phoneType#'
													document.errorFrm.otherphone.value = '#form.otherphone#'
													document.errorFrm.comments.value = '#form.comments#'
													document.errorFrm.errorMsg.value = '#errorMsg#'
													document.errorFrm.errorPhone.value = '1'
													document.errorFrm.submit();
												 </script>
											  </cfoutput>
											  <cfelseif captchaResponse.success NEQ 'YES'>
											  <cfoutput>
												 <script language="JavaScript">
													document.errorFrm.fname.value = '#form.fname#'
													document.errorFrm.lname.value = '#form.lname#'
													document.errorFrm.name.value = '#form.name#'
													document.errorFrm.email.value = '#form.email#'
													document.errorFrm.phone.value = '#form.phone#'
													document.errorFrm.phone.value = '#form.phoneType#'
													document.errorFrm.otherphone.value = '#form.otherphone#'
													document.errorFrm.comments.value = '#form.comments#'
													document.errorFrm.errorMsg.value = '#errorMsg#'
													document.errorFrm.captchaError.value = '1'
													document.errorFrm.submit();
												 </script>
											  </cfoutput>

											  <cfelse>

												<cftry>
													
													<cfif len(trim(form.phone)) AND form.phoneType EQ "Home Phone">
														<cfset phone = form.phone>
													<cfelse>
														<cfset phone = "">
													</cfif>

													<cfif len(trim(form.phone)) AND form.phoneType EQ "Cell Phone">
														<cfset cellphone = form.phone>
													<cfelse>
														<cfset cellphone = "">
													</cfif>

													<cfif len(trim(form.phone)) AND form.phoneType EQ "Business Phone">
														<cfset businessphone = form.phone>
													<cfelse>
														<cfset businessphone = "">
													</cfif>

													<cfif len(trim(form.phone)) AND form.phoneType EQ "OutsideUS">
														<cfset otherphone = form.phone>
													<cfelse>
														<cfset otherphone = "">
													</cfif>

													<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
													<cfset date = now()>
													<cfset moduleName = 'contact'>
													<cfset action = 'Insert'>
													
													<cfif form.name neq '' and form.email neq ''>
														<cfquery name="addgLead" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
															insert into leads (name, notes, email, phone,cellphone, businessphone, otherphone, maillist)
															values('#form.name#', '#form.comments#', '#form.email#', '#phone#', '#cellphone#', '#businessphone#', '#otherphone#', '#form.list#')
														</cfquery>													

															<script>
																$(document).ready(function() {
																	toastr.options = {
																		'closeButton': true,
																		'debug': false,
																		'newestOnTop': false,
																		'progressBar': true,
																		'positionClass': 'toast-center-center',
																		'preventDuplicates': false,
																		'showDuration': '1000',
																		'hideDuration': '1000',
																		'timeOut': '5000',
																		'extendedTimeOut': '1000',
																		'showEasing': 'swing',
																		'hideEasing': 'linear',
																		'showMethod': 'fadeIn',
																		'hideMethod': 'fadeOut',
																	}
																	toastr.success('Your Record is added successfully.');
																});

																
															</script>

															<style>
																/* Force center positioning */
																#toast-container.toast-center-center {
																	top: 40% !important;
																	left: 50% !important;
																	transform: translate(-50%, -50%) !important;
																	position: fixed !important;
																	margin: 0 auto;
																}

																/* Custom pink + white */
																#toast-container > .toast-success {
																	background-color: #ff4da6 !important;
																	color: #fff !important;
																	font-weight: bold;
																}
															</style>

															<cfquery name="addLog" datasource="#application.dsource#" >
																INSERT INTO logs 
																	( moduleName, ipAddress, date, action)
																	VALUES
																	( '#moduleName#', '#ipAddress#', #date#, '#action#')
															</cfquery>
																								  
															<cfmail 
																server="#servername#" 
																username="gallart@onlinegalleryart.com"
																password="re3objeC!P" 
																to="#emailsupport#" 
																cc="#emailsupportcc#"  
																from="#form.email#" 
																subject="GallArt.com <> Buying & Selling Fine Art <> Contact Form" 
																type="HTML"
																>
																<font style="font-size: 10pt; font-family: Arial;">
																Client Information:
																<br><br>
																<!--- Name: #form.fname# #form.lname#<br> --->
																Name: #form.name#<br>
																Email Address: #form.email#<br>
																Phone: #form.phone#<br>
																Phone Outside the US: #form.otherphone#<br>
																Comments: #form.comments#<br>
																<br><br>
																</font>
															</cfmail>

															<p>
																<b>
																	Thank you 
																	<!--- <cfoutput>#form.fname# #form.lname#</cfoutput> --->
																	<cfoutput>#form.name# </cfoutput>
																	. <br><br> Your Email has been sent to the respective personnel. <br><br>   We hope that your visit has been a pleasant experience so far.
																</b>
															</p>
													 <cfelse>
														<cfoutput>
															<p style="color: red;">Error: Your data is not added. Please fill out all required fields before submitting the form.</p>
														</cfoutput>
													</cfif>
													<cfcatch type="Any">
														Sorry - we have encountered a processing error.  Please try again.
														<cfabort>
													</cfcatch>
												</cftry>
										   </cfif>
										 <cfelse>
											<cfoutput>
												<CFFORM ACTION="/contact-us" METHOD="POST" name="guestFrm" onsubmit="return validateForm(event)">
													<input type="hidden" name="submitted" value="1" />
													<input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
													<div class="top-heading">
														<h3>CONTACT US</h3>
													</div>
													<cfif FORM.captchaError>
														<p style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</p>
													</cfif>
													<cfif FORM.errorPhone EQ 1>
														<p style="color: ##ff0000; font-weight: bold;">
														#form.errorMsg#
														</p>
													</cfif>
													<p>Please contact us using the form below:</p>

													<span style="color: ##ff0000;">* Required</span><br><br>

													<div class="input-form">
														<div class="row">															

															<div class="col-md-6">
																<div class="input-field">
																	<cfinput type="text" size=40 maxsize=50 maxLength="30" name="name" id="name" placeholder="Enter your Name*" value="#form.name#" autosuggest="cfc:admin.models.leads.searchLeadsByName({cfautosuggestvalue})" maxResultsDisplay="10">
																	<span class="error-message" id="nameError"></span>
																</div>
															</div>

															<div class="col-md-6">
																<div class="input-field">
																	<cfinput type="text" size=40 maxsize=50 maxlength="30" name="email" placeholder="Enter your Email Address*" value="#form.email#" autosuggest="cfc:admin.models.leads.searchLeadsByEmail({cfautosuggestvalue})" maxResultsDisplay="10" align="left" style="z-index:1000;" tabindex="0">
																	<span class="error-message" id="emailError"></span>
																</div>
															</div>

															<div class="col-md-6">
																<div class="input-field">
																	<select name="phoneType" id="phoneType" >
																		<option value="Cell Phone">Cell Phone</option>
																		<option value="Home Phone">Home Phone</option>
																		<option value="Business Phone">Business Phone</option>
																		<option value="OutsideUS">Outside US Phone</option>
																	</select>
																</div>
															</div>

															<div class="col-md-6">
																<div class="input-field">
																	<cfinput type="text" size=40 maxsize=50 maxLength="20" name="phone" placeholder="Enter your Phone Number" value="#form.phone#" >
																	<span id="formatSign">(xxx) xxx-xxxx</span>
																	<span class="error-message" id="phoneError"></span>
																</div>
															</div>

														</div>
														<div class="input-field">
														
															<TEXTAREA NAME="comments" id="comments" maxlength="500" ROWS=10 COLS=35 placeholder="Enter your Comments">#form.comments#</TEXTAREA>
														 	<div id="charCount" class="mb-3">0 / 500 characters</div>
														</div>

														<!--- <div class="input-field">
														<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low"	fonts="verdana,arial,times new roman,courier" fontsize="28"/>
														<label><FONT color="000000"><b>Please enter the characters in the image above: <span style="color:##ff0000;">*</span></b></FONT></label>
														<cfinput type="text" name="captcha" >
														<span class="error-message" id="captchaError"></span>
														</div> --->

														<div class="input-field pt-3">
															<div class="g-recaptcha" id="gRecaptchaGeneral" data-sitekey="6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne"></div>
															<span class="error-message" id="recaptchaError"></span>
														</div>

														<div class="input-button">
															<button type="submit" id="submitBtn" class="SeeMore">Send</button>
															<button type="reset" class="SeeMore">Reset</button>
														</div>
													</div>
												</CFFORM>
											</cfoutput>
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

	   <script src="https://www.google.com/recaptcha/api.js" async defer></script>

	   <script>
		 function validateForm(e) {
			let isValid = true;
			
			// Clear previous error messages
			document.querySelectorAll('.error-message').forEach(error => error.textContent = '');
			
			// Get form field values
			const name = document.getElementById('name').value.trim();
			const email = document.getElementById('email').value.trim();
			const phone = document.getElementById('phone').value.trim();
			const phoneType = document.querySelector("[name='phoneType']").value;
			// const captcha = document.getElementById('captcha').value.trim();

			const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;

			const submitButton = document.getElementById('submitBtn');

			var recaptcha = grecaptcha.getResponse();
			console.log(recaptcha.length);
			

			if (recaptcha.length == 0) {
				document.getElementById("recaptchaError").innerText = "Please confirm you are not a robot.";
				isValid = false;
			}
						

			if (!name) {
				document.getElementById('nameError').textContent = 'Please enter your name.';
				isValid = false;
			}
			
			// Validate EMAIL
			if (!email) {
				document.getElementById('emailError').textContent = 'Please fill in your email address.';
				isValid = false;
			} else if (!/\S+@\S+\.\S+/.test(email)) {
				document.getElementById('emailError').textContent = 'Please enter a valid email address.';
				isValid = false;
			}


			if (!phone) {
				document.getElementById('phoneError').textContent = 'Please enter a valid phone number ';
				isValid = false;
			}

			if(phoneType){
				if(phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone"){
					if (phone && !phoneRegex.test(phone)) {
						document.getElementById('phoneError').textContent = 'Please enter phone number in format: (xxx) xxx-xxxx ';
						document.getElementById('phone').focus();
						isValid = false;
					}
				}
			}

			if (!isValid) {		
				return false;
			} else {
				
				submitButton.disabled = true;
				submitButton.innerText = "Sending...";

				// prevent default submit first
				e.preventDefault();

				// Now submit form manually after disabling button
				setTimeout(() => {
					document.forms['guestFrm'].submit();
				}, 10);

				return false; // stop default submit
			}
			
			
			
			// Validate CAPTCHA
			// if (!captcha) {
			// 	document.getElementById('captchaError').textContent = 'Please enter the characters in the image.';
			// 	isValid = false;
			// }
			
			return isValid;
         }
	   </script>

	    <script>
			document.addEventListener("DOMContentLoaded", function() {
				const phoneInput = document.getElementById("phone");
				const phoneType = document.getElementById("phoneType");
				const formatSign = document.getElementById("formatSign");

				function toggleFormatSign() {
					if (phoneType.value === "OutsideUS") {
						formatSign.style.display = "none";
					} else {
						formatSign.style.display = "inline";
					}
				}

				// run on load (in case form already has value)
				toggleFormatSign();

				// run on change
				phoneType.addEventListener("change", toggleFormatSign);

				phoneInput.addEventListener("input", function(e) {
					// If type is OutsideUS → skip formatting
					if (phoneType.value === "OutsideUS") {
						return;
					}

					let value = e.target.value.replace(/\D/g, ""); // only digits
					if (value.length > 10) value = value.substring(0, 10);

					// Apply formatting as user types
					if (value.length > 6) {
						e.target.value = `(${value.substring(0,3)}) ${value.substring(3,6)}-${value.substring(6)}`;
					} else if (value.length > 3) {
						e.target.value = `(${value.substring(0,3)}) ${value.substring(3)}`;
					} else if (value.length > 0) {
						e.target.value = `(${value}`;
					} else {
						e.target.value = "";
					}
				});
			});

		</script>


		<script>
			document.addEventListener("DOMContentLoaded", function() {
				const textarea = document.getElementById("comments");
				const counter = document.getElementById("charCount");
				const maxLength = 500;

				function updateCount() {
				const currentLength = textarea.value.length;
				counter.textContent = `${currentLength} / ${maxLength} characters`;
				}

				// Update counter initially
				updateCount();

				// Update on input
				textarea.addEventListener("input", updateCount);
			});
		</script>

		<style>
			.error-message {
				color: #ff0000;
				font-size: 0.9em;
				margin-top: 5px;
				display: block;
			}
			.input-field {
				margin-bottom: 15px;
				position: relative;
			}
			.star{
				color: red;
				position: absolute;
				top: -10;
				right: 0
			}
		</style>

	

	</body>
 </html>