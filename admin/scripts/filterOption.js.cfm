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
        var deleteCheck = document.getElementById('deleteCheck').value;
        if(deleteCheck){
            document.getElementById('delete').style.display = '';
        }
    } else {
        alert('Failed to retrieve employee data.');
    }
}
 
// edit form functions

function doEdit(type) {
    
  var filterName = document.getElementById('filterName').value.trim();
  var filterType = document.getElementById('filterType').value.trim();

  if (filterName === '' || filterType === '') {
      alert('Please fill out all fields.');
      return; 
  }
 var edit = new admin.models.filterOption();

 edit.setForm("editForm");
 
 if (type == 'edit'){


    console.log('Calling addFilterRecord...');
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
        });
         
  <!--- if ( edit.addFilterRecord()) {
    ColdFusion.Grid.refresh('data', true);
    } 
    else {
       alert( 'There was a problem in the processing.')
    } --->
   }
else if (type == 'delete'){
    if ( edit.deleteEmployee()) {
        ColdFusion.Grid.refresh('data', true);
  } 
  else { alert( 'There was a problem in the processing.')}
   }
document.getElementById('edit').value = 'Edit';
 document.getElementById('delete').style.display = '';
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
