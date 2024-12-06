<cfif IsDefined( "form.email" )>
	<cfquery name="ValidUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT * from users
		where email = '#form.email#'
		and password = '#form.password#'
	</cfquery>

	<cfif ValidUser.recordcount>
	
		<cfset session.sellerinfo.pk_users = ValidUser.pk_users>
		<cfset session.sellerinfo.fname = ValidUser.fname>
		<cfset session.sellerinfo.lname = ValidUser.lname>
		<cfset session.sellerinfo.email = ValidUser.email>
		<cfset session.sellerinfo.login = 1 />
		
		<cfif isDefined('xss')>
			<cfset url_string = "user_listing_search.cfm?xss="&xss />
		<cfelse>
			<cfset url_string = "user_listing_search.cfm" />
		</cfif>
		
		
		<cflocation addtoken="No" url="#url_string#">
	
	<cfelse>

		<cflocation addtoken="No" url="#script_name#?#query_string#&error=notFound">
	</cfif>
	

</cfif>

<cfoutput>
<div>
	<cfif structKeyExists(url,"error")>
		<p style="color: ##ff0000;" class="text-center">That email address/password is not in the system.  Please try again.</p>
	</cfif>
	<div class="seller-login">
		<cfform action="#script_name#?#query_string#" method="post">
			<div class="input-form">
				<div class="input-field">
					<label><strong>Email Address:</strong></label>
					<cfinput type="text" required="Yes" message="Please enter your email address" name="email">
				</div>
				<div class="input-field text-left">
					<label><strong>Password:</strong></label>
					<cfinput type="password" required="Yes" message="Please enter your password" name="password">
				</div>
				<div class="input-button">
					<input type="submit" value="Sign In" style="margin: auto;" class="SeeMore">
				</div>
				<div class="forget-message text-center">
					<a href="forgot_password.cfm?xss=#xss#">Forget your password?</a>
				</div>
			</div>
			
		</cfform>
		<div>
			<p style="line-height: 1.4;" class="text-center">You must register with Galleryart before you can login and sell your art. You will create a username and password, which you should keep in a safe place.  As soon as you register, you may begin listing your art.  All listings are subject to approval by Gallart.com.</p>
			<div align="center">
				<a href="user_registration.cfm?xss=#xss#" style="color: ##d9387c; font-size: 14px; font-weight: bold;">Register Now!</a></div>
		</div>
	</div>
</div>
	
</cfoutput>
