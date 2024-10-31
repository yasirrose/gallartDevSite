	<!--- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!--- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> --->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script> --->

	<cfif IsDefined( "form.req_username" )>
		<cfquery name="ValidUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * from users
			where email = '#form.req_username#'
			and password = '#form.password#'
		</cfquery>
		
		<!--- <cfdump var="#script_name#"> <br>
		<cfdump var="#query_string#" abort="true"> --->
		
		<cfif ValidUser.recordcount>
		
		<cfset session.sellerinfo.pk_users = ValidUser.pk_users>
		<cfset session.sellerinfo.fname = ValidUser.fname>
		<cfset session.sellerinfo.lname = ValidUser.lname>
		<cfset session.sellerinfo.email = ValidUser.email>
		<cfset session.sellerinfo.login = 1 />
		
		
		
		<cfif isDefined('xss')>
			<cfset url_string = "alerts.cfm?xss="&xss />
		<cfelse>
			<cfset url_string = "alerts.cfm" />
		</cfif>
		
		
		<cflocation addtoken="No" url="#url_string#">
		
		<cfelse>
		
			<cfif isDefined('xss')>
				<cfset url_string = "alerts.cfm?xss="&xss />
			<cfelse>
				<cfset url_string = "alerts.cfm" />
			</cfif>
		
			<cfset session.sellerinfo.login = 0 />
			<!--- <cfoutput>
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
	
					toastr.error('Invalid Username or Password');
	
					// window.location.href = "#url_string#";
	
				</script>
			</cfoutput> --->
			<cflocation addtoken="No" url="#url_string#">
		</cfif>
		
	
	</cfif>
	
	<cfoutput>
			<cfform action="#script_name#?#query_string#" method="post">
				<div class="input-form">
					<div class="input-field">
						<label><strong>Username:</strong></label>
						<cfinput type="text" required="Yes" message="Please enter your email address" name="req_username">
					</div>
					<div class="input-field">
						<label><strong>Password:</strong></label>
						<cfinput type="password" required="Yes" message="Please enter your password" name="password">
					</div>
					<div class="input-button">
						<button type="submit" class="SeeMore">Sign In</button>
					</div>
					<p><a href="forgot_password.cfm?xss=#xss#">Forget your password?</a></p>
				</div>
			</cfform>
			
	</cfoutput>
	