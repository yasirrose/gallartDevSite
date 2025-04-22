// create a new JS proxy object for the CFC
var dataproxy = new cfcproxy_bios();
dataproxy.setCallbackHandler(handleResult);

// this function recieves the response from CFC whenever a CFC function is called.
// we are simply alerting the response but we could do more if we had to.
function handleResult(response)
{
	alert(response);
}

// get search values

getArtist = function(){
   var s = ColdFusion.getElementValue('searchArtist');
   return s;
}

// the init()
function init(){
 grid = ColdFusion.Grid.getGridObject("bioGrid");
  // get the header and fotoer objects
 //var gridHead = grid.getTopToolbar();
 //var tbar = new Ext.Toolbar(gridHead);
 //var gridFoot = grid.getBottomToolbar();
//  var ds = grid.getStore();

 // add the 2 custom buttons to the toolbar
 //tbar.addButton({text:"Add Bio", handler:onAdd });
 //tbar.addSeparator();
 //tbar.addButton({ text:"Delete Bio", handler:onDelete });

 // add a row double click event for the grid rows.
 // the double click will open a popup window for editing the row.
 //var sm = grid.getSelectionModel();
 grid.on('itemdblclick',function(grid, rowIndex, record){
 	// var rec = ds.getAt(rowIndex); // get the clicked row
	populateForm(rowIndex); // populate the form with values
 	// ColdFusion.Window.show('editBioWin'); // display the window
 });



// add a custom combobox to the grid header - this combobox lets you choose the number of rows you want to see
 cb = new Ext.form.ComboBox({
   id:"pagingCombo",
   emptyText:"Rows per page",
   mode:"local",
   triggerAction:"all",
   displayField:"text",
   valueField:"value",
         store:new Ext.data.SimpleStore({
            fields: ["value", "text"],
            data: [
               ["5","5 rows per page"],
               ["10","10 rows per page"],
               ["15","15 rows per page"],
               ["20","20 rows per page"]
            ]
   })
});

// add event listener to combobox
// this code will update the grid pageSize
//cb.addListener("select",function(combo,record,index){
// the new pageSize from combobox -  it needs to have parseInt() else it starts acting weird
 //var numRows = parseInt(record.data.value);
 //paging.pageSize = parseInt(numRows);
 //paging.onClick("refresh");
//});

// add the paging combo to right side of the toolbar
//Ext.fly(tbar.addSpacer().getEl().parentNode).setStyle('width', '100%');
//tbar.add(cb);

}

function populateForm(record){
	// gets the selected row from double click event and populates the form
	// could also use ColdFusion.getElementValue() here which gets the bound grid row but I find this method better

	window.open('index.cfm?event=bios.editor&id=' + record.data.PK_BIOS + '&artist=' + record.data.ARTIST, 'editor', 'width=800,height=800,left=0,top=0,resizable=yes,scrollbars=yes');

/*
	// the form
	var frm = document.forms["frmBio"];

	// default values if using the "add bio" mode
	var artist = "";
	var bio = "";
	var pk_bios = "0";
	var btntext = "Add Bio";

	if(record)
	{
		// values for the selected row
		artist = record.data.ARTIST;
		bio = record.data.BIO;
		if(record.data.PK_BIOS != '0') pk_bios = record.data.PK_BIOS;
		if(record.data.PK_BIOS != '0') ; btntext = "Update Bio";
	}
	//populate the form, finally

	frm.pk_bios.value = pk_bios;
 	frm.txtArtist.value = artist;
	contentId = frm.txtBio.id;
	ColdFusion.RichText.setValue(contentId, bio);
	//frm.txtBio.value = bio;
	frm.pk_bios.value = pk_bios;
	frm.btnAction.value = btntext;
*/
}

function onAdd(button,event){
	window.open('index.cfm?event=bios.editor', 'editor', 'width=800,height=800,left=0,top=0,resizable=yes,scrollbars=yes');
	// populateForm(false);
	// ColdFusion.Window.show('editBioWin');
}
function onDelete(){
	ColdFusion.Window.show('deleteBioWin');
}

function saveBio()
{
	//send data to CFC to add bio, the result will be handled by handleResult function above
	//set dataproxy method to post, to avoid "url too long" error
	dataproxy.setHTTPMethod("POST");
	var frm = document.frmBio;
	var richTextField = frm.txtBio.id;
	contentValue = ColdFusion.getElementValue(richTextField, frm);
	dataproxy.saveBio(
		 frm.pk_bios.value,
		 frm.txtArtist.value,
		 contentValue
	);
    setTimeout(function(){
    	ColdFusion.Grid.refresh('bioGrid', true);
   	},1000);
	//ColdFusion.Grid.refresh('bioGrid', true);
	// ColdFusion.Window.hide('editBioWin');
}

function deleteBio(s)
{
	// if user choose to delete, then send the CFC call, otherwise just sit back!
	if (s == 'yes')
	{
	var grid = ColdFusion.Grid.getGridObject("bioGrid");
	// var record = grid.getSelectionModel().getSelected();
	// remember, CF makes column names to all UPPERCASE, so dont forget to do that
	dataproxy.deleteBio(grid.selection.data.PK_BIOS);
	}
	setTimeout(function(){
    	ColdFusion.Grid.refresh('bioGrid', true);
   	},1000);
	//ColdFusion.Grid.refresh('bioGrid', true);
	ColdFusion.Window.hide('deleteBioWin');
}

// get search values

getArtist = function(){
   var s = ColdFusion.getElementValue('searchArtist');
   return s;
}
