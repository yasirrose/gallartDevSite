
<cfset temp = structDelete(session,'massEmail') />
<cfquery name="getEmailList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM mailinglist_export
</cfquery> 

<cfoutput>


<strong>MASS EMAIL APPLICATION</strong><br><br>
<table cellspacing="0" cellpadding="5" border="0" width="100%" height="600">
	<tr>
		<td colspan="2" valign="top">
			<font face="verdana,arial,helvetica" size="2"><strong>TOTAL NUMBER OF EMAILS ON THIS LIST: #getEmailList.recordcount#</strong></font>
		</td>
	</tr>
	
	<tr>
		<td colspan="2">
			<input type="Button" value="Create Excel File" onclick="document.getElementById('createXls').src='views/exports/create_mailinglist_xls.cfm'">
		</td>
	
	</tr>
	<tr>
	    <td colspan="2" valign="top">
			<iframe id="createXls" src="" frameborder="0"></iframe>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="400">&nbsp;</td>
	</tr>
</table>
		
						
</cfoutput>
