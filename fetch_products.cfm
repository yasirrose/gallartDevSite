<cftry>
    <!-- Define default values for page and items per page (ipp) -->
    <cfparam name="page" default="1" type="numeric">
    <cfparam name="ipp" default="12" type="numeric"> <!-- Items per page -->

    <!-- Calculate the starting row -->
    <cfset startrow = ((page - 1) * ipp) + 1>
	<!--- <cfdump var="#artist#" abort="true"> --->
    <!-- Initialize base SQL query -->
	<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT gallery_price as pvalue, *
		FROM (
			SELECT *, ROW_NUMBER() OVER (
				<cfif isDefined('priceOrder') and len(priceOrder)>
                    <cfif priceOrder EQ 'newest' >
                        ORDER BY uid desc
                        <cfelse>
                            ORDER BY gallery_price #priceOrder#
                    </cfif>
                    
                <cfelse>
                    ORDER BY gallery_price DESC
                </cfif>
			) AS RowNum
			FROM products
			WHERE active = 1 
			  AND (path <> '') 
			  AND (path IS NOT NULL)

			  	<cfif isDefined('man') and len(trim(man))>
				  	<cfif man EQ 'Erte'>
					  AND (manufacturer = 'ERTE' OR manufacturer = 'ERTE, ROMAIN')
				  	<cfelse>
					  AND manufacturer LIKE '%#man#%'
				  	</cfif>
			  	</cfif>
			  	<cfif isDefined('Size') and len(trim(Size))>
					AND artSize LIKE '%#Size#%'
			  	</cfif>
			  	<cfif isDefined('Subject') AND len(Subject)>
					AND artSubject LIKE '%#Subject#%'
				</cfif>
				<cfif isDefined('Style') AND len(Style)>
					-- AND artType LIKE '%#Style#%'
					AND artType LIKE <cfqueryparam value="#Style#" cfsqltype="cf_sql_varchar"> OR
					artType LIKE <cfqueryparam value="#Style#,%"
						cfsqltype="cf_sql_varchar"> OR
					artType LIKE <cfqueryparam value="%,#Style#"
						cfsqltype="cf_sql_varchar"> OR
					artType LIKE <cfqueryparam value="%,#Style#,%"
						cfsqltype="cf_sql_varchar">
				</cfif>
				<cfif isDefined('Size') AND len(Size)>
					AND artSize LIKE '%#Size#%'
				</cfif>
				<cfif isDefined('Type') AND len(Type)>
					AND artTypee LIKE '%#Type#%'
				</cfif>
				<cfif isDefined('keywords')>
					AND (name LIKE '%#keywords#%' OR caption LIKE '%#keywords#%' OR modelno LIKE '#keywords#%' OR manufacturer LIKE '%#keywords#%')
				</cfif>
				<cfif isDefined('artist') and len(artist)>
				AND manufacturer LIKE '%#artist#%'
				</cfif>
				<cfif isDefined('year') and len(year)>
				AND year LIKE '%#year#%'
				</cfif>
				<cfif isDefined('path') and len(trim(path))>
                AND path LIKE '%#path#%'
            	</cfif>
				<cfif isDefined('title') and len(trim(title))>
                AND name LIKE '%#title#%'
            	</cfif>
				<cfif isDefined('desc_keyword') and len(trim(desc_keyword))>
                AND location_notes LIKE '%#desc_keyword#%'
            	</cfif>
				<cfif isDefined('a') and len(trim(a)) and isDefined('b') and len(trim(b)) >
                AND gallery_price between #a# and #b#
            	</cfif>

			  
		) AS Subquery
		WHERE RowNum BETWEEN #startrow# AND (#startrow# + #ipp# - 1)
	</cfquery>

<cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT show FROM makeoffer_buttons
	WHERE pk_makeoffer_buttons = 1
</cfquery>
	
	
	<!--- <cfdump var="#productinfo#" abort="true"> --->
    <!-- Output the products as HTML -->
	<cfif productinfo.recordcount gt 0>
	
		
        <cfoutput query="productinfo">
			<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
            <div class="list-item">
                <a href="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#jsStringFormat(trim(replace(name,"'",'')))#')" class="add-hover">
                    <cfif fileexists("http://23.20.226.157/img/thumbnails/#uid#.jpg")>
                        <img src="http://23.20.226.157/img/#uid#.jpg" alt="#name#" title="#name#" border="0" align="center">
                    <cfelse>
                        <!--- <div align="center" style="padding: 20px;">NO IMAGE AVAILABLE</div> --->
						<!--- <img src="https://dummyimage.com/150x100/050005/ededf2.png&text=No+Image+Available+"> --->
						<!--- <img src="https://as2.ftcdn.net/v2/jpg/07/95/29/45/1000_F_795294547_gaBzWLhkAYBSz1ZUIZssHhvzGzstNmHK.jpg"> --->
						<img src="http://23.20.226.157/img/thumbnails/noImage.jfif.jpeg">
                    </cfif>  
                </a>
                <div class="product-name" style="font-weight: 600;">#name#</div>
                <!--- <div class="product-price">
                    <cfif retail_price neq ''>
                        <span style="font-weight: 600;">BY:</span> #ucase(artist_name)#
                    </cfif>
                </div> --->
                <div class="product-price">
                    <cfif retail_price neq ''>
                        <span style="font-weight: 600;">Retail Price:</span> #dollarformat(retail_price)#
                    </cfif>
                </div>
                <div class="product-price">
                    <cfif gallery_price neq ''>
                        <span style="font-weight: 600;">Gallery Price:</span> #dollarformat(gallery_price)#
                    <cfelse>
                        Price On Request
                    </cfif>
				</div>
				<div class="product-price">
                    <cfif modelno neq ''>
                        <!--- <span style="font-weight: 600;">Art ID:</span> #modelno# --->

						<span style="font-weight: 600;">
							<a href="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#jsStringFormat(trim(replace(name,"'",'')))#')" class="add-hover">
								Art ID: #modelno#
							</a>
						</span>
						
                    </cfif>
				</div>
				
				<!--- <a>MORE INFO</a> --->
				<span class="pinkText">
					<b><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#jsStringFormat(trim(replace(name,"'",'')))#')" class="dbl_arrows">MORE INFO</a></b>
				</span>

				<cfif len(fk_users)><span style="font-size: 12px; font-weight: bold; color: ##ff0000;">PRIVATE LISTING</span><br><br></cfif>

				<!--- <div class="e-pricing">
					
					<cfif makeoffer_buttons.show EQ 1>
						<a href="make_offer.cfm?pid=#uid#&xss=#xss#"><img src="images/make_offer.gif" border="0"></a>
					<cfelse>
						<a href="epricing.cfm?pid=#uid#&xss=#xss#">
							<!--- <img src="images/epricing.gif" border="0"> --->
							<img src="images/question.gif" border="0">
						</a>
					</cfif>
				</div> --->


				
				
            </div>
        </cfoutput>
    <cfelse>
        <!-- Return an empty response if no more products -->
        <cfoutput></cfoutput>
    </cfif>

<cfcatch type="any">
    <!-- Error handling: log and display error message -->
    <!--- <cflog file="query_errors" text="Error fetching products: #cfcatch.message#"> --->
    <cfdump var="#cfcatch#" abort="true">
</cfcatch>
</cftry>

<style>
	.add-hover:hover{
		color: #dd3a7d;
	}
	.add-hover{
		color:black;
	}
</style>
