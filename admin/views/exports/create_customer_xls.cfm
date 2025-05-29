<cfquery name="getEmailList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM customers C
	WHERE 0=0
	<cfif session.qCustomers.Fname neq ''>
		AND C.fname like '#session.qCustomers.Fname#%'
	</cfif>
	<cfif session.qCustomers.Lname neq ''>
		AND C.lname like '#session.qCustomers.Lname#%'
	</cfif>
	<cfif session.qCustomers.Email neq ''>
		AND C.email like '%#session.qCustomers.Email#%'
	</cfif>
	<cfif session.qCustomers.Areacode neq ''>
		AND (
			C.phone like '#session.qCustomers.Areacode#%' OR
			C.phone like '(#session.qCustomers.Areacode#%' OR
			C.businessphone like '#session.qCustomers.Areacode#%' OR
			C.businessphone like '(#session.qCustomers.Areacode#%'
			)
	</cfif>
	<cfif session.qCustomers.City neq ''>
		AND C.city like '#session.qCustomers.City#%'
	</cfif>
	<cfif session.qCustomers.State neq ''>
		AND C.state like '#session.qCustomers.State#%'
	</cfif>
	ORDER BY lname, fname, email
</cfquery>
<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Customers #DateFormat(createodbcdate(now()))#.xls""">
<cfoutput>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr bgcolor="##000000">
			<td style="color: ##FFFFFF;" valign="top">
				<strong>First Name</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top" >
				<strong>Last Name</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Email</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Phone</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Work Phone</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>City</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>State</strong>
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
			<td valign="top">
				#phone#
			</td>
			<td valign="top">
				#businessphone#
			</td>
			<td valign="top">
				#city#
			</td>
			<td valign="top">
				#ucase(state)#
			</td>
		</tr>
		</cfloop>
	</table>
</cfoutput>