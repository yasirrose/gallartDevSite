// create a new JS proxy object for the CFC
var dataproxy = new cfcproxy_emailtemplate();
dataproxy.setCallbackHandler(handleResult);

// this function recieves the response from CFC whenever a CFC function is called.
// we are simply alerting the response but we could do more if we had to.
function handleResult(response)
{
	alert(response);
}

// the init()
function init(){
 grid = ColdFusion.Grid.getGridObject("emailTemplateGrid");

var tb = new Ext.Toolbar({
renderTo: document.getElementById('aboveGrid'),
   width: document.getElementById(grid.id).width,
items: [
	{ text:"Add Template", cls:"x-btn-text-icon", icon:"images/add.png", handler:onAdd },'-',
	{ text:"Delete Template", cls:"x-btn-text-icon", icon:"images/del.png", handler:onDelete }
]
});
  // get the header and fotoer objects
//  var gridHead = grid.getTopToolbar();
//  var tbar = new Ext.Toolbar(gridHead);
var tbar = ColdFusion.Grid.getTopToolbar("emailTemplateGrid");
//  var gridFoot = grid.getBottomToolbar();
 var ds = grid.getStore();

 // add the 2 custom buttons to the toolbar
//  tbar.addButton({text:"Add Email Template", handler:onAdd });
//  tbar.addSeparator();
//  tbar.addButton({ text:"Delete Email Template", handler:onDelete });

 // add a row double click event for the grid rows.
 // the double click will open a popup window for editing the row.
 var sm = grid.getSelectionModel();
 grid.on('rowdblclick',function(grid, rowIndex, record){
 	// var rec = ds.getAt(rowIndex); // get the clicked row
	populateForm(rowIndex); // populate the form with values
 	// ColdFusion.Window.show('editEmailTemplateWin'); // display the window
 });

  // this shows the display message by default
 /* var paging = new Ext.PagingToolbar(gridFoot,ds,{
	  pageSize:10, //number of records displayed in grid
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
               ["5","5 rows per page"],
               ["10","10 rows per page"],
               ["15","15 rows per page"],
               ["20","20 rows per page"]
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

function populateForm(record){
	// gets the selected row from double click event and populates the form
	// could also use ColdFusion.getElementValue() here which gets the bound grid row but I find this method better

	if( record ) {
		var id = record.data.PK_EMAILTEMPLATE;
	} else {
		var id = 0;
	}

	window.open('index.cfm?event=email.editor&id=' + id, 'editor', 'width=800,height=800,left=0,top=0,resizable=yes,scrollbars=yes');

	/* // the form
	var frm = document.forms["frmEmailTemplate"];

	// default values if using the "add email template" mode
	var email_name = "";
	var email_content = "";
	var pk_emailtemplate = "0";
	var btntext = "Add Email Template";

	if(record)
	{
		// values for the selected row
		email_name = record.data.EMAIL_NAME;
		email_content = record.data.EMAIL_CONTENT;
		if(record.data.PK_EMAILTEMPLATE != '0') pk_emailtemplate = record.data.PK_EMAILTEMPLATE;
		if(record.data.PK_EMAILTEMPLATE != '0') ; btntext = "Update Email Template";
	}
	//populate the form, finally
	frm.pk_emailtemplate.value = pk_emailtemplate;
 	frm.txtEmailName.value = email_name;
	contentId = frm.txtEmailContent.id;
	ColdFusion.RichText.setValue(contentId, email_content);
	//frm.txtEmailContent.value = email_content;
	frm.pk_emailtemplate.value = pk_emailtemplate;
	frm.btnAction.value = btntext; */
}

function onAdd(button,event){
	populateForm(false);
	// ColdFusion.Window.show('editEmailTemplateWin');
}
function onDelete(){
	ColdFusion.Window.show('deleteEmailTemplateWin');
}

function saveemailtemplate()
{
	//send data to CFC to add email template, the result will be handled by handleResult function above
	//set dataproxy method to post, to avoid "url too long" error
	dataproxy.setHTTPMethod("POST");
	var frm = document.frmEmailTemplate;
	var richTextField = frm.txtEmailContent.id;
	contentValue = ColdFusion.getElementValue(richTextField, frm);
	dataproxy.saveEmailTemplate(
		 frm.pk_emailtemplate.value,
		 frm.txtEmailName.value,
		 contentValue
	);
	ColdFusion.Grid.refresh('emailTemplateGrid', true);
	ColdFusion.Window.hide('editEmailTemplateWin');
}

function deleteEmailTemplate(s)
{
	// if user choose to delete, then send the CFC call, otherwise just sit back!
	if (s == 'yes')
	{
	var grid = ColdFusion.Grid.getGridObject("emailTemplateGrid");
	//var record = grid.getSelections();

	var record = grid.getSelectionModel().getSelected();
	var selected = record.items[0].data;

	// remember, CF makes column names to all UPPERCASE, so dont forget to do that
	dataproxy.deleteEmailTemplate(selected.PK_EMAILTEMPLATE);
	}
	ColdFusion.Grid.refresh('emailTemplateGrid', true);
	ColdFusion.Window.hide('deleteEmailTemplateWin');
}
