<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/bulk" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "bulk">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>

<cfswitch expression="#Action#" >

    <cfdefaultcase>
        <cfinclude template="#ViewPath#/bulk_menu.cfm">
    </cfdefaultcase>

    <cfcase value="bulkSearch">
	
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
		</cfscript>

		<cfinclude template="#ViewPath#/bulk_search.cfm">
		
	</cfcase>

    <cfcase value="bulkSearchResults">
	
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getListingsForBulk = application.objectFactoryAdmin.getInstance('art').getListingsForBulk( argumentcollection = form );
		</cfscript>

		<cfinclude template="#ViewPath#/bulk_search_results.cfm">
		
	</cfcase>

    
</cfswitch>

<cfinclude template="../views/layout.bottom.cfm" />