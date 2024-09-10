<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/sellers" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "sellers">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>
		
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	<cfcase value="latestListings">
	
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getAllMedium 	= application.objectFactoryAdmin.getInstance('art').getAllMedium();
		</cfscript>
	
		<cfinclude template="#ViewPath#/latest_listings.cfm">
		
	</cfcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />