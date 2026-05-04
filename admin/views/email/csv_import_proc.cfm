<cfoutput>
	<link REL="STYLESHEET" TYPE="text/css" HREF="http://#server_name#/admin/css/main.css">
</cfoutput>
<cfparam name="url.startID" default="1">
<cfparam name="url.batchCount" default="0">

<cfset batchNum = 1000 />
<cfoutput>
<table cellspacing="0" cellpadding="5" border="0" width="400" height="200">
	<tr>
		<td valign="top" style="font-family: arial;">
			<cfif arrayLen(session.csvArray) LT url.startID>
				Batches Inserted:<br><br>
				<cfloop from="1" to="#url.batchCount#" index="idx">
					 #idx#<br>
				</cfloop>
			
				<span style="color:##ff0000;">IMPORT COMPLETE!</span><br><br>
				<cfquery name="getImports" datasource="#application.dsource#">
			        SELECT * from email_imports
					WHERE fk_email_imports_list = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.importID#">
			   </cfquery>
			   #getImports.recordcount# records imported.
				
				<cfset temp = structDelete(session,'csvArray') />
				<cfset temp = structDelete(session,'importID') />
				<br><br>
				<input type="Button" value="Back" onclick="parent.location.href='http://#server_name#/admin/index.cfm?event=email.csvImportSearch'">
				<cfabort> 
				
			<cfelse>
				Starting . . .<br>
				<cfif arrayLen(session.csvArray) lt (url.startID + batchNum)>
					<cfset endrow = arrayLen(session.csvArray) />
				<cfelse>
					<cfset endrow = startID + batchNum />
				</cfif>
				
				<cfif url.batchCount GT 0>
					Inserted Batch: #url.batchCount#
				</cfif>
				
				<cfset url.batchCount = url.batchCount + 1 />
				
				<script language="JavaScript">
					setTimeout("window.location.href='http://#server_name#/admin/views/email/csv_import_insert.cfm?startID=#url.startID#&endrow=#endrow#&batchCount=#url.batchCount#'", 1000)
				
				</script>
				
			</cfif>

		</td>
	</tr>
</table>



</cfoutput>