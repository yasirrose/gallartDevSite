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
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+customer_email+'" style="color: black; text-decoration: none;">[SEND EMAIL]</a>';
	maillist			= strCustomer['MAILLIST'];
	for(i = 0; i < frm.maillist.length; i++){
		if(frm.maillist[i].value == maillist){
			frm.maillist[i].checked = true;
		}
		else{
			frm.maillist[i].checked = false;
		}
	}

	phone = strCustomer['PHONE'];
	cellphone = strCustomer['CELLPHONE'];
	businessphone = strCustomer['BUSINESSPHONE'];
	otherphone = strCustomer['OTHERPHONE'];

	if(cellphone && cellphone.trim() !== ""){
		
        $("#phoneNumber").val(cellphone);
        $("#PhoneType").val("Cell Phone");
    }
    else if(phone && phone.trim() !== ""){
        $("#phoneNumber").val(phone);
        $("#PhoneType").val("Home Phone");
    }
    else if(businessphone && businessphone.trim() !== ""){
        $("#phoneNumber").val(businessphone);
        $("#PhoneType").val("Business Phone");
    }
    else if(otherphone && otherphone.trim() !== ""){
        $("#phoneNumber").val(otherphone);
        $("#PhoneType").val("OutsideUS");
    }
    else {
        $("#phoneNumber").val("");
        $("#PhoneType").val('Cell Phone'); // default
    }

	<!--- var td =  $("##PhoneType").val(); --->
	var phoneType = document.getElementById('PhoneType').value
	var formatSign = document.getElementById("formatSign");
	

	if (phoneType === "OutsideUS") {
		formatSign.style.display = "none";
	} else {
		formatSign.style.display = "inline";
	}


}
	
// edit form functions

function doEdit(type) {

	

	console.log('test type: ' + type)

	<!--- return false; --->

    var edit = new admin.models.customers();



    edit.setForm("editForm");
    
    if (type == 'edit'){

		var phone = document.getElementById('phoneNumber').value.trim();
		var phoneType = document.getElementById('PhoneType').value;

	if (phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone") {
		// Format: (123) 456-7890
		var phonePattern = /^\(\d{3}\)\s\d{3}-\d{4}$/;
		if (!phonePattern.test(phone)) {
			alert("Please enter phone number in format: (xxx) xxx-xxxx");
			document.getElementById('phoneNumber').focus();
			return false;
		}
	}
    		
     if ( edit.editCustomerFromForm()) {
         ColdFusion.Grid.refresh('data',true);
		 toastr.success('Data is Updated Successfully!');
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




