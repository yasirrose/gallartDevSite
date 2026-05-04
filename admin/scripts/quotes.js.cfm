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
getTitle = function(){
	   var s = ColdFusion.getElementValue('searchTitle');
	   return s;
	}

// the init()
function init(){
 pageGrid = ColdFusion.Grid.getGridObject("data");
 
 // get the header and fotoer objects
 var gridHead = pageGrid.getView().getHeaderPanel(true);
 var tbar = new Ext.Toolbar(gridHead);
 var gridFoot = pageGrid.getView().getFooterPanel(true);
 var ds = pageGrid.getDataSource();

 
  // this shows the display message by default 
 var paging = new Ext.PagingToolbar(gridFoot,ds,{
	  pageSize:15, //number of records displayed in grid
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


//alert(document.getElementById('ext-gen134').innerHTML);

// get current row id 
function gridChange(thisId) {
	if( thisId != 'null' ){
		populateForm(thisId);
	}
}

// populate edit form using row id
 function populateForm(thisId){
 	var edit 		= new admin.models.quotes();
 	var frm 		= document.forms["editForm"];
 	strQuote 		= edit.getQuoteFromId(thisId);
	signature 		= strQuote['SIGNATURE'];
	pictureupload	= strQuote['PICTUREUPLOAD'];
	for(i = 0; i < frm.signature.length; i++){
		if(frm.signature[i].value == signature){
			frm.signature[i].checked = true;
		}
		else{
			frm.signature[i].checked = false;
		}
	}
	document.getElementById('artImg').src = 'http://<cfoutput>#server_name#</cfoutput>/quotes/uploads/'+pictureupload;
	email			= strQuote['EMAIL'];
	document.getElementById('emailLink').innerHTML = '<a href="mailto:'+email+'" style="color: #000000; text-decoration: none;">[EMAIL]</a>';
}

function doEdit(type) {

    var edit = new admin.models.quotes();

    edit.setForm("editForm");
   	
   	if ( edit.deleteQuotes()) {
         ColdFusion.Grid.refresh('data',true);
     } 
     else { alert( 'There was a problem in the processing.')}

	document.getElementById('delete').style.display = '';
}