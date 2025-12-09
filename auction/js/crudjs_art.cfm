// create a new JS proxy object for the CFC	
var dataproxy = new cfcproxy_art();
dataproxy.setCallbackHandler(handleResult);

// this function recieves the response from CFC whenever a CFC function is called.
// we are simply alerting the response but we could do more if we had to. 
function handleResult(response)
{
	alert(response);
}

// the init()
function init(){
 artGrid = ColdFusion.Grid.getGridObject("ArtGrid");
 
 // get the header and fotoer objects
 var gridHead = artGrid.getView().getHeaderPanel(true);
 var tbar = new Ext.Toolbar(gridHead);
 var gridFoot = artGrid.getView().getFooterPanel(true);
 var ds = artGrid.getDataSource();
 
 // add the 2 custom buttons to the toolbar
 //tbar.addButton({text:"Add Art", handler:onAdd });
 //tbar.addSeparator();
 //tbar.addButton({ text:"Delete Art", handler:onDelete });
 
 // add a row double click event for the grid rows.
 // the double click will open a popup window for editing the row.
 var sm = artGrid.getSelectionModel();
 artGrid.on('rowdblclick',function(artGrid, rowIndex, record){
 	var rec = ds.getAt(rowIndex); // get the clicked row
	populateFormArt(rec); // populate the form with values
 	ColdFusion.Window.show('addArtWin'); // display the window
 });
 
  // this shows the display message by default 
 var paging = new Ext.PagingToolbar(gridFoot,ds,{
	  pageSize:25, //number of records displayed in grid
	  displayInfo:true, // change this to false, if you dont want info displayed
	  displayMsg:'Displaying records {0} - {1} of {2}',
	   emptyMsg:"No records to display"
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
Ext.fly(tbar.addSpacer().getEl().parentNode).setStyle('width', '100%');
tbar.add(cb);	   
	   
}

function populateFormArt(record){
	// gets the selected row from double click event and populates the form 
	// could also use ColdFusion.getElementValue() here which gets the bound grid row but I find this method better
	
	// the form
	var frm = document.forms["frmArt"];
	
	// default values if using the "add art" mode
	var title = "";
	var artist= "";
	var medium= "";
	var year= "";
	var price = "";
	var hi = "";
	var lo = "";
	var uid = "0";
	var btntext = "Add Art";
	
	if(record)
	{
		// values for the selected row 
		if(record.data.NAME.length != 0) title = record.data.NAME;
		if(record.data.MANUFACTURER.length != 0) artist = record.data.MANUFACTURER;
		if(record.data.PATH.length != 0) medium = record.data.PATH;
		if(record.data.SPECS.length != 0) year = record.data.SPECS;
		if(record.data.PRICE.length != 0) price = record.data.PRICE;
		if(record.data.HIGH_ESTIMATE.length != 0) hi = record.data.HIGH_ESTIMATE;
		if(record.data.LOW_ESTIMATE.length != 0) lo = record.data.LOW_ESTIMATE;
		if(record.data.UID != '0') uid = record.data.UID; 
		if(record.data.UID != '0') ; btntext = "Update Art";
	}
	//populate the form, finally
	frm.uid.value = uid;
 	frm.txtTitle.value = title;
	frm.txtArtist.value = artist;
	frm.txtMedium.value = medium;
	frm.txtYear.value = year;
	frm.txtPrice.value = price;
	frm.txtHi.value = hi;
	frm.txtLo.value = lo;
	document.getElementById('artImage').src = 'http://<cfoutput>#server_name#</cfoutput>/img/thumbnails/'+uid+'.jpg';
	frm.uid.value = uid;   
	//frm.btnAction.value = btntext;
}

function onAdd(button,event){
	populateFormArt(false);
	ColdFusion.Window.show('addArtWin');
}
function onDelete(){
	ColdFusion.Window.show('deleteArtWin');
}

function saveart()
{
	
	//send data to CFC to add art, the result will be handled by handleResult function above
	var f = document.frmArt;
	dataproxy.saveArt(
		 f.uid.value
		,f.chkLocation.checked
		,f.txtLocationPrice.value
	);
	ColdFusion.Grid.refresh('ArtGrid', true);	
	ColdFusion.Window.hide('addArtWin');
}

function deleteArt(s)
{
	// if user choose to delete, then send the CFC call, otherwise just sit back!
	if (s == 'yes')
	{
	var artGrid = ColdFusion.Grid.getGridObject("ArtGrid");
	var record = artGrid.getSelections();
	// remember, CF makes column names to all UPPERCASE, so dont forget to do that
	dataproxy.deleteArt(record[0].data.UID);
	}
	ColdFusion.Grid.refresh('ArtGrid', true);
	ColdFusion.Window.hide('deleteArtWin');
}

// for searches
	getModelno = function(){
		   var s = ColdFusion.getElementValue('modelno');
		   return s;
		}
	getTitle = function(){
		   var s = ColdFusion.getElementValue('title');
		   return s;
		}
	getArtist = function(){
		   var s = ColdFusion.getElementValue('artist');
		   return s;
		}
	getFromDate = function(){
		   var s = ColdFusion.getElementValue('fromDate');
		   return s;
		}
	getToDate = function(){
		   var s = ColdFusion.getElementValue('toDate');
		   return s;
		}