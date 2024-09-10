<table border="0" cellpadding="0" cellspacing="0" width="90%">
<tr>
<td><br>
<cfif isDefined('form.create')>
	
	<CFQUERY name="export_contacts" dataSource="#dsource#" username="#uname#" password="#pword#">
	    SELECT fname,lname,email from leads where maillist = 1 and email <> ''
		UNION
		 
		SELECT fname,lname,email from customers where email <> ''
		
		UNION 
		
		SELECT fname,lname,email from users where email <> ''
		
	</CFQUERY>

	<cfif export_contacts.recordcount GTE 66000>
	
	    <!--- Excel can only handle 66000 rows --->
	    Too many records
	
	<cfelse>
	
	       <cffile action="write"
	             file="#expandPath('.')#\data\export.csv"
	             output="First Name,Last Name,Email"
	             addnewline="yes">
	
	    <cfoutput>
	        <cfloop query="export_contacts">
	    
	        <cffile action="append"
	                 file="#expandPath('.')#\data\export.csv"
	                  output="#TRIM(fname)#,#TRIM(lname)#,#TRIM(Email)#" 
	                 addnewline="yes">
	
	        </cfloop>
	    </cfoutput>
	
	    <cflocation url="http://#server_name#/adminpage/data/export.csv">
	
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