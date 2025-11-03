<cftry>

	<cfparam name="page" default="1" type="numeric">
<cfparam name="ipp" default="12" type="numeric"> <!-- Items per page -->
    <!--- <cfdump var="#priceOrder#"> --->

    <!--- <cfdump var="#Style#"> --->
    <!--- <cfdump var="#artist#"> --->

<!-- Calculate the starting row -->
<cfset startrow = ((page - 1) * ipp) + 1>

    <cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * FROM (
            SELECT *, ROW_NUMBER() OVER (
                <cfif isDefined('priceOrder') and len(priceOrder)>
                    <cfif priceOrder EQ 'newest' >
                        ORDER BY active_date desc
                        <cfelse>
                            ORDER BY special_price #priceOrder#
                    </cfif>
                    
                <cfelse>
                    ORDER BY active_date desc
                </cfif>
            ) AS RowNum
            FROM products 
            WHERE (path <> '') 
            AND active = 1
            AND (path IS NOT NULL)
            <cfif isDefined('keywords')>
                AND (name LIKE '%#keywords#%' OR caption LIKE '%#keywords#%' OR modelno LIKE '#keywords#%' OR manufacturer LIKE '%#keywords#%')
            </cfif>
            <cfif isDefined('artist') AND len(artist)>
                AND manufacturer = '#artist#'
            </cfif>
            <cfif isDefined('path') AND len(path)>
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
                AND (
                artType LIKE <cfqueryparam value="%#Style#%" cfsqltype="cf_sql_varchar">
                OR artType LIKE <cfqueryparam value="#Style#,%" cfsqltype="cf_sql_varchar">
                OR artType LIKE <cfqueryparam value="%,#Style#" cfsqltype="cf_sql_varchar"> 
                OR artType LIKE <cfqueryparam value="%,#Style#,%" cfsqltype="cf_sql_varchar">
            )
			</cfif>
            AND closeout = 1
            AND fk_users IS NULL
        ) AS Subquery
        WHERE RowNum BETWEEN #startrow# AND (#startrow# + #ipp# - 1)
    </cfquery>

    

    <cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT show FROM makeoffer_buttons
        WHERE pk_makeoffer_buttons = 1
    </cfquery>
	
	<cfif productinfo.recordcount gt 0>
        <cfoutput query="productinfo" >
            <div class="list-item">
                <cfif listlen(manufacturer) gt 1>
                    <cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
                    <cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
                <cfelse>
                    <cfset artist_name = manufacturer />
                    <cfset artist_name_url = manufacturer />
                </cfif>
            
                <!--- <Cfset pc = pc + 1> --->
                <td valign="top" align="Center">
                    <a href="/artist/#urlencodedformat(trim(replace(producturl, "'", "")))#/#urlencodedformat(trim(slug))#">

                        <cfif fileexists("http://#server_name#/img/thumbnails/#uid#.jpg")> 
                            <IMG SRC="./img/#uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#trim(modelno)#" align="Center">
                            <cfelse>
                                
                                <img src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg">
                        </cfif>   
                    </a>
                    <br>
                    <a href="/artist/#urlencodedformat(trim(replace(producturl, "'", "")))#/#urlencodedformat(trim(slug))#" class="name-hover" >
                        <cfset romanNumerals = "I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI,XVII,XVIII,XIX,XX">


                        <cfset words = ListToArray(name, " ")>
                        <cfset updatedName = "">

                        <cfloop index="word" array="#words#">
                            <cfset cleanWord = REReplace(word, "[^a-zA-Z]", "", "ALL")>

                            <cfif cleanWord EQ "FS">
                                <!--- Preserve "FS" in uppercase --->
                                <cfset updatedName = updatedName & " " & UCase(word)>
                            <cfelse>
                                <!--- Keep the original case of other words --->
                                <cfset updatedName = updatedName & " " & word>
                            </cfif>
                        </cfloop>

                        <cfset updatedName = Trim(updatedName)>

                        
                        <b>#updatedName#</b>
                    </a>
            
                    <br>
                
                    <a href="/artist/#urlencodedformat(trim(replace(producturl, "'", "")))#/#urlencodedformat(trim(slug))#" class="name-hover">
                        By: #artist_name#<Br>
                    </a>

                    <div>
                        <cfif retail_price gt 0 and retail_price gt gallery_price>

                            <cfif gallery_price gt 0 and  gallery_price gte special_price>

                                <cfif closeout eq 1 and special_price gt 0 >
                                    <del>#DollarFormat(gallery_price)#</del>
                                    &nbsp; 
                                    <b>
                                        <span style="color: ##ff0000;">
                                            #DollarFormat(special_price)# 
                                        </span>
                                    </b>
                                <cfelse>
                                    <del>#DollarFormat(retail_price)#</del>
                                    &nbsp; 
                                    
                                    <b> #DollarFormat(gallery_price)# </b>
                                </cfif>

                            <cfelse>
                                <!--- <span style="color: red;">
                                        Price On Request
                                </span> --->
                                <cfif gallery_price neq 0 and gallery_price LT special_price>
                                    
                                    <del>#DollarFormat(retail_price)# </del>
                                    &nbsp; 
                                        <b> #DollarFormat(gallery_price)# </b>

                                <cfelse>
                                    <cfif closeout eq 1 and special_price gt 0 and special_price LT retail_price>
                                        <del>#DollarFormat(retail_price)# </del>
                                        &nbsp; 
                                            <b>
                                                <span style="color: ##ff0000;">
                                                #DollarFormat(special_price)# 
                                                </span>
                                            </b>
                    
                                            <cfelse>
                                                <b> #DollarFormat(retail_price)# </b>
                                    </cfif>
                                </cfif>

                            </cfif>
                        <cfelse>
                            
                            <cfif gallery_price EQ 0 OR gallery_price EQ ''>
                                
                                <span style="color: red;">
                                    Price On Request
                                </span>
                            <cfelse>
                                <cfif retail_price neq 0 and retail_price LT gallery_price >

                                    <cfif closeout eq 1 and special_price gt 0 and special_price LT retail_price>
                                        <del>#DollarFormat(retail_price)# </del>
                                        &nbsp; 
                                            <b>
                                                <span style="color: ##ff0000;">
                                                #DollarFormat(special_price)# 
                                                </span>
                                            </b>
                                        <cfelse>
                                            <b>#DollarFormat(retail_price)#</b>
                                    </cfif>

                                    <!--- <b>#DollarFormat(retail_price)#</b> --->
                                <cfelse>
                                    <cfif closeout eq 1 and special_price gt 0 and special_price LT gallery_price>
                                        <del>#DollarFormat(gallery_price)# </del>
                                        &nbsp; 
                                            <b>
                                                <span style="color: ##ff0000;">
                                                #DollarFormat(special_price)# 
                                                </span>
                                            </b>
                    
                                            <cfelse>
                                                <b>#DollarFormat(gallery_price)#</b>
                                    </cfif>
                                </cfif>
                            </cfif>

                        </cfif>
                    </div>
                    
                    <br>
                    <a href="/artist/#urlencodedformat(trim(replace(producturl, "'", "")))#/#urlencodedformat(trim(slug))#" class="name-hover">
                        Art ID:&nbsp;#modelno#<br><br>
                    </a>

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


