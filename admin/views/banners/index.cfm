<cfajaxproxy cfc="admin.models.banners" />
<cfajaxproxy bind="javascript:gridChangeFilter({data.id})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/banners.js.cfm" language="JavaScript"></script>'>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>


		
    <!--- <cfif isDefined('form.actionType') and form.actionType eq 'Add'>
        <cftry>    
			 <!--- Save banner details into the database --->            
            <cfquery name="qSaveData" datasource="#application.dsource#">
                INSERT INTO banners (
                    bannerName,
                    bannerImagesUrl,
                    bannerType,
					active
                )
                VALUES (
                    <cfqueryparam value="#form.bannerName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#form.bannerImagesUrl#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#form.bannerType#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#form.active#" cfsqltype="cf_sql_varchar">
                )
                SELECT @@identity as newId
            </cfquery>
            <cfset thisId = qSaveData.newId />

			<cfset moduleName = 'Banners Module'>
			<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
			<cfset date = now()>				
			<cfset action = 'Insert'>

			<cfquery name="addLog" datasource="#application.dsource#" >
				INSERT INTO logs 
					( moduleName, ipAddress, date, action)
					VALUES
					( '#moduleName#', '#ipAddress#', #date#, '#action#')
			</cfquery>
    
           <!--- Upload Image and Save to Directory --->
            <cfif len(form.bannerImage)>

				<cfset path = "#application.ppath#/images/banners/" />
				
				<cffile 
					action="upload" 
					nameconflict="overwrite" 
					filefield="bannerImage" 
					destination="#path#" 
					result="fileupload">

					<cfset fileExt = lcase(fileupload.clientFileExt) >


				<cfif fileupload.fileWasSaved AND (fileExt EQ "jpg" OR fileExt EQ "png")>                    
					<cfset fileName = fileupload.CLIENTFILE />
					<cfquery name="qUpdateImage" datasource="#application.dsource#">
						UPDATE banners
						SET bannerImage = <cfqueryparam value="#fileName#" cfsqltype="cf_sql_varchar">
						WHERE id = <cfqueryparam value="#thisId#" cfsqltype="cf_sql_integer">
					</cfquery>

					<cfelse>
						<cffile action="delete" file="#fileupload.serverDirectory#/#fileupload.serverFile#">
						<cfset session.ext = true>
				</cfif>
				
            </cfif>
    
            <cfoutput>
                <script>
					// alert('Data Added Successfully!');
					// toastr.success('Data Updated Successfully');                 

					<cfif structKeyExists(session, "ext") AND session.ext EQ true>
						toastr.error("Invalid image format. Only JPG and PNG allowed.");
					<cfelse>
						toastr.success("Data Updated Successfully");
					</cfif>

                </script>
            </cfoutput>

			<cfif structKeyExists(session, "ext")>
				<cfset structDelete(session, "ext")>
			</cfif>
            
            <cfcatch>
                <cfdump var="#cfcatch#" abort="true">
            </cfcatch>
        </cftry>
    </cfif>
    

	<cfif isDefined('form.actionType') and form.actionType eq 'Edit'>

		<cftry>    
			<!--- Update banner details in the database --->			
			<cfquery name="qUpdateData" datasource="#application.dsource#">
				UPDATE banners
				SET
					bannerName = <cfqueryparam value="#form.bannerName#" cfsqltype="cf_sql_varchar">,
					bannerType = <cfqueryparam value="#form.bannerType#" cfsqltype="cf_sql_varchar">,
					bannerImagesUrl = <cfqueryparam value="#form.bannerImagesUrl#" cfsqltype="cf_sql_varchar">,
					active = <cfqueryparam value="#form.active#" cfsqltype="cf_sql_varchar">
				WHERE id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfset moduleName = 'Banners Module'>
			<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
			<cfset date = now()>				
			<cfset action = 'Update'>

			<cfquery name="addLog" datasource="#application.dsource#" >
				INSERT INTO logs 
					( moduleName, ipAddress, date, action)
					VALUES
					( '#moduleName#', '#ipAddress#', #date#, '#action#')
			</cfquery>
			
			<!--- Handle image upload if a file is provided --->
			<cfif len(form.bannerImage)>
				<cfset path = "#application.ppath#/images/banners/" />
				
				<cffile 
					action="upload" 
					nameconflict="overwrite" 
					filefield="bannerImage" 
					destination="#path#" 
					result="fileupload">

					<cfset fileExt = lcase(fileupload.clientFileExt) >
	
				<cfif fileupload.fileWasSaved AND (fileExt EQ "jpg" OR fileExt EQ "png")>                    
					<cfset fileName = fileupload.CLIENTFILE />
					<cfquery name="qUpdateImage" datasource="#application.dsource#">
						UPDATE banners
						SET bannerImage = <cfqueryparam value="#fileName#" cfsqltype="cf_sql_varchar">
						WHERE id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer">
					</cfquery>

				<cfelse>
					<cffile action="delete" file="#fileupload.serverDirectory#/#fileupload.serverFile#">
					<cfset session.ext = true>

				</cfif>
				

			</cfif>
	
			<cfoutput>
				<script>
					// alert('Data Updateddd Successfully!');

					<cfif structKeyExists(session, "ext") AND session.ext EQ true>
						toastr.error("Invalid image format. Only JPG and PNG allowed.");
					<cfelse>
						toastr.success("Data Updated Successfully");
					</cfif>

					// toastr.success('Data Updated Successfully');
				</script>
			</cfoutput>

			<cfif structKeyExists(session, "ext")>
				<cfset structDelete(session, "ext")>
			</cfif>
			
			<cfcatch>
				<cfdump var="#cfcatch#" abort="true">
			</cfcatch>
		</cftry>
	</cfif> --->

    
    

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
	<tr>
		<td valign="top">
			<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">

				<tr>
					<td valign="top" width="400">
						<cfform name="gridForm">
							<table cellspacing="0" cellpadding="1" border="0" width="100%">
								<tr style="display:none;">
									<td align="right">
										<strong>Filter Name:</strong>
									</td>
									<td>
										<cfinput name="searchLname" size="30" />
									</td>
									<td>&nbsp;</td>
								</tr>	
								<tr>
									<td colspan="3">
										<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.banners.getBannerRecord({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
											<cfgridcolumn name="bannerName" header="Banner Name" width="100">
											<cfgridcolumn name="bannerType" header="Banner Type" width="100">
											<cfgridcolumn name="bannerImage" header="Banner Image" width="100">
											<cfgridcolumn name="active" header="Active" width="100">
										</cfgrid>
									</td>
								</tr>
							</table>
						</cfform>
						
						<cfquery name="qGetBanner" datasource="#application.dsource#">
							SELECT *
							FROM banners
						</cfquery>
						

					</td>
					<td valign="top">
						<!--- <cfif session.userinfo.sa EQ 1 OR session.userinfo.email EQ 'waseemgallart@gmail.com'> --->
							<input type="button" value="New" onclick="showNew()">
						<!--- </cfif> --->
						<cfform name="editForm" action="" enctype="multipart/form-data">
							<cfinput type="hidden" name="id" id="id" bind="{data.id}">
							<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
								<tr>
									<td id="stuff" colspan="2"></td>
								</tr>
								<tr>
									<td width="100">
										Banner Name:
										<br>
										<cfinput type="text" name="bannerName" id="bannerName" bind="{data.bannerName}" size="30" required="true" message="Please enter Banner Name.">
									</td>
									<td>
										Banner Type:
										<br>
										<cfinput type="text" name="bannerType" id="bannerType"  bind="{data.bannerType}" size="30" required="true" message="Please enter Banner Type.">
									</td>
								</tr>
								<!--- <tr>
									<td>
										Banner Type:
									</td>
									<td>
										<cfinput type="text" name="bannerType" id="bannerType" maxlength="30"  bind="{data.bannerType}" size="30" required="true" message="Please enter Banner Type.">
							
									</td>
								</tr> --->
								<tr>
									<td>
										Banner image URL:
										<br>
										<cfinput type="text"  name="bannerImagesUrl" id="bannerImagesUrl"  bind="{data.bannerImagesUrl}" size="30" >
									</td>
									<td>
										Active:
										<br>
										<cfinput type="hidden"  name="activeValue" id="activeValue"  bind="{data.active}"  >
										<select name="active" id="active" style="height:18px; width: 178px;" >
											<option value="">Please Select</option>
											<option value="Yes">Yes</option>
											<option value="No">No</option>
										</select>
									</td>
								</tr>
								<!--- <tr>
									<td>
										Active:
									</td>
									<td>
										<cfinput type="hidden"  name="activeValue" id="activeValue"  bind="{data.active}"  >
										<select name="active" id="active" style="height:18px; width: 178px;" >
											<option value="">Please Select</option>
											<option value="Yes">Yes</option>
											<option value="No">No</option>
										</select>
									</td>
								</tr> --->
								<tr>
									<td>
										Banner Image:
										<br>
										<cfinput type="text" disabled name="bannerImages" id="bannerImages"  bind="{data.bannerImage}" size="30" >
									</td>
									<td>										
										Choose Image:
										<br>
										<input type="File" name="bannerImage" id="bannerImage" onchange="validateImage()"/>			
										<span id="fileError" style="color:red;"></span>
									</td>
									
								</tr>
								<tr>
									<!--- <td>
										Note:
									</td> --->
									<td>
										Note:
										<br>
										<p class="upload-guidelines">
											<strong>Recommended Image Size:</strong><br>
											Dimention: 1145 x 400 pixels<br>
											Maximum File Size: 300 KB<br>
											Accepted Formats: JPG, PNG
										</p>
									</td>
								</tr>
								<tr>
									
									<td id="imageDisplay" height="150">
										<cfoutput>
											<img src="/images/banners/empty.png" name="mainImg" id="mainImg" border="0" width="200"  /><br>
										</cfoutput>
										<!--- <a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge<br><br> --->
									</td>
								</tr>
								<!--- <tr>
									<td>
										
									</td>
									<td id="imageDisplay" height="150">
										<cfoutput>
											<img src="/images/banners/empty.png" name="mainImg" id="mainImg" border="0" width="200"  /><br>
										</cfoutput>
										<!--- <a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge<br><br> --->
									</td>
								</tr> --->
								<input type="hidden" name="actionType" id="actionType" value="">
								
								<tr>
									<td colspan="2" style="display: flex;">
										<cfif session.userinfo.sa EQ 1 OR session.userinfo.email EQ 'waseemgallart@gmail.com'>
											<cfset buttonStyle = "">
											<cfset deleteChecck = "1">
											
										<cfelse>
											<cfset buttonStyle = "display:none;">
											<cfset deleteChecck = "">

										</cfif>
										<cfinput type="hidden" value="#deleteChecck#" name="deleteCheck" id="deleteCheck" >
										<!--- <cfinput type="submit" name="edit" id="Add" value="Add"  style="display:none;" />
										<cfinput type="submit" name="edit" id="edit" value="Edit"  onclick="doEdit('edit');" style="#buttonStyle#" /> --->
										

										<!--- <cfinput type="button" name="add_btn" id="Add" value="Add" onclick="return handleAction(this,'Add');" style="display:none;" />
										<cfinput type="button" name="edit_btn" id="edit" value="Edit" onclick="return handleAction(this,'Edit');" style="#buttonStyle#" /> --->
											
										<cfinput type="button" name="edit" id="edit" value="Edit"  onclick="editListing();"/>
										<cfinput type="button" name="delete" id="delete" value="Delete" onclick="return confirmDelete();"  />
									</td>			
								</tr>
							</table>
						</cfform>
					</td>
				</tr>
			</table>
			<script>
				document.addEventListener('DOMContentLoaded', function() {
					setTimeout(function() {
						// Assuming the bannerImage value is set as a hidden field or directly fetched
						var bannerImage = document.getElementById('bannerImages').value;

						if (bannerImage) {
							document.getElementById('mainImg').src = "/images/banners/" + bannerImage;
						} else {
							console.log("Banner image value is not defined.");
						}
					}, 1000);
				});
				function doEdit(type) {

					// Debug (use console.log instead of cfdump)
					// console.log(type);

					var filterName = document.getElementById('bannerName').value.trim();
					var filterType = document.getElementById('bannerType').value.trim();

					var edit = new admin.models.banners();
					edit.setForm("editForm");

					if (type === 'edit') {
						if (filterName === '' || filterType === '') {
							alert('Please fill out all fields.');
							return;
						}

						
						// call edit method here if required
						// edit.updateEmployee();

					} 
					else if (type === 'delete') {

						var result = edit.deleteEmployee();

						console.log('test result' , result)
						// return false;

						if (result.SUCCESS === true) {
							alert(result.MESSAGE);
							ColdFusion.Grid.refresh('data', true);
						} else {
							alert(result.MESSAGE);
						}

					} 
					else {
						alert('There was a problem in the processing.');
					}

					document.getElementById('edit').value = 'Edit';
					document.getElementById('delete').style.display = '';
				}

				function confirmDelete() {
					if (confirm('DELETE -- ARE YOU SURE?')) {
						doEdit('delete');
						return true; // allow form submit or your custom logic
					} else {
						return false; // stop form submit if cancel pressed
					}
				}

				function validateImage() {
					var fileInput = document.getElementById('bannerImage');
					var filePath = fileInput.value;
					var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
					var errorElement = document.getElementById('fileError');
					var maxSize = 300 * 1024;

					if (!allowedExtensions.exec(filePath)) {
						errorElement.innerHTML = 'Please upload a file with .jpg or .png extension only.';
						fileInput.value = '';
						return false;
					} 

					if(fileInput.files && fileInput.files[0].size > maxSize) {
						errorElement.innerHTML = 'Please upload an image smaller than 300 KB.';
						fileInput.value = '';
						return false;
					}
					errorElement.innerHTML = '';
					return true;
				}

				// var formSubmitted = false;

				// function handleAction(btn, action) {
				// 	console.log('handleAction');
				// 	var form = btn.form || document.forms['editForm'];
				// 	if (!form) return false;

				// 	// Run HTML5 validation first (if any required fields exist)
				// 	if (typeof form.checkValidity === 'function' && !form.checkValidity()) {
				// 		if (typeof form.reportValidity === 'function') form.reportValidity();
				// 		return false;
				// 	}
				// 	console.log('handleActionww');
				// 	// if (formSubmitted) return false;
				// 	// formSubmitted = true;

				// 	// Set hidden 'edit' field so CF receives the action (preserves existing server checks)
				// 	var editField = document.getElementById('actionType');
				// 	if (editField) editField.value = action;

				// 	var bannerName = document.getElementById('bannerName').value.trim();
				// 	var bannerType = document.getElementById('bannerType').value.trim();
				// 	console.log('handleActionwww');
				// 	if(bannerName == ''){
				// 		alert('Please add Banner Name');
				// 		console.log('test1');
				// 		return false;
				// 	} else if(bannerType == ''){
				// 		alert('Please add Banner Type');
				// 		console.log('test2');
				// 		return false;
				// 	} else {
				// 		try {
				// 			btn.disabled = true;
				// 			btn.value = action + 'ing...';
				// 			console.log('test3');
				// 		} catch(e) {}
				// 	}
				// 	console.log('handleActionw');
				// 	// Disable & give feedback
					

				// 	// Disable all other buttons to prevent double-clicks
				// 	var elems = form.querySelectorAll('input[type=submit], input[type=button], button');
				// 	elems.forEach(function(el){ el.disabled = true; });

				// 	// Small delay to ensure DOM updates, then submit the form programmatically
				// 	setTimeout(function(){
				// 		if (typeof form.requestSubmit === 'function') {
				// 			form.requestSubmit(); // better for HTML5 submit handling when available
				// 		} else {
				// 			form.submit();
				// 		}
				// 	}, 10);

				// 	return false;
				// }


				function editListing() {
					var form = document.getElementById("editForm");

					var bannerName = document.getElementById('bannerName').value.trim();
					var bannerType = document.getElementById('bannerType').value.trim();
					

					var fileInput = form.querySelector('input[name="bannerImage"]');

					var fileSizeLimit = 2000000;
					var allowedTypes = ['image/jpeg', 'image/png'];
    				var allowedExtensions = ['jpg', 'jpeg', 'png']; 

					if (fileInput && fileInput.files.length > 0) {
						var file = fileInput.files[0];

						// Check file size
						if (file.size > fileSizeLimit) {
							alert("Please limit your image file upload to 2MB.");
							return false;
						}

						// Check MIME type
						if (!allowedTypes.includes(file.type)) {
							alert("Only JPG and PNG images are allowed.");
							return false;
						}

						// Optional: extra safety check using file extension
						var fileName = file.name.toLowerCase();
						var fileExtension = fileName.split('.').pop();

						if (!allowedExtensions.includes(fileExtension)) {
							alert("Only JPG and PNG images are allowed.");
							return false;
						}
					}

					const validateField = (value, id, message) => 
					value === '' ? (alert(message), document.getElementById(id).focus(), false) : true;

					// Validate required fields
					if (!validateField(bannerName, 'bannerName', 'Banner Name is required.')) return false;
					if (!validateField(bannerType, 'bannerType', 'Banner Type is required.')) return false;

					// if (!validEntries(form)) return false;
					// if (!disableButtons(form)) return false;


					var formData = new FormData(form); 

					

					fetch("/admin/models/banners.cfc?method=updateBanner&returnformat=json", {
						method: "POST",
						body: formData
					})
					.then(res => res.json())
					.then(data => {
						console.log('test: ' , data)
						
						if (data.SUCCESS == false) {
							alert(data.MESSAGE);
							return;
						}

						alert(data.MESSAGE);

						
						window.location = "index.cfm?event=banners";
					})
					.catch(err => {
						console.error(err);
						alert("Error occurred.", err);
					});
				}

			</script>
