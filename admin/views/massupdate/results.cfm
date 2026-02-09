<!--- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript"></script> --->
<cfoutput>
	<link REL="STYLESHEET" TYPE="text/css" HREF="/admin/css/main.css">
	<!--- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript"></script> --->
	<!--- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js" type="text/javascript"></script> --->
	

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script src="https://cdn.rawgit.com/harvesthq/chosen/gh-pages/chosen.jquery.min.js"></script>
	<link href="https://cdn.rawgit.com/harvesthq/chosen/gh-pages/chosen.min.css" rel="stylesheet"/>
	

	<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

</cfoutput>
   <script type="text/javascript">
     document.addEventListener("DOMContentLoaded", function() {
    // Function to toggle checkboxes
		function toggleCheckboxes(toggleId, checkboxClass) {
			var toggleButton = document.getElementById(toggleId);
			if (!toggleButton) return; // Skip if the toggle element does not exist
			var checkboxes = document.querySelectorAll('.' + checkboxClass);
			var isChecked = true;

			toggleButton.addEventListener('click', function(e) {
				e.preventDefault(); // Prevent the default behavior of the link
				isChecked = !isChecked; // Toggle the checked state

				checkboxes.forEach(function(checkbox) {
					checkbox.checked = isChecked; // Set the checked attribute
				});
			});
		}

		// Toggle for 'Active' checkboxes
		toggleCheckboxes('activeToggle', 'activeCheckbox');

		// Toggle for 'ShowSalePrice' checkboxes
		toggleCheckboxes('ShowSalePriceToggle', 'ShowSalePriceCheckbox');

		// Toggle for 'Slideshow' checkboxes
		toggleCheckboxes('SlideshowToggle', 'SlideshowCheckbox');

		// Toggle for 'Frontshow' checkboxes
		toggleCheckboxes('FrontshowToggle', 'FrontshowCheckbox');

		// Toggle for 'BottomHome' checkboxes
		toggleCheckboxes('BottomHomeToggle', 'BottomHomeCheckbox');

		// Toggle for 'BottomHome' checkboxes
		toggleCheckboxes('PromotionToggle', 'PromotionCheckbox');
	});



	 function artTypeesvalue(uid) {
			var selectedArtValues = [];
			var selectedOptions = document.querySelector('select[name="artTypees_' + uid + '"]').selectedOptions;

			for (var i = 0; i < selectedOptions.length; i++) {
				// selectedArtValues.push(selectedOptions[i].value);
				var valueWithId = selectedOptions[i].value;        
				var valueWithoutId = valueWithId.split('_')[0]; 
				selectedArtValues.push(valueWithoutId); 
			}

			// Set the value to the hidden input or another field if needed
			document.querySelector('input[name="artTypee_' + uid + '"]').value = selectedArtValues.join(',');
			
			return true;
		}
	function artSubjectvalue(uid) {
		var selectedArtValues = [];
		var selectedOptions = document.querySelector('select[name="artSubjectt_' + uid + '"]').selectedOptions;

		for (var i = 0; i < selectedOptions.length; i++) {
			
			var valueWithId = selectedOptions[i].value;        
			var valueWithoutId = valueWithId.split('_')[0]; 
			selectedArtValues.push(valueWithoutId); 
		}
		document.querySelector('input[name="artSubject_' + uid + '"]').value = selectedArtValues.join(',');

		return true;
	}


// function artSubjectvalue(uid) {
//     var selectedArtValues = [];
//     var selectedOptions = document.querySelector('select[name="artSubjectt_' + uid + '"]').selectedOptions;

//     for (var i = 0; i < selectedOptions.length; i++) {
//         selectedArtValues.push(selectedOptions[i].value);
//     }

//     // Set the value to the hidden input or another field if needed
//     document.querySelector('input[name="artSubject_' + uid + '"]').value = selectedArtValues.join(',');
    
//     return true;
// }

