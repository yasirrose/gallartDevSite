<cftry>
    <!--- Define default values for page and items per page (ipp) --->
    <cfparam name="page" default="1" type="numeric">
    <cfparam name="ipp" default="12" type="numeric"> <!-- Items per page -->

    <!--- Calculate the starting row --->
    <cfset startrow = ((page - 1) * ipp) + 1>

    <!--- Initialize base SQL query --->
	<!--- Check if any search parameters are provided --->
	<cfset hasValidSearchCriteria = (
		(isDefined('man') and len(trim(man))) OR
		(isDefined('Size') and len(trim(Size))) OR
		(isDefined('Subject') and len(Subject)) OR
		(isDefined('Style') and len(Style)) OR
		(isDefined('Type') and len(Type)) OR
		(isDefined('keywords') and len(keywords)) OR
		(isDefined('adv_artist') and len(adv_artist)) OR
		(isDefined('adv_year') and len(adv_year)) OR
		(isDefined('adv_medium') and len(trim(adv_medium))) OR
		(isDefined('adv_title') and len(trim(adv_title))) OR
		(isDefined('adv_desc_keyword') and len(trim(adv_desc_keyword))) OR
		(isDefined('a') and len(trim(a)) and isDefined('b') and len(trim(b)))
	)>

	<cfif hasValidSearchCriteria>
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
						<cfif man EQ 'erte'>
						AND (producturl = 'erte' OR producturl = 'erte-romain')
						<cfelse>
						AND producturl = '#man#'
						</cfif>
					</cfif>
					<cfif isDefined('Size') and len(trim(Size))>
						AND artSize LIKE '%#Size#%'
					</cfif>
					<cfif isDefined('Subject') AND len(Subject)>
						AND artSubject LIKE '%#Subject#%'
					</cfif>
					<cfif isDefined('Style') AND len(Style)>
						AND (
						artType LIKE <cfqueryparam value="#Style#" cfsqltype="cf_sql_varchar"> 
						OR artType LIKE <cfqueryparam value="#Style#,%" cfsqltype="cf_sql_varchar"> 
						OR artType LIKE <cfqueryparam value="%,#Style#" cfsqltype="cf_sql_varchar"> 
						OR artType LIKE <cfqueryparam value="%,#Style#,%" cfsqltype="cf_sql_varchar">
						)
					</cfif>
					<cfif isDefined('Size') AND len(Size)>
						AND artSize LIKE '%#Size#%'
					</cfif>
					<cfif isDefined('Type') AND len(Type)>
						AND artTypee LIKE '%#Type#%'
					</cfif>
					<cfif isDefined('keywords')>
						<cfset reversedKeyword = ListLast(keywords, " ") & ", " & ListFirst(keywords, " ")>
						<cfset reversedKeyworddd = ListFirst(keywords, " ") & ", " & ListLast(keywords, " ")>
						AND (
							name LIKE '%#keywords#%' 
							OR caption LIKE '%#keywords#%' 
							OR modelno LIKE '#keywords#%' 
							OR manufacturer LIKE '%#keywords#%'
							OR manufacturer LIKE '%#reversedKeyword#%'
							OR manufacturer LIKE '%#reversedKeyworddd#%'
							)
					</cfif>
					<cfif isDefined('adv_artist') and len(adv_artist)>
					AND manufacturer LIKE '%#adv_artist#%'
					</cfif>
					<cfif isDefined('adv_year') and len(adv_year)>
					AND year LIKE '%#adv_year#%'
					</cfif>
					<cfif isDefined('adv_medium') and len(trim(adv_medium))>
					AND path LIKE '%#adv_medium#%'
					</cfif>
					<cfif isDefined('adv_title') and len(trim(adv_title))>
					AND name LIKE '%#adv_title#%'
					</cfif>
					<cfif isDefined('adv_desc_keyword') and len(trim(adv_desc_keyword))>
					AND location_notes LIKE '%#adv_desc_keyword#%'
					</cfif>
					<cfif isDefined('a') and len(trim(a)) and isDefined('b') and len(trim(b)) >
					AND gallery_price between #a# and #b#
					</cfif>
				
			) AS Subquery
			WHERE RowNum BETWEEN #startrow# AND (#startrow# + #ipp# - 1)
		</cfquery>
	<cfelse>
		<!--- Create empty query structure if no search criteria provided --->
		<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM products WHERE 1 = 0
		</cfquery>
	</cfif>
	<cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT show FROM makeoffer_buttons
		WHERE pk_makeoffer_buttons = 1
	</cfquery>
	<!--- <cfdump var="#productinfo#" abort="true"> --->

	<cfif productinfo.recordcount gt 0>
	
		
        <cfoutput query="productinfo">
			<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />

			<cfif listlen(manufacturer) gt 1>
				<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
				<!--- <cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
				<cfset artist_name_alt = "#listlast(manufacturer)# #listfirst(manufacturer)#" /> --->
			<cfelse>
				<cfset artist_name = manufacturer />
				<!--- <cfset artist_name_url = manufacturer />
				<cfset artist_name_alt = manufacturer /> --->
			</cfif>


            <div class="list-item">
                <a href="/artist/#urlencodedformat(trim(replace(producturl,"'","")) )#/#urlencodedformat(trim(slug))#" class="add-hover">
                    <cfif fileexists("http://#server_name#/img/thumbnails/#uid#.jpg")>
                        <img src="http://#server_name#/img/#uid#.jpg" alt="#name#" title="#name#" border="0" align="center">
                    <cfelse>

						<img src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg">
                    </cfif>  
                </a>
                <div class="product-name" style="font-weight: 600;">
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

					<a href="/artist/#urlencodedformat(trim(replace(producturl,"'","")) )#/#urlencodedformat(trim(slug))#" class="add-hover">
						#updatedName#
					</a>

				</div>

				<div>
					<a href="/artist/#urlencodedformat(trim(replace(producturl,"'","")) )#/#urlencodedformat(trim(slug))#" class="add-hover">
						By: #artist_name#<Br>
					</a>					
				</div>
				
                <div class="product-price">
					<cfif retail_price gt 0 and retail_price gt gallery_price>
		
						<cfif gallery_price gt 0 and  gallery_price gt special_price>
		
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
							<cfif retail_price neq 0 and retail_price GT gallery_price >
								<b>#DollarFormat(retail_price)#</b>
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

				<div class="product-price">
                    <cfif modelno neq ''>
						<span>
							<a href="/artist/#urlencodedformat(trim(replace(producturl,"'","")) )#/#urlencodedformat(trim(slug))#" class="add-hover">
								Art ID: #modelno#
							</a>
						</span>						
                    </cfif>
				</div>

				<cfif len(fk_users)>
					<span style="font-size: 12px; font-weight: bold; color: ##ff0000;">
						PRIVATE LISTING
					</span>
					<br><br>
				</cfif>
							
            </div>
        </cfoutput>
    <cfelse>
        
        <cfoutput></cfoutput>
    </cfif>

<cfcatch type="any">
    <!-- Error handling: log and display error message -->
    <!--- <cflog file="query_errors" text="Error fetching products: #cfcatch.message#"> --->
    <cfdump var="#cfcatch#" abort="true">
</cfcatch>
</cftry>


<!--- <script>
	 let url = new URL(window.location.href);
	let params = new URLSearchParams(url.search);

	let Manufacturer = params.get('man'); // Retrieve 'man' value
	if (Manufacturer) {
		Manufacturer = decodeURIComponent(Manufacturer);
	}


	const artistSlug = Manufacturer.toLowerCase()
		.replace(/\s*,\s*/g, '-') // replace commas with hyphens
		.replace(/\s+/g, '-');    // replace spaces with hyphens

	// Create the new URL
	const newURL = `${window.location.origin}/artists/${artistSlug}/`;
	console.log(newURL);
	window.history.pushState({}, '', newURL)
</script> --->

<style>
	.add-hover:hover{
		color: #dd3a7d;
	}
	.add-hover{
		color:black;
	}
</style>
