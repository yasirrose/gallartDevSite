  // get current row id 
function gridChange(thisId) {
	populateForm(thisId);
}

// populate edit form using row id
 function populateForm(thisId){
 	var edit 		= new admin.models.events();
 	var frm 		= document.forms["editForm"];
 	strEvent 		= edit.getEvent(thisId);
	isCurrent		= strEvent['ISCURRENT'];
	for(i = 0; i < frm.isCurrent.length; i++){
		if(frm.isCurrent[i].value == isCurrent){
			frm.isCurrent[i].checked = true;
		}
		else{
			frm.isCurrent[i].checked = false;
		}
	}
	document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';
}
  
function doEdit(type) {

	var title = document.getElementById('event_title').value.trim();
	var date = document.getElementById('event_date').value.trim();
	var location = document.getElementById('event_location').value.trim();

	var editBtn = document.getElementById('edit');
	var deleteBtn = document.getElementById('delete');

    var edit = new admin.models.events();
    edit.setForm("editForm");
    
    if (type == 'edit'){

		const validateField = (value, id, message) => 
		value === '' ? (toastr.error(message), document.getElementById(id).focus(), false) : true;

		if (!validateField(title, 'event_title', 'Title is required.')) return false;
		if (!validateField(date, 'event_date', 'Date is required.')) return false;
		if (!validateField(location, 'event_location', 'Location is required.')) return false;

		<!--- if (title === '') {
			toastr.error('Title is required.');
			document.getElementById('event_title').focus();
			return false;
		} --->

		<!--- if (date === '') {
			toastr.error('Date is required.');
			document.getElementById('event_date').focus();
			return false;
		} --->

		<!--- if (location === '') {
			toastr.error('Location is required.');
			document.getElementById('event_location').focus();
			return false;
		} --->

		editBtn.disabled = true;
		deleteBtn.disabled = true;

		result = edit.editEventsFromForm();
    		
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

			ColdFusion.Grid.refresh('data',true);
			toastr.success(result.MESSAGE); 

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

		result = edit.deleteEvent();

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

			ColdFusion.Grid.refresh('data',true);
			toastr.success(result.MESSAGE); 
		
			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);
		} 
     	else 
			{ 
				alert( result.MESSAGE)
			}
      }
      
	document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';
}
  
  function showNew () {
  	document.getElementById('pk_event_registration_title').value = '';
  	document.getElementById('event_title').value = '';
  	document.getElementById('event_date').value = '';
	document.getElementById('event_location').value = '';
	document.editForm.isCurrent.checked = false;
	document.getElementById('datestamp').value = '';

  	document.getElementById('edit').value = 'Add';
  	document.getElementById('delete').style.display = 'none';
   }
