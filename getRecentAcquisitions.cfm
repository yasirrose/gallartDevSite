<cftry>
    <!-- Define default values for page and items per page (ipp) -->
    <cfparam name="page" default="1" type="numeric">
    <cfparam name="ipp" default="12" type="numeric"> <!-- Items per page -->

    <!-- Calculate the starting row -->
    <cfset startrow = ((page - 1) * ipp) + 1>
    
    <cfquery name="getRecentAcquisitions" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * 
        FROM (
            SELECT *, ROW_NUMBER() OVER (ORDER BY active_date DESC) AS RowNum
            FROM products
            WHERE active = 1
            <cfif isDefined('keywords') and len(trim(keywords))>
                AND (name LIKE '%#keywords#%' OR caption LIKE '%#keywords#%' OR modelno LIKE '#keywords#%' OR manufacturer LIKE '%#keywords#%')
            </cfif>
            <cfif isDefined('artist') and len(trim(artist))>
                AND manufacturer = '#artist#'
            </cfif>
            <cfif isDefined('path') and len(trim(path))>
                AND path = '#path#'
            </cfif>
            AND fk_users IS NULL
        ) AS Subquery
        WHERE RowNum BETWEEN #startrow# AND (#startrow# + #ipp# - 1)
    </cfquery>

	<!--- <cfdump var="#productinfo#" abort="true"> --->
    <!-- Output the products as HTML -->
    <cfif getRecentAcquisitions.recordcount gt 0>
        <cfoutput query="getRecentAcquisitions" >
            <div class="list-item">
            <cfif listlen(manufacturer) gt 1>
                <cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
                <cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
            <cfelse>
                <cfset artist_name = manufacturer />
                <cfset artist_name_url = manufacturer />
            </cfif>
            
        <!--- <Cfset pc = pc + 1> --->
        <Td valign="top" align="Center">
        <A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
            <!--- <cfset uidd = '20338'> --->
        <!--- <IMG SRC="http://23.20.226.157/img/#uidd#.jpg?x=randrange(1,99)"  width="100" BORDER="0" ALT="#trim(modelno)#" align="Center"> 
        
         SRC="./img/thumbnails/#uid#.jpg?x=randrange(1,99)"
        --->
        <IMG SRC="./img/#uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#trim(modelno)#" align="Center">
        </A>
        <Br>
        <A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
        #name#
        </a>
        <br>
        <span class="bytext">
        By: #ucase(artist_name)#<Br> </span>
        <font color="660066" size="2">
        <cfif retail_price gt 0 and retail_price gt gallery_price>
        Retail Price: #dollarformat(retail_price)#
        </cfif></font><Br>
        <span class="pinkText">
        <cfif gallery_price eq 0>
        <b>Price On Request</b>
        <cfelse>
        Gallery Price: <b>#dollarformat(gallery_price)#</b>
        </cfif>
        </span><br>
        Art ID:&nbsp;#modelno#<br><br>
    <cfif len(fk_users)><span style="font-size: 12px; font-weight: bold; color: ##ff0000;">PRIVATE LISTING</span><br><br></cfif>
    
    </td>

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