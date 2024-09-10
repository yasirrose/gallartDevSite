getModelno = function(){
	var s = ColdFusion.getElementValue('searchModelno');
	return s;
 }
getTitle = function(){
	var s = ColdFusion.getElementValue('searchTitle');
	return s;
 }
getArtist = function(){
	var s = ColdFusion.getElementValue('searchArtist');
	return s;
 }
getShowResults= function(){
	var s = ColdFusion.getElementValue('showResults');
	return s;
 }



// the init()
function init(){
pageGrid = ColdFusion.Grid.getGridObject("data");

//  pageGrid.addListener("rowclick",showListing);
pageGrid.on("itemdblclick", showListing);

// get the header and fotoer objects
//var gridHead = pageGrid.getView().getHeaderPanel(true);
//  var gridHead = pageGrid.getTopToolbar();
var tbar = ColdFusion.Grid.getTopToolbar("data");
//  var gridFoot = pageGrid.getBottomToolbar();
var ds = pageGrid.getStore();


// this shows the display message by default
/* var paging = new Ext.PagingToolbar(gridFoot,ds,{
pageSize:10, //number of records displayed in grid
displayInfo:true, // change this to false, if you dont want info displayed
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


function showListing(pageGrid,rowIndex,e){
var record = ds.getAt(rowIndex);

var frame = document.getElementById('campaignListFrame').contentWindow.document;
$(frame).find('#listingId').val(record.data.UID);

var $f = $("#campaignListFrame");
$f[0].contentWindow.addListing();
//refreshIframe();
}

function refreshIframe(){
$("#campaignListFrame").attr("src","http://<cfoutput>#server_name#</cfoutput>/admin/index.cfm?event=campaign.campaign_list");
}

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



function refreshGrid(){
ColdFusion.Grid.refresh('data',true);
}



