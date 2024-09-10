// get search values

getFname = function(){
	   var s = ColdFusion.getElementValue('searchFname');
	   return s;
} 

getLname = function(){
	   var s = ColdFusion.getElementValue('searchLname');
	   return s;
}

getEmail = function(){
	   var s = ColdFusion.getElementValue('searchEmail');
	   return s;
}

getAreacode= function(){
	   var s = ColdFusion.getElementValue('searchAreacode');
	   return s;
}

getCity = function(){
	   var s = ColdFusion.getElementValue('searchCity');
	   return s;
}

getState = function(){
	   var s = ColdFusion.getElementValue('searchState');
	   return s;
}
	
	
// get current row id 
function gridChange(thisId) {
	populateForm(thisId);
}

// populate edit form using row id
 function populateForm(thisId){
 	var edit 			= new admin.models.customers();
 	var frm 			= document.forms["editForm"];
 	strCustomer 		= edit.getCustomer(thisId);
	customer_email 		= strCustomer['CUSTOMER_EMAIL'];
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+customer_email+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
	maillist			= strCustomer['MAILLIST'];
	for(i = 0; i < frm.maillist.length; i++){
		if(frm.maillist[i].value == maillist){
			frm.maillist[i].checked = true;
		}
		else{
			frm.maillist[i].checked = false;
		}
	}
}
	
// edit form functions

function doEdit(type) {

    var edit = new admin.models.customers();

    edit.setForm("editForm");
    
    if (type == 'edit'){
    		
     if ( edit.editCustomerFromForm()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}
      }
   else if (type == 'delete'){
   	if ( edit.deleteCustomer()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}
      }
document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';
}




