<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/customers" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "customers">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>
	
		<cfscript>
			getStates	 = application.objectFactoryAdmin.getInstance('orders').getStates();
		</cfscript>
		
		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />