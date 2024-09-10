<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/artists" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "artists">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>
	
		<cfscript>
			getAllArtists			= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getHighlightedArtists	= application.objectFactoryAdmin.getInstance('artists').getHighlightedArtists();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	<cfcase value="processHighlightArtists">
	
		<cfscript>
			processHighlightedArtists	= application.objectFactoryAdmin.getInstance('artists').processHighlightedArtists(argumentcollection = form);
		</cfscript>

		<cflocation url="index.cfm?event=artists" addtoken="No">
	
	</cfcase>
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />