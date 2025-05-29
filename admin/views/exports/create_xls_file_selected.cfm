
<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Inventory Listing #DateFormat(createodbcdate(now()))#.xls""">

<cfoutput>

<cfif isDefined('url.displayFields') AND url.displayFields NEQ ''>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr class="row0">
			<td>
				UID
			</td>
			 <td>
				Title
			</td>
			<cfif listFind(url.displayFields,'ModelNo')>
		    <td>
				Model Number
			</td>
			</cfif>
			<cfif listFind(url.displayFields,'Artist')>
				<td>
					Artist
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Medium')>
				<td>
					Medium
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Retail')>
				<td>
					Retail Price
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Gallery')>
			    <td>
					Gallery Price
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Sale')>
			    <td>
					Sale Price
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Year')>
			    <td>
					Year
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Size')>
			    <td>
					Size
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Edition')>
				<td>
					Edition
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Low')>
				<td>
					Low Estimate
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'High')>
				<td>
					High Estimate
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Desc')>
				<td>
					Description
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Thumbnail')>
				<td>
					Thumbnail
				</td>
			</cfif>
			<cfif listFind(url.displayFields,'Url')>
				<td>
					URL
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
					http://#server_name#/item.cfm?pid=#trim(uid)#&artist=#ucase(manufacturer)#&artistname=#trim(artist_name_url)#&gallery=GALLART&title=#trim(replace(name,"'",''))#
				</td>
			</cfif>
		</tr>
		</cfloop>
	</table>
</cfif>
</cfoutput>