// get search values

getLname = function(){
    var s = ColdFusion.getElementValue('searchLname');
    return s;
}
<!--- getEmail = function(){
    var s = ColdFusion.getElementValue('searchEmail');
    return s;
} --->
 
// get current row id 
function gridChangeFilter(thisId) {
    populateFormfilter(thisId);
}

// populate edit form using row id
function populateFormfilter(thisId){
    var edit = new admin.models.filterOption();
    var frm = document.forms["editForm"];
    var strEmployee = edit.getFilterdataFromID(thisId);

    // Assuming the response is a JSON object
    if (strEmployee) {
        frm.filterName.value = strEmployee['filterName'];
        frm.filterType.value = strEmployee['filterType'];
        document.getElementById('edit').value = 'Edit';
        <!--- var deleteCheck = document.getElementById('deleteCheck').value;
        if(deleteCheck){
            document.getElementById('delete').style.display = '';
        } --->

       active = strEmployee['FILTERTYPE']

        <!--- console.log('test data: ' + active) --->

        for(i = 0; i < frm.filterType.options.length; i++){
            if(frm.filterType.options[i].value == active){
                frm.filterType.options[i].selected = true;
            }
            else{
                frm.filterType.options[i].selected = false;
            }
        }

    } else {
        alert('Failed to retrieve employee data.');
    }
}
 
// edit form functions

function doEdit(type) {
    
    var filterName = document.getElementById('filterName').value.trim();
    var filterType = document.getElementById('filterType').value.trim();

    var editBtn = document.getElementById('edit');
	var deleteBtn = document.getElementById('delete');

    <!--- if (filterName === '' || filterType === '') {
        alert('Please fill out all fields.');
        return; 
    } --->

    if (filterName === '' || filterType === '') return alert('Please fill out all fields.');

    var edit = new admin.models.filterOption();

    edit.setForm("editForm");
 
    if (type == 'edit'){


            <!--- console.log('Calling addFilterRecord...');
                edit.addFilterRecord({
                    callback: function(result) {
                        console.log('Callback result:', result);

                        if (result.success) {
                            console.log('Success:', result.message);
                            ColdFusion.Grid.refresh('data', true);
                            setTimeout(function() {
                                alert(result.message);
                            }, 100);
                        } else {
                            console.log('Error:', result.message);
                            setTimeout(function() {
                                alert(result.message || 'There was a problem in the processing.');
                            }, 100);
                        }
                    }
                }); --->

            editBtn.disabled = true;
		    deleteBtn.disabled = true;

            result = edit.addFilterRecord();
              
            <!--- console.log('test update: ' , result) --->

            if (result.SUCCESS === true) {

                 alert(result.MESSAGE);
                 ColdFusion.Grid.refresh('data', true);

                setTimeout(function() {
                    editBtn.disabled = false;
				    deleteBtn.disabled = false;                   
                }, 5000);

            } 
            else {               
                alert(result.MESSAGE);

                setTimeout(function() {
                    editBtn.disabled = false;
				    deleteBtn.disabled = false;                   
                }, 5000);
            }
    }
    else if (type == 'delete'){

         result = edit.deleteEmployee();

         <!--- console.log('test delete: ' , result) --->

        if ( result.SUCCESS === true) {

            alert(result.MESSAGE);
            ColdFusion.Grid.refresh('data', true);
        } 
        else { 
            alert( result.MESSAGE)
        }
   }
    <!--- document.getElementById('edit').value = 'Edit';
    document.getElementById('delete').style.display = ''; --->

    <!--- if (document.getElementById('id').value === '') {
		document.getElementById('edit').value = 'Add';
		document.getElementById('delete').style.display = 'none';
	} else{
		document.getElementById('edit').value = 'Edit';
		document.getElementById('delete').style.display = ''; 
	} --->

    const hasId = document.getElementById('id').value !== '';

    document.getElementById('edit').value = hasId ? 'Edit' : 'Add';
    document.getElementById('delete').style.display = hasId ? '' : 'none';
}

// clear all fields when new is clicked

function showNew () {
    document.getElementById('id').value = '';
    document.getElementById('filterName').value = '';
    document.getElementById('filterType').value = '';
    document.getElementById('edit').value = 'Add';
   	document.getElementById('delete').style.display = 'none';
   
}
function updateGrid() {
    // Get the search input value
    var searchLname = document.getElementById('searchLname').value.trim();

    // Update the cfgrid binding with the new search value
    var grid = ColdFusion.Grid.getGridObject('data');
    var bindUrl = "cfc:admin.models.filterOption.getFilterRecord({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},'" + encodeURIComponent(searchLname) + "')";
    
    ColdFusion.Grid.refresh('data', {
        bindurl: bindUrl
    });
}
