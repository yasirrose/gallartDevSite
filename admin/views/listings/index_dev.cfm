<cfajaxproxy cfc="admin.models.art" />
<cfajaxproxy bind="javascript:gridChange({data.uid})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/listings.js_dev.cfm" language="JavaScript"></script>'>

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
    	<td>
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td style="font-size: 11px;">
						<strong>SEARCH BY:</strong>
					</td>
				</tr>
			</table>
		</td>
		<td>&nbsp;</td>
  	</tr>
	<tr>
		<td valign="top" width="350">
			<cfform name="gridForm" method="POST" action="index.cfm?event=listings.spreadsheet">
			<input type="Hidden" name="showResults" id="showResults" value="0" />
			<table cellspacing="5" cellpadding="3" border="0" width="100%">
				<tr>
					<td width="100" style="font-size: 10px;">
						<strong>Art ID:</strong>
					</td>
					<td>
						<cfinput name="searchModelno" id="searchModelno" size="10" />
					</td>

				</tr>
				<tr>
					<td style="font-size: 10px;">
						<strong>Title:</strong>
					</td>
					<td>
						<cfinput name="searchTitle" size="30" />
					</td>

				</tr>
				<tr>
					<td style="font-size: 10px;">
						<strong>Artist:</strong>
					</td>
					<td>
						<select name="searchArtist" id="searchArtist">
							<option value="">All
							<cfoutput query="getAllArtists" group="manufacturer">
							<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
								<option value="#manufacturer#">#ucase(manufacturer)#
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
						<select name="searchMedium">
							<option value="">All
							<cfoutput query="getAllMedium">
								<option value="#path#">#ucase(path)#
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
									<cfinput name="searchYear" size="10" />
								</td>
								<td width="50" style="font-size: 10px;">
									<strong>Size:</strong>
								</td>
								<td>
									<cfinput type="Text" name="searchHeight" style="width: 50px;">&nbsp;x&nbsp;<cfinput type="Text" name="searchWidth" style="width: 50px;"> (HEIGHT X WIDTH)
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
						<cfinput name="searchDescription" size="30" />
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
									$<cfinput name="searchFromPrice" size="10" />
								</td>
								<td width="25" style="font-size: 10px;">
									<strong>to:</strong>
								</td>
								<td nowrap>
									$<cfinput name="searchToPrice" size="10" />
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
									<cfinput name="searchFromDate" type="datefield" validate="date" size="10" />
								</td>
								<td width="25" style="font-size: 10px;">
									<strong>to:</strong>
								</td>
								<td nowrap>
									<cfinput name="searchToDate" type="datefield" validate="date" size="10" />
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
									<cfinput name="searchFromLastedit" type="datefield" validate="date" size="10" />
								</td>
								<td width="25" style="font-size: 10px;">
									<strong>to:</strong>
								</td>
								<td nowrap>
									<cfinput name="searchToLastedit" type="datefield" validate="date" size="10" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;">
						<strong>Seller:</strong>
					</td>
					<td>
						<select name="searchSellerId">
							<option value="">All
							<option value="0">Only Seller Listings
							<!---<cfoutput query="getAllSellers">
								<option value="#pk_users#">#full_seller_name#
							</cfoutput>--->
						</select>
					</td>

				</tr>
                <tr>
					<td style="font-size: 10px;">
						<strong>Image Name:</strong>
					</td>
					<td>
						<cfinput name="searchImageName" size="8" />.jpg
					</td>

				</tr>
				<tr>
					<td style="font-size: 10px;">
						Active/Inactive:
					</td >
					<td style="font-size: 10px;">
						<input type="radio" name="searchActive" value="1">Active
						<input type="radio" name="searchActive" value="0">Inactive
						<input type="radio" name="searchActive" value="" checked>All
					</td>

				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td width="106" style="font-size: 10px;">&nbsp;

								</td>
								<td width="20">
									<input type="Checkbox" name="searchOnSale">
									<input type="Hidden" name="searchOnSale">
								</td>
								<td width="75" style="font-size: 10px;">
									On Sale
								</td>
								<td width="20">
									<input type="Checkbox" name="searchTrump">
									<input type="Hidden" name="searchTrump">
								</td>
								<td width="75" style="font-size: 10px;">
									Trump Site
								</td>
								<td width="20">
									<input type="Checkbox" name="searchAuction">
									<input type="Hidden" name="searchAuction">
								</td>
								<td>
									Auction Site
								</td>
								<td width="20">
									<input type="Checkbox" name="searchSlideshow">
									<input type="Hidden" name="searchSlideshow">
								</td>
								<td>
									Slideshow
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td width="50" style="font-size: 10px;">&nbsp;

								</td>
								<td width="10">
									<input type="Checkbox" name="searchFrontshow">
									<input type="Hidden" name="searchFrontshow">
								</td>
								<td width="70" style="font-size: 10px;">
									Featured on Home Page
								</td>
								<td width="10">
									<input type="Checkbox" name="searchBottomHome">
									<input type="Hidden" name="searchBottomHome">
								</td>
								<td width="70" style="font-size: 10px;">
									Bottom of Home Page
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="Reset"><cfinput type="button" name="searchBtn" id="searchBtn" value="Search" onclick="document.getElementById('showResults').value = 1; ColdFusion.Grid.refresh('data', false);" />
						<input type="Submit" value="Ken's Spreadsheet View" />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<cfgrid format="html" name="data" pagesize="10" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.art.getListings({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchSellerId},{searchImageName},{searchModelno},{searchTitle},{searchArtist},{searchMedium},{searchYear},{searchHeight},{searchWidth},{searchDescription},{searchFromPrice},{searchToPrice},{searchFromDate},{searchToDate},{searchFromLastedit},{searchToLastedit},{searchOnSale},{searchTrump},{searchAuction},{searchSlideshow},{searchFrontshow},{searchBottomHome},{searchActive},{searchShowResults})">
						    <cfgridcolumn name="name" header="Title" width="150">
							<cfgridcolumn name="manufacturer" header="Artist" width="150">
							<cfgridcolumn name="gallery_price" header="Gallery Price" width="100">
							<cfgridcolumn name="listingDate" header="Date" width="75">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<input type="button" value="New" onclick="showNew()">
			<cfform name="currListingIdFrm">
				<cfinput type="hidden" name="currListingId" id="currListingId" bind="{data.uid}">
			</cfform>
			<cfoutput><iframe src="index.cfm?event=listings.loadEditForm_dev" name="editFormFrame" id="editFormFrame" width="100%" height="1300" frameborder="0"></iframe></cfoutput>
		</td>
	</tr>
</table>
<cfif structKeyExists(url,'CFGRIDKEY')>
	<script type="text/javascript">
		document.getElementById('searchModelno').value = '<cfoutput>#listFirst(url.CFGRIDKEY)#</cfoutput>';
	</script>
</cfif>


<!--- from delete_dups --->
<cfif structKeyExists(url,'TITLE') AND structKeyExists(url,'ARTIST')>
	<script type="text/javascript">
		document.getElementById('searchTitle').value = '<cfoutput>#url.TITLE#</cfoutput>';
		for(i = 0; i < document.getElementById('searchArtist').options.length; i++){
			if(document.getElementById('searchArtist').options[i].value == '<cfoutput>#url.ARTIST#</cfoutput>'){
				document.getElementById('searchArtist').options[i].selected = true;
			}
			else{
				document.getElementById('searchArtist').options[i].selected = false;
			}
		}
		document.getElementById('searchBtn').click();

	</script>
</cfif>




<cfset ajaxOnLoad("init")>
