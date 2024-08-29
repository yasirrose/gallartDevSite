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
		<cfset url_string = "requests_submit.cfm?xss="&xss />
	<cfelse>
		<cfset url_string = "requests_submit.cfm" />
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
		<table cellspacing="0" cellpadding="5" border="0" width="100%">
			<cfform action="#script_name#?#query_string#" method="post">
			<tr>
				<td>
					<strong>Username:</strong>
				</td>
			</tr>
			<tr>
				<td>
					<cfinput type="text" required="Yes" message="Please enter your email address" name="req_username" style="font-size: 8pt; width: 132px;">
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
		
</cfoutput>
