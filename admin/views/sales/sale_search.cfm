<div style="text-align: center"><input type="Button" value="Back To Sales Menu" onclick="location.href='index.cfm?event=sales'"></div>
<table cellspacing="0" cellpadding="0" border="0" width="500" align="left">
    <tr>
		<td colspan="2">
			<cfform method="post" action="index.cfm?event=sales.saleSearchResults">
			<table cellspacing="0" cellpadding="0" border="0" width="100%" align="left">
				<tr>
			    	<td colspan="2" style="font-size: 13px;"><strong>SET SALE PRICES</strong><br /><br />
					</td>
			  	</tr>
				<tr>
			    	<td colspan="2">
						<input type="button" value="SET SALE PRICES FOR ENTIRE DATABASE" onclick="location.href='index.cfm?event=sales.setAllSalePrices'" /><br /><br />
					</td>
			  	</tr>
				<tr>
			    	<td colspan="2" style="font-size: 11px;"><strong>Use fields below to search for listings for which sale prices are to be set:</strong><br />
<br />
					</td>
			  	</tr>
				<tr>
					<td valign="top" colspan="2">
						<table cellspacing="0" cellpadding="3" border="0" width="100%">
							<tr>
								<td width="100" style="font-size: 10px;">
									<strong>Art ID:</strong>
								</td>
								<td>
									<cfinput name="modelno" size="10" />
								</td>
			
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Title:</strong>
								</td>
								<td>
									<cfinput name="title" size="30" />
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
									<strong>Exclude Artist:</strong>
								</td>
								<td>
									<select name="exclude_artist">
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
									<strong>Medium:</strong>
								</td>
								<td>
									<select name="path">
										<option value="">All</option>
										<cfoutput query="getAllMedium">
											<option value="#path#">#ucase(path)#</option>
										</cfoutput>
									</select>
								</td>
			
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">
												<strong>Year:</strong>
											</td>
											<td width="100">
												<cfinput name="Year" size="10" />
											</td>
											<td width="50" style="font-size: 10px;">
												<strong>Size:</strong>
											</td>
											<td>
												<cfinput type="Text" name="Height" style="width: 50px;">&nbsp;x&nbsp;<cfinput type="Text" name="Width" style="width: 50px;"> (HEIGHT X WIDTH)
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Description:</strong> (keywords)
								</td>
								<td>
									<cfinput name="caption" size="30" />
								</td>
			
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">
												<strong>Gallery Price from:</strong>
											</td>
											<td width="100">
												$<cfinput name="FromPrice" size="10" />
											</td>
											<td width="25" style="font-size: 10px;">
												<strong>to:</strong>
											</td>
											<td nowrap>
												$<cfinput name="ToPrice" size="10" />
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">
												<strong>Date from:</strong>
											</td>
											<td width="100">
												<cfinput name="FromDate" type="datefield" validate="date" size="10" />
											</td>
											<td width="25" style="font-size: 10px;">
												<strong>to:</strong>
											</td>
											<td nowrap>
												<cfinput name="ToDate" type="datefield" validate="date" size="10" />
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">
												<strong>Last Edit from:</strong>
											</td>
											<td width="100">
												<cfinput name="FromLastedit" type="datefield" validate="date" size="10" />
											</td>
											<td width="25" style="font-size: 10px;">
												<strong>to:</strong>
											</td>
											<td nowrap>
												<cfinput name="ToLastedit" type="datefield" validate="date" size="10" />
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" colspan="2">
									<strong>Gallery Listings Only:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="gallery_only" value="1" checked>
								</td>
			
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Seller:</strong>
								</td>
								<td>
									<select name="SellerId">
										<option value="">All
										<option value="0">Only Seller Listings
										<cfoutput query="getAllSellers">
											<option value="#pk_users#">#full_seller_name#
										
									</cfoutput></select>
								</td>
			
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">&nbsp;
												
											</td>
											<td width="20">
												<input type="Checkbox" name="OnSale" value="1">
												<input type="Hidden" name="OnSale" value="">
											</td>
											<td width="75" style="font-size: 10px;">
												On Sale
											</td>
											<td width="20">
												<input type="Checkbox" name="Trump" value="1">
												<input type="Hidden" name="Trump" value="">
											</td>
											<td width="75" style="font-size: 10px;">
												Trump Site
											</td>
											<td width="20">
												<input type="Checkbox" name="Auction" value="1">
												<input type="Hidden" name="Auction" value="">
											</td>
											<td>
												Auction Site
											</td>
										</tr>
									</table>					
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
			    	<td colspan="2" style="padding: 10px 0;" align="center">
						<input type="Submit" value="View Results">&nbsp;&nbsp;<input type="reset" value="Reset Values">
					</td>
			  	</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>
