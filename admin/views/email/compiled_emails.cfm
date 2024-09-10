
<cfset temp = structDelete(session,'massEmail') />
<cfquery name="getEmailList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM mailinglist
</cfquery> 

<cfoutput>


<strong>MASS EMAIL APPLICATION</strong><br><br>
<cfform method="post" action="index.cfm?event=email.sendtoTestemail&subject=#url.subject#&pk_emailtemplate=#url.pk_emailtemplate#">
<table cellspacing="0" cellpadding="5" border="0" width="100%" height="600">
	<tr>
		<td colspan="2" valign="top">
			<font face="verdana,arial,helvetica" size="2"><strong>TOTAL NUMBER OF EMAILS ON THIS LIST: #getEmailList.recordcount#</strong></font>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="top" >
			<font face="verdana,arial,helvetica" size="2">Send to test email:
		</td>
	</tr>
	<tr>
	    <td colspan="2" valign="top"><font face="verdana,arial,helvetica" size="2"><b>Test Mode Email Address:</b></font><br>
		<cfinput type="text" size="30" name="testemail" value="" required="Yes" message="Please enter a test email address"><input type="Submit" name="sendEmail" value="SEND TO TEST EMAIL">
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="top">
			<font face="verdana,arial,helvetica" size="2">Or send to email list:</font>
		</td>
	</tr>
	<tr>
	    <td colspan="2" valign="top">
			<input type="Button" value="SEND TO EMAIL LIST" onclick="window.location.href='index.cfm?event=email.viewCompiledList&subject=#url.subject#&pk_emailtemplate=#url.pk_emailtemplate#'" />
		</td>
	</tr>
	<tr>
		<td colspan="2" height="400">&nbsp;</td>
	</tr>
</table>
</cfform>
						
						
</cfoutput>
