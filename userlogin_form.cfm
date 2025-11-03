<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

<cfif IsDefined("form.email")>

    <cfset apikey="6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">
    <cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post">
        <cfhttpparam type="formField" name="secret" value="#apikey#">
        <cfhttpparam type="formField" name="response" value="#form['g-recaptcha-response']#">
        <cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
    </cfhttp>

    <cfset captchaResponse = DeserializeJSON(cfhttp.FileContent)>

    <!--- <cfdump var="#captchaResponse.success#" abort="true"> --->

    <cfif captchaResponse.success  >
        <cfquery name="ValidUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT * FROM users
            WHERE email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
            AND password = <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
        </cfquery>
    
        <cfif ValidUser.recordcount>
    
            <cfset session.sellerinfo.pk_users = ValidUser.pk_users>
            <cfset session.sellerinfo.fname = ValidUser.fname>
            <cfset session.sellerinfo.lname = ValidUser.lname>
            <cfset session.sellerinfo.email = ValidUser.email>
            <cfset session.sellerinfo.login = 1>

            <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
            <cfset date = now()>
            <cfset moduleName = 'login'>
             
            <cfquery name="addLog" datasource="#application.dsource#" >
                INSERT INTO logs 
                    ( moduleName, ipAddress, date)
                    VALUES
                    ( '#moduleName#', '#ipAddress#', #date#)
            </cfquery>
            
            <cfset url_string = "overView" />
    
            <cfset result = {
                "success": true,
                "redirectURL": url_string
            }>
        <cfelse>
            <cfset result = {
                "success": false,
                "errorMessage": "Email or Password is Invalid. Please try again."
            }>
        </cfif>

    <cfelse>
        <cfset result = {
            "success": false,
            "errorMessage": "reCAPTCHA verification failed. Please try again."
        }>

    </cfif>

   

    <cfcontent type="application/json" reset="yes">
    <cfoutput>#serializeJSON(result)#</cfoutput>
    <cfabort>
</cfif>


<!--- <cfoutput> --->
	<div id="loginContainer">
		<div>
			<p id="errorMessage" style="color: #ff0000; text-align: center;"></p>
		</div>
		<div class="seller-login">
			<form id="loginForm" method="post">
				<div class="input-form">
					<div class="input-field">
						<label><strong>Email Address: <span style="color: #ff0000;">* </span></strong></label>
						<input type="text" id="email" name="email" maxlength="25">
						<span class="error-message" id="email_loginError"></span>
					</div>
					<div class="input-field text-left">
						<label><strong>Password: <span style="color: #ff0000;">* </span></strong></label>
						<input type="password" id="password" name="password" maxlength="25">
						<span class="error-message" id="passwordError"></span>
					</div>

                    <div class="input-field pt-3">
                        <div class="g-recaptcha" id="gRecaptchaGeneral" data-sitekey="6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne"></div>
                        <span class="error-message" id="recaptchaError"></span>
                    </div>

					<div class="input-button">
						<button type="submit" id="loginBtn" style="margin: auto;" class="SeeMore">Sign In</button>
                        
					</div>

                    <span class="error-message" id="errorMessage"></span>

					<div class="forget-message text-center">
						<a href="forgot_password">Forget your password?</a>
					</div>
				</div>
			</form>
			<div>
				<p style="line-height: 1.4;" class="text-center">Create an account with Gallery Art to track your purchases, create wish lists and sell your artwork</p>
				<div align="center">
					<a href="register" style="color: #d9387c; font-size: 14px; font-weight: bold;">Create an Account</a>
				</div>
			</div>
		</div>
	</div>


<!--- </cfoutput> --->

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

        document.getElementById('loginForm').addEventListener('submit', function (e) {
            e.preventDefault(); // Prevent form from refreshing the page

            // Clear previous error messages
            document.getElementById('email_loginError').textContent = '';
            document.getElementById('passwordError').textContent = '';
            document.getElementById('errorMessage').textContent = '';

            const loginBtn = document.getElementById('loginBtn');
            loginBtn.disabled = true;           // disable button immediately
            loginBtn.textContent = 'Signing In...';

            let isValid = true;
            const email_login = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            const recaptchaResponse = grecaptcha.getResponse();

            // if (!recaptchaResponse) {
            //     document.getElementById('recaptchaError').textContent = 'Please verify reCAPTCHA.';
            //     isValid = false;
            // }

            if (!email_login) {
                document.getElementById('email_loginError').textContent = 'Please enter your email address';
                isValid = false;
            }else if (!/\S+@\S+\.\S+/.test(email_login)) {
                document.getElementById('email_loginError').textContent = 'Please enter a valid email address.';
                isValid = false;
            }

            if (!password) {
                document.getElementById('passwordError').textContent = 'Please enter your password';
                isValid = false;
            }

            
            if (!isValid) {
                // Re-enable button if validation fails
                loginBtn.disabled = false;
                loginBtn.textContent = 'Sign In';
                return;
            }

            // Create a FormData object for AJAX
            const formData = new FormData();
            formData.append('email', email_login);
            formData.append('password', password);
            formData.append('g-recaptcha-response', recaptchaResponse);

            // Send an AJAX request
            fetch('user_login_page.cfm', {
                method: 'POST',
                body: formData,
            })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json(); // Parse JSON only if response is valid
        })
        .then(data => {
            if (data.success) {
            
                window.location.href = data.redirectURL; // Redirect on successful login
            } else {
                toastr.error(data.errorMessage ); // Display error message
                loginBtn.disabled = false;
                loginBtn.textContent = 'Sign In';
            }
        })
        .catch(error => {
            document.getElementById('errorMessage').textContent = 'An error occurred. Please try again.';
            console.error('Error:', error);
            loginBtn.disabled = false;
            loginBtn.textContent = 'Sign In';
        });
    });
</script>
 <style>
	.error-message {
        color: #ff0000;
        font-size: 0.9em;
        margin-top: 5px;
        display: block;
	}
 </style>
