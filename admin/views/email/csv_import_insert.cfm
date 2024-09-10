
<cftry>
	<cfloop index="idx" from="#url.startID#" to="#url.endrow#">
		<cfquery name="importcsv" datasource="#application.dsource#">
	         INSERT INTO email_imports (fk_email_imports_list,fname,lname,email)
	         VALUES
               (
			   	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.importID#">,
	  			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#replace(listgetAt('#session.csvArray[idx]#',1, ','),'~','','all')#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#replace(listgetAt('#session.csvArray[idx]#',2, ','),'~','','all')#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#listgetAt('#session.csvArray[idx]#',3, ',')#">
               )
	   </cfquery> 
	
	</cfloop>
	<cfcatch type="Any"><cfoutput>#cfcatch.Detail#</cfoutput><cfabort></cfcatch>
</cftry> 



<cflocation url="http://#server_name#/admin/views/email/csv_import_proc.cfm?startID=#evaluate(endrow+1)#&batchCount=#url.batchCount#" addtoken="No">




