<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/events" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "events">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	<cfcase value="eventRegistrations">

		<cfinclude template="#ViewPath#/event_registrations.cfm">
		
	</cfcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />