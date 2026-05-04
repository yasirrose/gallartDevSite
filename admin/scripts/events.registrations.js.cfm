//
getLname = function(){
	   var s = ColdFusion.getElementValue('searchLname');
	   return s;
	}
getEmail = function(){
	   var s = ColdFusion.getElementValue('searchEmail');
	   return s;
	}
getEventTitle = function(){
	   var s = ColdFusion.getElementValue('searchEventTitle');
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
 	var edit 		= new admin.models.events();
 	var frm 		= document.forms["editForm"];
 	strRegistration	= edit.getRegistration(thisId);
	consignment_form = strRegistration['CONSIGNMENT_FORM'];
	for(i = 0; i < frm.consignment_form.length; i++){
		if(frm.consignment_form[i].value == consignment_form){
			frm.consignment_form[i].checked = true;
		}
		else{
			frm.consignment_form[i].checked = false;
		}
	}
}
  
function doEdit(type) {

	var editBtn = document.getElementById('edit');
	var deleteBtn = document.getElementById('delete');

	var fname = document.getElementById('fname').value;
	var lname = document.getElementById('lname').value;
	var email = document.getElementById('email').value;

    var edit = new admin.models.events();
    edit.setForm("editForm");
    
    if (type == 'edit'){

		const validateField = (value, id, message) => 
		value === '' ? (toastr.error(message), document.getElementById(id).focus(), false) : true;

		// Validate required fields
		if (!validateField(fname, 'fname', 'First Name is required.')) return false;
		if (!validateField(lname, 'lname', 'Last Name is required.')) return false;

		// Email validation
		if (!validateField(email, 'email', 'Email is required.')) return false;

		const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		if (!emailPattern.test(email)) 
			return (toastr.error('Please enter a valid email address.'), document.getElementById('email').focus(), false); 

		editBtn.disabled = true;
		deleteBtn.disabled = true;

		result = edit.editRegistrationsFromForm();
    		
		if ( result.SUCCESS === true) {

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

			
			toastr.success(result.MESSAGE);
			ColdFusion.Grid.refresh('data',true);

			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);

		} 
     	else { 
			alert( result.MESSAGE)
				editBtn.disabled = false;
				deleteBtn.disabled = false;
		}
    }
   else {
	
		if (!confirm('Delete -- ARE YOU SURE? ')) {
				return false; 
			}

		editBtn.disabled = true;
		deleteBtn.disabled = true;

		if ( edit.deleteEvent()) {

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

			toastr.success(result.MESSAGE); 
			ColdFusion.Grid.refresh('data',true);

			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);
		} 
     	else { 
			alert( result.MESSAGE)
				editBtn.disabled = false;
				deleteBtn.disabled = false;
		}
    }
      
	document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';
}

