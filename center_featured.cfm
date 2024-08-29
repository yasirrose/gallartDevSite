<cfquery name="artistgroup"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" maxrows="1000">
	SELECT TOP 15 * 
	FROM products
	WHERE  Active = 1 and family = '1'
	order by newid() 
</cfquery>


<cfset columns =3>

<div>
	<div class="featured-row">
	<cfset i = 0>
	<cfoutput query="artistgroup" group="manufacturer" maxrows="15">
		<cfif listlen(manufacturer) gt 1>
			<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
			<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
			<cfset artist_name_alt = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
		<cfelse>
			<cfset artist_name = manufacturer />
			<cfset artist_name_url = manufacturer />
			<cfset artist_name_alt = manufacturer />
		</cfif>
		
			<div class="featured-item">
				<div class="featured-img">
					<span itemprop="url"><a href="products.cfm?man=#manufacturer#<cfif parameterexists(xss)>&xss=#xss#</cfif>">
						<cfset imgFile =  'http://#server_name#/img/thumbnails/' & uid &'.jpg' />
						<cfif fileExists(imgFile)>
							<span itemprop="image"><img src="http://#server_name#/img/#uid#.jpg" alt="#artist_name_alt# - #name#" title="#artist_name_alt# - #name#" border="0" align="center"></span>
							<!--- <img src="http://#server_name#/img/thumbnails/#uid#.jpg" alt="#artist_name_alt# - #name#" title="#artist_name_alt# - #name#" border="0" align="center"> --->
						<cfelse>
							#artist_name#
						</cfif>
				</div>
				<div class="featured-heading" itemscope itemtype="http://schema.org/ArtGallery">
					<h5 itemprop="name">
						<a href="products.cfm?man=#manufacturer#<cfif parameterexists(xss)>&xss=#xss#</cfif>">
							#ucase(artist_name)#</a>
					</h5>
				</div>
			</div>
		
		<cfset i = i + 1>
			<cfif i mod columns is 0></cfif>
	</cfoutput>
</div>
</div>
<!--- <table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td style="padding: 0 25px;" align="center">
			<table width="100%" border="0" cellspacing="0" cellpadding="1">
				<tr>
				<cfset i = 0>
				<cfoutput query="artistgroup" group="manufacturer" maxrows="12">
					<cfif listlen(manufacturer) gt 1>
						<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
						<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
                        <cfset artist_name_alt = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
					<cfelse>
						<cfset artist_name = manufacturer />
						<cfset artist_name_url = manufacturer />
                        <cfset artist_name_alt = manufacturer />
					</cfif>
					
					<td align="center" valign="top" width="30%">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center" style="font-size: 8pt; font-weight: bold;">
									<hr size="1" color="##000000">
                                    <div itemscope itemtype="http://schema.org/ArtGallery">
										<h1 itemprop="name"><a href="products.cfm?man=#manufacturer#<cfif parameterexists(xss)>&xss=#xss#</cfif>">
                                        #ucase(artist_name)#</a></h1>
									<hr size="1" color="##000000">
										<span itemprop="url"><a href="products.cfm?man=#manufacturer#<cfif parameterexists(xss)>&xss=#xss#</cfif>">
										<cfset imgFile =  'http://#server_name#/img/thumbnails/' & uid &'.jpg' />
										<cfif fileExists(imgFile)>
											<span itemprop="image"><img src="http://#server_name#/img/thumbnails/#uid#.jpg" alt="#artist_name_alt# - #name#" title="#artist_name_alt# - #name#" border="0" align="center"></span>
										<cfelse>
											#artist_name#
										</cfif>
										</A></span>
                                    </div>
								</td>
							</tr>
						</table>
					</td>
					<cfset i = i + 1>
					<cfif i mod columns is 0></tr><tr></cfif>
				</cfoutput>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<!--- <cfinclude template="scroller_view.cfm"> --->
		</td>	
	</tr>
</table>
--->
