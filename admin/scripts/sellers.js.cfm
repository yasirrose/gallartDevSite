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
getListed = function(){
	   var s = ColdFusion.getElementValue('searchListed');
	   return s;
}

// get current row id 
function gridChange(thisId) {
	populateForm(thisId);
}

// populate edit form using row id
 function populateForm(thisId){
 	var edit = new admin.models.users();
 	var frm = document.forms["editForm"];
 	strSeller = edit.getUserFromId(thisId);
	email = strSeller['EMAIL'];
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+email+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
	sellerListings = strSeller['LISTINGS'];
	if (sellerListings > 0){
		document.getElementById('viewListings').innerHTML ='<input type="Button" value="VIEW SELLER LISTINGS" onclick="ColdFusion.Window.show(\'viewListingsWin\');">';
	}
	else{
		document.getElementById('viewListings').innerHTML = 'NO LISTINGS IN SYSTEM';
	}
	document.getElementById('sellerId').value = thisId;
	ColdFusion.Grid.refresh('sellerListingsGrid',true);
}

function doEdit(type) {

    var edit = new admin.models.users();

    edit.setForm("editForm");
    
    if (type == 'edit'){
    		
     if ( edit.editUserFromForm()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}
      }
   else if (type == 'delete'){
   	if ( edit.deleteUser()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}
      }
document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';
}
	
function showNew () {
   	document.getElementById('pk_users').value = '';
   	document.getElementById('fname').value = '';
   	document.getElementById('lname').value = '';
   	document.getElementById('email').value = '';
	document.getElementById('phone').value = '';
	document.getElementById('password').value = '';
}

function fillSearchFields(){
	document.getElementById('listingFrmTitle').value = document.getElementById('searchTitle').value;
	document.getElementById('listingFrmArtist').value = document.getElementById('searchArtist').value;
}
