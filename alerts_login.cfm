<cfif IsDefined( "form.req_username" )>
	<cfquery name="ValidUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT * from users
		where email = '#form.req_username#'
		and password = '#form.password#'
	</cfquery>
	
	
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
			<cfset url_string = "index.cfm?xss="&xss />
		<cfelse>
			<cfset url_string = "index.cfm" />
		</cfif>
	
		<cfset session.sellerinfo.login = 0 />
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
