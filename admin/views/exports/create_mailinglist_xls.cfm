<cfquery name="getEmailList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM mailinglist_export
</cfquery>
<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Mailing List #DateFormat(createodbcdate(now()))#.xls""">
<cfoutput>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr bgcolor="##000000">
			<td style="color: ##FFFFFF;" valign="top">
				<strong>First Name</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Last Name</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Email</strong>
			</td>
		</tr>
		<cfloop query="getEmailList">
		<tr>
			<td valign="top">
				#fname#
			</td>
			<td valign="top">
				#lname#
			</td>
			<td valign="top">
				#email#
			</td>
		</tr>
		</cfloop>
	</table>
</cfoutput>