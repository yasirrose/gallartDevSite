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
	getStatus = function(){
		   var s = ColdFusion.getElementValue('searchStatus');
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
	var edit = new admin.models.requests();
 	var frm = document.forms["editForm"];
 	strRequest = edit.getRequestFromId(thisId);
	document.getElementById('responses').innerHTML = strRequest['responseTable'];
	
	requestStatus = strRequest['FK_REQUEST_STATUS'];
	for(i = 0; i < frm.fk_request_status.options.length; i++){

		if(frm.fk_request_status.options[i].value == requestStatus){
			frm.fk_request_status.options[i].selected = true;
		}
		else{
			frm.fk_request_status.options[i].selected = false;
		}
	}
	req_email = strRequest['REQ_EMAIL'];
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+req_email+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
}

  function doEdit(type) {

      var edit = new admin.models.requests();
      edit.setForm("editForm");
      
      if (type == 'edit'){
      		
       if ( edit.editRequestFromForm()) {
           ColdFusion.Grid.refresh('data',true);
       } 
       else { alert( 'There was a problem in the processing.')}
        }
     else {
     	
     	if ( edit.deleteRequest()) {
           ColdFusion.Grid.refresh('data',true);
       } 
       else { alert( 'There was a problem in the processing.')}
        }
        
	document.getElementById('edit').value = 'Edit';
  	document.getElementById('delete').style.display = '';
  }
  
 
 

 
 
