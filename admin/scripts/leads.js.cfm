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

   function doEdit(type) {

       var edit = new admin.models.leads();

       edit.setForm("editForm");

       if (type == 'edit'){

        if ( edit.editLeadFromForm()) {
			document.getElementById('emailButton').style.display = 'block';
            ColdFusion.Grid.refresh('leadGrid',true);
        }
        else { alert( 'There was a problem in the processing.')}
	        }
	     else if (type == 'delete'){
		document.getElementById('notes').value = '';
	     	if ( edit.deleteLead()) {
            ColdFusion.Grid.refresh('leadGrid',true);
        }
        else { alert( 'There was a problem in the processing.')}
	        }
	document.getElementById('edit').value = 'Edit';
   	document.getElementById('delete').style.display = '';
   }

   function showNew () {
   	document.getElementById('pk_leads').value = '';
	document.getElementById('fk_employees').value = '<cfoutput>#session.userinfo.pk_employees#</cfoutput>';
   	document.getElementById('fname').value = '';
   	document.getElementById('lname').value = '';
   	document.getElementById('leadEmail').value = '';
	document.getElementById('cellphone').value = '';
	document.getElementById('phone').value = '';
	document.getElementById('businessphone').value = '';
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
 }

 function populateForm(){
 	var edit = new admin.models.leads();
 	var frm = document.forms["editForm"];
 	strLead = edit.getLeadFromId(frm.pk_leads.value);
	empDisplay = strLead['EMPDISPLAY'];
	origin = strLead['ORIGIN'];
	maillist = strLead['MAILLIST'];
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

}

function refreshMe(){
	ColdFusion.Grid.refresh('leadGrid',true);
}
