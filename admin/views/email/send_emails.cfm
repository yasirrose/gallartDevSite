<cfquery name="getEmailList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM mailinglist
</cfquery> 

<cfquery name="getTemplate" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from emailtemplate
	WHERE pk_emailtemplate = '#url.pk_emailtemplate#'
</cfquery>

<cfoutput query="getEmailList" startrow="#url.startRow#" maxrows="#url.batchNum#">

	<cfset error = '' />
	
	<cfquery name="insertEmailLog" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    INSERT into email_log
			(
				email,
				fk_emailtemplate
			)
			values
			(
				'#email#',
				#url.pk_emailtemplate#
			)
		SELECT @@identity as uid
	</cfquery>
	
	<cfset message = replace(getTemplate.email_content,'/UserFiles','http://#server_name#/UserFiles','all') />
	<cfset message = replace(message,'[emailLogId]',insertEmailLog.uid,'all') />

	<cftry>
		<cfmail server="#servername#" username="gallart@onlinegalleryart.com"
	password="re3objeC!P" from="info@gallart.com" to="#email#" type="HTML"  subject="#url.subject#">
		<!--- <cfmail server="#application.email_server#" username="#application.email_username#"
password="#application.email_password#" from="#application.email_from#" to="#email#" type="HTML"  subject="#url.subject#"> --->
			#message#
			<br><br><br>
			<!--- To be removed from our mailing list, please <a href="http://www.onlinegalleryart.us/optout.cfm?db_table=#db_table#&db_keyname=#db_keyname#&db_keyvalue=#db_keyvalue#">CLICK</a> --->
		</cfmail>	
		
		<cfcatch type="Any"><cfset error = cfcatch.message /></cfcatch>
	</cftry>
 	
	<cfquery name="updateEmailLog" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    UPDATE email_log SET
			error = '#error#'
		WHERE pk_email_log = #insertEmailLog.uid#
	</cfquery>

</cfoutput>

<cflocation addtoken="No" url="index.cfm?event=email.viewCompiledList&start=#evaluate(url.start+1)#&subject=#url.subject#&pk_emailtemplate=#url.pk_emailtemplate#" />
