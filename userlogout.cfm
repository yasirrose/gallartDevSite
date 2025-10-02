<cfif IsDefined( "form.logout" )>

	<cfset temp = StructDelete(session,'sellerinfo') />	
	
	<cflocation addtoken="No" url="#script_name#?#query_string#">

</cfif>
<cfif structKeyExists(session,'sellerinfo') AND session.sellerinfo.login NEQ 0>
	<cfoutput>
		<div class="welcome-logout">
			<cfform action="/logout" method="post">
				<input type="Hidden" name="logout">
					<div class="logout-form">
						<div class="main-heading">
							<strong>Welcome: #session.sellerinfo.fname# #session.sellerinfo.lname#</strong>
						</div>
						<div class="logout-button">
							<button type="submit" class="SeeMore">Log Out</button>
							<!--- <input type="image" src="images/log_out_button.gif" value="Log Out" name="logout" style="border: none;"> --->
						</div>	
					</div>
			</cfform>
		</div>
	</cfoutput>
</cfif>