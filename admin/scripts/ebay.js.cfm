// get search values

getLname = function(){
	   var s = ColdFusion.getElementValue('searchLname');
	   return s;
	}
getEmail = function(){
	   var s = ColdFusion.getElementValue('searchEmail');
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
getArtist = function(){
	   var s = ColdFusion.getElementValue('searchArtist');
	   return s;
	}

// the init()
function init(){
	 pageGrid = ColdFusion.Grid.getGridObject("data");
	 
	 var ds = pageGrid.getDataSource();
	 
	 // add a row double click event for the grid rows.
	 // the double click will open a popup window for editing the row.
	 var sm = pageGrid.getSelectionModel();
	 pageGrid.on('rowdblclick',function(pageGrid, rowIndex, record){
		var rec = ds.getAt(rowIndex); // get the clicked row
		location.href='index.cfm?event=ebay.details&pk_ebay=' + rec.data.PK_EBAY;
	 });
  	   
}