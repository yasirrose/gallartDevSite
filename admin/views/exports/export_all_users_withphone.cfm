<table border="0" cellpadding="0" cellspacing="0" width="90%">
<tr>
<td><br>
<cfif isDefined('form.create')>
	
	<CFQUERY name="export_contacts" dataSource="#dsource#" username="#uname#" password="#pword#">
		<cfif form.table_name EQ "leads">
			SELECT fname,lname,phone from leads where maillist = 1 and phone <> ''
			order by lname
		<cfelse>
			SELECT fname,lname,phone from #form.table_name# where phone <> ''
			order by lname
		</cfif>
	</CFQUERY>

	<!--- <cfdump var="#export_contacts.recordcount#">
<cfabort> --->
	
	     <cffile action="write"
	             file="#expandPath('.')#\data\export.csv"
	             output="First Name,Last Name,Phone"
	             addnewline="yes">
	
	    <cfoutput query="export_contacts" startrow="1001">
	
	        <cffile action="append"
	                 file="#expandPath('.')#\data\export.csv"
	                  output="#TRIM(fname)#,#TRIM(lname)#,#TRIM(Phone)#" 
	                 addnewline="yes">
	
	    </cfoutput>
	
	    <cflocation url="http://#server_name#/admin/data/export.csv"> 
	
	<!--- </cfif> --->
	<cfabort>
	
<cfelse>
<cfoutput>
	<form method="post" action="index.cfm?event=exports.allUsersPhone" name="searchfrm">
	<table border="0" cellpadding="0" cellspacing="0" width="90%">
		<tr>
			<td valign="top"><br>
				<h3>EXPORT USERS WITH PHONE NUMBERS AS EXCEL</h3>
			</td>
		</tr>
		<tr>
			<td valign="top"><br>
				<h3>
					<select name="table_name">
						<option value="leads">Leads</option>
						<option value="customers">Customers</option>
						<option value="users">Users</option>
					</select>
				</h3>
			</td>
		</tr>
		<tr>
			<td>
				<input type="Submit" name="create" value="Create">
			</td>
		</tr>
	</table>
	</form>
</cfoutput>

</cfif>	