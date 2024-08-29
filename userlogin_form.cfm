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

<table border="0" cellspacing="0" cellpadding="5" width="100%" style="border: 1px solid ##000000;">
	<td width="200" valign="top">
		<table cellspacing="0" cellpadding="5" border="0" width="100%">
			<cfif structKeyExists(url,"error")>
			<tr>
				<td style="color: ##ff0000;">
					That email address/password is not in the system.  Please try again.
				</td>
			</tr>
			</cfif>
			<cfform action="#script_name#?#query_string#" method="post">
			<tr>
				<td>
					<strong>Email Address:</strong>
				</td>
			</tr>
			<tr>
				<td>
					<cfinput type="text" required="Yes" message="Please enter your email address" name="email" style="font-size: 8pt; width: 132px;">
				</td>
			</tr>
			<tr>
				<td>
					<strong>Password:</strong>
				</td>
			</tr>
			<tr>
				<td>
					<cfinput type="password" required="Yes" message="Please enter your password" name="password" style="font-size: 8pt; width: 132px;">
				</td>
			</tr>
			<tr>
				<td style="padding-left: 68px;  padding-bottom: 7px;">
					<input type="image" src="images/signin.jpg" alt="Sign In." style="border: 1px solid ##ffffff;">
				</td>
			</tr>
			<tr>
				<td>
					<a href="forgot_password.cfm?xss=#xss#">Forget your password?</a>
				</td>
			</tr>
			</cfform>
		</table>
	</td>
	<td valign="top" style="padding: 10px 10px 0 0; line-height: 18px;">
		You must register with Galleryart before you can login and sell your art. You will create a username and password, which you should keep in a safe place.  As soon as you register, you may begin listing your art.  All listings are subject to approval by Gallart.com.
		<br><br>
		<div align="center"><a href="user_registration.cfm?xss=#xss#" style="color: ##d9387c; font-size: 14px; font-weight: bold;">Register Now!</a></div>
	</td>
</table>
	
</cfoutput>
