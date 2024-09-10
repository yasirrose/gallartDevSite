<cfsilent>
<!---
Run Rate is the number of seconds between refresh.  To
optimize this make this setting about 2 seconds longer
than the ColdFusion Server's mail spool fetch rate. 
Otherwise mail will pile up in the spooler and partially
defeat the purpose of trickling out the mail
 --->
<cfset variables.RunRate=5>
<!---
Query Run is the number of query rows (email addresses)
that will be processed on each execution of this template
--->
<cfset variables.QueryRun=5>
<!---
pull the ID field so we can get a record count. 
--->
<cfquery
   datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#"
   name="MailList">
   SELECT
      mailer.ID
   FROM mailer
   WHERE
      mailer.EmailAddr IS NOT NULL
   ORDER BY
      mailer.ID ASC
</cfquery>
<!---
Do some stuff to prevent page caching, which was found to
be a problem on some client browsers
--->
<cfheader
   name="Expires"
   value="Sun, 06 Nov 1994 08:49:37 GMT">
<cfheader
   name="Pragma"
   value="no-cache">
<cfheader
   name="cache-control"
   value="no-cache, no-store, must-revalidate">
</cfsilent>
<!---
Are we there yet?
--->
<cfif MailList.RecordCount lt 1>

   <!---
   yes.  Inform the user
   --->
   <html><head><title>FINISHED</title>
   <style>
		body {
			font-family: Arial;
			font-size: 11px;
		}
	</style>
   
   </head>
   <h1>All Done</h1>
   <b>Close this browser window!</b>
   <p><b>Do NOT press your BACK button</b> to leave.</p>
   </body></html>
<cfelse>
   <!---
   display the "in-progress" page
   --->
   <html>
   <cfoutput>
   <!---
   This next line re-runs the template automatically at the run rate.

Note the UUID inserted into the url.  This is another part of ensuring

the browser doesn't cache this page.
   --->
   <meta
      http-equiv="REFRESH"
      content="#variables.RunRate#;URL=#cgi.script_name#
?UniqueURL=#UrlEncodedFormat(CreateUUID())#">
   </cfoutput>
   <head><title>Low Volume Mass Mailer with Failover</title>
   <style>
	body {
		font-family: Arial;
		font-size: 11px;
	}
</style>
   
   </head>
   <!--- 
   Send the actual mail. 
   --->
   <cfloop
      query="MailList"
      startrow="1"
      endrow="#variables.QueryRun#">
      <cfquery name="ThisEmail" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         SELECT
            mailer.EmailAddr,
            mailer.EmailMsg,
            mailer.EmailType,
            mailer.EmailServer,
            mailer.EmailSubject,
            mailer.EmailFrom
         FROM mailer
         WHERE
         mailer.ID=
         <cfqueryparam
            cfsqltype="CF_SQL_NUMERIC"
            value="#MailList.ID#">
      </cfquery>
      <cfmail
         to="#ThisEmail.EmailAddr#"
         from="#ThisEmail.EmailFrom#"
         subject="#ThisEmail.EmailSubject#"
         server="#ThisEmail.EmailServer#"
		 username="onli16@onlinegalleryart.com"
		 password="r3eOteC"
         type="#ThisEmail.EmailType#">
      <cfmailparam
         name="Message-ID"
         value="<#CreateUUID()#@#ThisEmail.EmailServer#>">

      #ThisEmail.EmailMsg#
      </cfmail>
      <cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         DELETE FROM mailer
         WHERE mailer.ID = <cfqueryparam
               cfsqltype="CF_SQL_NUMERIC"
               value="#MailList.ID#">
      </cfquery>
   </cfloop>
   <!---
   give the user a visual cue as to where the operation is at the moment.
   You can get qite fancy here with pretty html and time-to-completion
   calculations based on your record count, refresh rate etc.
   --->
   <cfset variables.LeftToGo=MailList.RecordCount-variables.QueryRun>
   <cfoutput>
   <p><b>Total left to send: #variables.LeftToGo#</b>.</p>
   <p>Each run is #variables.RunRate# seconds apart.</p>
   </cfoutput>
   <p>Leave this system alone and wait for this job to complete.</p>
   <p>When it finishes, you will be notified.</p>
   </body></html>
</cfif>