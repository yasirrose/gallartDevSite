// create a new JS proxy object for the CFC
var dataproxy = new cfcproxy_emailtemplate();

// the init()
function init(){
 grid = ColdFusion.Grid.getGridObject("emailTemplateGrid");

 // var ds = grid.getDataSource();

 // add a row double click event for the grid rows.
 // the double click will open a popup window for editing the row.
 var sm = grid.getSelectionModel();
 grid.on('rowdblclick',function(grid, rowIndex, record){
 	// var rec = ds.getAt(rowIndex); // get the clicked row
	populateWindow(rowIndex); // populate the form with values
 	ColdFusion.Window.show('displayClickReport'); // display the window
 });




}

function populateWindow(record){
	// gets the selected row from double click event and populates the window


	if(record){
		// values for the selected row
		pk_email_template 	= record.data.PK_EMAILTEMPLATE;
		emailsSent			= dataproxy.getEmailsSent(pk_email_template);
		clickIns 			= dataproxy.getClickins(pk_email_template);

		document.getElementById('emailsSent').innerHTML 		= emailsSent;
		document.getElementById('clickIns').innerHTML 		= clickIns;
	}

}


