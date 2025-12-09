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

		if (title === '') {
			toastr.error('Title is required.');
			document.getElementById('event_title').focus();
			return false;
		}

		if (date === '') {
			toastr.error('Date is required.');
			document.getElementById('event_date').focus();
			return false;
		}

		if (location === '') {
			toastr.error('Location is required.');
			document.getElementById('event_location').focus();
			return false;
		}

		editBtn.disabled = true;
		deleteBtn.disabled = true;
    		
		if ( edit.editEventsFromForm()) {

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
			toastr.success('Data is Added or Updated Successfully!'); 

			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);
		} 
		else { 
			alert( 'There was a problem in the processing.')
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

			ColdFusion.Grid.refresh('data',true);
			toastr.success('Record is Deleted Successfully'); 
		
			setTimeout(function () {
				editBtn.disabled = false;
				deleteBtn.disabled = false;
			}, 5000);
		} 
     	else 
			{ 
				alert( 'There was a problem in the processing.')
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
