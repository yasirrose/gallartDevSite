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
	getMedium = function(){
		   var s = ColdFusion.getElementValue('searchMedium');
		   return s;
		}
	getYear = function(){
		   var s = ColdFusion.getElementValue('searchYear');
		   return s;
		}
	getHeight = function(){
		   var s = ColdFusion.getElementValue('searchHeight');
		   return s;
		}
	getWidth = function(){
		   var s = ColdFusion.getElementValue('searchWidth');
		   return s;
		}
	getDescription= function(){
		   var s = ColdFusion.getElementValue('searchDescription');
		   return s;
		}
	getFromPrice = function(){
		   var s = ColdFusion.getElementValue('searchFromPrice');
		   return s;
		}
	getToPrice= function(){
		   var s = ColdFusion.getElementValue('searchToPrice');
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
	getFromLastedit = function(){
		   var s = ColdFusion.getElementValue('searchFromLastedit');
		   return s;
		}
	getToLastedit = function(){
		   var s = ColdFusion.getElementValue('searchToLastedit');
		   return s;
		}
	getSellerId= function(){
		   var s = ColdFusion.getElementValue('searchSellerId');
		   return s;
		}
    getImageName= function(){
		   var s = ColdFusion.getElementValue('searchImageName');
		   return s;
		}
	getOnSale= function(){
			s = 0;
			if(typeof(gridForm.searchOnSale[0]) != 'undefined' && gridForm.searchOnSale[0].checked){s = 1}
			return s;
		}
	getTrump= function(){
		  	s = 0;
			if(typeof(gridForm.searchTrump[0]) != 'undefined' && gridForm.searchTrump[0].checked){s = 2}
			return s;
		}
	getAuction= function(){
			s = 0;
			if(typeof(gridForm.searchAuction[0]) != 'undefined' && gridForm.searchAuction[0].checked){s = 1}
			return s;
		}
	getSlideshow= function(){
			s = 0;
			if(typeof(gridForm.searchSlideshow[0]) != 'undefined' && gridForm.searchSlideshow[0].checked){s = 1}
			return s;
		}
	getActive= function(){
		   var s = ColdFusion.getElementValue('searchActive');
		   return s;
		}
	getShowResults= function(){
		   var s = ColdFusion.getElementValue('showResults');
		   return s;
		}
	getFrontshow= function(){
			s = 0;
			if(typeof(gridForm.searchFrontshow[0]) != 'undefined' && gridForm.searchFrontshow[0].checked){s = 1}
			return s;
		}
	getBottomHome= function(){
			s = 0;
			if(typeof(gridForm.searchBottomHome[0]) != 'undefined' && gridForm.searchBottomHome[0].checked){s = 1}
			return s;
		}

// the init()
function init(){
 pageGrid = ColdFusion.Grid.getGridObject("data");
 

 var ds = pageGrid.getStore();

	   
}
		
// get current row id 
function gridChange(thisId) {
	setTimeout(function(){
		populateForm(thisId);
    },1000)
}

// populate edit form using row id

 function populateForm(thisId){

 	var edit = new admin.models.art();
	if (navigator.appName=="Netscape"){
		var editFrame = document.getElementById('editFormFrame').contentDocument;
	}
	else{
		var editFrame = document.frames('editFormFrame').document;
	}
 	var frm 				= editFrame.editForm;
	 strListing 				= edit.getListingFromId(thisId);
	 <!--- console.log(strListing); --->
	frm.uid.value 			= thisId;
    frm.imageName.value		= thisId + '.jpg';
	frm.modelno.value 		= strListing['MODELNO'];
	frm.name.value 			= strListing['NAME'];
	frm.manufacturer.value	= strListing['MANUFACTURER'];
	frm.path.value			= strListing['PATH'];
	frm.artType.value 		= strListing['ARTTYPE'];
	artist 					= strListing['MANUFACTURER'];
	medium 					= strListing['PATH'];
	savedartType 			= strListing['ARTTYPE'];
	frm.year.value			= strListing['YEAR'];
	frm.size.value			= strListing['SIZE'];
	frm.edition.value		= strListing['EDITION'];
	frm.retail_price.value	= formatAsDollars(strListing['RETAIL_PRICE']);
	frm.gallery_price.value	= formatAsDollars(strListing['GALLERY_PRICE']);
	frm.special_price.value	= formatAsDollars(strListing['SPECIAL_PRICE']);
	closeout				= strListing['CLOSEOUT'];
	for(i = 0; i < frm.closeout.length; i++){
		if(frm.closeout[i].value == closeout){
			frm.closeout[i].checked = true;
		}
		else{
			frm.closeout[i].checked = false;
		}
	}
	frm.low_estimate.value	= strListing['LOW_ESTIMATE'];
	frm.high_estimate.value	= strListing['HIGH_ESTIMATE'];
	frm.quantity.value		= strListing['QUANTITY'];
	frm.caption.value		= strListing['CAPTION'];
	frm.datestamp.value		= strListing['DATESTAMP'];
	frm.lastedit.value		= strListing['LASTEDIT'];
	active					= strListing['ACTIVE'];
	frontshow				= strListing['FRONTSHOW'];
	family					= strListing['FAMILY'];
	slideshow				= strListing['SLIDESHOW'];
	<!--- startworking --->
	frm.artTypee.value 		= strListing['ARTTYPEE'];
	artTypee				= strListing['ARTTYPEE'];
	frm.artSubject.value 	= strListing['ARTSUBJECT'];
	artSubject				= strListing['ARTSUBJECT'];
	frm.artSize.value 	    = strListing['ARTSIZE'];
	artSize 				= strListing['ARTSIZE'];

	for(i = 0; i < frm.artistview.options.length; i++){
		if(frm.artistview.options[i].value == artist){
			frm.artistview.options[i].selected = true;
		}
		else{
			frm.artistview.options[i].selected = false;
		}
	}

	<!--- newlyADDed --->
	// Split the artTypee string into an array
	var savedartTypeeValues = artTypee.split(',');
	<!--- console.log(artTypee);
	console.log(frm.artTypees.options.length); --->
	
	for (var k = 0; k < frm.artTypees.options.length; k++) {
		<!--- console.log(savedartTypeeValues.indexOf(frm.artTypees.options[k].value)); --->		
		frm.artTypees.options[k].selected = (savedartTypeeValues.indexOf(frm.artTypees.options[k].value) !== -1);
	}
	
    if (frm.artTypees.classList.contains('chosen-select')) {
        // Get the Chosen select element
        var chosenSelect = editFrame.querySelector('.artTypeesvalue');
		<!--- console.log(chosenSelect); --->
        // Trigger Chosen update event
        if (chosenSelect) {
            chosenSelect.dispatchEvent(new Event('chosen:updated', { bubbles: true }));
        }
	}
	

	// Split the artTypee string into an array
	var savedartSubjectValues = artSubject.split(',');	
	for (var k = 0; k < frm.artSubjectt.options.length; k++) {
		frm.artSubjectt.options[k].selected = (savedartSubjectValues.indexOf(frm.artSubjectt.options[k].value) !== -1);
	}
	
    if (frm.artSubjectt.classList.contains('chosen-select')) {
				
        var chosenSelect = editFrame.querySelector('.artSubjectvalue');		
        if (chosenSelect) {
            chosenSelect.dispatchEvent(new Event('chosen:updated', { bubbles: true }));
        }
	}
	
	// Split the artTypee string into an array
	var savedartSizeValues = artSize.split(',');	
	for (var k = 0; k < frm.artSizee.options.length; k++) {
		frm.artSizee.options[k].selected = (savedartSizeValues.indexOf(frm.artSizee.options[k].value) !== -1);
	}
	
    if (frm.artSizee.classList.contains('chosen-select')) {
				
        var chosenSelect = editFrame.querySelector('.artSizevalue');		
        if (chosenSelect) {
            chosenSelect.dispatchEvent(new Event('chosen:updated', { bubbles: true }));
        }
    }





<!--- console.log(frm.artTypee.options.length);
	console.log(strListing['ARTTYPEE']); --->
	<!--- for(i = 0; i < frm.artTypee.options.length; i++){
		if(frm.artTypee.options[i].value == artTypee){
			frm.artTypee.options[i].selected = true;
		}
		else{
			frm.artTypee.options[i].selected = false;
		}
	}

	for(i = 0; i < frm.artSubject.options.length; i++){
		if(frm.artSubject.options[i].value == artSubject){
			frm.artSubject.options[i].selected = true;
		}
		else{
			frm.artSubject.options[i].selected = false;
		}
	}

	for(i = 0; i < frm.artSize.options.length; i++){
		if(frm.artSize.options[i].value == artSize){
			frm.artSize.options[i].selected = true;
		}
		else{
			frm.artSize.options[i].selected = false;
		}
	} --->
	
	<!--- end here --->
	// Split the savedartType string into an array
	var savedValues = savedartType.split(',');
	
	// Loop through each option in the select element
    for (var k = 0; k < frm.artTypes.options.length; k++) {
        // Check if the option value exists in the savedValues array
        frm.artTypes.options[k].selected = (savedValues.indexOf(frm.artTypes.options[k].value) !== -1);
    }

    // After updating the selections, if you're using Chosen library, you need to trigger its update event
    if (frm.artTypes.classList.contains('chosen-select')) {
        // Get the Chosen select element
        var chosenSelect = editFrame.querySelector('.chosen-select');
		<!--- console.log('chosenSelect122:'+ chosenSelect); --->
        // Trigger Chosen update event
        if (chosenSelect) {
            chosenSelect.dispatchEvent(new Event('chosen:updated', { bubbles: true }));
        }
    }
	
	for(i = 0; i < frm.catstringview.options.length; i++){
		if(frm.catstringview.options[i].value == medium){
			frm.catstringview.options[i].selected = true;
		}
		else{
			frm.catstringview.options[i].selected = false;
		}
	}
	for(i = 0; i < frm.active.length; i++){
		if(frm.active[i].value == active){
			frm.active[i].checked = true;
		}
		else{
			frm.active[i].checked = false;
		}
	}
	if(active == 1){
		frm.deactivated.value = 0;
	} else {
		frm.deactivated.value = 1;
	}
	for(i = 0; i < frm.frontshow.options.length; i++){
		if(frm.frontshow.options[i].value == frontshow){
			frm.frontshow.options[i].selected = true;
		}
		else{
			frm.frontshow.options[i].selected = false;
		}
	}
	for(i = 0; i < frm.family.length; i++){
		if(frm.family[i].value == family){
			frm.family[i].checked = true;
		}
		else{
			frm.family[i].checked = false;
		}
	}
	for(i = 0; i < frm.slideshow.length; i++){
		if(frm.slideshow[i].value == slideshow){
			frm.slideshow[i].checked = true;
		}
		else{
			frm.slideshow[i].checked = false;
		}
	}
	editFrame.getElementById('clickEnlarge').href = 'http://<cfoutput>#server_name#</cfoutput>/img/'+thisId+'.jpg?'+new Date().getTime();
	editFrame.getElementById('mainImg').src = 'http://<cfoutput>#server_name#</cfoutput>/img/thumbnails/'+thisId+'.jpg?'+new Date().getTime();
	editFrame.getElementById('imageUrl').innerHTML = 'http://<cfoutput>#server_name#</cfoutput>/img/'+thisId+'.jpg';
	// trump info
	trumpLocation = strListing['LOCATION'];
	if(trumpLocation == 2){
		frm.location[0].checked = true;
	}
	frm.location_price.value 	= formatAsDollars(strListing['LOCATION_PRICE']);
	frm.location_floor.value 	= strListing['LOCATION_FLOOR'];
	frm.location_wall.value 	= strListing['LOCATION_WALL'];
	frm.location_notes.value 	= strListing['LOCATION_NOTES'];
	// auction site
	auction = strListing['AUCTION'];
	if(auction == 1){
		frm.auction[0].checked = true;
	}
	//seller info
	if (strListing['PK_USERS'] > 0 ){
		editFrame.getElementById('displaySellerInfo').style.display = 'block';
		frm.fname.value 	= strListing['FNAME'];
		frm.lname.value 	= strListing['LNAME'];
		frm.email.value 	= strListing['EMAIL'];
		frm.phone.value 	= strListing['PHONE'];
		editFrame.getElementById('emailLink').innerHTML = '<a href="mailto:'+strListing['EMAIL']+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
	}
	else{
		editFrame.getElementById('displaySellerInfo').style.display = 'none';
		
	}
	editFrame.getElementById('coaLink').innerHTML = '<input type="Button" value="CREATE COA" onclick="popupWin(\'index.cfm?event=forms.coa&listingId='+thisId+'\')">';
	editFrame.getElementById('orderLink').innerHTML = '<input type="Button" value="CREATE ORDER" onclick="popupWin(\'index.cfm?event=orders.newOrder&modelNo='+strListing['MODELNO']+'\')">';
	//hide gridRefresh Message
	if (editFrame.getElementById('gridRefreshMsg') != null){
		editFrame.getElementById('gridRefreshMsg').style.display = 'none';
	}
    if (strListing['ADDITIONAL_IMAGES'].length != 0 ){
        editFrame.getElementById('addImageFrame').src = 'http://www.gallart.com/admin/views/listings/showAdditional.cfm?pid=' + thisId;
    } else {
    	editFrame.getElementById('addImageFrame').src = '';
   	}

	
}

function refreshGrid(){
	ColdFusion.Grid.refresh('data',true);
}

function doEdit(type) {

     var edit = new admin.models.art();
     edit.setForm("editForm");
     
     if (type == 'edit'){
     		
      if ( edit.editListingsFromForm()) {
          ColdFusion.Grid.refresh('data',true);
	   //populateFirstRow();
	   alert( 'Listing successfully edited.')
      } 
      else { alert( 'There was a problem in the processing.')}
       }
    else {
    	
    	if ( edit.deleteListing()) {
          ColdFusion.Grid.refresh('data',true);
	   //populateFirstRow();
      } 
      else { alert( 'There was a problem in the processing.')}
       }
       
 document.getElementById('edit').value = 'Edit';
 document.getElementById('delete').style.display = '';
}


function showNew () {
	if (navigator.appName=="Netscape"){
		var editFrame = document.getElementById('editFormFrame').contentDocument;
	}
	else{
		var editFrame = document.frames('editFormFrame').document;
	}
	var edit 				= new admin.models.art();
	var frm 				= editFrame.editForm;
	frm.uid.value 			= 0;
	strNewModelno 			= edit.getNewModelno();
	frm.modelno.value 		= strNewModelno['MODELNO'];
	frm.newModelno.value	= strNewModelno['MODELNO'];
	frm.newModelno_numeric.value	= strNewModelno['NEW_MODELNO_NUMERIC'];
	frm.name.value 			= '';
	frm.manufacturer.value 	= '';
	frm.path.value			= '';
	frm.artType.value			= '';
	frm.artistview.options[0].selected 		= true;
	frm.artTypes.options[0].selected 		= true;
	frm.catstringview.options[0].selected 	= true;
	frm.year.value			= '';
	frm.size.value			= '';
	frm.edition.value		= '';
	frm.artTypee.value		= '';
	frm.artSubject.value		= '';
	frm.artSize.value		= '';
	frm.retail_price.value	= '';
	frm.gallery_price.value	= '';
	frm.special_price.value	= '';
	for(i = 0; i < frm.closeout.length; i++){
		frm.closeout[i].checked = false;
	}
	frm.low_estimate.value	= '';
	frm.high_estimate.value	= '';
	frm.quantity.value		= '1';
	frm.caption.value		= '';
	frm.datestamp.value		= '';
	frm.lastedit.value		= '';
	frm.active[0].checked 	= true;
	frm.frontshow.options[0].selected 		= true;
	for(i = 0; i < frm.family.length; i++){
		frm.family[i].checked = false;
	}
	for(i = 0; i < frm.slideshow.length; i++){
		frm.slideshow[i].checked = false;
	}
	 	editFrame.getElementById('edit').value 	= 'Add';
	 	editFrame.getElementById('delete').style.display = 'none';
	editFrame.getElementById('imageDisplay').style.display = 'none';
	// trump info
	for(i = 0; i < frm.location.length; i++){
		frm.location[i].checked = false;
	}
	frm.location_price.value 	= '';
	frm.location_floor.value 	= '';
	frm.location_wall.value 	= '';
	frm.location_notes.value 	= '';
	// auction site
	for(i = 0; i < frm.auction.length; i++){
		frm.auction[i].checked = false;
	}
	//show gridRefresh Message
	if (editFrame.getElementById('gridRefreshMsg') != null){
		editFrame.getElementById('gridRefreshMsg').style.display = 'block';
	}
	// hide seller info
	editFrame.getElementById('displaySellerInfo').style.display = 'none';
    // hide additional images
	//editFrame.getElementById('viewAdditionalButton').style.display = 'none';
}


function printImageSheet() {

    var imageSheet = new admin.models.art();

    imageSheet.setForm("imageSheetForm");
	strImageTable = imageSheet.getImagesByArtist();
	imageTable = strImageTable['IMAGESHEETTABLE'];
	imgRecordcount = strImageTable['RECORDCOUNT'];
    document.getElementById('displaySheet').innerHTML = imageTable;
	document.getElementById('imgSheetRecordcount').innerHTML = imgRecordcount;
	window.print();
}

