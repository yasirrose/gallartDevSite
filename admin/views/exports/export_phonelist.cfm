<table border="0" cellpadding="0" cellspacing="0" width="90%">
	<tr>
		<td>
			<br>
			<cfif isDefined('form.create')>

				<cfquery name="export_phonenumbers" dataSource="#dsource#" username="#uname#" password="#pword#">
					<cfif form.table EQ "leads">
						SELECT fname,lname,cellphone, name from leads where maillist = 1 and cellphone <> '' and cellphone is not null and isdeleted is null
						ORDER BY lname,fname
					 <cfelseif form.table EQ 'users'>
						SELECT fname,lname,cellphone, '' AS name from users where cellphone <> '' and cellphone is not null
						AND NOT (
							pk_users BETWEEN 29662 AND 30649
							OR pk_users BETWEEN 15398 AND 29264
							OR pk_users BETWEEN 29423 AND 29660
							OR pk_users BETWEEN 15121 AND 29395
							OR pk_users BETWEEN 14793 AND 29419
						)
						ORDER BY lname,fname
					 <cfelse>
							SELECT fname,lname,cellphone, name from #form.table# where cellphone <> '' and cellphone is not null and fname !='1' and Lname!='1' 
							ORDER BY lname,fname
					</cfif>
				</cfquery>

				<cfif export_phonenumbers.recordcount GTE 66000>
				
					<!--- Excel can only handle 66000 rows --->
					Too many records
				
				 <cfelse>					
				
					<cffile action="write" file="#expandPath('.')#\data\export.csv" output="First Name,Last Name, Name, Cellphone" addnewline="yes">
				
					<cfoutput>
						<cfparam name="startrow" default="1">
						<cfparam name="endrow" default="1000">
						<cfif form.rows EQ 2000>
							<cfset startrow = 1001>
							<cfset endrow = 2000>
						<cfelseif form.rows EQ 3000>
							<cfset startrow = 2001>
							<cfset endrow = 3000>
						<cfelseif form.rows EQ 4000>
							<cfset startrow = 3001>
							<cfset endrow = 4000>
						<cfelseif form.rows EQ 5000>
							<cfset startrow = 4001>
							<cfset endrow = 5000>
						</cfif>

						<cfloop query="export_phonenumbers" startrow="#startrow#" endrow="#endrow#">
					
							<cffile action="append" file="#expandPath('.')#\data\export.csv" output="#TRIM(fname)#,#TRIM(lname)#,#TRIM(name)#,#TRIM(cellphone)#" addnewline="yes">
				
						</cfloop>
						<!--- Read the contents of the CSV file --->
						<cffile action="read" file="#expandPath('.')#\data\export.csv" variable="fileContents">

						<!--- Display the contents using cfdump --->
						<cfdump var="#fileContents#">
						<!--- Set the content type and disposition headers to prompt the user to download the file --->
						<cfheader name="Content-Disposition" value="attachment; filename=export.csv">
						<cfcontent type="application/octet-stream" file="#expandPath('.')#\data\export.csv" reset="true">
						
					</cfoutput>								
				
				</cfif>
				<cfabort>
				
			 <cfelse>
				<cfquery name="leads" dataSource="#dsource#" username="#uname#" password="#pword#">
					SELECT fname,lname,cellphone, name from leads where maillist = 1 and cellphone <> '' and cellphone is not null and isdeleted is null
				</cfquery>
				<cfquery name="customers" dataSource="#dsource#" username="#uname#" password="#pword#">
					SELECT fname,lname,cellphone, name from customers where cellphone <> '' and cellphone is not null and fname !='1' and Lname!='1'
				</cfquery>
				<cfquery name="sellers" datasource="#dsource#" username="#uname#" password="#pword#">
					SELECT fname, lname, cellphone
					FROM users
					WHERE cellphone IS NOT NULL
						AND cellphone <> ''
						AND NOT (
							pk_users BETWEEN 29662 AND 30649
							OR pk_users BETWEEN 15398 AND 29264
							OR pk_users BETWEEN 29423 AND 29660
							OR pk_users BETWEEN 15121 AND 29395
							OR pk_users BETWEEN 14793 AND 29419
						)
				</cfquery>

				<cfoutput>
					<form method="post" action="index.cfm?event=exports.phonelist" name="searchfrm">
						<table border="0" cellpadding="0" cellspacing="0" width="90%">
							<tr>
								<td valign="top"><br>
									<h3>EXPORT ALL CELLPHONE NUMBERS AS CSV: CUSTOMERS, LEADS, SELLERS</h3>
									<br /><br />
								</td>
							</tr>
							<tr>
								<td>
									Leads: #leads.recordcount#
								</td>
							</tr>
							<tr>
								<td>
									Customers: #customers.recordcount#
								</td>
							</tr>
							<tr>
								<td>
									Sellers: #sellers.recordcount#
								</td>
							</tr>
							<tr>
								<td>
									<br /><br />
									<select name="table">
										<option value="leads">Leads</option>
										<option value="customers">Customers</option>
										<option value="users">Users</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<br /><br />
									Rows:
									<br /><br />
									<select name="rows">
										<option value="1000">1000</option>
										<option value="2000">2000</option>
										<option value="3000">3000</option>
										<option value="4000">4000</option>
										<option value="5000">5000</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<br /><br />
									<input type="Submit" name="create" value="Create">
								</td>
							</tr>
						</table>
					</form>
				</cfoutput>
			</cfif>	