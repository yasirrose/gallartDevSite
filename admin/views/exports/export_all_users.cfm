<table border="0" cellpadding="0" cellspacing="0" width="90%">
	<tr>
		<td><br>
			<cfif isDefined('form.create')>
				
				<CFQUERY name="export_contacts" dataSource="#dsource#" username="#uname#" password="#pword#">
					SELECT fname,lname,email from leads where maillist = 1 and email <> '' 
					and fname != '' AND lname != '' and fname Is not null and lname is not null and fname !='*' and lname!='*' and fname !='?' and lname !='????????' and isdeleted is null
					UNION
					
					SELECT fname,lname,email from customers where email <> ''
					and fname !='1' and Lname!='1' and Fname!='admin' and Lname !='123456' and email NOT like '0%' and email NOT like '%0' and fname != '!S!WCRTESTINPUT000000!E!'
					
					UNION 
					
					SELECT fname,lname,email from users where email <> ''
					and pk_users NOT BETWEEN 29662 AND 30649 and pk_users NOT BETWEEN 15398 and 29264 and pk_users NOT BETWEEN 29423 and 29660 and pk_users NOT BETWEEN 15121 and 29395 and pk_users NOT BETWEEN 14793 and 29419 
					
				</CFQUERY>

				<cfif export_contacts.recordcount GTE 66000>
					
					<!--- Excel can only handle 66000 rows --->
					
					Too many records
				
				 <cfelse>

					<!--- <cfdump var="#export_contacts.recordCount#" abort="true"> --->
					
					<cffile action="write" file="#expandPath('.')#\data\export.csv" output="First Name,Last Name,Email" addnewline="yes">
				
					<cfoutput>
						<cfloop query="export_contacts">
							
							
							<cffile action="append" file="#expandPath('.')#\data\export.csv" output="#TRIM(export_contacts.fname)#,#TRIM(export_contacts.lname)#,#TRIM(export_contacts.Email)#" addnewline="yes">
				
						</cfloop>
					</cfoutput>
				
					<cflocation url="http://23.20.226.157/adminpage/data/export.csv">
				
				</cfif>
				<cfabort>
				
			 <cfelse>
				<cfoutput>
					<form method="post" action="index.cfm?event=exports.allUsers" name="searchfrm">
						<table border="0" cellpadding="0" cellspacing="0" width="90%">
							<tr>
								<td valign="top"><br>
									<h3>EXPORT ALL USERS AS CSV: CUSTOMERS, LEADS, SELLERS</h3>
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