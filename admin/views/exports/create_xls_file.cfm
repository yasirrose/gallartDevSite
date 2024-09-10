
<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Inventory Listing #DateFormat(createodbcdate(now()))#.xls""">

<cfoutput>

<cfif isDefined('url.displayFields') AND url.displayFields NEQ ''>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr class="row0">
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
			<cfif listFind(url.displayFields,'Trump')>
			    <td>
					Trump Price
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
			<cfif listFind(url.displayFields,'Thumbnail')>
				<td>
					&nbsp;
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