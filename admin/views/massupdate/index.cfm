
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<table cellspacing="0" cellpadding="0" border="0" width="100%" align="left">
    <cfform method="post" action="index.cfm?event=massupdate.results" onsubmit="return validateForm();">
	<input type="hidden" name="page" value="1" />
	<tr>
		<td colspan="2"><br>
			<input type="submit" value="ALPHABETICAL ENTRY IN GROUPS - DEFAULT DISPLAY FIELDS" />&nbsp;Groups of:&nbsp;				<input type="text" name="groups" value="25" size="2" />&nbsp;
				Letter:&nbsp;
				<select name="alphaCharNum">
					<option value="65">A</option>
					<option value="66">B</option>
					<option value="67">C</option>
					<option value="68">D</option>
					<option value="69">E</option>
					<option value="70">F</option>
					<option value="71">G</option>
					<option value="72">H</option>
					<option value="73">I</option>
					<option value="74">J</option>
					<option value="75">K</option>
					<option value="76">L</option>
					<option value="77">M</option>
					<option value="78">N</option>
					<option value="79">O</option>
					<option value="80">P</option>
					<option value="81">Q</option>
					<option value="82">R</option>
					<option value="83">S</option>
					<option value="84">T</option>
					<option value="85">U</option>
					<option value="86">V</option>
					<option value="87">W</option>
					<option value="88">X</option>
					<option value="89">Y</option>
					<option value="90">Z</option>
				</select>
				<br><br>
			</td>
		</tr>
		<tr>
			<td>
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr>
							<td width="106" style="font-size: 10px;">
						<strong>Gallery Price from:</strong>
									</td>
					<td width="100">
						$<cfinput name="FromPrice" size="10" maxlength="10"/>
					</td>
					<td width="25" style="font-size: 10px;">
						<strong>to:</strong>
					</td>
					<td nowrap>
						$<cfinput name="ToPrice" size="10" maxlength="10"/>
									</td>
								</tr>
							</table>
				<br><br>			
			</td>
		</tr>
    </cfform>
    <!---<form method="post" action="index.cfm?event=massupdate.results">
    <!-- set alphaCharNum to coldfusion chr for letter A -->
    <input type="hidden" name="alphaCharNum" value="65" />
	<tr>
    	<td colspan="2"><input type="submit" value="ALPHABETICAL ENTRY - DEFAULT DISPLAY FIELDS" /></td>
  	</tr>
    </form>
    <form method="post" action="index.cfm?event=massupdate.results">
	<input type="hidden" name="alphaCharNum" value="65" />
	<input type="hidden" name="page" value="1" />
    <tr>
    	<td colspan="2"><br>
			<input type="submit" value="ALPHABETICAL ENTRY IN GROUPS - DEFAULT DISPLAY FIELDS" />&nbsp;Groups of:&nbsp;<input type="text" name="groups" value="25" size="2" />
		<br><br>
		</td>
  	</tr>
    </form>--->
	<tr>
		<td colspan="2">
			<cfform method="post" action="index.cfm?event=massupdate.results" onsubmit="return validateSearchForm() && disableSubmitBtn()">
				<table cellspacing="0" cellpadding="0" border="0" width="75%" align="left">
					<tr>
						<td colspan="2" style="font-size: 11px;"><strong>SEARCH:</strong></td>
					</tr>
					<tr>
						<td valign="top" width="50%">
							<table cellspacing="0" cellpadding="3" border="0" width="100%">
								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Art ID:</strong>
									</td>
									<td>
										<cfinput name="modelno" size="10" maxlength="10"/>
									</td>
				
								</tr>
								<tr>
									<td style="font-size: 10px;">
										<strong>Title:</strong>
									</td>
									<td>
										<cfinput name="name" size="30" maxlength="30"/>
									</td>
				
								</tr>
								<tr>
									<td style="font-size: 10px;">
										<strong>Artist:</strong>
									</td>
									<td>
										<select name="manufacturer" class="select2">
											<option value="">All
											<cfoutput query="getAllArtists" group="manufacturer">
												<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
													<option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#
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
										<select name="path" class="select2">
											<option value="">All
											<cfoutput query="getAllMedium">
												<option value="#path#">#path#
											
											</cfoutput></select>
									</td>
				
								</tr>

								<tr>
									<td style="font-size: 10px;">
										<strong>Art Style:</strong>
									</td>
									<td>
										<cfquery name="qGetStyle" datasource="#application.dsource#">
											SELECT * 
											FROM filterOption
											WHERE filterType = 'Style'
											ORDER BY filterName ASC
										</cfquery>

										<select name="artType">
											<option value="">All
											<cfoutput query="qGetStyle">
												<option value="#filterName#">#filterName#</option>
											
											</cfoutput></select>
									</td>
				
								</tr>

								<tr>
									<td style="font-size: 10px;">
										<strong>Art Size:</strong>
									</td>

									<cfquery name="qGetSize" datasource="#application.dsource#">
										SELECT * 
										FROM filterOption
										WHERE filterType = 'Size'
										ORDER BY filterName ASC
									</cfquery>

									<td>
										<select name="artSize">
											<option value="">All
											<cfoutput query="qGetSize">
												<option value="#filterName#">#filterName#</option>
											
											</cfoutput></select>
									</td>
				
								</tr>

								<tr>
									<td style="font-size: 10px;">
										<strong>Art Type:</strong>
										</td>
										<td>
										<cfquery name="qGetType" datasource="#application.dsource#">
											SELECT * 
											FROM filterOption
											WHERE filterType = 'Type'
											ORDER BY filterName ASC
										</cfquery>

										<select name="artTypee">
											<option value="">All
											<cfoutput query="qGetType">
												<option value="#filterName#">#filterName#</option>
											
											</cfoutput></select>
									</td>
				
								</tr>

								<tr>
									<td style="font-size: 10px;">
										<strong>Art Subject:</strong>
									</td>
									<td>

										<cfquery name="qGetSubject" datasource="#application.dsource#">
											SELECT * 
											FROM filterOption
											WHERE filterType = 'Subject'
											ORDER BY filterName ASC
										</cfquery>

										<select name="artSubject">
											<option value="">All
											<cfoutput query="qGetSubject">
												<option value="#filterName#">#filterName#</option>
											
											</cfoutput></select>
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
													<cfinput name="Year" size="10" maxlength="10"/>
												</td>
												<td width="50" style="font-size: 10px;">
													<strong>Size:</strong>
												</td>
												<td>
													<cfinput type="Text" name="Height" style="width: 50px;" maxlength="4">
													&nbsp;x&nbsp;
													<cfinput type="Text" name="Width" style="width: 50px;" maxlength="4"> (HEIGHT X WIDTH)
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
										<cfinput name="caption" size="30" maxlength="30"/>
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
													$<cfinput name="FromPrice" size="10" maxlength="10"/>
												</td>
												<td width="25" style="font-size: 10px;">
													<strong>to:</strong>
												</td>
												<td nowrap>
													$<cfinput name="ToPrice" size="10" maxlength="10"/>
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
													<cfinput name="FromDate" type="datefield" validate="date" size="10" maxlength="10"/>
												</td>
												<td width="25" style="font-size: 10px;">
													<strong>to:</strong>
												</td>
												<td nowrap>
													<cfinput name="ToDate" type="datefield" validate="date" size="10" maxlength="10"/>
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
													<cfinput name="FromLastedit" type="datefield" validate="date" size="10" maxlength="10"/>
												</td>
												<td width="25" style="font-size: 10px;">
													<strong>to:</strong>
												</td>
												<td nowrap>
													<cfinput name="ToLastedit" type="datefield" validate="date" size="10" maxlength="10"/>
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
										<select name="SellerId" class="select2">
											<option value="">All
											<option value="0">Only Seller Listings
											<cfoutput query="getAllSellers">
												<option value="#pk_users#">#full_seller_name#
											
											</cfoutput></select>
									</td>

									</tr>
								<tr>
									<td style="font-size: 10px;">
										<strong>Active/Inactive:</strong>
									</td >
									<td style="font-size: 10px;">
										<input type="radio" name="Active" value="1" checked>Active
										<input type="radio" name="Active" value="0">Inactive
										<input type="radio" name="Active" value="">All
									</td>

									</tr> 
									<tr>
									<td style="font-size: 10px;">
										<strong>Promotion:</strong>
									</td >
									<td style="font-size: 10px;">
										<input type="Checkbox" name="Promotion" value="1">
										<input type="Hidden" name="Promotion" value="">
									</td>
				
								</tr>
								<tr>
										<td style="font-size: 10px;">
										<strong>Number of Records:</strong>
									</td >
									<td style="font-size: 10px;">
										<select name="number_records">
											<option value="">All</option>
											<option value="1">1 - 50</option>
											<option value="51">51 - 100</option>
											<option value="101">101 - 150</option>
											<option value="151">151 - 200</option>
											<option value="201">201 - 250</option>
											<option value="251">251 - 300</option>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="listing-flags">
											<label><input type="Checkbox" name="OnSale" value="1">On Sale</label>
											<input type="Hidden" name="OnSale" value="">
											<label><input type="Checkbox" name="Trump" value="1">Trump Site</label>
											<input type="Hidden" name="Trump" value="">
											<label><input type="Checkbox" name="Auction" value="1">Auction Site</label>
											<input type="Hidden" name="Auction" value="">
											<label><input type="Checkbox" name="Slideshow">Slideshow</label>
											<input type="Hidden" name="Slideshow">
											<label><input type="Checkbox" name="Frontshow">Featured on Home Page</label>
											<input type="Hidden" name="Frontshow">
											<label><input type="Checkbox" name="BottomHome">Bottom of Home Page</label>
											<input type="Hidden" name="BottomHome">
										</div>
									</td>
								</tr>
							</table>
						</td>
						<td valign="top" width="50%">
							<table cellspacing="0" cellpadding="3" border="0" width="100%">
								<tr>
									<td style="font-size: 10pt;">
										<b>Choose Fields You Want To Display:</b>
									</td>
								</tr>
								<tr>
									<td style="font-size: 9pt;">
										<input type="Checkbox" name="displayFields" value="ModelNo" checked>Art ID<br>
										<input type="Checkbox" name="displayFields" value="Artist" checked>Artist<br>
										<input type="Checkbox" name="displayFields" value="Medium" checked>Medium<br>
										<input type="Checkbox" name="displayFields" value="Year">Year<br>
										<input type="Checkbox" name="displayFields" value="Size">Size<br>
										<input type="Checkbox" name="displayFields" value="Edition">Edition<br>
										<input type="Checkbox" name="displayFields" value="Low" checked>Low Estimate<br>
										<input type="Checkbox" name="displayFields" value="High" checked>High Estimate<br>
										<input type="Checkbox" name="displayFields" value="Retail" checked>Retail Price<br>
										<input type="Checkbox" name="displayFields" value="Gallery" checked>Gallery Price<br>
										<input type="Checkbox" name="displayFields" value="Sale" checked>Sale Price<br>
										<input type="Checkbox" name="displayFields" value="SellerInfo">Seller Info<br>
										<input type="Checkbox" name="displayFields" value="Thumbnail" checked>Thumbnail<br>
										<input type="Checkbox" name="displayFields" value="artType" >Art Style <br>
										<input type="Checkbox" name="displayFields" value="artSize" >Art Size <br>
										<input type="Checkbox" name="displayFields" value="artSubject" >Art Subject<br>
										<input type="Checkbox" name="displayFields" value="artTypee" >Art Type<br>
										<input type="Checkbox" name="displayFields" value="quantity" >Quantity<br>
										<input type="Checkbox" name="displayFields" value="datestamp" >Listing Date<br>
										<input type="Checkbox" name="displayFields" value="lastEdit" >Last Edit<br>
										<input type="Checkbox" name="displayFields" value="location_notes" >Notes <br>
										<input type="Checkbox" name="displayFields" value="caption" >Description <br>
										<input type="Checkbox" name="displayFields" value="Slideshow" >Slide Show <br>
										<input type="Checkbox" name="displayFields" value="Frontshow" >Featured on Home Page <br>
										<input type="Checkbox" name="displayFields" value="BottomHome" >Bottom on Home Page <br>
										<input type="Checkbox" name="displayFields" value="Promotion" >Promotion
										
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding-top: 10px;" align="center">
							<input type="Reset" value="Reset">
							<input type="Submit" id="submitBtn" value="Search">
						</td>
					</tr>
				</table>
			</cfform>
		</td>
	</tr>
