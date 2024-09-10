<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/phoneformat" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "phoneformat">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>

		<cfscript>
			getUnformattedCustomers = application.objectFactoryAdmin.getInstance('phoneformat').getUnformattedCustomers();
			getUnformattedLeads = application.objectFactoryAdmin.getInstance('phoneformat').getUnformattedLeads();
			getUnformattedSellers = application.objectFactoryAdmin.getInstance('phoneformat').getUnformattedSellers();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">

	</cfdefaultcase>

	<cfcase value="edit">
		
		<cfscript>
			getNumbers = application.objectFactoryAdmin.getInstance('phoneformat').getNumbers(url.db);
		</cfscript>

		<cfinclude template="#ViewPath#/edit.cfm">

	</cfcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />