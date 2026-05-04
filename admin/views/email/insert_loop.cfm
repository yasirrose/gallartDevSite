<cfif NOT structKeyExists(session,'currquery')>
	<cflocation url="mass_email.cfm" addtoken="No" />
</cfif>

<cfparam name="url.startID" default="1">

<cfset batchNum = 200 />

<cfif session.currQuery.recordcount LT url.startID>
	
	<cfset temp = structDelete(session,'currQuery') />
	
	<cfif session.emailTable eq 'seller'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=email.emailCompile&listName=customers" addtoken="No">
		
	<cfelseif session.emailTable eq 'customer'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=email.emailCompile&listName=leads" addtoken="No">
		
	<cfelseif session.emailTable eq 'lead'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=email.emailCompile&listName=imports" addtoken="No">
	
	<cfelseif session.emailTable eq 'import'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=email.emailCompile&listName=end" addtoken="No">
		
	</cfif>
	
<cfelse>

	<cfif session.currQuery.recordcount LT (url.startID + batchNum)>
		<cfset maxrows = session.currQuery.recordcount - (url.startID - 1) />
	<cfelse>
		<cfset maxrows = batchNum />
	</cfif>
	
	<cfoutput>
		<script language="JavaScript">
			setTimeout("window.location.href='index.cfm?event=email.insertMailinglist2&startID=#url.startID#&maxrows=#maxrows#'", 10)
		</script>
	</cfoutput>

		
</cfif>
