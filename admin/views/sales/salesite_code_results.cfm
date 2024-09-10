<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td align="center" colspan="2" bgcolor="#333333" height="25" style="font-weight: bold; font-size: 10pt; color: #ffffff;">
			NUMBER OF RECORDS FOUND: <cfoutput>#getSalesiteCodeListings.recordcount#</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="center" height="10">
			<form>
				<input type="button" value="Back to Search" onclick="javascript:self.history.go(-1);">
			</form>
		</td>
	</tr>
	<tr>
		<td width="100%" align="center" valign="top" colspan="2">
			<cfif getSalesiteCodeListings.recordcount>
			<cfform method="post" action="index.cfm?event=sales.editSales">
			<input type="Hidden" name="pk_sales" value="<cfoutput>#form.pk_sales#</cfoutput>">
			<input type="Hidden" name="saleCode" value="<cfoutput>#getSalesFromId.saleCode#</cfoutput>">
			<table border=0 cellpadding=2 cellspacing=0 width="98%" align="center">
				<tr>
					<td nowrap>
						<strong>Sale Code:</strong>
					</td>
					<td>
						<cfoutput>http://onlinegalleryart.com/sales/index.cfm?saleCode=#getSalesFromId.saleCode#</cfoutput>
					</td>
					<td nowrap>
						<strong>Percentage of Retail Price:</strong>
					</td>
					<td>
						<cfinput type="text" name="percentMarkdown" size="2" validate="integer" value="#getSalesFromId.percentMarkdown#">%
					</td>
					<td nowrap colspan="4" align="right">
						<input type="Submit" value="Update Sale Link" name="update">
						<input type="Submit" value="Delete Sale Link" name="delete" onClick="javascript:return confirm('DELETE -- ARE YOU SURE?')">
					</td>
				</tr>
				<tr class="row0">
				    <td>
						Model#
					</td>
					<td>
						Artist
					</td>
					<td>
						Medium
					</td>
				    <td>
						Name of Piece
					</td>
					<td>
						Retail Price
					</td>
				    <td>
						Gallery Price
					</td>
					 <td>
						Sale Price
					</td>
				    <td>
						Use Sale Price
					</td>
				</tr>
				<cfoutput query="getSalesiteCodeListings">
				<cfset this_manufacturer = manufacturer />
				<cfset this_path = path />
				<tr class="#this_row()#">
					<td>
						#modelno#
					</td>
				 	<td>
						#manufacturer#									
					</td>
					<td>
						#path#
					</td>
					<td>
						#name#
					</td>
					<td nowrap>
						$#price#		 	
					</td>
					<td nowrap>
						$#sale_price#
					</td>
					<td nowrap>
						$#closeout_price#
					</td>
					<td>
						<input type="Checkbox" name="salelink_#uid#" value="1" <cfif listFind(valuelist(getSaleCodeInfo.ProductId),uid)>checked</cfif>>
					</td>
				</tr>
				</cfoutput>
				</cfform>
			</table>			
			<cfelse>
			No Results Found
			</cfif>	
					
		</td>
	</tr>	
</table>




