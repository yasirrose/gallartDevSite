<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/sales" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "sales">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>

		<cfinclude template="#ViewPath#/sales_menu.cfm">
		
	</cfdefaultcase>

	<cfcase value="saleSearch">
	
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
		</cfscript>

		<cfinclude template="#ViewPath#/sale_search.cfm">
		
	</cfcase>
	
	<cfcase value="saleSearchResults">
	
		<cfscript>
			getListingsForSales = application.objectFactoryAdmin.getInstance('art').getListingsForSales( argumentcollection = form );
		</cfscript>

		<cfinclude template="#ViewPath#/sale_search_results.cfm">
		
	</cfcase>
	
	<cfcase value="saleProc">
	
		<cfscript>
			insertSalePrices = application.objectFactoryAdmin.getInstance('art').insertSalePrices( form );
		</cfscript>


		
		<!---FOR TESTING ONLY -- YOUR CHANGES HAVE NOT BEEN SAVED--->
		
		<cflocation url="index.cfm?event=sales.saleSearch" addtoken="No">
		
	</cfcase>
	
	
	<cfcase value="saleLinks">
	
		<cfscript>
			getSales = application.objectFactoryAdmin.getInstance('sales').getSales();
		</cfscript>

		<cfinclude template="#ViewPath#/sale_links.cfm">
		
	</cfcase>
	
	<cfcase value="salesiteCodeResults">
	
		<cfscript>
			getSalesFromId = application.objectFactoryAdmin.getInstance('sales').getSalesFromId( form.pk_sales );
			getSaleCodeInfo = application.objectFactoryAdmin.getInstance('sales').getSaleCodeInfo( getSalesFromId.SaleCode );
			getSalesiteCodeListings = application.objectFactoryAdmin.getInstance('art').getSalesiteCodeListings( getSalesFromId.queryString );
		</cfscript>

		<cfinclude template="#ViewPath#/salesite_code_results.cfm">
		
	</cfcase>
	
	<cfcase value="salelinkCreateSearch">
	
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>

		<cfinclude template="#ViewPath#/salelink_create_search.cfm">
		
	</cfcase>
	
	<cfcase value="salelinkSearchResults">
	
		<cfscript>
			createQueryString = application.objectFactoryAdmin.getInstance('sales').createQueryString( form );
			getSalesiteCodeListings = application.objectFactoryAdmin.getInstance('art').getSalesiteCodeListings( createQueryString );
		</cfscript>

		<cfinclude template="#ViewPath#/salesite_create_results.cfm">
		
	</cfcase>
	
	<cfcase value="editSales">
	
		<cfif structKeyExists(form,'delete')>
		
			<cfscript>
				deleteSales = application.objectFactoryAdmin.getInstance('sales').deleteSales( argumentcollection = form );
			</cfscript>
			
			<cfdump var="#deleteSales#"><cfabort>
			
		<cfelse>
		
			<cfscript>
				editSales = application.objectFactoryAdmin.getInstance('sales').editSales( form );
			</cfscript>	
		
		</cfif>
		
		<cflocation url="index.cfm?event=sales.salesiteCodeSearch" addtoken="No">
		
	</cfcase>
	
	<cfcase value="setSalePrices">
	
		<cfscript>
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>
	
		<cfinclude template="#ViewPath#/set_sale_prices.cfm">
	
	</cfcase>
	
	<cfcase value="setSalePricesResults">
	
		<cfscript>
			setSalePrices = application.objectFactoryAdmin.getInstance('art').setSalePrices( argumentcollection=form );
		</cfscript>

		<cfinclude template="#ViewPath#/set_sale_prices_results.cfm">
	
	</cfcase>
	
	<cfcase value="setAllSalePrices">
		
		<cfinclude template="#ViewPath#/set_all_sale_prices.cfm">
	
	</cfcase>
	
	<cfcase value="setAllSalePricesProc">
    
    	<cfparam name="form.priceToReduce" default="gallery">
    	<cfparam name="form.highEstimate" default="0">
        <cfparam name="form.removeSale" default="0">
		
		<cfscript>
			setAllSalePrices = application.objectFactoryAdmin.getInstance('art').setAllSalePrices( argumentcollection=form );
		</cfscript>
		
		<cfinclude template="#ViewPath#/set_all_sale_prices_done.cfm">
	
	</cfcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />