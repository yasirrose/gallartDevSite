<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/email_imports" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "email_imports">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />