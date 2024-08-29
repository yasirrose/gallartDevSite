<cfquery name="getProducts" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM products P
	LEFT OUTER JOIN users U
	on P.fk_users = U.pk_users
	WHERE P.active = 1
	order by manufacturer,name
</cfquery>


<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Product Details #DateFormat(createodbcdate(now()))#.xls""">

<cfcontent type="application/ms-excel" reset="Yes">


<cfoutput>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr bgcolor="##000000">
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Availability</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Caption</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Code</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Datestamp</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>ExpressAir</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>ImageURL</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Artist</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>ModelNo</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Name</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Size</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Category</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Retail Price</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Sale Price</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>ShipInfo</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>ShipWeight</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Year</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>ID</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Vendor</strong>
			</td>
		</tr>
		<cfloop query="getProducts">
		<tr>
			<td valign="top">
				#Availablity#
			</td>
			<td valign="top">
				#Caption#
			</td>
			<td valign="top">
				#Code#
			</td>
			<td valign="top">
				#DateFormat(Datestamp)#
			</td>
			<td valign="top">
				#ExpressAir#
			</td>
			<td valign="top">
				#ImageURL#
			</td>
			<td valign="top">
				#Manufacturer#
			</td>
			<td valign="top">
				#ModelNo#
			</td>
			<td valign="top">
				#Name#
			</td>
			<td valign="top">
				#Overview#
			</td>
			<td valign="top">
				#Path#
			</td>
			<td valign="top">
				#DollarFormat(retail_price)#
			</td>
			<td valign="top">
				#DollarFormat(gallery_price)#
			</td>
			<td valign="top">
				#ShipInfo#
			</td>
			<td valign="top">
				#Ship_Weight#
			</td>
			<td valign="top">
				#specs#
			</td>
			<td valign="top">
				#uid#
			</td>
			<td valign="top">
				<cfif not len(fk_users)>
					GallArt
				<cfelse>
					#fname# #lname#
				</cfif>
			</td>
		</tr>
		</cfloop>
	</table>
</cfoutput>