<cfif NOT structKeyExists(session,'currquery')>
	<cflocation url="index.cfm?event=email" addtoken="No" />
</cfif>

<cfset thisQ = session.currQuery />

<cfquery name="getMessage" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT email_content from emailtemplate
	WHERE pk_emailtemplate = #session.massEmail.pk_emailtemplate#
</cfquery>

<cfoutput query="thisQ" startrow="#url.startID#" maxrows="#url.maxrows#">

		<cfquery name="qOptout" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * from optout
			WHERE email = '#email#'
		</cfquery>
		
		<!---<cfsavecontent variable="contentWithOptout">
			<cfoutput>
				#getMessage.email_content#<br /><br />
				<a href="http://www.gallart.com/opt-out.cfm?email=#email#"><img src="http://www.gallart.com/images/unsubscribe.png" border="0" /></a>
			</cfoutput>
		</cfsavecontent>--->
		
		<cfset contentWithOptout = getMessage.email_content & '<br /><a href="http://www.gallart.com/opt-out.cfm?email=' & email & '"><img src="http://www.gallart.com/images/unsubscribe.png" border="0" /></a>' />
		
		<cfif isValid("email",email) AND maillist EQ 1 AND qOptout.recordcount EQ 0>
	
			<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" timeout="10000">
				INSERT INTO mailer
					(
						EmailAddr,
						EmailMsg,
						EmailType,
						EmailServer,
						EmailSubject,
						EmailFrom
					)
					values
					(
						'#email#',
						'#contentWithOptout#',
						'HTML',
						'#servername#',
						'#session.massEmail.subject#',
						'info@gallart.com'
					)
					
			</cfquery>
			
		</cfif>
		
		<cfif currentrow EQ (url.startID + url.maxrows) - 1>
			<cflocation url="index.cfm?event=email.insertLoop&startID=#evaluate(url.startID+maxrows)#" addtoken="No">
		</cfif>
	
</cfoutput>

	
