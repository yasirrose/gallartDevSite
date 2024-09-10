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

