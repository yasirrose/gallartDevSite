// get search values

getLname = function(){
	   var s = ColdFusion.getElementValue('searchLname');
	   return s;
}
getEmail = function(){
	   var s = ColdFusion.getElementValue('searchEmail');
	   return s;
}
getTitle = function(){
	   var s = ColdFusion.getElementValue('searchTitle');
	   return s;
}
getArtist = function(){
	   var s = ColdFusion.getElementValue('searchArtist');
	   return s;
}
getListed = function(){
	   var s = ColdFusion.getElementValue('searchListed');
	   return s;
}

// get current row id 
function gridChange(thisId) {
	populateForm(thisId);
}

// populate edit form using row id
 function populateForm(thisId){
 	var edit = new admin.models.users();
 	var frm = document.forms["editForm"];
 	strSeller = edit.getUserFromId(thisId);
	email = strSeller['EMAIL'];
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+email+'" style="color: black; text-decoration: none;">[SEND EMAIL]</a>';
	sellerListings = strSeller['LISTINGS'];
	if (sellerListings > 0){
		document.getElementById('viewListings').innerHTML ='<input type="Button" value="VIEW SELLER LISTINGS" onclick="ColdFusion.Window.show(\'viewListingsWin\');">';
	}
	else{
		document.getElementById('viewListings').innerHTML = 'NO LISTINGS IN SYSTEM';
	}

	document.getElementById('password').value = strSeller['PASSWORD'];
	
	<!--- console.table(strSeller);                      --->

	phone = strSeller['PHONE'];
	cellphone = strSeller['CELLPHONE'];
	businessphone = strSeller['BUSINESSPHONE'];
	otherphone = strSeller['OTHERPHONE'];

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

	<!--- var td =  $("##PhoneType").val(); --->
	var phoneType = document.getElementById('PhoneType').value
	<!--- var formatSign = document.getElementById("formatSign"); --->
	

	<!--- if (phoneType === "OutsideUS") {
		formatSign.style.display = "none";
	} else {
		formatSign.style.display = "inline";
	} --->

	<!--- console.log('test data: ' + td) --->

	<!--- toggleFormatSign(); --->

	document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';

	document.getElementById('sellerId').value = thisId;
	ColdFusion.Grid.refresh('sellerListingsGrid',true);
}

function doEdit(type) {

	  var fname = document.getElementById('fname').value.trim();
	  var lname = document.getElementById('lname').value.trim();
	  var email = document.getElementById('seller_email').value.trim();
	  <!--- var password = document.getElementById('password').value.trim(); --->

	  var phone = document.getElementById('phoneNumber').value.trim();
	  var phoneType = document.getElementById('PhoneType').value;

	  var editBtn = document.getElementById('edit');
	  var deleteBtn = document.getElementById('delete');

    var edit = new admin.models.users();

    edit.setForm("editForm");
    
    if (type == 'edit'){

		const validateField = (value, id, message) => 
		value === '' ? (toastr.error(message), document.getElementById(id).focus(), false) : true;

		// Validate required fields
		if (!validateField(fname, 'fname', 'First Name is required.')) return false;
		if (!validateField(lname, 'lname', 'Last Name is required.')) return false;

		// Email validation
		if (!validateField(email, 'seller_email', 'Email is required.')) return false;

		const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		if (!emailPattern.test(email)) 
			return (toastr.error('Please enter a valid email address.'), document.getElementById('seller_email').focus(), false); 

		<!--- if (password === '') {
			toastr.error('Password is required.');
			document.getElementById('password').focus();
			return false;
		} else {
			
			var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
			if (!passwordPattern.test(password)) {
				toastr.error('Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.');
				document.getElementById('password').focus();
				return false;
			}
		} --->

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
    		
		var result = edit.editUserFromForm();

		console.log('test result: ' , result);
		

			if (result.SUCCESS === true) {

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
		} 
		
		else {
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

		if ( edit.deleteUser()) {
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
			
			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);

     	} 
     	else { 
			alert( 'There was a problem in the processing.')
			editBtn.disabled = false;
			deleteBtn.disabled = false;
		}
    }

	<!--- document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = ''; --->

	if (document.getElementById('pk_users').value === '') {
		document.getElementById('edit').value = 'Add';
		document.getElementById('delete').style.display = 'none';
	} else{
		document.getElementById('edit').value = 'Edit';
		document.getElementById('delete').style.display = ''; 
	}
}
	
function showNew () {
   	document.getElementById('pk_users').value = '';
   	document.getElementById('fname').value = '';
   	document.getElementById('lname').value = '';
   	document.getElementById('seller_email').value = '';
	<!--- document.getElementById('cellphone').value = ''; --->
	document.getElementById('website').value = '';
	document.getElementById('phoneNumber').value = '';
	document.getElementById('PhoneType').options[0].selected = true;
	document.getElementById('password').value = '';
	document.getElementById('edit').value = 'Add';
   	document.getElementById('delete').style.display = 'none';
}

function fillSearchFields(){
	document.getElementById('listingFrmTitle').value = document.getElementById('searchTitle').value;
	document.getElementById('listingFrmArtist').value = document.getElementById('searchArtist').value;
}
