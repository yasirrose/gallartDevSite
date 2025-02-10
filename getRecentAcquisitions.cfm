<cftry>
    <!-- Define default values for page and items per page (ipp) -->
    <cfparam name="page" default="1" type="numeric">
    <cfparam name="ipp" default="12" type="numeric"> <!-- Items per page -->

    <!-- Calculate the starting row -->
    <cfset startrow = ((page - 1) * ipp) + 1>
    
    <cfquery name="getRecentAcquisitions" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * 
        FROM (
            SELECT TOP 200 *, ROW_NUMBER() OVER (
                <cfif isDefined('priceOrder') and len(priceOrder)>
					<cfif priceOrder EQ 'newest' >
                        ORDER BY uid DESC
                        <cfelse>
                            ORDER BY gallery_price #priceOrder# 
                    </cfif>
				<cfelse>
					ORDER BY active_date DESC
				</cfif>
            ) AS RowNum
            FROM products
            WHERE active = 1
            
            <cfif isDefined('keywords') and len(trim(keywords))>
                AND (name LIKE '%#keywords#%' OR caption LIKE '%#keywords#%' OR modelno LIKE '%#keywords#%' OR manufacturer LIKE '%#keywords#%')
            </cfif>
            <cfif isDefined('artist') and len(trim(artist))>
                AND manufacturer = '#artist#'
            </cfif>
            <cfif isDefined('path') and len(trim(path))>
                AND path = '#path#'
            </cfif>
            <cfif isDefined('Subject') and len(Subject)>
				AND artSubject LIKE '%#Subject#%'
			</cfif>
            <cfif isDefined('Size') and len(trim(Size))>
					AND artSize LIKE '%#Size#%'
			</cfif>
            <cfif isDefined('Type') and len(trim(Type))>
					AND artTypee LIKE '%#Type#%'
			</cfif>
            <cfif isDefined('Style') AND len(Style)>
					-- AND artType LIKE '%#Style#%'
                AND (
                artType LIKE <cfqueryparam value="#Style#" cfsqltype="cf_sql_varchar"> 
                OR artType LIKE <cfqueryparam value="#Style#,%" cfsqltype="cf_sql_varchar"> 
                OR artType LIKE <cfqueryparam value="%,#Style#" cfsqltype="cf_sql_varchar"> 
                OR artType LIKE <cfqueryparam value="%,#Style#,%" cfsqltype="cf_sql_varchar">
                )
			</cfif>
            AND fk_users IS NULL
        ) AS Subquery
        WHERE RowNum BETWEEN #startrow# AND (#startrow# + #ipp# - 1)
       
    </cfquery>
    
<cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT show FROM makeoffer_buttons
	WHERE pk_makeoffer_buttons = 1
</cfquery>

	<!--- <cfdump var="#getRecentAcquisitions.recordcount#" abort="true"> --->
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
        <cfif fileexists("http://23.20.226.157/img/thumbnails/#uid#.jpg")> 
            <IMG SRC="./img/#uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#trim(modelno)#" align="Center">
        <cfelse>
            <!--- <img src="https://dummyimage.com/150x100/050005/ededf2.png&text=No+Image+Available+"> --->
            <img src="http://23.20.226.157/img/thumbnails/noImage.jfif.jpeg">
        </cfif>
        </A>
        
        <Br>
        <A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')" class="name-hover" >
            <cfset romanNumerals = "I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI,XVII,XVIII,XIX,XX">

            <!--- Split the name into words --->
            <cfset words = ListToArray(name, " ")>
            <cfset updatedName = "">

            <cfloop index="word" array="#words#">
                <!--- Check if the word (before any punctuation) is a Roman numeral --->
                <cfif ListFindNoCase(romanNumerals, REReplace(word, "[^a-zA-Z]", "", "ALL"))>
                    <!--- Preserve the Roman numeral as is --->
                    <cfset updatedName = updatedName & " " & UCase(word)>
                <cfelse>
                    <!--- Capitalize the word (convert to Title Case) --->
                    <cfset updatedName = updatedName & " " & REReplace(word, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")>
                </cfif>
            </cfloop>

            <cfset updatedName = Trim(updatedName)>

            #updatedName#
        </a>
        <br>
        <span class="bytext">
            <cfset capitalize_artistName = REReplace(artist_name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")>
            By: #capitalize_artistName#<Br>
        </span>
        <font color="660066" >
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

        <!--- <div class="e-pricing">
            <cfif len(fk_users)><span style="font-size: 12px; font-weight: bold; color: ##ff0000;">PRIVATE LISTING</span><br><br></cfif>
            <cfif makeoffer_buttons.show EQ 1>
                <a href="make_offer.cfm?pid=#uid#&xss=#xss#"><img src="images/make_offer.gif" border="0"></a>
            <cfelse>
                <a href="epricing.cfm?pid=#uid#&xss=#xss#">
                    <img src="images/question.gif" border="0">
                </a>
            </cfif>
        </div> --->
            <cfif len(fk_users)>
                <span style="font-size: 12px; font-weight: bold; color: ##ff0000;">
                    PRIVATE LISTING
                </span>
                <br><br>
            </cfif>
    
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

<style>
	.name-hover:hover{
		color: #dd3a7d;
	}
	.name-hover{
		color:black;
	}
</style>