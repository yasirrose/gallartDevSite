<div style="text-align: center"><input type="Button" value="Back To Sales Menu" onclick="location.href='index.cfm?event=sales'"></div>
<table cellspacing="0" cellpadding="0" border="0" width="500" align="left">
    <tr>
		<td colspan="2">
			<cfform method="post" action="index.cfm?event=sales.salelinkSearchResults">
			<table cellspacing="0" cellpadding="0" border="0" width="100%" align="left">
				<tr>
			    	<td colspan="2" style="font-size: 13px;"><strong>CREATE NEW SALE LINK</strong><br /><br />
					</td>
			  	</tr>
				<tr>
			    	<td colspan="2" style="font-size: 11px;">Use dropdown below to choose artist whose listings you want to appear on sale link.  On the next page, you will be able to choose which of this artist's listings you want to appear.<br />
<br />
					</td>
			  	</tr>
				<tr>
					<td style="font-size: 10px;">
						<strong>Artist:</strong>
					</td>
					<td>
						<select name="artist">
							<option value="">All</option>
							<cfoutput query="getAllArtists" group="manufacturer">
							<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
								<option value="#manufacturer#">#ucase(manufacturer)#</option>
							</cfif>
							</cfoutput>
						</select>
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;">
						<strong>Choose CODE for sale link:</strong>
					</td>
					<td>
						<input type="text" name="SaleCode" size="10" />
					</td>
				</tr>
					
				<tr>
			    	<td colspan="2" style="padding: 10px 0;">
						<input type="Submit" value="Add Artist to Sale">&nbsp;&nbsp;<input type="reset" value="Reset Values">
					</td>
			  	</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>
