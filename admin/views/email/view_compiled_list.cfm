
<!--- SET NUMBER OF EMAILS TO BE SENT IN BATCH --->
<cfset batchNum = 100 />

<cfquery name="getEmailList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM mailinglist
</cfquery> 

<cfparam name="url.start" default="1">

<cfset batchListLen = getEmailList.recordcount/batchNum />
<cfif getEmailList.recordcount MOD batchNum gt 0>
	<cfset batchListLen = batchListLen + 1 />
</cfif>

<cfoutput>

<table cellspacing="0" cellpadding="5" border="0" width="100%" height="600">
	<tr>
		<td valign="top">
			<font face="verdana,arial,helvetica" size="2"><strong>TOTAL NUMBER OF EMAILS: #getEmailList.recordcount#</strong></font>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<form>
			<table cellspacing="0" cellpadding="2" border="0" width="100%">
				<cfloop from="1" to="#batchListLen#" index="idx">
				<cfset startRow = ((idx - 1) * batchNum) + 1 />
				<tr>
					<td valign="top">
						<font face="verdana,arial,helvetica" size="2">
						<input name="batchButton" type="Button" value="Batch #idx# of #batchNum# emails" onclick="window.location.href='index.cfm?event=email.sendEmails&start=#idx#&startRow=#startRow#&batchNum=#batchNum#&subject=#url.subject#&pk_emailtemplate=#url.pk_emailtemplate#'" <cfif url.start NEQ idx>disabled</cfif>>

							Starting with:  #getEmailList.email[startRow]#
						<cfif url.start gt batchListLen><br><br><span style="color: $$ff0000; font-weight: bold;">ALL EMAILS SENT</span></cfif>
						</font>
					</td>
				</tr>
				</cfloop>
			</table>
			</form>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="400">&nbsp;</td>
	</tr>
</table>
					

</cfoutput>

