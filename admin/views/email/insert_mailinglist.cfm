<cfif NOT structKeyExists(session,'currquery')>
	<cflocation url="index.cfm?event=email" addtoken="No" />
</cfif>

<cfset thisQ = session.currQuery />

<cfoutput query="thisQ" startrow="#url.startID#" maxrows="#url.maxrows#">
	
		<cfif isValid("email",email) and maillist EQ 1>
	
			<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" timeout="10000">
				INSERT INTO mailinglist
					(
						fname,
						lname,
						email,
						phone,
						role,
						db_table,
						db_keyname,
						db_keyvalue
					)
					values
					(
						'#fname#',
						'#lname#',
						'#email#',
						'',
						'#session.emailTable#',
						'#session.db_table#',
						'#session.db_keyname#',
						'#db_keyvalue#'
					)
					
			</cfquery>
			
		</cfif>
		
		<cfif currentrow EQ (url.startID + url.maxrows) - 1>
			<cflocation url="index.cfm?event=email.insertLoop&startID=#evaluate(url.startID+maxrows)#" addtoken="No">
		</cfif>
	
</cfoutput>

	
