// get search values

getLname = function(){
	   var s = ColdFusion.getElementValue('searchLname');
	   return s;
}
getEmail = function(){
	   var s = ColdFusion.getElementValue('searchEmail');
	   return s;
}
	
// get current row id 
function gridChange(thisId) {
	populateForm(thisId);
}

// populate edit form using row id
 function populateForm(thisId){
 	var edit = new admin.models.employees();
 	var frm = document.forms["editForm"];
 	strEmployee = edit.getEmployeeFromId(thisId);
	emp_email = strEmployee['EMP_EMAIL'];
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+emp_email+'" style="color: black; text-decoration: none;">[SEND EMAIL]</a>';
	roles = strEmployee['ROLES'];
	for(i = 0; i < frm.roles.length; i++){
		frm.roles[i].checked = false;
		if (typeof roles.split != 'undefined'){
			rolesArray = roles.split(',');
			for(ii = 0; ii < rolesArray.length; ii++){
				if(frm.roles[i].value == rolesArray[ii]){
					frm.roles[i].checked = true;
				}
			}
		}
		else{
			if(frm.roles[i].value == roles){
				frm.roles[i].checked = true;
			}
		}
	}

	document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';
}
	
// edit form functions

function doEdit(type) {

	  var fname = document.getElementById('emp_fname').value.trim();
	  var lname = document.getElementById('emp_lname').value.trim();
	  var email = document.getElementById('emp_email').value.trim();
	  var password = document.getElementById('password').value.trim();
	  var commission_minus = document.getElementById('commission_minus').value.trim();
	  var commission_percent = document.getElementById('commission_percent').value.trim();

	  var editBtn = document.getElementById('edit');
	  var deleteBtn = document.getElementById('delete');

    var edit = new admin.models.employees();

    edit.setForm("editForm");
    
   if (type == 'edit') {

		if (fname === '') {
			alert('First Name is required.');
			document.getElementById('emp_fname').focus();
			return false;
		}

		if (lname === '') {
			alert('Last Name is required.');
			document.getElementById('emp_lname').focus();
			return false;
		}

		if (!email === '') {			
			// Simple email format check using regex
			var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailPattern.test(email)) {
				alert('Please enter a valid email address.');
				document.getElementById('emp_email').focus();
				return false;
			}
		}

		if (password === '') {
			alert('Password is required.');
			document.getElementById('password').focus();
			return false;
		} 
		<!--- else {
			
			var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
			if (!passwordPattern.test(password)) {
				toastr.error('Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.');
				document.getElementById('password').focus();
				return false;
			}
		} --->

		if (!/^\d+(\.\d+)?$/.test(commission_minus)) {
			alert("Only numeric value allowed (integer or decimal).");
			document.getElementById('commission_minus').focus();
			return false;
		}
		
		if (!/^[0-9]+$/.test(commission_percent)) {
			alert("Only numeric value allowed.");
			return false;
		}

		editBtn.disabled = true;
		deleteBtn.disabled = true;

        var result = edit.editEmployeeFromForm(); 

		console.log('test emp: ',result);

        if (result.SUCCESS == true) {
				
            
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
			ColdFusion.Grid.refresh('data', true);

			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);

        } else {
            alert(result.MESSAGE);

				editBtn.disabled = false;
				deleteBtn.disabled = false;				
        }
    }
   else if (type == 'delete'){
		if (!confirm('Delete -- ARE YOU SURE? ')) {
			return false; 
		}

		editBtn.disabled = true;
		deleteBtn.disabled = true;

		var result = edit.deleteEmployee(); 

		if ( result.SUCCESS == true) {

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
	<!--- document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = ''; --->

	<!--- if (document.getElementById('pk_employees').value === '') {
		document.getElementById('edit').value = 'Add';
		document.getElementById('delete').style.display = 'none';
	} else{
		document.getElementById('edit').value = 'Edit';
		document.getElementById('delete').style.display = ''; 
	} --->

	const hasId = document.getElementById('pk_employees').value !== '';

    document.getElementById('edit').value = hasId ? 'Edit' : 'Add';
    document.getElementById('delete').style.display = hasId ? '' : 'none';
}

// clear all fields when new is clicked

function showNew () {
   	<!--- document.getElementById('pk_employees').value = '';
   	document.getElementById('emp_fname').value = '';
   	document.getElementById('emp_lname').value = '';
   	document.getElementById('emp_email').value = '';
	document.getElementById('emp_phone').value = '';
	document.getElementById('password').value = '';
	document.getElementById('commission_minus').value = '0';
	document.getElementById('commission_percent').value = '0';
   	document.getElementById('edit').value = 'Add';
   	document.getElementById('delete').style.display = 'none';
	for(i = 0; i < document.editForm.roles.length; i++){
		document.editForm.roles[i].checked = false;
	} --->

	['pk_employees', 'emp_fname', 'emp_lname', 'emp_email', 'emp_phone', 'password','commission_minus','commission_percent']
        .forEach(id => document.getElementById(id).value = '');

		document.getElementById('edit').value = 'Add';
    	document.getElementById('delete').style.display = 'none';

		Array.from(document.editForm.roles).forEach(role => role.checked = false);


}
	
