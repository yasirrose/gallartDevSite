// get search values
	getLname = function(){
		   var s = ColdFusion.getElementValue('searchLname');
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
	console.log(thisId)
	populateForm(thisId);
}

		
// populate edit form using row id		
function populateForm(thisId){
	var edit = new admin.models.appraisals();
 	var frm = document.forms["editForm"];
 	strAppraisal = edit.getAppraisalFromId(thisId);
	medium = strAppraisal['MEDIUM'];
	ground = strAppraisal['GROUND'];
	reason = strAppraisal['REASON'];
	image = strAppraisal['IMAGE_NAME'];
	for(i = 0; i < frm.medium.options.length; i++){
		if(frm.medium.options[i].value == medium){
			frm.medium.options[i].selected = true;
		}
		else{
			frm.medium.options[i].selected = false;
		}
	}
	for(i = 0; i < frm.ground.length; i++){
		if(frm.ground[i].value == ground){
			frm.ground[i].checked = true;
		}
		else{
			frm.ground[i].checked = false;
		}
	}
	reasonArray = reason.split(',');
	for(i = 0; i < frm.reason.length; i++){
		frm.reason[i].checked = false;
		for(ii = 0; ii < reasonArray.length; ii++){
			if(frm.reason[i].value == reasonArray[ii]){
				frm.reason[i].checked = true;
			}
		}
	}
	<cfoutput>
	document.getElementById('mainImg').src = 'http://#server_name#/appraisal/images/'+image;
	document.getElementById('clickEnlarge').href = 'http://#server_name#/appraisal/images/'+image+'?'+new Date().getTime();
	</cfoutput>
}

  function doEdit(type) {

      var edit = new admin.models.appraisals();
      edit.setForm("editForm");
      
      if (type == 'edit'){
      		
       if ( edit.editAppraisalsFromForm()) {
           ColdFusion.Grid.refresh('data',true);
       } 
       else { alert( 'There was a problem in the processing.')}
        }
     else {
     	
     	if ( edit.deleteAppraisal()) {
           ColdFusion.Grid.refresh('data',true);
       } 
       else { alert( 'There was a problem in the processing.')}
        }
        
	document.getElementById('edit').value = 'Edit';
  	document.getElementById('delete').style.display = '';
  }
  
 function showNew () {
  	document.getElementById('pk_appraisal').value = '';
  	document.getElementById('fname').value = '';
  	document.getElementById('lname').value = '';
	document.getElementById('address').value = '';
	document.getElementById('city').value = '';
	document.getElementById('state').value = '';
	document.getElementById('zip').value = '';
  	document.getElementById('email').value = '';
	document.getElementById('phone').value = '';
	document.getElementById('besttime').value = '';
	document.getElementById('mainImg').src = '';
	document.getElementById('artist_fname').value = '';
	document.getElementById('artist_lname').value = '';
	document.getElementById('title').value = '';
  	document.getElementById('year').value = '';
	document.getElementById('edition').value = '';
	document.editForm.medium.options[0].selected = true;
	for(i = 0; i < document.editForm.ground.length; i++){
		document.editForm.ground[i].checked = false;
	}
	document.getElementById('groundOther').value = '';
	document.getElementById('size_unframed').value = '';
	document.getElementById('size_with_frame').value = '';
	document.getElementById('condition').value = '';
	document.getElementById('signature').value = '';
	document.getElementById('description').value = '';
	for(i = 0; i < document.editForm.reason.length; i++){
		document.editForm.reason[i].checked = false;
	}
	document.getElementById('purchased_from').value = '';
	document.getElementById('appraisal_where').value = '';
	document.getElementById('appraisal_year').value = '';
	document.getElementById('appraisal_amount').value = '';
	for(i = 0; i < document.editForm.reason.length; i++){
		document.editForm.reason[i].checked = false;
	}
	
  	document.getElementById('edit').value = 'Add';
  	document.getElementById('delete').style.display = 'none';
   }
 

 
 
