	<cfcomponent displayname="mailer" hint="I handle mailer">

	<!---
		function init
		in:		OF
		out:	this
		notes:
	 --->
	<cffunction name="init" access="public" output="No" returntype="mailer">
		<cfargument name="objectFactory" required="no" />

		<cfscript>
			// hold instance
			variables.instance = structNew();
			// objectFactory
			// variables.objectFactory = arguments.objectFactory;

			// initialize database variables
			variables.instance.dsource 		= application.dsource;
			variables.instance.mailserver 	= application.mailserver;
			variables.instance.dbuname		= application.dbuname;
			variables.instance.dbpword		= application.dbpword;
		</cfscript>

		<cfreturn this />
	</cffunction>

	<!--- Send Email --->
	<cffunction name="sendMail" access="remote" returntype="struct" returnformat="JSON">
		<cfargument name="sender" type="string" default="">
		<cfargument name="recipient" type="string" default="">
		<cfargument name="subject" type="string" default="">
		<cfargument name="body" type="string" default="">
		<cfargument name="attachment" type="string" default="">
		<cfargument name="salutation" type="string" default="">
		<cfargument name="closer" type="string" default="">

		<cfset var returnStruct = structNew() />
		<cfset var success = 1 />

		<cftry>
			<cfmail to="#arguments.recipient#" from="#arguments.sender#" subject="#arguments.subject#" cc="" server="#application.mailserver#" username="#application.mailserver_un#"
	password="#application.mailserver_pw#"  type="HTML">
				<cfif len(arguments.attachment)>
					<cfmailparam file="#arguments.attachment#" type="application/pdf" />
				</cfif>
				<cfif len(arguments.salutation)>
					#arguments.salutation#
				</cfif>
				#arguments.body#
				<cfif len(arguments.closer)>
					#arguments.closer#
				</cfif>
			</cfmail>

			<cfcatch type="Any"><cfset success = 0 /></cfcatch>
		</cftry>

		<cfset returnStruct.success = success />

		<cfreturn returnStruct>
	</cffunction>
</cfcomponent>
