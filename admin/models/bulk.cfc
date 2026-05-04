<cfcomponent>
    <!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="art">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>


    <cffunction name="getListingsForBulk" access="remote" returntype="query">

		<cfargument name="sellerId" required="no" type="string" default="">
		<cfargument name="modelno" required="no" type="string" default="">
		<cfargument name="title" required="no" type="string" default="">
		<cfargument name="artist" required="no" type="string" default="">
		<cfargument name="exclude_artist" required="no" type="string" default="">
		<cfargument name="medium" required="no" type="string" default="">
		<cfargument name="year" required="no" type="string" default="">
		<cfargument name="height" required="no" type="string" default="">
		<cfargument name="width" required="no" type="string" default="">
		<cfargument name="description" required="no" type="string" default="">
		<cfargument name="fromPrice" required="no" type="string" default="">
		<cfargument name="toPrice" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
		<cfargument name="fromLastEdit" required="no" type="string" default="">
		<cfargument name="toLastEdit" required="no" type="string" default="">
		<cfargument name="gallery_only" required="no" type="string" default="">
		<cfargument name="onSale" required="no" type="string" default="">
		<cfargument name="trump" required="no" type="string" default="">
		<cfargument name="auction" required="no" type="string" default="">
		<cfargument name="active" required="no" type="string" default="">
		<cfargument name="searchArtist" required="no" type="string" default="">
		<cfargument name="priceOrder" required="no" type="string" default="">

		<cfset var qListings='' />

        <!--- <cfif arguments.searchArtist NEQ '' >
            <cfdump var="#arguments.searchArtist#" abort="true">
        </cfif> --->
        

		<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
			<cfset arguments.fromPrice 	= rereplace(arguments.fromPrice, "[^0-9|.]", "", "all")>
		</cfif>
		<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
			<cfset arguments.toPrice 	= rereplace(arguments.toPrice, "[^0-9|.]", "", "all")>
		</cfif>

	   	<cfquery name="qListings" datasource="#application.dsource#">
	      	SELECT CONVERT(CHAR(9),datestamp,6) as listingDate,*
	      	FROM products P
			LEFT OUTER JOIN users U on P.fk_users = U.pk_users
			WHERE active = 1
			<cfif isDefined('arguments.modelno') AND arguments.modelno neq ''>
	      		AND modelno like '#arguments.modelno#%'
	      	</cfif>
			<cfif isDefined('arguments.title') AND arguments.title neq ''>
	      		AND name like '#arguments.title#%'
	      	</cfif>
			<cfif isDefined('arguments.artist') AND arguments.artist neq ''>
	      		AND manufacturer like '#arguments.artist#%'
	      	</cfif>
			<cfif isDefined('arguments.exclude_artist') AND arguments.exclude_artist neq ''>
	      		AND manufacturer <> '#arguments.exclude_artist#'
	      	</cfif>
			<cfif isDefined('arguments.medium') AND arguments.medium neq ''>
	      		AND path = '#arguments.medium#'
	      	</cfif>
			<cfif isDefined('arguments.year') AND arguments.year neq ''>
	      		AND year = '#arguments.year#'
	      	</cfif>
			<cfif isDefined('arguments.height') and len(trim(arguments.height))>
				AND (patindex('%x%',size) > 1 AND substring(size,1,patindex('%x%',size)-1) like '#arguments.height#')
			</cfif>
			<cfif isDefined('arguments.width') and len(trim(arguments.width))>
				AND (patindex('%x%',size) > 1 AND replace(substring(size,patindex('%x%',size)+1,10),' ','') like '#arguments.width#%')
			</cfif>
			<cfif isDefined('arguments.description') AND arguments.description neq ''>
	      		AND caption like '%#arguments.description#%'
	      	</cfif>
			<cfif isDefined('arguments.fromPrice') AND arguments.fromPrice neq ''>
				AND gallery_price >= #arguments.fromPrice#
			</cfif>
			<cfif isDefined('arguments.toPrice') AND arguments.toPrice neq ''>
				AND gallery_price <= #arguments.toPrice#
			</cfif>
			<cfif isDefined('arguments.fromDate') AND arguments.fromDate neq ''>
				AND datestamp >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif isDefined('arguments.toDate') AND arguments.toDate neq ''>
				AND datestamp <= '#dateFormat(arguments.toDate)#'
			</cfif>
			<cfif isDefined('arguments.fromLastedit') AND arguments.fromLastedit neq ''>
				AND lastedit >= '#dateFormat(arguments.fromLastedit)#'
			</cfif>
			<cfif isDefined('arguments.toLastedit') AND arguments.toLastedit neq ''>
				AND lastedit <= '#dateFormat(arguments.toLastedit)#'
			</cfif>
			<cfif isDefined('arguments.gallery_only') AND arguments.gallery_only EQ 1>
				AND fk_users is null
			</cfif>
			<cfif isDefined('arguments.sellerId') and len(trim(arguments.sellerId))>
				<cfif arguments.sellerId eq 0>
				 	AND fk_users is not null
				<cfelseif arguments.sellerId gt 0>
					AND fk_users = #arguments.sellerId#
				</cfif>
			</cfif>
			<cfif isDefined('arguments.onSale') AND arguments.onSale EQ 1>
				AND closeout = 1
			</cfif>
			<cfif isDefined('arguments.trump') AND arguments.trump EQ 2>
				AND location = 2
			</cfif>
			<cfif isDefined('arguments.auction') AND arguments.auction EQ 1>
				AND auction = 1
			</cfif>
            <cfif isDefined('arguments.searchArtist') AND arguments.searchArtist NEQ ''>
				AND manufacturer like '#arguments.searchArtist#%'
			</cfif>
            <cfif isDefined('arguments.priceOrder') AND arguments.priceOrder NEQ ''>
				ORDER BY gallery_price  #arguments.priceOrder#
                <cfelse>
                    ORDER BY name
			</cfif>
	      		
	   	</cfquery>

   		<cfreturn qListings />

	</cffunction>

</cfcomponent>