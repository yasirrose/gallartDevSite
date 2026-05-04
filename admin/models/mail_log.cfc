<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="mail_log">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="getMail" access="remote">
		<cfargument name="pk_employees" required="yes">
		<cfargument name="pk_modules" required="yes">
		<cfargument name="moduleId" required="yes">
	
		<cfset var qMail='' />

	   	<cfquery name="qMail" datasource="#application.dsource#">
	      	SELECT *
	      	FROM  mail_log ML
			<!--- WHERE fk_employees = #arguments.pk_employees#
			AND fk_modules = #arguments.pk_modules#
			AND moduleId = #arguments.moduleId# --->
	   	</cfquery>
	   	
   		<cfreturn qMail />
	
   	</cffunction>

	
</cfcomponent>