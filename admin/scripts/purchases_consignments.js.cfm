// get search values
	getName = function(){
		   var s = ColdFusion.getElementValue('searchName');
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
	populateForm(thisId);
}

		
// populate edit form using row id		
function populateForm(thisId){
	var edit = new admin.models.purchases_consignments();
 	var frm = document.forms["editForm"];
 	strPurchasesConsignments = edit.getPurchasesConsignmentsFromId(thisId);
	medium = strPurchasesConsignments['MEDIUM'];
	image = strPurchasesConsignments['IMAGE_NAME'];
	for(i = 0; i < frm.medium.options.length; i++){
		if(frm.medium.options[i].value == medium){
			frm.medium.options[i].selected = true;
		}
		else{
			frm.medium.options[i].selected = false;
		}
	}
	<cfoutput>
	document.getElementById('mainImg').src = 'http://#server_name#/purchases_consignments/images/'+image;
	document.getElementById('clickEnlarge').href = 'http://#server_name#/purchases_consignments/images/'+image+'?'+new Date().getTime();
	</cfoutput>
}

  function doEdit(type) {

      var edit = new admin.models.purchases_consignments();
      edit.setForm("editForm");
      
      if (type == 'edit'){
      		
       if ( edit.editPurchasesConsignmentsFromForm()) {
           ColdFusion.Grid.refresh('data',true);
       } 
       else { alert( 'There was a problem in the processing.')}
        }
     else {
     	
     	if ( edit.deletePurchasesConsignments()) {
           ColdFusion.Grid.refresh('data',true);
       } 
       else { alert( 'There was a problem in the processing.')}
        }
        
	document.getElementById('edit').value = 'Edit';
  	document.getElementById('delete').style.display = '';
  }
  
 function showNew () {
  	document.getElementById('pk_purchases_consignments').value = '';
  	document.getElementById('name').value = '';
  	document.getElementById('phone').value = '';
  	document.getElementById('email').value = '';
	document.getElementById('artist').value = '';
	document.getElementById('title').value = '';
	document.getElementById('size').value = '';
	document.getElementById('additional_details').value = '';
  	document.getElementById('edit').value = 'Add';
  	document.getElementById('delete').style.display = 'none';
   }
 

 
 
