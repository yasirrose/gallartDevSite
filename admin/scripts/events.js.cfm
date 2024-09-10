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
}
  
function doEdit(type) {

    var edit = new admin.models.events();
    edit.setForm("editForm");
    
    if (type == 'edit'){
    		
     if ( edit.editEventsFromForm()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}
      }
   else {
   	
   	if ( edit.deleteEvent()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}
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
