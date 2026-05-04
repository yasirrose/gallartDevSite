// create a new JS proxy object for the CFC
var dataproxy = new cfcproxy_pages();
dataproxy.setCallbackHandler(handleResult);

// this function recieves the response from CFC whenever a CFC function is called.
// we are simply alerting the response but we could do more if we had to.
function handleResult(response)
{
	alert(response);
}
// the init()
function init(){
 pageGrid = ColdFusion.Grid.getGridObject("pageGrid");

//  pageGrid.on("itemdblclick", 'editPageWin');
 // get the header and fotoer objects
//  var gridHead = pageGrid.getTopToolbar();
//  var tbar = new Ext.Toolbar(gridHead);

var tbar = ColdFusion.Grid.getTopToolbar("pageGrid");

//  var gridFoot = pageGrid.getBottomToolbar();
 var ds = pageGrid.getStore();

 // add a row double click event for the grid rows.
 // the double click will open a popup window for editing the row.
 var sm = pageGrid.getSelectionModel();
	 pageGrid.on('itemdblclick',function(pageGrid, rowIndex, record){
 	var rec = ds.getAt(rowIndex); // get the clicked row
	populateFormPage(rowIndex); // populate the form with values
	ColdFusion.Window.show('editPageWin'); // display the window
 });

  // this shows the display message by default
 /* var paging = new Ext.PagingToolbar(gridFoot,ds,{
	  pageSize:25, //number of records displayed in grid
	  displayInfo:false, // change this to false, if you dont want info displayed
	  displayMsg:'Displaying records {0} - {1} of {2}',
	   emptyMsg:"No records to display"
	   }); */

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
               ["10","10 rows per page"],
               ["25","25 rows per page"],
               ["50","50 rows per page"],
			   ["75","75 rows per page"]
            ]
   })
});

// add event listener to combobox
// this code will update the grid pageSize
cb.addListener("select",function(combo,record,index){
// the new pageSize from combobox -  it needs to have parseInt() else it starts acting weird
 var numRows = parseInt(record.data.value);
 paging.pageSize = parseInt(numRows);
 paging.onClick("refresh");
});

// add the paging combo to right side of the toolbar

//Ext.fly(tbar.addSpacer().getEl().parentNode).setStyle('width', '100%');
tbar.add(cb);

}

function populateFormPage(record){
	// gets the selected row from double click event and populates the form
	// could also use ColdFusion.getElementValue() here which gets the bound grid row but I find this method better

	window.open('index.cfm?event=content.editor&id=' + record.data.PK_PAGES, 'editor', 'width=800,height=800,left=0,top=0,resizable=yes,scrollbars=yes');

/*
	// default values if using the "edit page" mode
	var txtPageContent = "";
	var pk_pages = "0";
	var btntext = "Edit Page";

	if(record)
	{
		// values for the selected row
		page_content = record.data.PAGE_CONTENT;
		if(record.data.PK_PAGES != '0') pk_pages = record.data.PK_PAGES;
		if(record.data.PK_PAGES != '0') ; btntext = "Update Page";
	}
	//populate the form, finally
	frm.pk_pages.value = pk_pages;
 	contentId = frm.txtPageContent.id;
	ColdFusion.RichText.setValue(contentId, page_content);
	frm.btnAction.value = btntext;
*/
}

function savepage()
{

	//send data to CFC to edit page, the result will be handled by handleResult function above
	//set dataproxy method to post, to avoid "url too long" error
	dataproxy.setHTTPMethod("POST");
	var frm = document.frmPage;
	var richTextField = frm.txtPageContent.id;
	contentValue = ColdFusion.getElementValue(richTextField, frm);
	dataproxy.savePage(
		 frm.pk_pages.value,
		 contentValue
	);
	ColdFusion.Grid.refresh('pageGrid', true);
	ColdFusion.Window.hide('editPageWin');
}