</table>


<script>
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

		$('form').on('reset', function () {
			// Wait a tiny bit for the form to actually reset its elements
			setTimeout(function () {
				$('.select2').val(null).trigger('change'); // clear the select2
			}, 0);
		});

	});


	function disableSubmitBtn() {
		// get the button directly by ID (works reliably)
		var btn = document.getElementById('submitBtn');
		if (btn) {
			btn.disabled = true;        // disable button to prevent double-submit
			btn.value = 'Loading...';   // give user feedback
		}
		return true; // allow the form to submit
	} 


	function validateForm() {
		var groupValue = document.getElementsByName("groups")[0].value.trim();

		// check empty
		if (groupValue === "") {
			alert("Groups field cannot be empty.");
			return false;
		}

		// check numeric only
		if (isNaN(groupValue) || Number(groupValue) <= 0) {
			alert("Please enter a valid numeric value for Groups.");
			return false;
		}

		return true; // allow submit
	}

	function validateSearchForm() {

		var year   = document.getElementById('Year').value.trim();
		var height = document.getElementsByName('Height')[0].value.trim();
		var width  = document.getElementsByName('Width')[0].value.trim();

		// ===== YEAR VALIDATION (Only Integer Allowed) =====
		if (year !== '' && !/^\d+$/.test(year)) {
			alert('Year must be a numeric value.');
			document.getElementById('Year').focus();
			return false;
		}

		// ===== HEIGHT VALIDATION (Integer or Float Allowed) =====
		if (height !== '' && !/^\d+(\.\d+)?$/.test(height)) {
			alert('Height must be numeric (integer or decimal).');
			document.getElementsByName('Height')[0].focus();
			return false;
		}

		// ===== WIDTH VALIDATION (Integer or Float Allowed) =====
		if (width !== '' && !/^\d+(\.\d+)?$/.test(width)) {
			alert('Width must be numeric (integer or decimal).');
			document.getElementsByName('Width')[0].focus();
			return false;
		}

		return true; // allow submit if all valid
	}


</script>

<style>
	.massupdate-page {
		font-family: "Segoe UI", Tahoma, sans-serif;
	}
	.massupdate-page > tbody > tr > td {
		padding: 6px 8px;
	}
	.massupdate-page .search-panel {
		width: 96%;
		background: #f8fafc;
		border: 1px solid #d8e1eb;
		border-radius: 8px;
		box-shadow: 0 2px 8px rgba(25, 45, 74, 0.08);
	}
	.massupdate-page .search-panel > tbody > tr:first-child td {
		padding: 12px 12px 4px;
	}
	.massupdate-page .search-col-left {
		padding: 8px 12px 12px;
	}
	.massupdate-page .search-col-right {
		padding: 8px 12px 12px 20px !important;
		border-left: 1px dashed #c8d2de;
	}
	.massupdate-page input[type="submit"],
	.massupdate-page input[type="reset"],
	.massupdate-page input[type="button"] {
		border: 1px solid #98a8bd;
		background: linear-gradient(#ffffff, #eaf0f7);
		color: #1c2d42;
		padding: 4px 10px;
		border-radius: 4px;
		font-weight: 600;
		cursor: pointer;
	}
	.massupdate-page input[type="submit"]:hover,
	.massupdate-page input[type="reset"]:hover,
	.massupdate-page input[type="button"]:hover {
		background: linear-gradient(#ffffff, #dde8f4);
	}
	.massupdate-page #submitBtn {
		min-width: 88px;
	}
	.massupdate-page input[type="text"],
	.massupdate-page select,
	.massupdate-page textarea {
		border: 1px solid #b9c6d6;
		border-radius: 4px;
		padding: 3px 6px;
	}
	.massupdate-page td[style*="font-size: 10px;"] strong {
		color: #1c2d42;
	}
	.massupdate-page .select2-container--default .select2-selection--single {
		height: 27px;
		border: 1px solid #b9c6d6;
		border-radius: 4px;
	}
	.massupdate-page .select2-container--default .select2-selection--single .select2-selection__rendered {
		line-height: 25px;
	}
	.massupdate-page .select2-container--default .select2-selection--single .select2-selection__arrow {
		height: 25px;
	}
	.checkbox-grid {
		display: grid;
		grid-template-columns: repeat(2, minmax(180px, 1fr));
		gap: 6px 18px;
	}

	.checkbox-grid label {
		white-space: nowrap;
		display: flex;
		align-items: center;
		gap: 6px;
	}
	.massupdate-page .listing-flags {
		display: grid;
		grid-template-columns: repeat(4, minmax(120px, max-content));
		gap: 8px 18px;
		align-items: center;
		font-size: 10px;
		padding-left: 106px;
	}
	.massupdate-page .listing-flags label {
		display: inline-flex;
		align-items: center;
		gap: 6px;
		margin: 0;
		white-space: nowrap;
	}
	.massupdate-page .listing-flags input[type="checkbox"] {
		margin: 0;
	}
	.layout-table-content td {
		width: 50%;
	}
	.layout-table-content input:not([type="checkbox"]):not([type="radio"]) {
		width: 100%;
	}
	.layout-table-content .select2-container,
	.layout-table-content select:not(.select2) {
		width: 100% !important;
	}
	.layout-table-content .form-row {
		display: flex;
		flex-wrap: wrap;
		gap: 2px;
	}
	.layout-table-content .form-row .form-group {
		width: 24%;
		display: flex;
		flex-direction: row-reverse;
		align-items: center;
		justify-content: flex-end;
		gap: 2px;
	}
	.layout-table-content .calendar-field > div {
		width: 100%;
	}
	.layout-table-content .calendar-field > div > div:first-child {
		width: calc(100% - 20px);
	}
	@media (max-width: 1100px) {
		.massupdate-page .search-panel {
			width: 100%;
		}
		.massupdate-page .search-col-right {
			padding-left: 12px !important;
			border-left: none;
			border-top: 1px dashed #c8d2de;
		}
		.massupdate-page .listing-flags {
			grid-template-columns: repeat(2, minmax(140px, 1fr));
			padding-left: 0;
		}
		.checkbox-grid {
			grid-template-columns: 1fr;
		}
	}
</style>


