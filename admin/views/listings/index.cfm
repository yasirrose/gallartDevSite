<cfajaxproxy cfc="admin.models.art" />
<cfajaxproxy bind="javascript:gridChange({data.uid})">
<!--- <cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/listings.js.cfm" language="JavaScript"></script>'> --->
	<cfhtmlhead text='
		<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

		<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
		<script type="text/javascript" src="/admin/scripts/listings.js.cfm" language="JavaScript"></script>
	'>

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
							<cfinput name="searchTitle" id="searchTitle" size="30" />
						</td>

					</tr>
					<tr>
						<td style="font-size: 10px;">
							<strong>Artist:</strong>
						</td>
						<td>
							<select name="searchArtist" id="searchArtist" class="select2">
								<option value="">All
								<cfoutput query="getAllArtists" group="manufacturer">
								<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
									<option value="#manufacturer#">#left(HTMLEditFormat(manufacturer),50)#
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
							<select name="searchMedium" class="select2">
								<option value="">All
								<cfoutput query="getAllMedium">
									<option value="#URLEncodedFormat(path)#">#left(path,50)#
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
										<input type="date" name="searchFromDate" size="10" />
									</td>
									<td width="25" style="font-size: 10px;">
										<strong>to:</strong>
									</td>
									<td nowrap>
										<input type="date" name="searchToDate" size="10" />
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
										<input type="date" name="searchFromLastedit" size="10" />
									</td>
									<td width="25" style="font-size: 10px;">
										<strong>to:</strong>
									</td>
									<td nowrap>
										<input type="date" name="searchToLastedit" size="10" />
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
							<select name="searchSellerId" class="select2">
								<option value="">All
								<option value="0">Only Seller Listings
								<cfoutput query="getAllSellers">
									<option value="#pk_users#">#REReplace(full_seller_name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")#
								</cfoutput>
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
						<td style="font-size: 10px;">
							Promotion:
						</td >
						<td style="font-size: 10px;">
							<input type="checkbox" name="searchpromotion" >
							<input type="Hidden" name="searchpromotion">
						</td>						
					</tr>

					
					<tr>
						<td colspan="2">
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td width="106" style="font-size: 10px;">&nbsp;

									</td>
									<td width="20">
										<!--- <input type="Checkbox" name="searchOnSale"> --->
										<input type="Hidden" name="searchOnSale">
									</td>
									<!--- <td width="75" style="font-size: 10px;">
										On Sale
									</td> --->
									<td width="20">
										<!--- <input type="Checkbox" name="searchTrump"> --->
										<input type="Hidden" name="searchTrump">
									</td>
									<!--- <td width="75" style="font-size: 10px;">
										Trump Site
									</td> --->
									<td width="20">
										<!--- <input type="Checkbox" name="searchAuction"> --->
										<input type="Hidden" name="searchAuction">
									</td>
									<!--- <td>
										Auction Site
									</td> --->
									<td width="20">
										<!--- <input type="Checkbox" name="searchSlideshow"> --->
										<input type="Hidden" name="searchSlideshow">
									</td>
									<!--- <td>
										Slideshow
									</td> --->
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
										<!--- <input type="Checkbox" name="searchFrontshow"> --->
										<input type="Hidden" name="searchFrontshow">
									</td>
									<!--- <td width="70" style="font-size: 10px;">
										Featured on Home Page
									</td> --->
									<td width="10">
										<!--- <input type="Checkbox" name="searchBottomHome"> --->
										<input type="Hidden" name="searchBottomHome">
									</td>
									<!--- <td width="70" style="font-size: 10px;">
										Bottom of Home Page
									</td> --->
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="Reset" onclick="setTimeout(function(){location.reload();},100);">
							<!--- <cfinput type="button" name="searchBtn" id="searchBtn" value="Search" onclick="document.getElementById('showResults').value = 1; ColdFusion.Grid.refresh('data', false);" /> --->
							<cfinput type="button" name="searchBtn" id="searchBtn" value="Search" onclick="encodeSearchTitle(); ColdFusion.Grid.refresh('data', false);" />
							<input type="Submit" value="Ken's Spreadsheet View" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<!--- <cfgrid format="html" name="data" pagesize="10" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.art.getListings({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchSellerId},{searchImageName},{searchModelno},{searchTitle},{searchArtist},{searchMedium},{searchYear},{searchHeight},{searchWidth},{searchDescription},{searchFromPrice},{searchToPrice},{searchFromDate},{searchToDate},{searchFromLastedit},{searchToLastedit},{searchOnSale},{searchTrump},{searchAuction},{searchSlideshow},{searchFrontshow},{searchBottomHome},{searchActive},{showResults})">
								<cfgridcolumn name="name" header="Title" width="150">
								<cfgridcolumn name="manufacturer" header="Artist" width="150">
								<cfgridcolumn name="gallery_price" header="Gallery Price" width="100">
								<cfgridcolumn name="listingDate" header="Date" width="75">
							</cfgrid> --->
							<cfgrid format="html" name="data" pagesize="10" stripeRows="true" stripeRowColor="##e0e0e0" 
								bind="cfc:admin.models.art.getListings(
									{cfgridpage}, {cfgridpagesize}, {cfgridsortcolumn}, {cfgridsortdirection} 
									
									)">
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
			<cfoutput><iframe src="index.cfm?event=listings.loadEditForm" name="editFormFrame" id="editFormFrame" width="100%" height="1300" frameborder="0"></iframe></cfoutput>
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
		document.addEventListener("DOMContentLoaded", function () {

			var titleVal  = '<cfoutput>#JSStringFormat(url.TITLE)#</cfoutput>';
			var artistVal = '<cfoutput>#JSStringFormat(url.ARTIST)#</cfoutput>';

			document.getElementById('searchTitle').value = titleVal;

			var artistDD = document.getElementById('searchArtist');
			for (var i = 0; i < artistDD.options.length; i++) {
				artistDD.options[i].selected = (artistDD.options[i].value === artistVal);
			}

			// ✅ IMPORTANT: encode BEFORE grid refresh
			encodeSearchTitle();

			// document.getElementById('showResults').value = 1;
			ColdFusion.Grid.refresh('data', false);
		});

	</script>
</cfif>


<script>

	function encodeSearchTitle() {
		var searchTitleValue = document.getElementById('searchTitle').value;
		document.getElementById('searchTitle').value = encodeURIComponent(searchTitleValue);
		document.getElementById('showResults').value = 1;
	}


	$(document).ready(function () {
		$('.select2').select2({
			matcher: function (params, data) {
				if ($.trim(params.term) === '') {
					return data;
				}

				// Prevent matching placeholder during search
				if (data.id === '') {
					return null;
				}

				var term = params.term.toLowerCase();
				var text = data.text.toLowerCase();

				// Starts with match
				if (text.startsWith(term)) {
					return data;
				}

				// Contains match (less priority)
				if (text.indexOf(term) > -1) {
					var modifiedData = $.extend({}, data, true);
					modifiedData.text = data.text + ' ';
					return modifiedData;
				}

				return null;
			},

			sorter: function (data) {
				var term = $('.select2-search__field').val().toLowerCase();
				return data.sort(function (a, b) {
					var aStarts = a.text.toLowerCase().startsWith(term);
					var bStarts = b.text.toLowerCase().startsWith(term);

					if (aStarts && !bStarts) return -1;
					if (!aStarts && bStarts) return 1;
					return 0;
				});
			}
        });
	});
</script>




<cfset ajaxOnLoad("init")>
