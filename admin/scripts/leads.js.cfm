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
getEmployee = function(){
	   var s = ColdFusion.getElementValue('searchEmployeeId');
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
getComments = function(){
	   var s = ColdFusion.getElementValue('searchComments');
	   return s;
	}
getKeywords = function(){
	   var s = ColdFusion.getElementValue('searchKeywords');
	   return s;
	}

	function validateField(value, fieldId, message) {
		if (value === '') {
			alert(message);
			document.getElementById(fieldId).focus();
			return false;
		}
		return true;
	}

   function doEdit(type) {
	  
		var editBtn = document.getElementById('edit');
		var deleteBtn = document.getElementById('delete');

       var edit = new admin.models.leads();

       edit.setForm("editForm");

       if (type == 'edit'){

			var fname = document.getElementById('fname').value.trim();
			var lname = document.getElementById('lname').value.trim();
			var name = document.getElementById('name').value.trim();
			var email = document.getElementById('leadEmail').value.trim();

			var phone = document.getElementById('phoneNumber').value.trim();
			var phoneType = document.getElementById('PhoneType').value;
		

			<!--- if (fname === '') {
				toastr.error('First Name is required.');
				document.getElementById('fname').focus();
				return false;
			}

			if (lname === '') {
				toastr.error('Last Name is required.');
				document.getElementById('lname').focus();
				return false;
			} --->

			<!--- if (name === '') {
				toastr.error('Name is required.');
				document.getElementById('name').focus();
				return false;
			} --->

			if (!validateField(name, 'name', 'You must add a name')) return false;

			if (email === '') {
				<!---toastr.error('Email is required.');
				document.getElementById('leadEmail').focus();
				return false;--->
			} else {
				// Simple email format check using regex
				var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
				if (!emailPattern.test(email)) {
					toastr.error('Please enter a valid email address.');
					document.getElementById('leadEmail').focus();
					return false;
				}
			}

			if (phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone") {
					// Format: (123) 456-7890
					var phonePattern = /^\(\d{3}\)\s\d{3}-\d{4}$/;
					if (!phonePattern.test(phone)) {
						alert("Please enter phone number in format: (123) 456-7890");
						document.getElementById('phoneNumber').focus();
						return false;
					}
				}


			editBtn.disabled = true;
			deleteBtn.disabled = true;

			var result = edit.editLeadFromForm();

			<!--- console.log('test lead: ' , result) --->

			if ( result.SUCCESS === true) {
				document.getElementById('emailButton').style.display = 'block';
				
				ColdFusion.Grid.refresh('leadGrid',true);
				
				toastr.options = {
					"closeButton": true,
					"debug": false,
					"newestOnTop": true,
					"progressBar": true,
					"positionClass": "toast-center",
					"preventDuplicates": false,
					"onclick": null,
					"showDuration": "300",
					"hideDuration": "1000",
					"timeOut": "3000",
					"extendedTimeOut": "1000",
					"showEasing": "swing",
					"hideEasing": "linear",
					"showMethod": "fadeIn",
					"hideMethod": "fadeOut"
				};

				toastr.success(result.MESSAGE); 

				setTimeout(function () {
					editBtn.disabled = false;
					deleteBtn.disabled = false;
				}, 5000);
			}
			else { 
				alert(result.MESSAGE)
			
					editBtn.disabled = false;
					deleteBtn.disabled = false;
				
			}
	    }
	     else if (type == 'delete'){
			document.getElementById('notes').value = '';

			var result = edit.deleteLead();

	     	if ( result.SUCCESS === true) {
				
           		ColdFusion.Grid.refresh('leadGrid',true);

				toastr.options = {
					"closeButton": true,
					"debug": false,
					"newestOnTop": true,
					"progressBar": true,
					"positionClass": "toast-center",
					"preventDuplicates": false,
					"onclick": null,
					"showDuration": "300",
					"hideDuration": "1000",
					"timeOut": "3000",
					"extendedTimeOut": "1000",
					"showEasing": "swing",
					"hideEasing": "linear",
					"showMethod": "fadeIn",
					"hideMethod": "fadeOut"
				};

				toastr.success(result.MESSAGE); 
        	}
			else { 
				alert( result.MESSAGE)
			}
	    }
	document.getElementById('edit').value = 'Edit';
   	document.getElementById('delete').style.display = '';

	<!--- setTimeout(resetButtons, 1000);  --->

   }

   <!--- function resetButtons() {
		isProcessing = false;
		document.getElementById('edit').disabled = false;
		const deleteBtn = document.getElementById('delete');
		if (deleteBtn) deleteBtn.disabled = false;
	} --->

   function showNew () {
		document.getElementById('pk_leads').value = '';
		document.getElementById('fk_employees').value = '<cfoutput>#session.userinfo.pk_employees#</cfoutput>';
		document.getElementById('fname').value = '';
		document.getElementById('lname').value = '';
		document.getElementById('name').value = '';
		document.getElementById('leadEmail').value = '';
		<!--- document.getElementById('cellphone').value = ''; --->
		<!--- document.getElementById('phone').value = ''; --->
		<!--- document.getElementById('otherphone').value = ''; --->
		<!--- document.getElementById('businessphone').value = ''; --->
		document.getElementById('phoneNumber').value = '';
		document.getElementById('PhoneType').options[0].selected = true;
		document.getElementById('besttime').value = '';
		document.getElementById('address').value = '';
		document.getElementById('city').value = '';
		document.getElementById('state').value = '';
		document.getElementById('country').value = '';
		document.getElementById('zip').value = '';
		document.getElementById('company').value = '';
		document.getElementById('artists').value = '';
		document.getElementById('titles').value = '';
		document.getElementById('notes').value = '';
		document.getElementById('origin').options[0].selected = true;
		document.getElementById('empDisplay').innerHTML = '<cfoutput>#session.userinfo.lname#</cfoutput>, <cfoutput>#session.userinfo.fname#</cfoutput>';
		document.getElementById('emailButton').style.display = 'none';
		document.getElementById('edit').value = 'Add';
		document.getElementById('Addresstype').value = 'Add';
		document.getElementById('website').value = 'Add';

		if (window.updateArtists) window.updateArtists();
		if (window.updateTitles) window.updateTitles();
		if (window.updateNotes) window.updateNotes();

		<cfif session.loggedin EQ true AND session.userinfo.sa EQ 1>
			document.getElementById('delete').style.display = 'none';
		</cfif>
    }

 function init(){
 	leadGrid = ColdFusion.Grid.getGridObject("leadGrid");
  	// var ds = leadGrid.getDataSource();
 	leadGrid.on('rowclick',function(){
	populateForm(); // populate the form with values
 	});
	// ds.on('load',function(){populateForm()});


	var ds = leadGrid.getStore();
    
	 ds.on('load', function(store){
        <!--- console.log("Grid store loaded, checking first record..."); --->
        
        if (store.getCount() > 0) {
            var firstRecord = store.getAt(0); // first row
            var pk = firstRecord.get("PK_LEADS"); // column name from cfgrid
            
            if (pk) {
                // form field me pk_leads set karo
                document.getElementById("pk_leads").value = pk;

                <!--- console.log("Auto-selecting first record, pk_leads=" + pk); --->
                populateForm(); // ab safe call hoga
            }
        }
    });
  

 }

 function populateForm(){

	var frm = document.forms["editForm"];
	 var pk = frm.pk_leads.value;

    // agar PK empty hai to kuch mat karo
    if (!pk || isNaN(pk)) {
        console.log("populateForm() skipped - no pk_leads yet");
        return;
    }

 	var edit = new admin.models.leads();
 	
 	strLead = edit.getLeadFromId(pk);
	empDisplay = strLead['EMPDISPLAY'];
	origin = strLead['ORIGIN'];
	maillist = strLead['MAILLIST'];


	Addresstype = strLead['ADDRESSTYPE'];

	console.log('test address: ' + Addresstype);

	if (!Addresstype || Addresstype.trim() === "") {
		Addresstype = "USA";
	}

	for(i = 0; i < frm.Addresstype.options.length; i++){
		if(frm.Addresstype.options[i].value == Addresstype){
			frm.Addresstype.options[i].selected = true;
		}
		else{
			frm.Addresstype.options[i].selected = false;
		}
	}

	if (Addresstype && Addresstype.toLowerCase() === "outside") {
		document.getElementById("stateTextRow").style.display = "";
		document.getElementById("stateDropdownRow").style.display = "none";
	} else {
		document.getElementById("stateTextRow").style.display = "none";
		document.getElementById("stateDropdownRow").style.display = "";

		state = strLead['STATE']

			for(i = 0; i < frm.state.options.length; i++){
			if(frm.state.options[i].value == state){
				frm.state.options[i].selected = true;
			}
			else{
				frm.state.options[i].selected = false;
			}
		}
	} 

	  // ✅ Update counters again after populating data
    if (window.updateArtists) setTimeout(window.updateArtists, 200);
    if (window.updateTitles)  setTimeout(window.updateTitles, 200);
    if (window.updateNotes)   setTimeout(window.updateNotes, 200);


	var fname = strLead.RESULTSET.DATA[0][4]; // FNAME
	var lname = strLead.RESULTSET.DATA[0][5]; // LNAME
	var name = strLead.RESULTSET.DATA[0][31]; // NAME

	<!--- var phone = strLead.RESULTSET.DATA[0][7] //otherphone
	var cellphone = strLead.RESULTSET.DATA[0][8] //otherphone
	var businessphone = strLead.RESULTSET.DATA[0][9] //otherphone
	var otherphone = strLead.RESULTSET.DATA[0][26] //otherphone

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
        $("#PhoneType").val(""); // default
    } --->


	const data = strLead.RESULTSET.DATA[0];

	const phonePriority = [
		{ value: data[8],  type: "Cell Phone" },
		{ value: data[7],  type: "Home Phone" },
		{ value: data[9],  type: "Business Phone" },
		{ value: data[26], type: "OutsideUS" }
	];

	const selectedPhone = phonePriority.find(p => p.value && p.value.trim());

	$("#phoneNumber").val(selectedPhone ? selectedPhone.value : "");
	$("#PhoneType").val(selectedPhone ? selectedPhone.type : "");

	var phoneType = document.getElementById('PhoneType').value
	<!--- var formatSign = document.getElementById("formatSign"); --->
	

	<!--- if (phoneType === "OutsideUS") {
		formatSign.style.display = "none";
	} else {
		formatSign.style.display = "inline";
	} --->

	
	<!--- console.log('test1: ' + strLead.RESULTSET.DATA[0][9]); // businessphone
	console.log('test1: ' + strLead.RESULTSET.DATA[0][8]); // cellphone
	console.log('test1: ' + strLead.RESULTSET.DATA[0][7]); //phone
	console.log('test1: ' + strLead.RESULTSET.DATA[0][26]); --->
	


    // Set the name field based on logic
    if (!name || name.trim() === "") {
        frm.name.value = (fname ? fname : "") + " " + (lname ? lname : "");
    } else {
        frm.name.value = name;
    }


	for(i = 0; i < frm.origin.options.length; i++){
		if(frm.origin.options[i].value == origin){
			frm.origin.options[i].selected = true;
		}
		else{
			frm.origin.options[i].selected = false;
		}
	}
	for(i = 0; i < frm.maillist.length; i++){
		if(frm.maillist[i].value == maillist){
			frm.maillist[i].checked = true;
		}
		else{
			frm.maillist[i].checked = false;
		}
	}
	<cfif session.loggedin EQ true AND session.userinfo.sa EQ 1>
	employeeId = strLead['EMPID'];
	for(i = 0; i < frm.fk_employees.options.length; i++){
		if(frm.fk_employees.options[i].value == employeeId){
			frm.fk_employees.options[i].selected = true;
		}
		else{
			frm.fk_employees.options[i].selected = false;
		}
	}
	document.getElementById('empDisplay').innerHTML = empDisplay;
	<cfelse>
		if( document.getElementById('fk_employees').value == 0 || empDisplay == '' ){
			document.getElementById('empDisplay').innerHTML = 'UNASSIGNED';
		}
		else{
			document.getElementById('empDisplay').innerHTML = empDisplay;
		}
	</cfif>

	document.getElementById('edit').value = 'Edit';
	document.getElementById('delete').style.display = '';

}

function refreshMe(){
	ColdFusion.Grid.refresh('leadGrid',true);
}
