<!--- <cfsilent>
	<cfparam name="FORM.captcha_check"	type="string" default="" />
	<cfparam name="form.captchaError" default="0">

	   <cftry>
		<cfparam
		   name="FORM.submitted"	type="numeric"	default="0"	/>
 
		<cfcatch>
		   <cfset FORM.submitted = 0 />
		</cfcatch>
	 </cftry>

	 <cfif isDefined('form.submit') >
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

</cfsilent> --->

<cfif NOT structKeyExists(session, 'sellerinfo') >

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
	group by path
	order by path
</CFQUERY>

<cfparam name="success" default="false">
<cfparam name="msg" default="">

<cfif isDefined("proc_pw")>

	<cfset apikey="6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">
    <cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post">
        <cfhttpparam type="formField" name="secret" value="#apikey#">
        <cfhttpparam type="formField" name="response" value="#form['g-recaptcha-response']#">
        <cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
    </cfhttp>

    <cfset captchaResponse = DeserializeJSON(cfhttp.FileContent)>

	<cfif captchaResponse.success >
		<cfquery name="findUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM users WHERE email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar" maxlength="255">
		</cfquery>
	
		<cfif findUser.recordcount>
			<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
				password="re3objec" to="#findUser.email#" from="onli16@onlinegalleryart.com"
				subject="Gallery Art Password Retrieval" type="HTML">
				<font style="font-size: 10pt; font-family: Arial;">
				Your Gallery Art Password is:
				<br><br>
				#findUser.password#
				<br><br>
				Please keep it in a safe place.
				<br><br>
				Thank you from Gallery Art.
				</font>
			</cfmail>
	
			<cfoutput>
				<strong style="color:green;">Your password has been emailed to you.</strong>
			</cfoutput>
		<cfelse>
			<cfoutput>
				<strong style="color:red;">That email address is not in our system. Please try again.</strong>
			</cfoutput>
		</cfif>
	<cfelse>
		<cfoutput>
			<strong style="color:red;">reCAPTCHA verification failed. Please try again.</strong>
		</cfoutput>

	</cfif>

   
    <cfabort>
</cfif>


<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/jquery-1.2.6.min.js"></script>
	<script language="JavaScript" src="/js/utils.js"></script>
</cfoutput>

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
		<div id="Table_01">
			<div class="header-section">
				<div class="top-header">
					<cfinclude template="top_.cfm">
				</div>
				<div class="navbar-section">
					<cfinclude template="navbar_.cfm">
				</div>
			</div>
			<div class="inner-section forget-password-screen">
				<div class="container-fluid">
					<div class="main-content">
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">

										<div aria-label="breadcrumb">
											<ol class="breadcrumb">
											  <li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
											  <li class="breadcrumb-item"><a href="/login" style="color:black;" >Seller Login</a></li>
											  <li class="breadcrumb-item active" aria-current="page">Forget Password</li>
											</ol>
										</div>

										<div class="bottom-content">
											<div class="user-registrations forgot-password">
												<div class="top-heading text-center">
													<h3>FORGOT PASSWORD</h3>
												</div>												
														<div id="responseMessage"></div>
														<form id="forgetForm" onsubmit="return false;">
														
															<div class="user-content text-center">
																<p>Enter your email address below, and we will email your password to you:</p>
																<div class="input-form">
																	<div class="input-field">
																		<input type="text" name="email" id="email" maxlength="30" size="40"><span class="star"> * </span>
																		<span class="error-message" id="email_loginError"></span>
																	</div>
																	
																	 <div class="input-field pt-3">
																		<div class="g-recaptcha" id="gRecaptchaGeneral" data-sitekey="6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne"></div>
																		<span class="error-message" id="recaptchaError"></span>
																	</div>
																	
																	<div class="input-button mt-3 register-btn">
																		<button type="button" id="sendPasswordBtn" onclick="submitForgetForm()" class="SeeMore">Send My Password</button>
																	</div>
																</div>
															</div>
														</form>
														
													
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
		<cfinclude template="footer_user.cfm">
	</td>
</tr>
<cfinclude template="frmxss.cfm">

<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<script>

	$(document).ready(function() {
		toastr.options = {
			'closeButton': true,
			'debug': false,
			'newestOnTop': false,
			'progressBar': true,
			'positionClass': 'toast-top-right',
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
	});

    function validateForgetForm() {
        let isValid = true;
        const email = document.getElementById('email').value.trim();
        const errorElement = document.getElementById('email_loginError');
        errorElement.textContent = ''; // Clear previous errors

		const recaptchaResponse = grecaptcha.getResponse();

		if (!recaptchaResponse) {
			document.getElementById('recaptchaError').textContent = 'Please verify reCAPTCHA.';
			isValid = false;
		}

        if (!email) {
            errorElement.textContent = 'Please enter your email address';
            isValid = false;
        } else if (!/\S+@\S+\.\S+/.test(email)) {
            errorElement.textContent = 'Please enter a valid email address.';
            isValid = false;
        }

        return isValid;
    }

    function submitForgetForm() {

		 const sendBtn = document.getElementById('sendPasswordBtn');

        if (!validateForgetForm()) {
            return; // Stop submission if validation fails
        }
	
		sendBtn.disabled = true;
    	sendBtn.textContent = 'Sending...';

			
        const formData = new FormData();
		formData.append('g-recaptcha-response', grecaptcha.getResponse());
        formData.append('email', document.getElementById('email').value);
        formData.append('proc_pw', true); // Pass this to detect the form submission on the backend

        fetch('forgot_password.cfm', {
            method: 'POST',
            body: formData,
        })
            .then((response) => response.text())
            .then((data) => {
				if (data.includes('Your password has been emailed to you.')) {
					toastr.success('Your password has been emailed to you.');
					grecaptcha.reset();
					$('#forgetForm')[0].reset();
					
					sendBtn.disabled = false;
                	sendBtn.textContent = 'Send My Password';
            } else {
				grecaptcha.reset();
                toastr.error('That email address is not in our system. Please try again.');
            }
            })
            .catch((error) => {
                console.error('Error:', error);
                document.getElementById('responseMessage').innerHTML = `<strong style="color:red;">An error occurred. Please try again later.</strong>`;

				sendBtn.disabled = false;
            	sendBtn.textContent = 'Send My Password';

            });
    }
</script>
 <style>
	.error-message {
		color: #ff0000;
		font-size: 0.9em;
		/* margin-top: 5px; */
		text-align: left;
		margin-left: 10px;
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
		right: 10
	}
 </style>

</body>
</html>

<cfelse>
	<cflocation addtoken="No" url="/user_listing_detail">
</cfif>