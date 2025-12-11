
<cfcontent type="application/vnd.ms-excel; charset=utf-8" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart_Inventory_Listing #DateFormat(createodbcdate(now()))#.xls""">

<cfoutput>

	<cfif isDefined('url.displayFields') AND url.displayFields NEQ ''>
		<table border="1" cellpadding="0" cellspacing="0">
			<tr class="row0" bgcolor="##000000">
				<td style="color: ##FFFFFF;">
					<strong>Title</strong>
				</td>
				<cfif listFind(url.displayFields,'ModelNo')>
					<td style="color: ##FFFFFF;">
						<strong>Model Number</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Artist')>
					<td style="color: ##FFFFFF;">
						<strong>Artist</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Medium')>
					<td style="color: ##FFFFFF;">
						<strong>Medium</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Retail')>
					<td style="color: ##FFFFFF;">
						<strong>Retail Price</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Gallery')>
					<td style="color: ##FFFFFF;">
						<strong>Gallery Price</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Sale')>
					<td style="color: ##FFFFFF;">
						<strong>Sale Price</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Trump')>
					<td style="color: ##FFFFFF;">
						<strong>Trump Price</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Year')>
					<td style="color: ##FFFFFF;">
						<strong>Year</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Size')>
					<td style="color: ##FFFFFF;"> 
						<strong>Size</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Edition')>
					<td style="color: ##FFFFFF;">
						<strong>Edition</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Low')>
					<td style="color: ##FFFFFF;">
						<strong>Low Estimate</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'High')>
					<td style="color: ##FFFFFF;">
						<strong>High Estimate</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Thumbnail')>
					<td style="color: ##FFFFFF;">
						<strong>Thumbnail</strong>
					</td>
				</cfif>
			</tr>
			<cfloop query="getExcelListingsByArtist">
				<tr>
					<td valign="top">
						#Name#
					</td>
					<cfif listFind(url.displayFields,'ModelNo')>
						<td>
							#modelno#
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Artist')>
						<td>
							#manufacturer#
							
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Medium')>
						<td>
							#ucase(path)#
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Retail')>
						<td valign="top" align="right">
							<cfif not retail_price eq 0>
								#DollarFormat(retail_price)#
							<cfelse>
								N/A
							</cfif>		 	
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Gallery')>
						<td valign="top" align="right">
							<cfif not gallery_price eq 0>
								#DollarFormat(gallery_price)#
							<cfelse>
								N/A
							</cfif>	
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Sale')>
						<td valign="top" align="right">
							<cfif not special_price eq 0>
								#DollarFormat(special_price)#
							<cfelse>
								N/A
							</cfif>	
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Trump')>
						<td valign="top" align="right">
							<cfif not location_price eq 0>
								#DollarFormat(location_price)#
							<cfelse>
								N/A
							</cfif>	
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Year')>
						<td>
							#year#
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Size')>
						<td>
							#size#
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Edition')>
						<td>
							#edition#
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Low')>
						<td>
							#low_estimate#
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'High')>
						<td>
							#high_estimate#
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Thumbnail')>
						<td>
							http://#server_name#/img/#uid#.jpg
						</td>
					</cfif>
				</tr>
			</cfloop>
		</table>
		
		
	 <cfelseif isDefined('url.artists') AND url.artists NEQ ''>

		<table border="1" cellpadding="0" cellspacing="0">
			<tr bgcolor="##000000">
				<td style="color: ##FFFFFF;" valign="top">
					<strong>Artist</strong>
				</td>
				<td style="color: ##FFFFFF;" valign="top">
					<strong>Art ID</strong>
				</td>
				<td style="color: ##FFFFFF;" valign="top" width="350">
					<strong>Title</strong>
				</td>
				<td style="color: ##FFFFFF;" valign="top">
					<strong>Medium</strong>
				</td>
				<td style="color: ##FFFFFF;" valign="top">
					<strong>Size</strong>
				</td>
				<td style="color: ##FFFFFF;" valign="top">
					<strong>Gallery Price</strong>
				</td>
			</tr>
			<cfloop query="getExcelListingsByArtist">
				<tr>
					<td valign="top">
						#Manufacturer#
					</td>
					<td valign="top">
						#modelno#
					</td>
					<td valign="top">
						#Name#
					</td>
					<td valign="top">
						#path#
					</td>
					<td valign="top">
						#size#
					</td>
					<td valign="top" align="right">
						<cfif not gallery_price eq 0>
							#DollarFormat(gallery_price)#
						<cfelse>
							N/A
						</cfif>
					</td>
				</tr>
			</cfloop>
		</table>
					

	</cfif>	
</cfoutput>

<!--- <cfcontent type="text/csv" reset="true">
<cfheader name="Content-Disposition" value="attachment; filename=Gallart_Inventory_Listing_#DateFormat(now(), 'yyyymmdd')#.csv">

<cfoutput>
Title,Model Number,Artist
<cfloop query="getExcelListingsByArtist">
#Name#, #modelno#, #manufacturer#
</cfloop>
</cfoutput> --->