function artTypesvalue(uid) {
    var selectedArtValues = [];
    var selectedOptions = document.querySelector('select[name="artTypes_' + uid + '"]').selectedOptions;

    for (var i = 0; i < selectedOptions.length; i++) {
        // selectedArtValues.push(selectedOptions[i].value);

			var valueWithId = selectedOptions[i].value;        
			var valueWithoutId = valueWithId.split('_')[0]; 
			selectedArtValues.push(valueWithoutId); 
    }

    // Set the value to the hidden input or another field if needed
    document.querySelector('input[name="artType_' + uid + '"]').value = selectedArtValues.join(',');
    
    return true;
}

function artSizevalue(uid) {
    var selectedArtValues = [];
    var selectedOptions = document.querySelector('select[name="artSizee_' + uid + '"]').selectedOptions;

    for (var i = 0; i < selectedOptions.length; i++) {
        // selectedArtValues.push(selectedOptions[i].value);
		var valueWithId = selectedOptions[i].value;        
		var valueWithoutId = valueWithId.split('_')[0]; 
		selectedArtValues.push(valueWithoutId); 
    }

    // Set the value to the hidden input or another field if needed
    document.querySelector('input[name="artSize_' + uid + '"]').value = selectedArtValues.join(',');
    
    return true;
}



     
   </script>

<script type="text/javascript" >
	$(document).ready(function(){
		$(".chosen-select").chosen({
			no_results_text: "Oops, nothing found!"
		});
		// $('.chosen-select').trigger('chosen:updated');
		var addImageIndex = 1;
  		$("#addImageButton").click(function(){
			$("#addImageContainer").append("<div class='additionalImage'><input type='File' name='addImage_" + addImageIndex + "' id='addImage_" + addImageIndex + "' /></div>");
			addImageIndex ++;
		});
	});
</script>

<cfquery name="qGetType" datasource="#application.dsource#">
	SELECT * 
	FROM filterOption
	WHERE filterType = 'Type'
	ORDER BY filterName ASC
</cfquery>

<cfquery name="qGetStyle" datasource="#application.dsource#">
	SELECT * 
	FROM filterOption
	WHERE filterType = 'Style'
	ORDER BY filterName ASC
</cfquery>

<cfquery name="qGetSize" datasource="#application.dsource#">
	SELECT * 
	FROM filterOption
	WHERE filterType = 'Size'
	ORDER BY filterName ASC
</cfquery>

<cfquery name="qGetSubject" datasource="#application.dsource#">
	SELECT * 
	FROM filterOption
	WHERE filterType = 'Subject'
	ORDER BY filterName ASC
