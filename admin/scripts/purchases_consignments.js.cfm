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
	
	<!--- image = strPurchasesConsignments['IMAGE_NAME']; --->

	var images = strPurchasesConsignments['IMAGE_NAME'].split(',');

	for(i = 0; i < frm.medium.options.length; i++){
		if(frm.medium.options[i].value == medium){
			frm.medium.options[i].selected = true;
		}
		else{
			frm.medium.options[i].selected = false;
		}
	}

	var imageDisplay = document.getElementById('imageDisplay');
    imageDisplay.innerHTML = '';


	 images.forEach(function(image, index) {
        var imgElement = document.createElement('img');
        imgElement.src = 'http://23.20.226.157/purchases_consignments/images/' + image;
        imgElement.border = "0";
        imgElement.width = "100";
        imgElement.style.marginRight = "10px";

        var linkElement = document.createElement('a');
        linkElement.href = 'http://23.20.226.157/purchases_consignments/images/' + image + '?' + new Date().getTime();
        linkElement.target = "_blank";
        linkElement.innerText = "Click to enlarge";

        var brElement = document.createElement('br');

        // Append elements to the container
        imageDisplay.appendChild(imgElement);
        imageDisplay.appendChild(brElement);
        imageDisplay.appendChild(linkElement);
        imageDisplay.appendChild(document.createElement('br'));
        imageDisplay.appendChild(document.createElement('br'));
    });



	<!--- <cfoutput>
	document.getElementById('mainImg').src = 'http://23.20.226.157/purchases_consignments/images/'+image;
	document.getElementById('clickEnlarge').href = 'http://23.20.226.157/purchases_consignments/images/'+image+'?'+new Date().getTime();
	</cfoutput> --->
}

  function doEdit(type) {

      var edit = new admin.models.purchases_consignments();
      edit.setForm("editForm");
      
      if (type == 'edit'){
      		
       if ( edit.editPurchasesConsignmentsFromForm()) {
           ColdFusion.Grid.refresh('data',true);
		   toastr.success('Purchase Consignment updated successfully!', 'Success'); 
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
 

 
 
