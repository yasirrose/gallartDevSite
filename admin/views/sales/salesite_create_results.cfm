<div style="text-align: center"><input type="Button" value="Back To Sales Menu" onclick="location.href='index.cfm?event=sales'"></div>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="10">
			<form>
				<input type="button" value="Back to Manage Sales Links" onclick="location.href='index.cfm?event=sales.salesiteCodeSearch'">
			</form>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			NUMBER OF RECORDS FOUND: <cfoutput>#getSalesiteCodeListings.recordcount#</cfoutput>
		</td>
	</tr>
	<tr>
		<td width="100%" align="center" valign="top" colspan="2">
			<cfif getSalesiteCodeListings.recordcount>
			<cfform method="post" action="index.cfm?event=sales.editSales">
			<input type="Hidden" name="queryString" value="<cfoutput>#createQueryString#</cfoutput>">
			<input type="Hidden" name="pk_sales" value="">
			<table border=0 cellpadding=2 cellspacing=0 width="98%" align="center">
				<tr>
					<td nowrap>
						<strong>Sale Code:</strong>
					</td>
					<td>
						<cfinput type="text" name="saleCode" size="10" required="Yes" message="You must enter a Sale Code">
					</td>
					<td nowrap>
						<strong>Percentage of Gallery Price:</strong>
					</td>
					<td>
						<cfinput type="text" name="percentMarkdown" size="2" validate="integer" required="Yes" message="You must enter an integer as the Percent Markdown.">%
					</td>
					<td colspan="4" align="right">
						<input type="Submit" value="Create Sale Link" name="new">
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
						<input type="Checkbox" name="salelink_#uid#" value="1">
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




