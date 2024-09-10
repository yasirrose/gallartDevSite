<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/requests" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "requests">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>
	
		<cfscript>
			getRequestStatus = application.objectFactoryAdmin.getInstance('requests').getRequestStatus();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />