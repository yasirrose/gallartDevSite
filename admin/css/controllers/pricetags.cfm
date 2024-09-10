<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/pricetags" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "quotes">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>
	
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllGallartArtists();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	<cfcase value="pricetagsResults">

		<cfscript>
			getListingsForSales = application.objectFactoryAdmin.getInstance('art').getListingsForPricetags( argumentcollection = form );
		</cfscript>
		
		<cfinclude template="#ViewPath#/pricetags_results.cfm">
	
	</cfcase>
	
	<cfcase value="createPdf">
	
		<cfif isDefined('form.productId')>
	
		<cfscript>
			getListingsByIdList = application.objectFactoryAdmin.getInstance('art').getListingsByIdList( form.productId );
		</cfscript>
		
		<cfinclude template="#ViewPath#/print_template.cfm">
		
		<cfelse>
		
			You must select at least one listing to print.
		
		</cfif>

	</cfcase>
	

	
</cfswitch>				
	
	


		
	
		
		
<!---include main bottom layout --->

<cfinclude template="../views/layout.bottom.cfm" />