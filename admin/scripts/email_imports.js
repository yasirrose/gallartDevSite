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
	var edit = new admin.models.email_imports();
 	var frm = document.forms["editForm"];
 	strImports = edit.getImportFromId(thisId);
 	email = strImports['EMAIL'];
 	console.log(strImports)
}

  function doEdit(type) {

      var edit = new admin.models.email_imports();
      edit.setForm("editForm");
      
      if (type == 'edit'){
      		
       if ( edit.editImportsFromForm()) {
           ColdFusion.Grid.refresh('data',true);
       } 
       else { alert( 'There was a problem in the processing.')}
        }
     else {
     	
     	if ( edit.deleteImport()) {
           ColdFusion.Grid.refresh('data',true);
       } 
       else { alert( 'There was a problem in the processing.')}
        }
        
	document.getElementById('edit').value = 'Edit';
  	document.getElementById('delete').style.display = '';
  }
  
 function showNew () {
  	document.getElementById('pk_email_imports').value = '';
  	document.getElementById('fname').value = '';
  	document.getElementById('lname').value = '';
  	document.getElementById('email').value = '';
	document.getElementById('edit').value = 'Add';
  	document.getElementById('delete').style.display = 'none';
   }
 

 
 
