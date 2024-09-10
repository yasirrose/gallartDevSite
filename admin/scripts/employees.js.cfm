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
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+emp_email+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
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
}
	
// edit form functions

function doEdit(type) {

    var edit = new admin.models.employees();

    edit.setForm("editForm");
    
    if (type == 'edit'){
    		
     if ( edit.editEmployeeFromForm()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}
      }
   else if (type == 'delete'){
   	if ( edit.deleteEmployee()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}
      }
document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';
}

// clear all fields when new is clicked

function showNew () {
   	document.getElementById('pk_employees').value = '';
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
	}
}
	
