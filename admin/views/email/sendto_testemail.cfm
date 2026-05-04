<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfquery name="findLastEmailImportList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT top 1 pk_email_imports_list from email_imports_list
	order by pk_email_imports_list desc
</cfquery>

<cfquery name="insertEmailImports" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    INSERT into email_imports
	(fk_email_imports_list,email)
	values
	(#findLastEmailImportList.pk_email_imports_list#,'#form.testemail#')
	SELECT @@identity as uid
</cfquery>

<cfquery name="findLastEmailImport" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT top 1 pk_email_imports from email_imports
	order by pk_email_imports desc
</cfquery>

<cfquery name="insertMailinglist" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    INSERT into mailinglist
	(email,db_table,db_keyname,db_keyvalue)
	values
	('#form.testemail#','email_imports','pk_email_imports',#findLastEmailImport.pk_email_imports#)
</cfquery>

<cfquery name="getEmailList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT top 1 * FROM mailinglist
	order by pk_mailinglist desc
</cfquery>

<cfquery name="getTemplate" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from emailtemplate
	WHERE pk_emailtemplate = '#url.pk_emailtemplate#'
</cfquery>

<cfoutput query="getEmailList">

	<cfset error = '' />
	
	<cfquery name="insertEmailLog" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    INSERT into email_log
			(
				email,
				fk_emailtemplate
			)
			values
			(
				'#form.testemail#',
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
	password="#application.email_password#" to="#form.testemail#" from="#application.email_from#" type="HTML"  subject="#url.subject#"> --->
			#message#<br>
			<!--- <br><br><br>
				To be removed from our mailing list, please <a href="http://gallart.com/optout.cfm?db_table=#db_table#&db_keyname=#db_keyname#&db_keyvalue=#db_keyvalue#">CLICK</a> --->
		</cfmail>
		<cfcatch type="Any">
			<cfset error = cfcatch.message />
		</cfcatch>
	</cftry>
	
	<cfquery name="updateEmailLog" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    UPDATE email_log SET
			error = '#error#'
		WHERE pk_email_log = #insertEmailLog.uid#
	</cfquery>

</cfoutput>

<cfoutput>

<table cellspacing="0" cellpadding="4" border="0" width="100%" height="600">
	<tr>
		<td valign="top">
			<font face="verdana,arial,helvetica" size="2">
			<cfif isDefined('errorMsg')>
				Error: #errorMsg#
			<cfelse>
				Test email sent to: #form.testemail#
			</cfif>
			</font>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<form><input type="Button" value="GO BACK" onclick="self.history.go(-1);" /></form>
		</td>
	</tr>
	<tr>
	    <td valign="top">
			<input type="Button" value="SEND TO EMAIL LIST" onclick="window.location.href='index.cfm?event=email.viewCompiledList&subject=#url.subject#&pk_emailtemplate=#url.pk_emailtemplate#'" />
		</td>
	</tr>
	<tr>
		<td colspan="2" height="400">&nbsp;</td>
	</tr>
</table>
					
</cfoutput>