</cfquery>
		<!--- <cfdump var="#getListingsMassUpdate#" abort="true"> --->
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td valign="top">
        	
			<cfform method="post" action="index.cfm?event=massupdate.massUpdateProc" >
				<table border="0" cellspacing="0" cellpadding="2" align="center">
					<tr>
						<td colspan="15">
							<cfoutput>
								<cfif  structKeyExists(form,'groups')>#getListingsMassUpdate.totalrecords#<cfelse>#getListingsMassUpdate.qListings.recordcount#</cfif> listings found
								<cfif structKeyExists(form,'alphaCharNum')> where artist's name starts with the letter <cfoutput>#chr(form.alphaCharNum)#</cfoutput></cfif>
								<cfif  structKeyExists(form,'groups')>
									(from #(page-1)*groups+1# to
								<cfif (getListingsMassUpdate.totalrecords-(page*groups)-page) GT 0> 
										#page*groups#<cfelse>#getListingsMassUpdate.totalrecords#</cfif>)
								</cfif>.
							</cfoutput>
						</td>
					</tr>
					<cfif isDefined('form.number_records') AND form.number_records neq ''>
						<cfset through = form.number_records + 49 />
						<cfif through GT getListingsMassUpdate.qListings.recordcount>
							<cfset through = getListingsMassUpdate.qListings.recordcount />
						</cfif> 
						<tr>
							<td colspan="15">
								<cfoutput>Showing #form.number_records# through #through#</cfoutput>
							</td>
						</tr>
					</cfif>
					<tr>
						<td colspan="3">
							<input type="Button" value="Back To Search" onclick="location.href='index.cfm?event=massupdate'">
						</td>
						<td>
							<span style="font-size: 10px;">(click to uncheck)</span>
						</td>
						<td colspan="11" align="right">
							<!--- check to see if next alphaCharNum is lte value for letter Z --->
							<!---<cfoutput>
							<cfif structKeyExists(form,'groups')>
								<input type="Hidden" name="groups" value="#form.groups#">
								<input type="Hidden" name="alphaCharNum" value="#evaluate(form.alphaCharNum)#" />
								<input type="Hidden" name="page" value="#form.page#">
								
								<cfif form.page GT 1>
									<input type="Submit" name="prev" value="<< PREV">
								</cfif>
								<cfif (getListingsMassUpdate.totalrecords.countall-(page*groups)-page) GT 0>
									<input type="Submit" name="next" value="NEXT >>">
								</cfif>
								
							<cfelse>
								<input type="Submit" value="Update All">
							</cfif>
							</cfoutput>--->
							<input type="Submit" value="Update All">
						</td>
					</tr>
					<tr class="row0">
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Thumbnail')>
							<td>&nbsp;
								
							</td>
						</cfif>
						<td>
							Last Edited
						</td>
						<td>
							Title
						</td>
						<td>
							<a href="" id="activeToggle" style="color: #ffffff;">Active</a>
						</td>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Promotion')>
							<td>
								<!---  Use Promotion --->
								<a href="" id="PromotionToggle" style="color: #ffffff;">Promotion </a>
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'ModelNo')>
						<td>
							Model#
						</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Artist')>
							<td>
								Artist
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Medium')>
							<td>
								Medium
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'SellerInfo')>
							<td>
								Seller Info
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Year')>
							<td>
								Year
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Size')>
							<td>
								Size
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Edition')>
							<td>
								Edition
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Low')>
							<td>
								Low Estimate
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'High')>
							<td>
								High Estimate
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Retail')>
							<td>
								Retail Price
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Gallery')>
							<td>
								Gallery Price
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Sale')>
							<td>
								Sale Price
							</td>
						</cfif>
						<td>
							<a href="" id="ShowSalePriceToggle" style="color: #ffffff;">Show Sale Price</a>
						</td>
						<td>
							Delete
						</td>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'artType')>
							<td>
								Art Style
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'artSize')>
							<td>
								Art Size
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'artSubject')>
							<td>
								Art Subject
							</td>
						</cfif>

						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'artTypee')>
							<td>
								Art Type
							</td>
						</cfif>
						
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'quantity')>
							<td>
								Quantity
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'datestamp')>
							<td>
								Listing Date
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'lastEdit')>
							<td>
								Last Edit
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'location_notes')>
							<td>
								Notes
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'caption')>
							<td>
								Description
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Slideshow')>
							<td>
								<!--- Slide Show --->
								<a href="" id="SlideshowToggle" style="color: #ffffff;">Slide Show</a
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Frontshow')>
							<td>
								<!--- Featured on Home Page --->
								<a href="" id="FrontshowToggle" style="color: #ffffff;">Featured </a>
							</td>
						</cfif>
						<cfif isDefined('form.displayFields') and listFind(form.displayFields,'BottomHome')>
							<td>
								<!--- Bottom on Home Page --->
								<a href="" id="BottomHomeToggle" style="color: #ffffff;">Bottom </a>
							</td>
						</cfif>
						
						<td>
							Update Record
						</td>

					</tr>
					<cfparam name="thisStartrow" default="1">
					<cfparam name="thisMaxrows" default="#getListingsMassUpdate.qListings.recordcount#">
					<cfif isDefined('form.number_records') AND form.number_records neq ''>
						<cfset thisStartrow = form.number_records />
						<cfset thisMaxrows = 49 />
					</cfif>
					<cfif getListingsMassUpdate.qListings.recordcount>
						
						<cfoutput query="getListingsMassUpdate.qListings" startrow="#thisStartrow#" maxrows="#thisMaxrows#">
							<input type="hidden" name="modelno_#uid#" value="#modelno#">
							<cfset this_manufacturer = manufacturer />
							<cfset this_path = path />
							<cfset this_artType = artType />
							<cfset this_artTypee = artTypee />
							<cfset this_artSize = artSize />
							<cfset this_artSubject = artSubject />
							<tr class="#this_row()#">
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Thumbnail')>
									<td>
										<cfif fileexists("http://23.20.226.157/img/thumbnails/#uid#.jpg")>
											<img src="http://23.20.226.157/img/#uid#.jpg?x=randrange(1,99)" alt="#name#" title="#name#" border="0" style="height: 100px; width: 100px;" align="center">
										<cfelse>
											<div align="center" style="padding: 20px;"><strong>NO IMAGE <br>AVAILABLE</strong></div>
										</cfif>
									</td>
								</cfif>
								<td>
									#dateFormat(lastedit)#
								</td>
								<td>
									<cfinput type="Text" name="name_#uid#" value="#name#" size="30" class="massupdate" required="Yes" message="NAME is required">
								</td>
								<td>
									<input type="Checkbox" name="active_#uid#" <cfif active eq 1>checked</cfif> class="activeCheckbox">
								</td>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Promotion')>
									<td >
										<input type="Checkbox" name="Promotion_#uid#" <cfif promotion eq 1>checked</cfif> class="PromotionCheckbox"> 	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'ModelNo')>
									<td>
										#modelno#
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Artist')>
									<td>
										<select name="manufacturer_#uid#" class="massupdate select2">
											<option value="">None</option>
											<cfloop query="getAllArtists">
												<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
												<option value="#HTMLEditFormat(manufacturer)#" <cfif trim(HTMLEditFormat(this_manufacturer)) eq trim(HTMLEditFormat(manufacturer))>selected</cfif>>#HTMLEditFormat(manufacturer)#
												</cfif>
											</cfloop>
										</select>
										
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Medium')>
									<td>
										<select name="path_#uid#" class="massupdate select2">
											<option value="">All
											<cfloop query="getAllMedium">
												<option value="#path#" <cfif trim(this_path) eq trim(path)>selected</cfif>>#path#
											</cfloop>
										</select>
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'SellerInfo')>
									<td style="font-size: 8pt;">
										#full_seller_name#<br>#email#<br>#phone#
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Year')>
									<td>
										<input type="Text" name="specs_#uid#" value="#specs#" size="5" class="massupdate">
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Size')>
									<td>
										<input type="Text" name="overview_#uid#" value="#overview#" size="30" class="massupdate">
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Edition')>
									<td>
										<input type="Text" name="edition_#uid#" value="#edition#" size="10" class="massupdate">
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Low')>
									<td>
										<input type="Text" name="low_estimate_#uid#" value="#low_estimate#" size="10" class="massupdate">
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'High')>
									<td>
										<input type="Text" name="high_estimate_#uid#" value="#high_estimate#" size="10" class="massupdate">
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Retail')>
									<td nowrap>
										$<cfinput type="Text" name="retail_price_#uid#" value="#retail_price#" size="8" class="massupdate" validate="float" message="Please enter a dollar amount into the PRICE field - no $ and no ,">		 	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Gallery')>
									<td nowrap>
										$<cfinput type="Text" name="gallery_price_#uid#" value="#gallery_price#" size="8" class="massupdate" validate="float" message="Please enter a dollar amount into the GALLERY PRICE field - no $ and no ,">		 	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Sale')>
									<td nowrap>
										$<cfinput type="Text" name="special_price_#uid#" value="#special_price#" size="8" class="massupdate" validate="float" message="Please enter a dollar amount into the SALE PRICE field - no $ and no ,">		 	
									</td>
								</cfif>
								<td align="center">
									<input type="checkbox" name="closeout_#uid#" <cfif closeout eq 1>checked</cfif> class="ShowSalePriceCheckbox" />
								</td>
								<td align="center">
									<input type="checkbox" name="delete_#uid#" />
								</td>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'artType')>
									<td>
										

										<cfset artTypeList = ListToArray(getListingsMassUpdate.qListings.artType, ",")>
										<cfset updatedArtTypeWithUid = "">
										<cfloop array="#artTypeList#" index="typesIndex">
											<cfset updatedArtTypeWithUid = ListAppend(updatedArtTypeWithUid, typesIndex & "_" & getListingsMassUpdate.qListings.uid)>
										</cfloop>

										<select name="artTypes_#uid#" class="massupdate chosen-select artTypesvalue" multiple onchange="artTypesvalue('#uid#')">
											<option value="">None</option>
											<cfloop query="qGetStyle">
												<cfif not isnumeric(artType)>
													<cfset filterNameWithId = filterName & "_" & getListingsMassUpdate.qListings.uid>

													<cfset dbvaluesattachedUid = ListToArray(updatedArtTypeWithUid, ",")>
													<cfset isSelected = ListFind(updatedArtTypeWithUid, filterNameWithId)>

													<option value="#filterNameWithId#" <cfif isSelected>selected</cfif>>#filterName#</option>
												</cfif>
											</cfloop>
										</select>

										<input type="hidden" name="artType_#uid#" value="#getListingsMassUpdate.qListings.artType#" size="100" >

									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'artSize')>
									<td>
										

										<cfset artSizeList = ListToArray(getListingsMassUpdate.qListings.artSize, ",")>
										
										<cfset updatedArtSizeWithUid = "">
										<cfloop array="#artSizeList#" index="ArtSizeIndex">
											<cfset updatedArtSizeWithUid = ListAppend(updatedArtSizeWithUid, ArtSizeIndex & "_" & getListingsMassUpdate.qListings.uid)>
										</cfloop>
										<!--- <cfdump var="#updatedArtSizeWithUid#"> --->

										<select name="artSizee_#uid#" class="massupdate chosen-select artSizevalue" multiple onchange="artSizevalue('#uid#')">
											<option value="">None</option>
											<cfloop query="qGetSize">
												<cfif not isnumeric(artSize)>
													<cfset filterNameWithId = filterName & "_" & getListingsMassUpdate.qListings.uid>

													<cfset dbvaluesattachedUid = ListToArray(updatedArtSizeWithUid, ",")>
													<cfset isSelected = ListFind(updatedArtSizeWithUid, filterNameWithId)>

													<option value="#filterNameWithId#" <cfif isSelected>selected</cfif>>#filterName#</option>
												</cfif>
											</cfloop>
										</select>

										<input type="hidden" name="artSize_#uid#" value="#getListingsMassUpdate.qListings.artSize#" size="100" >

									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'artSubject')>
									<td>
										

										<cfset artSubjectList = ListToArray(getListingsMassUpdate.qListings.artSubject, ",")>
										<cfset updatedArtSubjectWithUid = "">
										<cfloop array="#artSubjectList#" index="subjectIndex">
											<cfset updatedArtSubjectWithUid = ListAppend(updatedArtSubjectWithUid, subjectIndex & "_" & getListingsMassUpdate.qListings.uid)>
										</cfloop>

										<select name="artSubjectt_#uid#" class="massupdate chosen-select artSubjectvalue" multiple onchange="artSubjectvalue('#uid#')">
											<option value="">None</option>
											<cfloop query="qGetSubject">
												<cfif not isnumeric(artSubject)>
													<cfset filterNameWithId = filterName & "_" & getListingsMassUpdate.qListings.uid>

													<cfset dbvaluesattachedUid = ListToArray(updatedArtSubjectWithUid, ",")>
													<cfset isSelected = ListFind(updatedArtSubjectWithUid, filterNameWithId)>

													<option value="#filterNameWithId#" <cfif isSelected>selected</cfif>>#filterName#</option>
												</cfif>
											</cfloop>
										</select>
										<input type="hidden" name="artSubject_#uid#" value="#getListingsMassUpdate.qListings.artSubject#" size="100" >

									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'artTypee')>
									<td>
										
										<cfset artTypeeList = ListToArray(getListingsMassUpdate.qListings.artTypee, ",")>
										<cfset updatedartTypeeWithUid = "">
										<cfloop array="#artTypeeList#" index="typeeIndex">
											<cfset updatedartTypeeWithUid = ListAppend(updatedartTypeeWithUid, typeeIndex & "_" & getListingsMassUpdate.qListings.uid)>
										</cfloop>


										<select name="artTypees_#uid#" class="massupdate chosen-select artTypeesvalue" multiple onchange="artTypeesvalue('#uid#')">
											<option value="">None</option>
											<cfloop query="qGetType">
												<cfif not isnumeric(artTypee)>
													<cfset filterNameWithId = filterName & "_" & getListingsMassUpdate.qListings.uid>

													<cfset dbvaluesattachedUid = ListToArray(updatedartTypeeWithUid, ",")>
													<cfset isSelected = ListFind(updatedartTypeeWithUid, filterNameWithId)>

													<option value="#filterNameWithId#" <cfif isSelected>selected</cfif>>#filterName#</option>
												</cfif>
											</cfloop>
										</select>

										<input type="hidden" name="artTypee_#uid#" value="#getListingsMassUpdate.qListings.artTypee#" size="100" >
									</td>
								</cfif>


								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'quantity')>
									<td >
										<input type="number" name="quantity_#uid#" value="#quantity#" size="10" class="massupdate"> 	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'datestamp')>
									<td >
										<input type="text" name="datestamp_#uid#" disabled value="#datestamp#" size="10" class="massupdate"> 	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'lastEdit')>
									<td >
										<input type="text" name="lastEdit_#uid#" disabled value="#lastEdit#" size="10" class="massupdate"> 	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'location_notes')>
									<td >
										<textarea name="location_notes_#uid#" class="massupdate" rows="4" cols="50">#location_notes#</textarea>	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'caption')>
									<td >
										<textarea name="caption_#uid#" class="massupdate" rows="4" cols="50">#caption#</textarea>	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Slideshow')>
									<td >
										<input type="Checkbox" name="Slideshow_#uid#" <cfif Slideshow eq 1>checked</cfif> class="SlideshowCheckbox"> 	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Frontshow')>
									<td >
										<input type="Checkbox" name="Frontshow_#uid#" <cfif Frontshow eq 1>checked</cfif> class="FrontshowCheckbox" > 	
									</td>
								</cfif>
								<cfif isDefined('form.displayFields') and listFind(form.displayFields,'BottomHome')>
									<td >
										<input type="Checkbox" name="BottomHome_#uid#" <cfif family eq 1>checked</cfif> class="BottomHomeCheckbox"> 	
									</td>
								</cfif>
								
								
								<td>
									<!--- <input type="hidden" name="updatedRowRecord_#uid#" value="#uid#"> --->
									<!--- <input type="Submit" name="updatedRowRecord" value="#uid#"> --->
									<button type="Submit" name="updatedRowRecord" value=#uid# >Update</button>
								</td>
							</tr>
						</cfoutput>
					</cfif>
				</cfform>
			</table>
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
		 });
</script>

