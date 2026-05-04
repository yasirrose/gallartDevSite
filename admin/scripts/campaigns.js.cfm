// create a new JS proxy object for the CFC
var dataproxy = new cfcproxy_campaigns();
dataproxy.setCallbackHandler(handleResult);

// this function recieves the response from CFC whenever a CFC function is called.
// we are simply alerting the response but we could do more if we had to.
function handleResult(response)
{
  alert(response);
}

// the init()
function init(){
 grid = ColdFusion.Grid.getGridObject("campaignGrid");
  // get the header and fotoer objects
 //var gridHead = grid.getView().getHeaderPanel(true);


// console.log(grid)

grid.on("itemdblclick", showListing);



//  var gridHead = grid.getTopToolbar();
//  var tbar = new Ext.Toolbar(gridHead);
 var tbar = ColdFusion.Grid.getTopToolbar("campaignGrid");
//  var gridFoot = grid.getBottomToolbar();

 var ds = grid.getStore();

 var tb = new Ext.Toolbar({
renderTo: document.getElementById('aboveGrid'),
   width: document.getElementById(grid.id).width,
items: [
{ text:"Add Campaign", cls:"x-btn-text-icon", handler:onAdd },'-',
      { text:"Delete Campaign", cls:"x-btn-text-icon", handler:onDelete }
]
});

 // add the 2 custom buttons to the toolbar
 //tbar.addButton({text:"Add Campaign", handler:onAdd });
 //tbar.addSeparator();
 //tbar.addButton({ text:"Delete Campaign", handler:onDelete });

//  grid.addListener("rowdblclick",showListing);

 function showListing(grid,rowIndex,e){
     var record = ds.getAt(rowIndex);
console.log(record)
console.log(ds)
console.log(rowIndex)
console.log(rowIndex.internalId)
console.log(e)
   //console.log(record.data.PK_CAMPAIGN)
   document.location.href='http://208.106.244.207/admin/index.cfm?event=campaign.campaign_manage&campaignId=' + rowIndex.internalId;
}

 // add a row double click event for the grid rows.
 // the double click will open a popup window for editing the row.
 //var sm = grid.getSelectionModel();
 //grid.on('rowdblclick',function(grid, rowIndex, record){
  //var rec = ds.getAt(rowIndex); // get the clicked row
  //populateForm(rec); // populate the form with values
  //ColdFusion.Window.show('editCampaignWin'); // display the window
 //});

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
// tbar.add(cb);

}

function populateForm(record){
  // gets the selected row from double click event and populates the form
  // could also use ColdFusion.getElementValue() here which gets the bound grid row but I find this method better

  // the form
  var frm = document.forms["frmCampaign"];

  // default values if using the "add campaign" mode
  var campaign_title = "";
  var pk_campaign = "0";
  var btntext = "Add Campaign";

  if(record)
  {
    // values for the selected row
    campaign_title = record.data.CAMPAIGN_TITLE;
    if(record.data.PK_CAMPAIGN != '0') pk_campaign = record.data.PK_CAMPAIGN;
    if(record.data.PK_CAMPAIGN != '0') ; btntext = "Update Campaign";
  }
  //populate the form, finally
  frm.pk_campaign.value = pk_campaign;
  frm.txtCampaignTitle.value = campaign_title;
  frm.pk_campaign.value = pk_campaign;
  frm.btnAction.value = btntext;
}

function onAdd(button,event){
  populateForm(false);
  ColdFusion.Window.show('editCampaignWin');
}
function onDelete(){
  ColdFusion.Window.show('deleteCampaignWin');
}

function savecampaign()
{
  //send data to CFC to add campaign, the result will be handled by handleResult function above
  //set dataproxy method to post, to avoid "url too long" error
  dataproxy.setHTTPMethod("POST");
  var frm = document.frmCampaign;
  dataproxy.addCampaign(
     frm.pk_campaign.value,
     frm.txtCampaignTitle.value
  );
  ColdFusion.Grid.refresh('campaignGrid', true);
  ColdFusion.Window.hide('editCampaignWin');
}

function deleteCampaign(s)
{
  // if user choose to delete, then send the CFC call, otherwise just sit back!
  if (s == 'yes')
  {
  var grid = ColdFusion.Grid.getGridObject("campaignGrid");
  //var record = grid.getSelections();
  var record = grid.getSelectionModel().getSelected();
	var selected = record.items[0].data;

  // remember, CF makes column names to all UPPERCASE, so dont forget to do that
  dataproxy.deleteCampaign(selected.PK_CAMPAIGN);
  }
  ColdFusion.Grid.refresh('campaignGrid', true);
  ColdFusion.Window.hide('deleteCampaignWin');
}
