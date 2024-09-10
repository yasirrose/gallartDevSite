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
getTitle = function(){
   var s = ColdFusion.getElementValue('searchTitle');
   return s;
}
	
// unique to make offer module - shows seller email if not null 
function gridChange(uid,customer_email,seller_email) {
		document.getElementById('artImg').innerHTML = '<a href="http://<cfoutput>#server_name#</cfoutput>/img/'+uid+'.jpg" target="_blank"><img src="http://<cfoutput>#server_name#</cfoutput>/img/thumbnails/'+uid+'.jpg" border="0"></a>';
		document.getElementById('emailLink').innerHTML = '<a href="mailto:'+customer_email+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
		document.getElementById('mailLog').innerHTML = '<a href="#" onclick="openMailLogWindow(<cfoutput>#session.userinfo.pk_employees#</cfoutput>,4,' + uid + ',\'' + customer_email + '\');" style="color: #000000; text-decoration: none;">[VIEW EMAIL LOG]</a>';
		if(seller_email == 'null'){
			document.getElementById('emailLinkSeller').innerHTML = '';
			document.getElementById('displaySellerInfo').style.display = 'none';
		}
		else{
			document.getElementById('emailLinkSeller').innerHTML = '<a href="mailto:'+seller_email+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
			document.getElementById('displaySellerInfo').style.display = 'block';
		}
		
	}
	
// edit form functions

function doEdit(type) {

    var edit = new admin.models.makeoffer();

     edit.setForm("editForm");
    	
    	if ( edit.deleteMakeoffer()) {
          ColdFusion.Grid.refresh('data',true);
      } 
      else { alert( 'There was a problem in the processing.')}

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
   	document.getElementById('edit').value = 'Add';
   	document.getElementById('delete').style.display = 'none';
	for(i = 0; i < document.editForm.roles.length; i++){
		document.editForm.roles[i].checked = false;
	}
}
	
