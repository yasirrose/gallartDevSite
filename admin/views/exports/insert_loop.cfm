<cfif NOT structKeyExists(session,'currquery')>
	<cflocation url="index.cfm" addtoken="No" />
</cfif>

<cfparam name="url.startID" default="1">

<cfset batchNum = 1000 />

<cfif session.currQuery.recordcount LT url.startID>
	
	<cfset temp = structDelete(session,'currQuery') />
	
	<cfif session.emailTable eq 'seller'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=exports.emailCompile&listName=customers" addtoken="No">
		
	<cfelseif session.emailTable eq 'customer'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=exports.emailCompile&listName=leads" addtoken="No">
		
	<cfelseif session.emailTable eq 'lead'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=exports.emailCompile&listName=appraisals" addtoken="No">

	<cfelseif session.emailTable eq 'appraisal'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=exports.emailCompile&listName=quotes" addtoken="No">

	<cfelseif session.emailTable eq 'quote'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=exports.emailCompile&listName=imports" addtoken="No">

	<cfelseif session.emailTable eq 'import'>
	
		<cfset temp = structDelete(session,'emailTable') />
	
		<cflocation url="index.cfm?event=exports.emailCompile&listName=end" addtoken="No">
		
	</cfif>
	
<cfelse>

	<cfif session.currQuery.recordcount LT (url.startID + batchNum)>
		<cfset maxrows = session.currQuery.recordcount - (url.startID - 1) />
	<cfelse>
		<cfset maxrows = batchNum />
	</cfif>
	
	<cfoutput>
		<script language="JavaScript">
			setTimeout("window.location.href='index.cfm?event=exports.insertMailinglist&startID=#url.startID#&maxrows=#maxrows#'", 10)
		</script>
	</cfoutput>

		
</cfif>
