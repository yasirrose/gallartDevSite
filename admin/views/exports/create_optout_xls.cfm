<cfquery name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM optout
	ORDER BY datestamp
</cfquery>
<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Optout List #DateFormat(createodbcdate(now()))#.xls""">
<cfoutput>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr bgcolor="##000000">
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Email</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top" >
				<strong>Date</strong>
			</td>
		</tr>
		<cfloop query="data">
		<tr>
			<td valign="top">
				#email#
			</td>
			<td valign="top">
				#dateFormat(datestamp)#
			</td>
		</tr>
		</cfloop>
	</table>
</cfoutput>