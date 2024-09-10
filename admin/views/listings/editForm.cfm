<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Untitled Document</title>
</head>

<body>

<cfoutput>
	<link REL="STYLESHEET" TYPE="text/css" HREF="/admin/css/main.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.rawgit.com/harvesthq/chosen/gh-pages/chosen.jquery.min.js"></script>
	<link href="https://cdn.rawgit.com/harvesthq/chosen/gh-pages/chosen.min.css" rel="stylesheet"/>
</cfoutput>

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
	if(frm.uid.value == ''){
		frm.uid.value = 0;
	}
	console.log(frm.uid.value)
	if(frm.name.value == ''){
	alert('You must select a Name.');
	frm.name.focus();
	return false;
	}
	if(frm.manufacturer.value == ''){
	alert('You must select an Artist.');
	frm.manufacturer.focus();
	return false;
	}
	if(frm.path.value == ''){
	alert('You must select a Medium.');
	frm.path.focus();
	return false;
	}
	if(frm.quantity.value == ''){
	alert('You must select a Quantity.');
	frm.quantity.focus();
	return false;
	}
	if(!isValidSize(frm.size.value)){
	alert('You must enter a valid SIZE: only numbers and the letter x');
	frm.size.focus();
	return false;
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

<cfform method="POST" action="/admin/index.cfm?event=listings.procListing" name="editForm" id="editForm"  enctype="multipart/form-data" onsubmit="javascript:return validEntries(document.editForm);">
<cfinput type="hidden" name="uid" id="uid">
<table border = "0" width = "700" cellpadding = "3" cellspacing = "0" class="editBox">
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
						<cfinput type="text" name="name" id="name" size="50">
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
							<option value="#manufacturer#">#ucase(manufacturer)#
							</cfif>
						</cfoutput>
						</select>
						<br><i>Select an artist from dropdown above,<br>
						OR type in a new artist below:</i><br>
						<input type="Text" name="manufacturer" value="" size="35">
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
								<option value="#path#">#left(ucase(path),50)#
							</cfoutput>
						</select>
						<br><i>Select existing medium from dropdown above, and edit if desired,<br>OR type in a new string.
						Make sure subcategories (sub-mediums) are separated by colons, and that the entire string ends with a colon.</i>
						<input type="Text" name="path" value="" size="50">
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
							<option value="Figurative">Figurative</option>
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
						<cfinput type="text" name="year" id="year" size="20">
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
						<select name="artSubjectt" class="chosen-select artSubjectvalue" data-placeholder="Choose art Subject" multiple onchange="artSubjectvalue()">
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
						<cfinput type="text" name="size" id="size" size="20">&nbsp;INCHES <span style="color: #ff0000;">(FORMAT: HEIGHT x WIDTH)</span>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 10px;">
						Edition:
					</td>
					<td>
						<cfinput type="text" name="edition" id="edition" size="20">
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;">
						Retail Price:
					</td>
					<td>
						<cfinput type="text" name="retail_price" id="retail_price" size="20">
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;">
						Gallery Price:
					</td>
					<td>
						<cfinput type="text" name="gallery_price" id="gallery_price" size="20">
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;">
						Sale Price:
					</td>
					<td>
						<cfinput type="text" name="special_price" id="special_price" size="20">&nbsp;<input type="Checkbox" name="closeout" value="1">&nbsp;Use sale price
						<input type="hidden" name="closeout">
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;">
						Low Estimate:
					</td>
					<td>
						<cfinput type="text" name="low_estimate" id="low_estimate" size="20">
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;">
						High Estimate:
					</td>
					<td>
						<cfinput type="text" name="high_estimate" id="high_estimate" size="20">
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
						<cfinput type="text" name="quantity" id="quantity" size="5">
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;" valign="top">
						Description:
					</td>
					<td>
						<textarea name="caption" id="caption" cols="50" rows="8" style="font-size: 12px;"></textarea>
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
						<cfinput type="Text" name="datestamp" id="datestamp"  size="25" disabled class="displayInput" />
					</td>
				</tr>
				<tr>
					<td style="font-size: 10px;" valign="top">
						Last Edit:
					</td>
					<td valign="top">
						<cfinput type="Text" name="lastedit" id="lastedit"  size="25" disabled class="displayInput" />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table border="0" cellpadding="2" cellspacing="0" width="100%">
							<tr>
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
							</tr>
							<tr>
								<td colspan="2" style="font-size: 10px;" valign="top">Notes:</td>
							</tr>
							<tr>
								<td colspan="2">
									<textarea name="location_notes" cols="60" rows="5" value=""></textarea>
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
						<a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge<br><br>
					</td>
				</tr>
				<tr>
					<td id="imageUrl"></td>
				</tr>
				<tr>
					<td>
						Upload New:&nbsp;<input type="File" name="thisImage" id="thisImage" />
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
						<cfinput type="submit" name="edit" id="edit" value="Edit" />
						<cfinput type="submit" name="edit" id="delete" value="Delete" onclick="return confirm('DELETE -- ARE YOU SURE?')" />
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
	$(document).ready(function(){
		$(".chosen-select").chosen({
			no_results_text: "Oops, nothing found!"
		})
		// $('.chosen-select').trigger('chosen:updated');
		var addImageIndex = 1;
  		$("#addImageButton").click(function(){
			$("#addImageContainer").append("<div class='additionalImage'><input type='File' name='addImage_" + addImageIndex + "' id='addImage_" + addImageIndex + "' /></div>");
			addImageIndex ++;
		});
	});
</script>

<style>

.chosen-container.chosen-container-multi {
    width: 263px !important;
}
</style>

</body>
</html>
