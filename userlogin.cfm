<cfif IsDefined( "form.username" )>
	<cfquery name="ValidUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT * from users
		where email = '#form.username#'
		and password = '#form.password#'
	</cfquery>
	
	
	<cfif ValidUser.recordcount>
	
	<cfset session.userinfo.pk_users = ValidUser.pk_users>
	<cfset session.userinfo.fname = ValidUser.fname>
	<cfset session.userinfo.lname = ValidUser.lname>
	<cfset session.userinfo.email = ValidUser.email>
	<cfset session.userinfo.login = 1 />
	
	<cfif isDefined('xss')>
		<cfset url_string = "user_listing_search.cfm?xss="&xss />
	<cfelse>
		<cfset url_string = "user_listing_search.cfm" />
	</cfif>
	
	
	<cflocation addtoken="No" url="#url_string#">
	
	<cfelse>
	
		<cfif isDefined('xss')>
			<cfset url_string = "index.cfm?xss="&xss />
		<cfelse>
			<cfset url_string = "index.cfm" />
		</cfif>
	
		<cfset session.Userinfo.login = 0 />
		<cflocation addtoken="No" url="#url_string#">
	</cfif>
	

</cfif>

<cfoutput>

<table border="0" cellspacing="0" cellpadding="0" width="600">
	<cfform action="#script_name#?#query_string#" method="post">
	<tr>
		<td style="padding-right: 5px; font-size: 11pt;">
			<strong>Seller Login</strong>
		</td>
		<td style="padding-right: 5px; font-size: 8pt;">
			Username:
		</td>
		<td style="padding-right: 5px;">
			<cfinput type="text" required="Yes" message="Please enter your email address" name="username" style="font-size: 8pt; width: 132px;">
		</td>
		<td style="padding-right: 5px; font-size: 8pt;">
			Password:
		</td>
		<td style="padding-right: 5px;">
			<cfinput type="password" required="Yes" message="Please enter your password" name="password" style="font-size: 8pt; width: 132px;">
		</td>
		<td>
			<input type="submit" value="Sign In" style=" color: ##d9387c; font-size: 11pt; font-weight: bold; background-color: transparent; border: 1px solid ##eeeeee; cursor: pointer;">
		</td>
		<td style="padding-right: 5px;">
			<input type="image" src="images/arrow.jpg" alt="Sign In." style="border: 1px solid ##eeeeee;">
		</td>
	</tr>
	</cfform>
</table>
	
</cfoutput>
