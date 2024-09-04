<cftry>
    <!-- Define default values for page and items per page (ipp) -->
    <cfparam name="page" default="1" type="numeric">
    <cfparam name="ipp" default="12" type="numeric"> <!-- Items per page -->

    <!-- Calculate the starting row -->
    <cfset startrow = ((page - 1) * ipp) + 1>
	<!--- <cfdump var="#man#" abort="true"> --->
    <!-- Initialize base SQL query -->
	<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT gallery_price as pvalue, *
		FROM (
			SELECT *, ROW_NUMBER() OVER (ORDER BY gallery_price DESC) AS RowNum
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
			  
		) AS Subquery
		WHERE RowNum BETWEEN #startrow# AND (#startrow# + #ipp# - 1)
	</cfquery>
	
	<!--- <cfdump var="#productinfo#" abort="true"> --->
    <!-- Output the products as HTML -->
    <cfif productinfo.recordcount gt 0>
        <cfoutput query="productinfo">
            <div class="list-item">
                <a href="">
                    <cfif fileexists("http://23.20.226.157/img/thumbnails/#uid#.jpg")>
                        <img src="http://23.20.226.157/img/thumbnails/#uid#.jpg" alt="#name#" title="#name#" border="0" align="center">
                    <cfelse>
                        <div align="center" style="padding: 20px;">NO IMAGE AVAILABLE</div>
                    </cfif>  
                </a>
                <div class="product-name">#name#</div>
                <div class="product-price">
                    <cfif gallery_price neq ''>
                        Gallery Price: #dollarformat(gallery_price)#
                    <cfelse>
                        Price On Request
                    </cfif>
                </div>
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
