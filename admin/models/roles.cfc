<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="roles">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="getAllRoles" access="remote">
	
		<cfset var qRoles='' />

		   <cfquery name="qRoles" datasource="#application.dsource#">
		      SELECT *
		      FROM roles
			  ORDER BY role
		   </cfquery>
	   
   		<cfreturn qRoles />
	
   </cffunction>

	
</cfcomponent>