// get search values

getFname = function(){
	   var s = ColdFusion.getElementValue('searchFname');
	   return s;
} 

getLname = function(){
	   var s = ColdFusion.getElementValue('searchLname');
	   return s;
}

getEmail = function(){
	   var s = ColdFusion.getElementValue('searchEmail');
	   return s;
}

getAreacode= function(){
	   var s = ColdFusion.getElementValue('searchAreacode');
	   return s;
}

getCity = function(){
	   var s = ColdFusion.getElementValue('searchCity');
	   return s;
}

getState = function(){
	   var s = ColdFusion.getElementValue('searchState');
	   return s;
}
	
	
// get current row id 
function gridChange(thisId) {
	populateForm(thisId);
}

// populate edit form using row id
 function populateForm(thisId){
 	var edit 			= new admin.models.customers();
 	var frm 			= document.forms["editForm"];
 	strCustomer 		= edit.getCustomer(thisId);
	customer_email 		= strCustomer['CUSTOMER_EMAIL'];
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+customer_email+'" style="color: black; text-decoration: none;">[SEND EMAIL]</a>';
	maillist			= strCustomer['MAILLIST'];
	for(i = 0; i < frm.maillist.length; i++){
		if(frm.maillist[i].value == maillist){
			frm.maillist[i].checked = true;
		}
		else{
			frm.maillist[i].checked = false;
		}
	}

	phone = strCustomer['PHONE'];
	cellphone = strCustomer['CELLPHONE'];
	businessphone = strCustomer['BUSINESSPHONE'];
	otherphone = strCustomer['OTHERPHONE'];

	

	if(cellphone && cellphone.trim() !== ""){
		
        $("#phoneNumber").val(cellphone);
        $("#PhoneType").val("Cell Phone");
    }
    else if(phone && phone.trim() !== ""){
        $("#phoneNumber").val(phone);
        $("#PhoneType").val("Home Phone");
    }
    else if(businessphone && businessphone.trim() !== ""){
        $("#phoneNumber").val(businessphone);
        $("#PhoneType").val("Business Phone");
    }
    else if(otherphone && otherphone.trim() !== ""){
        $("#phoneNumber").val(otherphone);
        $("#PhoneType").val("OutsideUS");
    }
    else {
        $("#phoneNumber").val("");
        $("#PhoneType").val('Cell Phone'); // default
    }

	Addresstype = strCustomer['ADDRESSTYPE'];

	for(i = 0; i < frm.Addresstype.options.length; i++){
		if(frm.Addresstype.options[i].value == Addresstype){
			frm.Addresstype.options[i].selected = true;
		}
		else{
			frm.Addresstype.options[i].selected = false;
		}
	}

	if (Addresstype && Addresstype.toLowerCase() === "outside") {
		document.getElementById("stateTextRow").style.display = "";
		document.getElementById("stateDropdownRow").style.display = "none";
	} else {
		document.getElementById("stateTextRow").style.display = "none";
		document.getElementById("stateDropdownRow").style.display = "";

		state = strCustomer['STATE']

		for(i = 0; i < frm.state_dropdown.options.length; i++){
			if(frm.state_dropdown.options[i].value == state){
				frm.state_dropdown.options[i].selected = true;
			}
			else{
				frm.state_dropdown.options[i].selected = false;
			}
		}
	}

	var ta = document.getElementById('comments');
	if (ta) {
		// try common key names (uppercase/lowercase)
		var addDetails = strCustomer['COMMENTS'];
		ta.value = addDetails;
	}

	// update counter immediately after populating
	updateAdditionalDetailsCounter();

	<!--- var td =  $("##PhoneType").val(); --->
	var phoneType = document.getElementById('PhoneType').value
	var formatSign = document.getElementById("formatSign");
	

	if (phoneType === "OutsideUS") {
		formatSign.style.display = "none";
	} else {
		formatSign.style.display = "inline";
	}


}
	
// edit form functions

function doEdit(type) {
	


	var editBtn = document.getElementById('edit');
	var deleteBtn = document.getElementById('delete');
	

    var edit = new admin.models.customers();



    edit.setForm("editForm");
    
    if (type == 'edit'){

		var phone = document.getElementById('phoneNumber').value.trim();
		var phoneType = document.getElementById('PhoneType').value;

		

		if (phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone") {
			// Format: (123) 456-7890
			var phonePattern = /^\(\d{3}\)\s\d{3}-\d{4}$/;
			if (!phonePattern.test(phone)) {
				alert("Please enter phone number in format: (xxx) xxx-xxxx");
				document.getElementById('phoneNumber').focus();
				return false;
			}
		}

		editBtn.disabled = true;
		deleteBtn.disabled = true;
    		
		if ( edit.editCustomerFromForm()) {			

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

			toastr.success('Data is Updated Successfully!');
			ColdFusion.Grid.refresh('data',true);

			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);
		} 
     	else {
			 alert( 'There was a problem in the processing.')
			}
      }
   else if (type == 'delete'){

	 if (!confirm('Delete -- ARE YOU SURE? ')) {
        return false; 
    }

	editBtn.disabled = true;
	deleteBtn.disabled = true;

   	if ( edit.deleteCustomer()) {
         

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
			toastr.success('Data is Deleted Successfully!');
			ColdFusion.Grid.refresh('data',true);

			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);
     } 
     else { alert( 'There was a problem in the processing.')}
      }
	document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';
}




