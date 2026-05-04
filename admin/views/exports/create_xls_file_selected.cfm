
<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Inventory Listing #DateFormat(createodbcdate(now()))#.xls""">

<cfoutput>

	<cfif isDefined('url.displayFields') AND url.displayFields NEQ ''>
		<table border="1" cellpadding="0" cellspacing="0">
			<tr class="row0" bgcolor="##000000">
				<td style="color: ##FFFFFF;">
					<strong>UID</strong>
				</td>
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
				<cfif listFind(url.displayFields,'Desc')>
					<td style="color: ##FFFFFF;">
						<strong>Description</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Thumbnail')>
					<td style="color: ##FFFFFF;">
						<strong>Thumbnail</strong>
					</td>
				</cfif>
				<cfif listFind(url.displayFields,'Url')>
					<td style="color: ##FFFFFF;">
						<strong>URL</strong>
					</td>
				</cfif>
			</tr>
			<cfloop query="getExcelListingsBySelected">
				<tr>
					<td valign="top">
						#uid#
					</td>
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
					<cfif listFind(url.displayFields,'Desc')>
						<td>
							#caption#
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Thumbnail')>
						<td>
							http://#server_name#/img/#uid#.jpg
						</td>
					</cfif>
					<cfif listFind(url.displayFields,'Url')>
						<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
						<td>
							<!--- http://#server_name#/item.cfm?pid=#trim(uid)#&artist=#ucase(manufacturer)#&artistname=#trim(artist_name_url)#&gallery=GALLART&title=#trim(replace(name,"'",''))# --->
							https://#server_name#/artist/#urlencodedformat(trim(replace(producturl,"'","")) )#/#urlencodedformat(trim(slug))#
							
						</td>
					</cfif>
				</tr>
			</cfloop>
		</table>
	</cfif>
</cfoutput>