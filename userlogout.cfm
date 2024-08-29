<cfif IsDefined( "form.logout" )>

	<cfset temp = StructDelete(session,'sellerinfo') />	
	
	<cflocation addtoken="No" url="#script_name#?#query_string#">

</cfif>
<cfif structKeyExists(session,'sellerinfo') AND session.sellerinfo.login NEQ 0>
<cfoutput>
<table border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="##ffffff">
	<tr>
		<td>
			<table width="900" border="0">
				<cfform action="#script_name#?#query_string#" method="post">
				<input type="Hidden" name="logout">
				<tr>
					<td style="padding: 10px;">
						<strong>Welcome: #session.sellerinfo.fname# #session.sellerinfo.lname#</strong>
					</td>
					<td align="right">
						<input type="image" src="images/log_out_button.gif" value="Log Out" name="logout" style="border: none;">
					</td>
				</tr>
				</cfform>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
</cfif>