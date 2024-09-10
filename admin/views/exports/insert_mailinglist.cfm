<cfif NOT structKeyExists(session,'currquery')>
	<cflocation url="index.cfm?event=exports" addtoken="No" />
</cfif>

<cfset thisQ = session.currQuery />

<cfoutput query="thisQ" startrow="#url.startID#" maxrows="#url.maxrows#">
	
		<cfif isValid("email",email) and maillist EQ 1>
	
			<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" timeout="10000">
				INSERT INTO mailinglist_export
					(
						fname,
						lname,
						email
					)
					values
					(
						'#fname#',
						'#lname#',
						'#email#'
					)
					
			</cfquery>
			
		</cfif>
		
		<cfif currentrow EQ (url.startID + url.maxrows) - 1>
			<cflocation url="index.cfm?event=exports.insertLoop&startID=#evaluate(url.startID+maxrows)#" addtoken="No">
		</cfif>
	
</cfoutput>

	
