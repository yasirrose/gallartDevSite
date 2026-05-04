<cfajaxproxy cfc="admin.models.art" >

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Untitled Document</title>
	</head>
		<!--- <style>
				#toast-container.toast-center {
					position: fixed !important;
					top: 50% !important;
					left: 30% !important;
					right: auto !important;
					bottom: auto !important;
					margin: 0 !important;
					transform: translate(-50%, -50%) !important;
					z-index: 999999 !important;
					display: flex !important;
					flex-direction: column !important;
					align-items: center !important;
					justify-content: center !important;
					width: auto !important;
					max-width: 500px !important;
				}

				#toast-container > .toast {
					background-color: #ff4da6 !important;
					color: white !important;
					margin: 5px auto !important;
				}
			</style> --->
				<style>
				.toast-center {
					top: 50% !important;
					left: 50% !important;
					transform: translate(-50%, -50%) !important;
					position: fixed !important;
					z-index: 999999 !important;
				}

				#toast-container > .toast {
					background-color: #ff4da6 !important;
					color: white !important;
				}
			</style>
	<body>

		<cfoutput>
			<link REL="STYLESHEET" TYPE="text/css" HREF="/admin/css/main.css">
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
			<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
			<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
			<script src="https://cdn.rawgit.com/harvesthq/chosen/gh-pages/chosen.jquery.min.js"></script>
			<link href="https://cdn.rawgit.com/harvesthq/chosen/gh-pages/chosen.min.css" rel="stylesheet"/>
			<script type="text/javascript" src="/admin/scripts/listings.js.cfm" language="JavaScript"></script>
			
		</cfoutput>

		<script type="text/javascript">
			toastr.options = {
				closeButton: true,
				debug: false,
				newestOnTop: false,
				progressBar: true,
				positionClass: 'toast-center',
				preventDuplicates: false,
				showDuration: '1000',
				hideDuration: '1000',
				timeOut: '5000',
				extendedTimeOut: '1000',
				showEasing: 'swing',
				hideEasing: 'linear',
				showMethod: 'fadeIn',
				hideMethod: 'fadeOut'
			};
		</script>

		<script type="text/javascript">
			function ArtistView() {
				var artistvalue = document.editForm.artistview.value;
				document.editForm.manufacturer.value = artistvalue;
				return true;
			}

			function CatView() {
				var catvalue = document.editForm.catstringview.value;
				document.editForm.path.value = catvalue;
				return true;
			}
			function artTypesvalue() {
				var selectedValues = [];
				var selectedOptions = document.editForm.artTypes.selectedOptions;
				for (var i = 0; i < selectedOptions.length; i++) {
					selectedValues.push(selectedOptions[i].value);
				}
				document.editForm.artType.value = selectedValues.join(',');
				return true;
			}
			function artTypeesvalue() {
				var selectedArtValues = [];
				var selectedOptions = document.editForm.artTypees.selectedOptions;
				for (var i = 0; i < selectedOptions.length; i++) {
					selectedArtValues.push(selectedOptions[i].value);
				}
				document.editForm.artTypee.value = selectedArtValues.join(',');
				return true;
			}
			function artSubjectvalue() {
				var selectedArtSubject = [];
				var selectedOptions = document.editForm.artSubjectt.selectedOptions;
				for (var i = 0; i < selectedOptions.length; i++) {
					selectedArtSubject.push(selectedOptions[i].value);
				}
				document.editForm.artSubject.value = selectedArtSubject.join(',');
				return true;
			}
			function artSizevalue() {
				var selectedArtSize = [];
				var selectedOptions = document.editForm.artSizee.selectedOptions;
				for (var i = 0; i < selectedOptions.length; i++) {
					selectedArtSize.push(selectedOptions[i].value);
				}
				document.editForm.artSize.value = selectedArtSize.join(',');
				return true;
			}

			function isValidSize(sText){
				var ValidChars = "0123456789.xX ";
				var isValid=true;
				var Char;

				for (i = 0; i < sText.length && isValid == true; i++){
					Char = sText.charAt(i);
					if (ValidChars.indexOf(Char) == -1){
						isValid = false;
					}
				}
				return isValid;
			}


			function validEntries(frm) {
				// alert('test: ' + frm.size.value)
				
				if(frm.uid.value == ''){
					frm.uid.value = 0;
				}
				// console.log(frm.uid.value)
				if(frm.name.value == ''){
					toastr.warning('You must add a Name.', 'Alert!');
					frm.name.focus();
					return false;
				}
				if(frm.manufacturer.value == ''){
					toastr.warning('You must select an Artist.', 'Alert!');
					frm.manufacturer.focus();
					return false;
				}
				if(frm.path.value == ''){
					toastr.warning('You must select a Medium.', 'Alert!');
					frm.path.focus();
					return false;
				}
				if(frm.quantity.value == ''){
					toastr.warning('You must add a Quantity.', 'Alert!');
					frm.quantity.focus();
					return false;
				}
				if (!/^[0-9]+$/.test(frm.quantity.value.trim())) {
					toastr.warning('Quantity must be a numeric value. Please enter numbers only.', 'Alert!');
					frm.quantity.focus();
					return false;
				}

				if(frm.year.value != ''){
					if(!/^[0-9]+$/.test(frm.year.value.trim())){
						toastr.warning('Year must be numeric', 'Alert!');
						frm.year.focus();
						return false;
					}
				}

				// if(!isValidSize(frm.size.value)){
				// 	alert('You must enter a valid SIZE: only numbers and the letter x');
				// 	frm.size.focus();
				// 	return false;
				// }
				function isValidSize(value) {
				// Regex: numbers, optional spaces, 'x' (case insensitive), optional spaces, numbers
					// var pattern = /^\d+\s*[xX]\s*\d+$/;
					var pattern = /^[0-9]+(\.[0-9]+)*\s*[xX]\s*[0-9]+(\.[0-9]+)*(\s*[xX]\s*[0-9]+(\.[0-9]+)*)?$/;
					return pattern.test(value.trim());
				}

				if (frm.size.value.trim() !== '') {
					if (!isValidSize(frm.size.value)) {
						toastr.warning('You must enter a valid SIZE in format: height x width OR height x width x depth (only numbers and the letter x)', 'Alert!');
						frm.size.focus();
						return false;
					}
				}

				return true;

			}
		</script>

		<script>
			function popupWin(url) {
				w = 800;  // width
				h = 700;  // height
				var features =	'scrollbars=yes, toolbar=yes, status=no, menubar=no ' +
								',resizable=yes, location=no, directories=no ' +
								',left=' + ((screen.width-w)/2) +
								',top='  + ((screen.height-h)/2) +
								',width=' + w + ',height=' + h;

				myWin =	window.open(url,'WinName',features);
			}
		</script>

		<cfform method="POST" action="/admin/index.cfm?event=listings.procListing" name="editForm" id="editForm"  enctype="multipart/form-data">
			<cfinput type="hidden" name="uid" id="uid">
			<cfinput type="hidden" name="moduleName" id="moduleName" value="Listing Module">
			<table border = "0" width = "700" cellpadding = "3" cellspacing = "0" class="editBox">

				<!--- <cfif> --->
					<cfoutput>
						<script>
							<cfif structKeyExists(session, "ext") and session.ext eq 'true'>
								toastr.warning('Only JPG or JPEG files are allowed.', 'Alert!');
								<cfset structDelete(session, "ext")>
							</cfif>
						</script>
					</cfoutput>
				<!--- </cfif> --->

				<cfif structKeyExists(url,'gridRefresh')>
					<tr>
						<td colspan="2" valign="top" id="gridRefreshMsg"><span style="color: #ff0000;">LISTING EDIT SUCCESSFUL</span></td>
					</tr>
				</cfif>

				<tr>
					<td valign="top">
						<table border = "0" width = "100%" cellpadding = "3" cellspacing = "0">
							<tr>
								<td width="160" style="font-size: 10px;">
									Art ID Dev:
								</td>
								<td>
									<cfinput type="Text" name="modelno" id="modelno"  size="20" disabled class="displayInput" />
									<cfinput type="Hidden" name="newModelno" id="newModelno" />
									<cfinput type="Hidden" name="newModelno_numeric" id="newModelno_numeric" />
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Title:
								</td>
								<td>
									<cfinput type="text" name="name" id="name" maxlength="50" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Artist:
								</td>
								<td>
									<select name="artistview"  onchange="ArtistView()">
									<option value="">Please Select</option>
									<cfoutput query="getAllArtists" group="manufacturer">
										<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
										<option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#
										</cfif>
									</cfoutput>
									</select>
									<br><i>Select an artist from dropdown above,<br>
									OR type in a new artist below:</i><br>
									<input type="Text" name="manufacturer" id="manufacturer" value="" maxlength="40" size="35">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Medium:&nbsp;
								</td>
								<td>
									<select name="catstringview"  onchange="CatView()">
										<option value="">Please Select</option>
										<cfoutput query="getAllMedium" group="path">
											<option value="#path#">#path#
										</cfoutput>
									</select>
									<br><i>Select existing medium from dropdown above, and edit if desired,<br>OR type in a new string.
									Make sure subcategories (sub-mediums) are separated by colons, and that the entire string ends with a colon.</i>
									<input type="Text" name="path" id="path" value="" maxlength="50" size="50">
								</td>
							</tr>
							<tr>
								<cfquery name="qGetStyle" datasource="#application.dsource#">
									SELECT * 
									FROM filterOption
									WHERE filterType = 'Style'
									ORDER BY filterName ASC
								</cfquery>
								<td style="font-size: 10px;" valign="top">
									Art Style:&nbsp;
								</td>
								<td>
									<select name="artTypes" class="chosen-select" data-placeholder="Choose art Style" multiple onchange="artTypesvalue()">
										<option value="">Please Select</option>
										<cfoutput query="qGetStyle">
											<option value="#filterName#">#filterName#</option>
										</cfoutput>
										<!--- <option value="Abstract">Abstract</option>
										<option value="Art Deco">Art Deco</option>
										<option value="Contemporary Art">Contemporary Art</option>
										<option value="Cubism">Cubism</option>
										<option value="Pop Art">Pop Art</option>
										<option value="Realism">Realism</option>
										<option value="Surrealism">Surrealism</option>
										<option value="Urban Art">Urban Art</option>
										<option value="Animation">Animation</option>
										<option value="Memorabilia">Memorabilia</option> --->
									</select>
									<!--- <br><i>Select an art type from dropdown above,<br>
										OR type in a new art type below:</i><br> --->
									<input type="hidden" name="artType" value="" size="100" >
								</td>
							</tr>
							<tr>
								<cfquery name="qGetType" datasource="#application.dsource#">
									SELECT * 
									FROM filterOption
									WHERE filterType = 'Type'
									ORDER BY filterName ASC
								</cfquery>
								<td style="font-size: 10px;">
									Art Type:
								</td>
								<td>
									<select name="artTypees" class="chosen-select artTypeesvalue" data-placeholder="Choose art Type" multiple onchange="artTypeesvalue()">
										<option value="">Please Select</option>
										<cfoutput query="qGetType">
											<option value="#filterName#">#filterName#</option>
										</cfoutput>
										<!--- <option value="Paintings">Paintings</option>
										<option value="Drawings and Watercolor">Drawings and Watercolor</option>
										<option value="Mixed Media">Mixed Media</option>
										<option value="Prints and Editions">Prints and Editions</option>
										<option value="Photography">Photography</option>
										<option value="Sculptures">Sculptures</option> --->
									</select>

									<input type="hidden" name="artTypee" value="" size="100" >
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Year:
								</td>
								<td>
									<cfinput type="text" name="year" id="year" maxlength="10" size="20">
								</td>
							</tr>
							<tr>
								<cfquery name="qGetSubject" datasource="#application.dsource#">
									SELECT * 
									FROM filterOption
									WHERE filterType = 'Subject'
									ORDER BY filterName ASC
								</cfquery>
								<td style="font-size: 10px;">
									Art Subject:
								</td>
								<td>
									<select name="artSubjectt" id="artSubjectt" class="chosen-select artSubjectvalue" data-placeholder="Choose art Subject" multiple onchange="artSubjectvalue()">
										<option value="">Search by Subject</option>
										<cfoutput query="qGetSubject">
											<option value="#filterName#">#filterName#</option>
										</cfoutput>
										<!--- <option value="Abstract">Abstract</option>
										<option value="Animals">Animals</option>
										<option value="Animation">Animation</option>
										<option value="Cityscapes">Cityscapes</option>
										<option value="Famous People">Famous People</option>
										<option value="Fantasy">Fantasy</option>
										<option value="Figures">Figures</option>
										<option value="Floral">Floral</option>
										<option value="Inspirational">Inspirational</option>
										<option value="Landscapes">Landscapes</option>
										<option value="Military">Military</option>
										<option value="Music">Music</option>
										<option value="Nudes">Nudes</option>
										<option value="Religious">Religious</option>
										<option value="Seascapes">Seascapes</option>
										<option value="Sports">Sports</option>
										<option value="Still Life">Still Life</option>
										<option value="Text">Text</option>
										<option value="Transportation">Transportation</option> --->
									</select>
									<input type="hidden" name="artSubject" value="" size="100" >
								</td>
							</tr>
							<tr>
								<cfquery name="qGetSize" datasource="#application.dsource#">
									SELECT * 
									FROM filterOption
									WHERE filterType = 'Size'
									ORDER BY id ASC
								</cfquery>

								<td style="font-size: 10px;">
									Art Size:
								</td>
								<td>
									<select name="artSizee" class="chosen-select artSizevalue" data-placeholder="Choose art Size" multiple onchange="artSizevalue()">
										<option value="">Please Select</option>
										<cfoutput query="qGetSize">
											<option value="#filterName#">#filterName#</option>
										</cfoutput>
										<!--- <option value="small">Small (up to 12 inches)</option>
										<option value="medium">Medium (13 to 36 inches)</option>
										<option value="large">Large (37 to 60 inches)</option>
										<option value="Oversized">Oversized (over 60 inches)</option> --->
									</select>
									<input type="hidden" name="artSize" value="" size="100" >
								</td>
							</tr>
						
							<tr>
								<td style="font-size: 10px;">
									Size:
								</td>
								<td>
									<cfinput type="text" name="size" id="size" maxlength="20" size="20">&nbsp;INCHES <span style="color: #ff0000;">(FORMAT: HEIGHT x WIDTH)</span>
								</td>
							</tr>
							
							<tr>
								<td style="font-size: 10px;">
									Edition:
								</td>
								<td>
									<cfinput type="text" name="edition" id="edition" maxlength="20" size="20">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Retail Price:
								</td>
								<td>
									<cfinput type="text" name="retail_price" id="retail_price" maxlength="8" size="20">
								</td>
								
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Gallery Price:
								</td>
								<td>
									<cfinput type="text" name="gallery_price" id="gallery_price" maxlength="8" size="20">									
								</td>
							
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Sale Price:
								</td>
								<td>
									<cfinput type="text" name="special_price" id="special_price" maxlength="8" size="20">
									
									&nbsp;<input type="Checkbox" name="closeout" value="1">&nbsp;Use sale price
									&nbsp;<input type="Checkbox" name="promotion" value="1">&nbsp;Use promotion
									<input type="hidden" name="closeout">
									<input type="hidden" name="promotion"> <br>
									<span style="color: red;">(Sale Price should be less then from Retail and Gallery price)</span> 
									
								</td>
								
							</tr>
							
							<tr>
								<td style="font-size: 10px;">
									Low Estimate:
								</td>
								<td>
									<cfinput type="text" name="low_estimate" id="low_estimate" maxlength="20" size="20">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									High Estimate:
								</td>
								<td>
									<cfinput type="text" name="high_estimate" id="high_estimate" maxlength="20" size="20">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Image Name:
								</td>
								<td>
									<cfinput type="text" name="imageName" id="imageName" size="20" disabled="disabled">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Quantity:
								</td>
								<td>
									<cfinput type="text" name="quantity" id="quantity" maxlength="5" size="5">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Description:
								</td>
								<td>
									<textarea name="caption" id="caption" maxlength="500" cols="50" rows="8" style="font-size: 12px;"></textarea>
									<div id="captionCount" class="mb-3">0 / 500 characters</div>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Active:
								</td>
								<td>
									<input type="radio" name="active" value="1">Active <input type="radio" name="active" value="0">Inactive
									<input type="hidden" name="deactivated" />
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Featured on home page:
								</td>
								<td valign="top">
									<select name="frontshow">
										<option value="0">Don't Show
										<option value="1">Top
										<option value="2">Middle
										<option value="3">Bottom
									</select>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Bottom of home page:
								</td>
								<td>
									<input type="Checkbox" name="family" id="family" value="1">&nbsp;<span style="color: #ff0000;">(maximum TWO of each artist)</span>
									<input type="hidden" name="family" value="">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Slideshow:
								</td>
								<td>
									<input type="Checkbox" name="slideshow" id="slideshow" value="1">
									<input type="hidden" name="slideshow" value="">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Listing Date:
								</td>
								<td valign="top">
									<cfinput type="Text" name="datestamp" id="datestamp" maxlength="25" size="25" disabled class="displayInput" />
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Last Edit:
								</td>
								<td valign="top">
									<cfinput type="Text" name="lastedit" id="lastedit" maxlength="25" size="25" disabled class="displayInput" />
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table border="0" cellpadding="2" cellspacing="0" width="100%">
										<!--- <tr>
											<td colspan="2" width="100%">
												<hr>
											</td>
										</tr>
										<tr><td colspan="2"><strong>TRUMP INFO</strong></td></tr>
										<tr>
											<td width="25%" style="font-size: 10px;" valign="top">Listed on Trump Site:</td>
											<td width="75%">
												<input type="Checkbox" name="location" value="2">
												<input type="hidden" name="location" value="">
											</td>
										</tr>
										<tr>
											<tr>
												<td style="font-size: 10px;" valign="top">Trump Price:</td>
												<td><input type="text" name="location_price"></td>
											</tr>
										</tr>
										<tr>
											<tr>
												<td style="font-size: 10px;" valign="top">Floor:</td>
												<td><input type="text" name="location_floor"></td>
											</tr>
										</tr>
										<tr>
											<tr>
												<td style="font-size: 10px;" valign="top">Wall:</td>
												<td><input type="text" name="location_wall"></td>
											</tr>
										</tr> --->
										<tr>
											<td colspan="2" style="font-size: 10px;" valign="top">Notes:</td>
										</tr>
										<tr>
											<td colspan="2">
												<textarea name="location_notes" id="location_notes" maxlength="500" cols="60" rows="5" value=""></textarea>
												<div id="location_notesCount" class="mb-3">0 / 500 characters</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<hr>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellpadding="2" cellspacing="0" width="100%">
										<tr><td colspan="2"><strong>AUCTION SITE</strong></td></tr>
										<tr>
											<td colspan="2" style="font-size: 10px;">List on Auction Site:&nbsp;&nbsp;
												<input type="Checkbox" name="auction" value="1">
												<input type="hidden" name="auction" value="">
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<hr>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td valign="top">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td id="imageDisplay" height="150">
									<img src="/images/0.gif" name="mainImg" id="mainImg" border="0" width="100"  /><br>
									<a href="" id="clickEnlarge" target="_blank">Click  to enlarge</a><br><br>
								</td>
							</tr>
							<tr>
								<td id="imageUrl"></td>
							</tr>
							<tr>
								<td>
									Upload New:&nbsp;<input type="File" name="thisImage" id="thisImage" accept=".jpg,.jpeg,image/jpeg"/>
								</td>
							</tr>
						</table>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td>
									<iframe src="" id="addImageFrame" frameborder="0" width="200" height="200"></iframe>
								</td>
							</tr>
						</table>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td>
									<input type="button" value="Add Additional Image" id="addImageButton" />
								</td>
							</tr>
							<tr>
								<td>
									<div id="addImageContainer"></div>
								</td>
							</tr>
						</table>
						<br><br><br>
						<table cellspacing="0" cellpadding="3" border="0" width="100%" id="displaySellerInfo" style="display: block;">
							<tr>
								<td colspan="2">
									SELLER INFO
								</td>
							</tr>
							<tr>
								<td>
									First Name:
								</td>
								<td>
									<cfinput type="text" name="fname" id="fname" size="20" disabled class="displayInput">
								</td>
							</tr>
							<tr>
								<td>
									Last Name:
								</td>
								<td>
									<cfinput type="text" name="lname" id="lname" size="20" disabled class="displayInput">
								</td>
							</tr>
							<tr>
								<td>
									Phone:
								</td>
								<td>
									<cfinput type="text" name="phone" id="phone" size="20" disabled class="displayInput">
								</td>
							</tr>
							<tr>
								<td valign="top">
									Emaii:
								</td>
								<td>
									<cfinput type="text" name="email" id="email" size="20" disabled class="displayInput"><br><br>
									<span  id="emailLink"></span>
								</td>
							</tr>

						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table border = "0" width = "100%" cellpadding = "1" cellspacing = "0">
							<tr>
								<td colspan="2">
									<cfinput type="button" name="edit" id="edit" value="Edit"  onclick="editListing();"/>
									<cfinput type="button" name="edit" id="delete" value="Delete" onclick="doEdit('delete');" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</cfform>
		<div id="coaLink"></div>
		<br>
		<div id="orderLink"></div>

		<script>
			function disableButtons(formEl) {
				// ensure real form
				if (!(formEl instanceof HTMLFormElement)) {
					formEl = document.getElementById('editForm');
				}

				// hidden input add karo agar missing hai
				let hiddenEdit = formEl.querySelector('input[name="hiddenEdit"]');
				if (!hiddenEdit) {
					hiddenEdit = document.createElement('input');
					hiddenEdit.type = 'hidden';
					hiddenEdit.name = 'hiddenEdit';
					formEl.appendChild(hiddenEdit);
				}

				// saare submit buttons disable karo aur value copy karo
				var buttons = formEl.querySelectorAll('input[type="submit"]');
				buttons.forEach(function(btn){
					if (btn.disabled !== true) {
						// jo click hua uski value hidden me daal do
						if (document.activeElement === btn) {
							hiddenEdit.value = btn.value; // e.g. Edit or Delete
						}
					}
					btn.disabled = true;
				});
				return true;
			}

			function editListing() {
				console.log('Edit listing function called');
				var form = document.getElementById("editForm");

				var fileInput = form.querySelector('input[name="thisImage"]');
				var additionalImageInputs = form.querySelectorAll('input[type="file"][name^="addImage_"]');

				var fileSizeLimit = 2000000; 
				var allowedExtensions = /(\.jpe?g)$/i;

				function hasAllowedImageExtension(file) {
					return allowedExtensions.test(file.name);
				}

				if (fileInput && fileInput.files.length > 0) {
					var file = fileInput.files[0];
					if (file.size > fileSizeLimit) {
						toastr.warning('Please limit your image file upload to 2MB.', 'Alert!');
						return false; 
					}
					if (!hasAllowedImageExtension(file)) {
						toastr.warning('Only JPG or JPEG files are allowed.', 'Alert!');
						return false; 
					}
				}

				for (var i = 0; i < additionalImageInputs.length; i++) {
					if (additionalImageInputs[i].files.length > 0 && !hasAllowedImageExtension(additionalImageInputs[i].files[0])) {
						toastr.warning('Only JPG or JPEG files are allowed.', 'Alert!');
						return false;
					}
				}

				if (!validEntries(form)) return false;
    			if (!disableButtons(form)) return false;


				var formData = new FormData(form); 

				fetch("/admin/models/art.cfc?method=editListingsFromForm&returnformat=json", {
					method: "POST",
					body: formData
				})
				.then(res => res.json())
				.then(data => {
					console.log('test: ' , data)
					
					if (data.SUCCESS == false) {
						toastr.error(data.MESSAGE);
						return;
					}

					if (data.IMAGEVALIDATIONFAILED == true) {
						toastr.warning(data.MESSAGE, 'Alert!');
					} else {
						toastr.success(data.MESSAGE);
					}

					refreshListingsGrid();
				})
				.catch(err => {
					console.error(err);
					toastr.error('Error occurred.');
				});
			}

			function refreshListingsGrid() {
				if (window.parent && window.parent.ColdFusion && window.parent.ColdFusion.Grid && typeof window.parent.ColdFusion.Grid.refresh === 'function') {
					window.parent.ColdFusion.Grid.refresh('data', true);
					return;
				}

				if (window.opener && window.opener.ColdFusion && window.opener.ColdFusion.Grid && typeof window.opener.ColdFusion.Grid.refresh === 'function') {
					window.opener.ColdFusion.Grid.refresh('data', true);
					return;
				}

				if (window.ColdFusion && ColdFusion.Grid && typeof ColdFusion.Grid.refresh === 'function') {
					ColdFusion.Grid.refresh('data', true);
				}
			}

		</script>


		<script>
			window.additionalImageState = {
				nextIndex: 1,
				maxImages: 5,
				lastUid: null,
				watcherId: null
			};

			function buildAdditionalImageRow(imageIndex) {
				return `
					<div 
						class="additionalImage" 
						id="imageRow_${imageIndex}" 
						style="border:1px solid black; padding:10px; margin-bottom:10px; position:relative;"
					>
						<input 
							type="file" 
							accept=".jpg,.jpeg,image/jpeg" 
							name="addImage_${imageIndex}" 
							id="addImage_${imageIndex}" 
						/>

						<span 
							class="removeImage" 
							data-id="${imageIndex}"
							style="
								position:absolute;
								top:5px;
								right:8px;
								cursor:pointer;
								color:grey;
								font-weight:bold;
								font-size:20px;
							"
							title="Remove"
						>
							&times;
						</span>
					</div>
				`;
			}

			function resetAdditionalImageFields() {
				$("#addImageContainer").empty();
				$("#thisImage").val("");
				window.additionalImageState.nextIndex = 1;
			}

			function startAdditionalImageWatcher() {
				var uidField = document.getElementById("uid");

				if (!uidField || window.additionalImageState.watcherId) {
					return;
				}

				window.additionalImageState.lastUid = uidField.value || "";
				window.additionalImageState.watcherId = window.setInterval(function () {
					var currentUid = uidField.value || "";

					if (currentUid === window.additionalImageState.lastUid) {
						return;
					}

					window.additionalImageState.lastUid = currentUid;
					resetAdditionalImageFields();
				}, 250);
			}

			$(document).ready(function(){
				$(".chosen-select").chosen({
					no_results_text: "Oops, nothing found!"
				})
				// $('.chosen-select').trigger('chosen:updated');
				startAdditionalImageWatcher();

				// $("#addImageButton").click(function(){
				// 	$("#addImageContainer").append("<div class='additionalImage'><input type='File' accept='image/jpeg,image/png' name='addImage_" + window.additionalImageState.nextIndex + "' id='addImage_" + window.additionalImageState.nextIndex + "' /></div>");
				// 	window.additionalImageState.nextIndex ++;
				// });

				$("#addImageButton").click(function () {

					var currentCount = $(".additionalImage").length;

					if (currentCount >= window.additionalImageState.maxImages) {
						toastr.warning('You can upload a maximum of 5 images only.', 'Alert!');
						return false;
					}

					$("#addImageContainer").append(buildAdditionalImageRow(window.additionalImageState.nextIndex));
					window.additionalImageState.nextIndex++;
				});


				// Remove specific image field
				$(document).on("click", ".removeImage", function () {
					var id = $(this).data("id");
					$("#imageRow_" + id).remove();
				});

				
			});
		</script>


		<script>
			function setupCharCounter(textareaId, counterId, maxLength) {
				const textarea = document.getElementById(textareaId);
				const counter = document.getElementById(counterId);

				if (!textarea || !counter) return;

				function updateCount() {
					let currentLength = textarea.value.length;

					// Agar limit cross ho gayi to cut kar do
					if (currentLength > maxLength) {
						textarea.value = textarea.value.substring(0, maxLength);
						currentLength = maxLength;
					}

					counter.textContent = `${currentLength} / ${maxLength} characters`;
				}

				// Update on typing/paste
				textarea.addEventListener("input", updateCount);

				return updateCount;
			}

			// Initialize counters on page load
			document.addEventListener("DOMContentLoaded", function() {
				window.updateCaption = setupCharCounter("caption", "captionCount", 500);
				window.updateNotes  = setupCharCounter("location_notes", "location_notesCount", 500);
				
				// 👇 Yahan initial values ke liye manually call kar do
				if (typeof updateCaption === "function") updateCaption();
				if (typeof updateNotes === "function") updateNotes();
			});
		</script>


		<style>

			.chosen-container.chosen-container-multi {
				width: 263px !important;
			}
		</style>

	</body>
</html>
