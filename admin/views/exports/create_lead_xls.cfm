<cfquery name="getEmailList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM leads L
	WHERE 0=0
	<cfif session.qLeads.Fname neq ''>
		AND L.fname like '#session.qLeads.Fname#%'
	</cfif>
	<cfif session.qLeads.Lname neq ''>
		AND L.lname like '#session.qLeads.Lname#%'
	</cfif>
	<cfif session.qLeads.Email neq ''>
		AND L.email like '%#session.qLeads.Email#%'
	</cfif>
	<cfif session.qLeads.Areacode neq ''>
		AND (
			L.phone like '#session.qLeads.Areacode#%' OR
			L.phone like '(#session.qLeads.Areacode#%' OR
			L.cellphone like '#session.qLeads.Areacode#%' OR
			L.cellphone like '(#session.qLeads.Areacode#%' OR
			L.businessphone like '#session.qLeads.Areacode#%' OR
			L.businessphone like '(#session.qLeads.Areacode#%'
			)
	</cfif>
	<cfif session.qLeads.City neq ''>
		AND L.city like '#session.qLeads.City#%'
	</cfif>
	<cfif session.qLeads.State neq ''>
		AND L.state like '#session.qLeads.State#%'
	</cfif>
	<cfif session.qLeads.EmployeeId neq ''>
		AND L.fk_employees = '#session.qLeads.EmployeeId#'
	</cfif>
	<cfif session.qLeads.Comments neq ''>
		<cfif session.qLeads.Comments eq 1>
			AND L.notes is not null
		<cfelseif session.qLeads.Comments eq 0>
			AND L.notes is null
		</cfif>
	</cfif>
	<cfif session.qLeads.fromDate neq ''>
		AND L.datestamp >= '#dateFormat(session.qLeads.fromDate)#'
	</cfif>
	<cfif session.qLeads.toDate neq ''>
		AND L.datestamp <= '#dateFormat(session.qLeads.toDate)#'
	</cfif>
	<cfif session.qLeads.keywords neq ''>
		<cfset keyArray = listtoarray(session.qLeads.keywords,' ') />
		AND (
			(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
				artists like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
			</cfloop>)
			OR
			(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
				titles like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
			</cfloop>)
			OR
			(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
				notes like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
			</cfloop>)
		)
	</cfif>
	ORDER BY lname, fname, email
</cfquery>
<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Leads #DateFormat(createodbcdate(now()))#.xls""">
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
				<strong>Cell Phone</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Business Phone</strong>
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
				#cellphone#
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