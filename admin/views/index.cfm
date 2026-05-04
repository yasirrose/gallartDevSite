
<!--- default event --->
<cfparam name="session.loggedin" default="false" />
<cfif structKeyExists(url, "logout")>
	<cfset session.loggedin = false>
	<cfset structDelete(session,'userinfo')>
</cfif>

<cfparam name="URL.event" default="leads" />

<cfset ControllerPath = "controllers" />

<cfinclude template="#ControllerPath#/#listfirst(URL.event, '.')#.cfm" />