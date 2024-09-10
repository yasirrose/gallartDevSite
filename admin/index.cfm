
<!--- default event --->
<cftry>
<cfparam name="session.loggedin" default="false" />
<cfif structKeyExists(url, "logout")>
	<cfset session.loggedin = false>
	<cfset structDelete(session,'userinfo')>
</cfif>

<cfparam name="URL.event" default="leads" />

<cfset ControllerPath = "controllers" />
<!--- <cfdump var="#listfirst(URL.event, '.')#" abort="true"> --->
<cfinclude template="#ControllerPath#/#listfirst(URL.event, '.')#.cfm" />
<cfcatch>
	<!--- <cfset currentTemplate = CGI.SCRIPT_NAME>
	<cfdump var="#currentTemplate#" abort="true"> --->
	<cfdump var="#cfcatch#" abort='true'>
</cfcatch>
</cftry>