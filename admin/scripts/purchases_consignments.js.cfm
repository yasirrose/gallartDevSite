// get search values
	getName = function(){
		   var s = ColdFusion.getElementValue('searchName');
		   return s;
		}
	getEmail = function(){
		   var s = ColdFusion.getElementValue('searchEmail');
		   return s;
		}
	getFromDate = function(){
		   var s = ColdFusion.getElementValue('searchFromDate');
		   return s;
		}
	getToDate = function(){
		   var s = ColdFusion.getElementValue('searchToDate');
		   return s;
		}

	// get current row id 
	function gridChange(thisId) {
		populateForm(thisId);
	}


		
	// populate edit form using row id		
	function populateForm(thisId){
		var edit = new admin.models.purchases_consignments();
		var frm = document.forms["editForm"];
		strPurchasesConsignments = edit.getPurchasesConsignmentsFromId(thisId);
		medium = strPurchasesConsignments['MEDIUM'];


		phoneType = strPurchasesConsignments['PHONETYPE'];
		
		<!--- image = strPurchasesConsignments['IMAGE_NAME']; --->

		var images = strPurchasesConsignments['IMAGE_NAME'].split(',');

		for(i = 0; i < frm.medium.options.length; i++){
			if(frm.medium.options[i].value == medium){
				frm.medium.options[i].selected = true;
			}
			else{
				frm.medium.options[i].selected = false;
			}
		}

		for(i = 0; i < frm.PhoneType.options.length; i++){
			if(frm.PhoneType.options[i].value == phoneType){
				frm.PhoneType.options[i].selected = true;
			}
			else{
				frm.PhoneType.options[i].selected = false;
			}
		}

		

		var imageDisplay = document.getElementById('imageDisplay');
		imageDisplay.innerHTML = '';


		images.forEach(function(image, index) {
			var imgElement = document.createElement('img');
			imgElement.src = 'http://23.20.226.157/purchases_consignments/images/' + image;
			imgElement.border = "0";
			imgElement.width = "100";
			<!--- imgElement.style.marginRight = "10px"; --->

			var linkElement = document.createElement('a');
			linkElement.href = 'http://23.20.226.157/purchases_consignments/images/' + image + '?' + new Date().getTime();
			linkElement.target = "_blank";
			linkElement.innerText = "Click to enlarge";

			<!--- var brElement = document.createElement('br'); --->

			var divElement = document.createElement('div');
			divElement.classList.add('image-container');

			// Append elements to the container
			<!--- imageDisplay.appendChild(imgElement); --->
			<!--- imageDisplay.appendChild(brElement); --->
			<!--- imageDisplay.appendChild(linkElement); --->
			<!--- imageDisplay.appendChild(document.createElement('br')); --->
			<!--- imageDisplay.appendChild(document.createElement('br')); --->

			// Append the img and link to the div
			divElement.appendChild(imgElement);
			divElement.appendChild(linkElement);
			
			// Append the div to the image display container
			imageDisplay.appendChild(divElement);
		});

		 var ta = document.getElementById('additional_details');
			if (ta) {
				// try common key names (uppercase/lowercase)
				var addDetails = strPurchasesConsignments['ADDITIONAL_DETAILS'];
				ta.value = addDetails;
			}

			// update counter immediately after populating
			updateAdditionalDetailsCounter();

	}

	

	function doEdit(type) {
		
		var edit = new admin.models.purchases_consignments();
		edit.setForm("editForm");
		
		if (type == 'edit'){

			var phone = document.getElementById('phone').value.trim();
			var phoneType = document.getElementById('PhoneType').value;
			var fname = document.getElementById('fname').value;
			var lname = document.getElementById('lname').value;
			var name = document.getElementById('name').value;

			

			if (phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone") {
				// Format: (123) 456-7890
				var phonePattern = /^\(\d{3}\)\s\d{3}-\d{4}$/;
				if (!phonePattern.test(phone)) {
					alert("Please enter phone number in format: (xxx) xxx-xxxx");
					document.getElementById('phone').focus();
					

					return false;
				}
			}

			if (fname === '' && lname === '' && name === '') {
				alert('Please Add the Name.');
				document.getElementById('fname').focus();
				return false;
			}

			
				
			if ( edit.editPurchasesConsignmentsFromForm()) {
				ColdFusion.Grid.refresh('data',true);

				toastr.options = {
					"closeButton": true,
					"debug": false,
					"newestOnTop": true,
					"progressBar": true,
					"positionClass": "toast-center",
					"preventDuplicates": false,
					"onclick": null,
					"showDuration": "300",
					"hideDuration": "1000",
					"timeOut": "3000",
					"extendedTimeOut": "1000",
					"showEasing": "swing",
					"hideEasing": "linear",
					"showMethod": "fadeIn",
					"hideMethod": "fadeOut"
				};

				toastr.success('Record is updated Successfully'); 
			} 
			else { 
				alert( 'There was a problem in the processing.');
				 	
			}

		}
		else if (type == 'delete') {
			
			if ( edit.deletePurchasesConsignments()) {
			ColdFusion.Grid.refresh('data',true);
			
			toastr.options = {
				"closeButton": true,
				"debug": false,
				"newestOnTop": true,
				"progressBar": true,
				"positionClass": "toast-center",
				"preventDuplicates": false,
				"onclick": null,
				"showDuration": "300",
				"hideDuration": "1000",
				"timeOut": "3000",
				"extendedTimeOut": "1000",
				"showEasing": "swing",
				"hideEasing": "linear",
				"showMethod": "fadeIn",
				"hideMethod": "fadeOut"
			};

			toastr.success('Record is Deleted Successfully'); 
			} 
			else { 
				alert( 'There was a problem in the processing.');				
			}

		}
			
		document.getElementById('edit').value = 'Edit';
		document.getElementById('delete').style.display = '';
	}
  
	function showNew () {
		document.getElementById('pk_purchases_consignments').value = '';
		document.getElementById('name').value = '';
		document.getElementById('phone').value = '';
		document.getElementById('email').value = '';
		document.getElementById('artist').value = '';
		document.getElementById('title').value = '';
		document.getElementById('size').value = '';
		document.getElementById('additional_details').value = '';
		document.getElementById('edit').value = 'Add';
		document.getElementById('delete').style.display = 'none';
	}
 

 
 
