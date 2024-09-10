<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/appraisals" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "appraisals">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>
	
		<cfscript>
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />