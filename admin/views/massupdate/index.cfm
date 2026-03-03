
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<table cellspacing="0" cellpadding="0" border="0" width="100%" align="left">
    <cfform method="post" action="index.cfm?event=massupdate.results" onsubmit="return validateForm();">
		<input type="hidden" name="page" value="1" />
		<tr>
			<td colspan="2"><br>
				<input type="submit" value="ALPHABETICAL ENTRY IN GROUPS - DEFAULT DISPLAY FIELDS" />
				&nbsp;Groups of:&nbsp;
				<input type="text" name="groups" value="25" size="2" />&nbsp;
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
				<table cellspacing="0" cellpadding="0" border="0" width="100%" class="layout-table-content">
					<tr>
						<td valign="top" width="50%">
							<table cellspacing="0" cellpadding="0" border="0" width="75%" class="layout-table-content">
								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Gallery Price from:$</strong>
										<br>
										<cfinput name="FromPrice" size="10" maxlength="10"/>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Gallery Price to:$</strong>
										<br>
										<cfinput name="ToPrice" size="10" maxlength="10"/>
									</td>
								</tr>
							</table>
						</td>
						<td valign="top" width="50%">

						</td>
						
					</tr>
				</table>				
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
						<td valign="top" width="50%" class="editBox">
							<table cellspacing="0" cellpadding="3" border="0" width="100%" class="layout-table-content">
								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Art ID:</strong>
										<br>
										<cfinput name="modelno" size="10" maxlength="10"/>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Title:</strong>
										<br>
										<cfinput name="name" size="30" maxlength="30"/>
									</td>
				
								</tr>
								<!--- <tr>
									<td style="font-size: 10px;">
										<strong>Title:</strong>
									</td>
									<td>
										<cfinput name="name" size="30" maxlength="30"/>
									</td>
				
								</tr> --->
								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Artist:</strong>
										<br>
										<select name="manufacturer" class="select2">
											<option value="">All
											<cfoutput query="getAllArtists" group="manufacturer">
												<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
													<option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#
												</cfif>
											</cfoutput>
										</select>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Medium:</strong>
										<br>
										<select name="path" class="select2">
											<option value="">All
											<cfoutput query="getAllMedium">
												<option value="#path#">#path#
											
											</cfoutput>
										</select>
									</td>
				
								</tr>

								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Art Style:</strong>
										<br>
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
											
											</cfoutput>
										</select>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Art Size:</strong>
										<br>
										<cfquery name="qGetSize" datasource="#application.dsource#">
											SELECT * 
											FROM filterOption
											WHERE filterType = 'Size'
											ORDER BY filterName ASC
										</cfquery>

										<select name="artSize">
											<option value="">All
											<cfoutput query="qGetSize">
												<option value="#filterName#">#filterName#</option>
											
											</cfoutput>
										</select>
									</td>
				
								</tr>

								<!--- <tr>
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
											
											</cfoutput>
										</select>
									</td>
				
								</tr> --->

								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Art Type:</strong>
										<br>
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
											
											</cfoutput>
										</select>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Art Subject:</strong>
										<br>
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
											
											</cfoutput>
										</select>
									</td>
				
								</tr>

								<!--- <tr>
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
											
											</cfoutput>
										</select>
									</td>
				
								</tr> --->

								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Year:</strong>
										<br>
										<cfinput name="Year" id="Year" size="10" maxlength="10"/>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Size:</strong>
										<br>
										<cfinput type="Text" name="Height" style="width: 50px;" maxlength="4">
										&nbsp;x&nbsp;
										<cfinput type="Text" name="Width" style="width: 50px;" maxlength="4"> (HEIGHT X WIDTH)
									</td>
								</tr>
								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Description:</strong> (keywords)
										<br>
										<cfinput name="caption" size="30" maxlength="30"/>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Number of Records:</strong>
									    <br>
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
									<td width="100" style="font-size: 10px;">
										<strong>Gallery Price from:$</strong>
										<br>
										<cfinput name="FromPrice" size="10" maxlength="10"/>
									</td>
									<td width="100" style="font-size: 10px;">
										<strong>Gallery Price to:$</strong>
										<br>
										<cfinput name="ToPrice" size="10" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<td class="calendar-field" width="100" style="font-size: 10px;">
										<strong>Date from:</strong>
										<br>
										<cfinput name="FromDate" type="datefield" validate="date" size="10" maxlength="10"/>
									</td>
									<td class="calendar-field" width="100" style="font-size: 10px;">
										<strong>to:</strong>
										<br>
										<cfinput name="ToDate" type="datefield" validate="date" size="10" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<td class="calendar-field" width="100" style="font-size: 10px;">
										<strong>Last Edit from:</strong>
										<br>
										<cfinput name="FromLastedit" type="datefield" validate="date" size="10" maxlength="10"/>
									</td>
									<td class="calendar-field" width="100" style="font-size: 10px;">
										<strong>to:</strong>
										<br>
										<cfinput name="ToLastedit" type="datefield" validate="date" size="10" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<td width="100" style="font-size: 10px;">
										<strong>Seller:</strong>
										<br>
										<select name="SellerId" class="select2">
											<option value="">All
											<option value="0">Only Seller Listings
											<cfoutput query="getAllSellers">
												<option value="#pk_users#">#full_seller_name#
											
											</cfoutput>
										</select>
									</td>
									
									<td width="100" style="font-size: 10px;">
										<strong>Active/Inactive:</strong>
										<br>
										<div class="form-row">
											<div class="form-group">
												<strong>Active</strong>
												<input type="radio" name="Active" value="1" checked>
											</div>
											<div class="form-group">
												<strong>Inactive</strong>
												<input type="radio" name="Active" value="0">
											</div>
											<div class="form-group">
												<strong>All</strong>
												<input type="radio" name="Active" value="">
											</div>
										</div>
									</td>
								</tr>
								<!--- <tr> --->
									<!--- <td style="font-size: 10px;">
										<input type="radio" name="Active" value="1" checked>Active
										<input type="radio" name="Active" value="0">Inactive
										<input type="radio" name="Active" value="">All
									</td> --->

									<!--- <td style="font-size: 10px;">
										<strong>Promotion:</strong>
									</td>
									<td style="font-size: 10px;">
										<input type="Checkbox" name="Promotion" value="1">
										<input type="Hidden" name="Promotion" value="">
									</td> --->
				
								<!--- </tr> --->
								<!--- <tr>
									<td style="font-size: 10px;">
										<strong>Promotion:</strong>
									</td >
									<td style="font-size: 10px;">
										<input type="Checkbox" name="Promotion" value="1">
										<input type="Hidden" name="Promotion" value="">
									</td>
				
								</tr> --->
								<tr>
									<td width="100" style="font-size: 10px;" colspan="2">
										<div class="form-row">
											<div class="form-group">
												<strong>Gallery Listings Only:</strong>
												<input type="checkbox" name="gallery_only" value="1" checked>
											</div>
											<div class="form-group">
												<strong>Promotion:</strong>
												<input type="Checkbox" name="Promotion" value="1">
												<input type="Hidden" name="Promotion" value="">
											</div>

											<div class="form-group">
												<strong>On Sale</strong>
												<input type="Checkbox" name="OnSale" value="1">
												<input type="Hidden" name="OnSale" value="">
											</div>
											<div class="form-group">
												<strong>Trump Site</strong>
												<input type="Checkbox" name="Trump" value="1">
												<input type="Hidden" name="Trump" value="">
											</div>
											<div class="form-group">
												<strong>Auction Site</strong>
												<input type="Checkbox" name="Auction" value="1">
												<input type="Hidden" name="Auction" value="">
											</div>
											<div class="form-group">
												<strong>Slideshow</strong>
												<input type="Checkbox" name="Slideshow">
												<input type="Hidden" name="Slideshow">
											</div>

											<div class="form-group">
												<strong>Featured on Home Page</strong>
												<input type="Checkbox" name="Frontshow">
												<input type="Hidden" name="Frontshow">
											</div>
											<div class="form-group">
												<strong>Bottom of Home Page</strong>
												<input type="Checkbox" name="BottomHome">
												<input type="Hidden" name="BottomHome">
											</div>
										</div>
										<!--- <table cellspacing="0" cellpadding="0" border="0" width="100%">
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
												<td width="20">
													<input type="Checkbox" name="Slideshow">
													<input type="Hidden" name="Slideshow">
												</td>
												<td>
													Slideshow
												</td>
											</tr>
										</table>--->
									</td>
								</tr>
								<tr>
									<td width="100" style="font-size: 10px;">
										<!-- <div class="form-row">
											<div class="form-group">
												<strong>Featured on Home Page</strong>
												<input type="Checkbox" name="Frontshow">
												<input type="Hidden" name="Frontshow">
											</div>
											<div class="form-group">
												<strong>Bottom of Home Page</strong>
												<input type="Checkbox" name="BottomHome">
												<input type="Hidden" name="BottomHome">
											</div>
										</div> -->
										<!--- <table cellspacing="0" cellpadding="0" border="0" width="100%">
											<tr>
												<td width="50" style="font-size: 10px;">&nbsp;
													
												</td>
												<td width="10">
													<input type="Checkbox" name="Frontshow">
													<input type="Hidden" name="Frontshow">
												</td>
												<td width="70" style="font-size: 10px;">
													Featured on Home Page
												</td>
												<td width="10">
													<input type="Checkbox" name="BottomHome">
													<input type="Hidden" name="BottomHome">
												</td>
												<td width="70" style="font-size: 10px;">
													Bottom of Home Page
												</td>
											</tr>
										</table> --->
									</td>
								</tr>
							</table>
						</td>
						<td valign="top" width="50%" style="padding-left: 30px !important;">
							<table cellspacing="0" cellpadding="3" border="0" width="100%">
								<tr>
									<td style="font-size: 10pt;">
										<b>Choose Fields You Want To Display:</b>
									</td>
								</tr>
								<tr>
									<td style="font-size: 9pt;">
										<!--- <input type="Checkbox" name="displayFields" value="ModelNo" checked>Art ID<br>
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
										<input type="Checkbox" name="displayFields" value="Promotion" >Promotion   --->

										<div class="checkbox-grid editBox" >
											<label><input type="checkbox" name="displayFields" value="ModelNo" checked> Art ID</label>
											<label><input type="checkbox" name="displayFields" value="Artist" checked> Artist</label>
											<label><input type="checkbox" name="displayFields" value="Medium" checked> Medium</label>
											<label><input type="checkbox" name="displayFields" value="Year"> Year</label>

											<label><input type="checkbox" name="displayFields" value="Size"> Size</label>
											<label><input type="checkbox" name="displayFields" value="Edition"> Edition</label>
											<label><input type="checkbox" name="displayFields" value="Low" checked> Low Estimate</label>
											<label><input type="checkbox" name="displayFields" value="High" checked> High Estimate</label>

											<label><input type="checkbox" name="displayFields" value="Retail" checked> Retail Price</label>
											<label><input type="checkbox" name="displayFields" value="Gallery" checked> Gallery Price</label>
											<label><input type="checkbox" name="displayFields" value="Sale" checked> Sale Price</label>
											<label><input type="checkbox" name="displayFields" value="SellerInfo"> Seller Info</label>

											<label><input type="checkbox" name="displayFields" value="Thumbnail" checked> Thumbnail</label>
											<label><input type="checkbox" name="displayFields" value="artType"> Art Style</label>
											<label><input type="checkbox" name="displayFields" value="artSize"> Art Size</label>
											<label><input type="checkbox" name="displayFields" value="artSubject"> Art Subject</label>

											<label><input type="checkbox" name="displayFields" value="artTypee"> Art Type</label>
											<label><input type="checkbox" name="displayFields" value="quantity"> Quantity</label>
											<label><input type="checkbox" name="displayFields" value="datestamp"> Listing Date</label>
											<label><input type="checkbox" name="displayFields" value="lastEdit"> Last Edit</label>

											<label><input type="checkbox" name="displayFields" value="location_notes"> Notes</label>
											<label><input type="checkbox" name="displayFields" value="caption"> Description</label>
											<label><input type="checkbox" name="displayFields" value="Slideshow"> Slide Show</label>
											<label><input type="checkbox" name="displayFields" value="Frontshow"> Featured on Home Page</label>

											<label><input type="checkbox" name="displayFields" value="BottomHome"> Bottom on Home Page</label>
											<label><input type="checkbox" name="displayFields" value="Promotion"> Promotion</label>
										</div>
										
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px;" align="end">
							<input type="Reset" value="Reset">
							<input type="Submit" id="submitBtn" value="Search">
						</td>
						<td style="padding-top: 10px;" align="center"></td>
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
	.checkbox-grid {
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		gap: 6px 15px;
	}

	.checkbox-grid label {
		white-space: nowrap;
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
</style>


