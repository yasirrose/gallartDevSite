	getLname = function(){
		   var s = ColdFusion.getElementValue('searchLname');
		   return s;
		}
	getCompany = function(){
		   var s = ColdFusion.getElementValue('searchCompany');
		   return s;
		}
	getAmountSale = function(){
		   var s = ColdFusion.getElementValue('searchAmountSale');
		   return s;
		}
	getEmail = function(){
		   var s = ColdFusion.getElementValue('searchEmail');
		   return s;
		}
	getEmployee = function(){
		   var s = ColdFusion.getElementValue('searchEmployeeId');
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
	getBalancedue= function(){
			s = 0;
			if(typeof(gridForm.searchBalancedue[0]) != 'undefined' && gridForm.searchBalancedue[0].checked){s = 1}
			return s;
		}
	getOrigin = function(){
		   var s = ColdFusion.getElementValue('searchOrigin');
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
    getState = function(){
		   var s = ColdFusion.getElementValue('searchStates');
		   return s;
		}
	getLexy = function(){
		   s = 0;
			if(typeof(gridForm.searchLexy[0]) != 'undefined' && gridForm.searchLexy[0].checked){s = 1}
		   return s;
		}
/*
function init(){
 	orderGrid = ColdFusion.Grid.getGridObject("data");
  	var ds = orderGrid.getDataSource();
	var frm = document.forms["editForm"];
 	orderGrid.on('rowclick',function(orderGrid, rowIndex, record){
 	var rec = ds.getAt(rowIndex); // get the clicked row
	populateForm(rec); // populate the form with values
 	});
	ds.on('load',function(){populateForm()});
 }
 */

 // get current row id
function gridChange(thisId) {
	populateForm(thisId);
}

 function populateForm(thisId){
	var edit = new admin.models.orders();
 	var frm = document.forms["editForm"];
 	strOrder = edit.getOrder(thisId);
	customer_email = strOrder['CUSTOMER_EMAIL'];
	//document.getElementById('emailLink').innerHTML = '<a href="mailto:'+customer_email+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
	document.getElementById('zip').value = trim(strOrder['CUSTOMER_ZIP']);
	document.getElementById('comments').value = strOrder['COMMENTS'];
	paymentMethod = strOrder['PAYMENT_METHOD'];
	for(i = 0; i < frm.Payment_Method.options.length; i++){
		if(frm.Payment_Method.options[i].value == paymentMethod){
			frm.Payment_Method.options[i].selected = true;
		}
		else{
			frm.Payment_Method.options[i].selected = false;
		}
	}
	shippingMethod = strOrder['SHIPMETHOD'];
	for(i = 0; i < frm.shipMethod.options.length; i++){
		if(frm.shipMethod.options[i].value == shippingMethod){
			frm.shipMethod.options[i].selected = true;
		}
		else{
			frm.shipMethod.options[i].selected = false;
		}
	}
	origin = strOrder['ORIGIN'];
	for(i = 0; i < frm.origin.options.length; i++){
		if(frm.origin.options[i].value == origin){
			frm.origin.options[i].selected = true;
		}
		else{
			frm.origin.options[i].selected = false;
		}
	}
	lexy = strOrder['LEXY'];
	if (frm.lexy){
		if (lexy == 1) {
			frm.lexy.checked = true;
		}
		else {
			frm.lexy.checked = false;
		}
	}
	document.getElementById('productTable').innerHTML = strOrder['itemTable'];

	document.getElementById('amountSaleDisplay').value 	= formatAsDollars(1*strOrder['AMOUNTSALE']);
	document.getElementById('taxDisplay').value 		= formatAsDollars(1*strOrder['TAX']);
	document.getElementById('subtotalDisplay').value 	= formatAsDollars(1*strOrder['AMOUNTSALE'] + 1*strOrder['TAX']);
	document.getElementById('insuranceDisplay').value 	= formatAsDollars(1*strOrder['INSURANCE']);
	document.getElementById('shipCostDisplay').value 	= formatAsDollars(1*strOrder['SHIPCOST']);
	document.getElementById('totalDisplay').value 		= formatAsDollars(1*strOrder['TOTAL']);
	document.getElementById('discountDisplay').value 	= formatAsDollars(1*strOrder['DISCOUNT']);
	document.getElementById('amountPaidDisplay').value 	= formatAsDollars(1*strOrder['AMOUNTPAID']);
	document.getElementById('balanceDueDisplay').value 	= formatAsDollars(1*strOrder['BALANCEDUE']);
	if (strOrder['TOBESHIPPED'] == 1){
		document.getElementById('tobeshipped').innerHTML = 'TO BE SHIPPED';
	}
	else{
		document.getElementById('tobeshipped').innerHTML = '';
	}
	if (strOrder['INCOMPLETE'] == 1){
		document.getElementById('showIncomplete').style.display = 'inline';
	}
	else{
		document.getElementById('showIncomplete').style.display = 'none';
	}
	document.getElementById('searchLnameValue').value = getLname();
	document.getElementById('searchCompanyValue').value = getCompany();
	document.getElementById('searchAmountSaleValue').value = getAmountSale();
	document.getElementById('searchEmailValue').value = getEmail();
	document.getElementById('searchFromDateValue').value = getFromDate();
	document.getElementById('searchToDateValue').value = getToDate();
}


function openProductPrintWindow() {
	ColdFusion.Window.show('printWindow');

}

////////////   COMPUTE AMOUNTS ON ORDER MANAGE PAGE ////////////////

function computeAmountProductOrder() {

	document.editForm.subtotalDisplay.value =
	formatAsDollars
		(
			decimalFormat(document.editForm.amountSaleDisplay.value) +
			decimalFormat(document.editForm.taxDisplay.value)

		);

	document.editForm.totalDisplay.value =
	formatAsDollars
		(
			decimalFormat(document.editForm.amountSaleDisplay.value) +
			decimalFormat(document.editForm.taxDisplay.value) +
			decimalFormat(document.editForm.shipCostDisplay.value) +
			decimalFormat(document.editForm.insuranceDisplay.value)
		);

	// set total value so that it appears as form value (totalDisplay is disabled)
	document.editForm.totalValue.value =
		decimalFormat(document.editForm.amountSaleDisplay.value) +
		decimalFormat(document.editForm.taxDisplay.value) +
		decimalFormat(document.editForm.shipCostDisplay.value) +
		decimalFormat(document.editForm.insuranceDisplay.value)

	document.editForm.balanceDueDisplay.value =
	formatAsDollars
		(
			decimalFormat(document.editForm.amountSaleDisplay.value) -
			decimalFormat(document.editForm.discountDisplay.value) +
			decimalFormat(document.editForm.taxDisplay.value) +
			decimalFormat(document.editForm.shipCostDisplay.value) +
			decimalFormat(document.editForm.insuranceDisplay.value) -
			decimalFormat(document.editForm.amountPaidDisplay.value)
		);

	// set balanceDue value so that it appears as form value (balanceDueDisplay is disabled)
	document.editForm.balanceDueValue.value =
		decimalFormat(document.editForm.amountSaleDisplay.value) -
		decimalFormat(document.editForm.discountDisplay.value) +
		decimalFormat(document.editForm.taxDisplay.value) +
		decimalFormat(document.editForm.shipCostDisplay.value) +
		decimalFormat(document.editForm.insuranceDisplay.value) -
		decimalFormat(document.editForm.amountPaidDisplay.value)
}


function updateSubtotal(status,currStatus,itemPrice,itemId){
	if (status == 'Canceled' && currStatus != 'Canceled' && document.getElementById(itemId).value == 0){
		document.editForm.amountSaleDisplay.value =
		formatAsDollars
		(
			decimalFormat(document.editForm.amountSaleDisplay.value) -
			decimalFormat(itemPrice)
		);
		document.getElementById(itemId).value = 1;

	}
	else if (status != 'Canceled' && document.getElementById(itemId).value == 1){
		document.editForm.amountSaleDisplay.value =
		formatAsDollars
		(
			decimalFormat(document.editForm.amountSaleDisplay.value) +
			decimalFormat(itemPrice)
		);
		document.getElementById(itemId).value = 0;

	}
	computeAmountProductOrder();
}

function openItemEdit(itemId) {
	alert(itemId);
}


function openItemEditWindow(itemId) {
	window.open('index.cfm?event=orders.editItem&id=' + itemId, 'editItem', 'width=500,height=250,left=0,top=0,resizable=yes,scrollbars=yes');
}

function submitItemEdit() {
	ColdFusion.Ajax.submitForm('itemEditForm','models/orders.cfc?method=editItemInfo',saveEditResponse);
}

function saveEditResponse(s){
	if(trim(s)== "true") {
		ColdFusion.Grid.refresh('data', true);
		computeAmountProductOrder();
		ColdFusion.Window.hide('itemEditWindow');

	} else {
		alert('There was a problem in the processing.');
		return false;
	}

}

function deleteOrder(orderId) {
	if (confirm('DELETE -- ARE YOU SURE?')) {
	console.log(orderId)
		var edit = new admin.models.orders();
		var delOrder= edit.deleteOrder(orderId);
		ColdFusion.Grid.refresh('data', true);
	}
}

function deleteOrderItem(itemId,orderId) {
	if (confirm('DELETE -- ARE YOU SURE?')) {
		var edit = new admin.models.orders();
		var delItem = edit.deleteItem(itemId,orderId);
		ColdFusion.Grid.refresh('data', true);
		ColdFusion.Window.hide('itemEditWindow');
		/*if(trim(delItem) == "true") {
			ColdFusion.Grid.refresh('data', true);
			ColdFusion.Window.hide('itemEditWindow');

		} else {
			alert('There was a problem in the processing.');
			return false;
		}*/
		}
		else {
			return false;
		}
}

function openItemAddWindow(orderId) {
	document.getElementById('orderId_mainWindow').value = orderId;
	ColdFusion.Window.show('newItemWindow');

}

////////////   OPEN WINDOWS FOR PRODUCT ENTRY ON FORM PAGE ////////////////

function openProductIdWindowAdmin(orderId) {
	document.getElementById('orderId_artId').value = orderId;
	document.getElementById('modelno').value = '';
	ColdFusion.Window.show('artIdWindow');
	ColdFusion.Window.hide('newItemWindow');
}

function openProductTitleWindowAdmin(orderId) {
	document.getElementById('orderId_title').value = orderId;
	document.getElementById('artTitle').value = '';
	ColdFusion.Window.show('artTitleWindow');
	ColdFusion.Window.hide('newItemWindow');
}

function openProductEntryWindowAdmin(orderId) {
	document.getElementById('orderId_info').value = orderId;
	document.getElementById('title').value = '';
	document.getElementById('artist').value = '';
	document.getElementById('desc').value = '';
	document.getElementById('infoPriceInput').value = '';
	ColdFusion.Window.show('artInfoWindow');
	ColdFusion.Window.hide('newItemWindow');
}

function openFramingEntryWindowAdmin(orderId) {
	document.getElementById('orderId_framing').value = orderId;
	document.getElementById('titleFraming').value = '';
	document.getElementById('artistFraming').value = '';
	document.getElementById('descFraming').value = '';
	document.getElementById('priceInputFraming').value = '';
	ColdFusion.Window.show('framingInfoWindow');
	ColdFusion.Window.hide('newItemWindow');
}

var artProxy = new getArtById();

////////////   GET ART BY ART ID ////////////////

function findArt(modelno,orderId) {

	var result = artProxy.getArt(modelno);
	if (result == true) {
		var edit = new admin.models.orders();
		var addItem = edit.insertItemFromId(modelno,orderId);
		if (addItem == true) {
			ColdFusion.Grid.refresh('data', true);
			ColdFusion.Window.hide('artIdWindow');
		}
		else {
			alert('There was a problem in the processing.');
			return false;
		}
	}
	else {
		alert('That Art ID does not exist.');
		return false;
	}
}

////////////   GET ART BY PRODUCT TITLE ////////////////

function insertArtFromTitle(name,orderId) {

	var edit = new admin.models.orders();
	var addItem = edit.insertItemFromTitle(name,orderId);
	if (addItem == true) {
		ColdFusion.Grid.refresh('data', true);
		ColdFusion.Window.hide('artTitleWindow');
	}
	else {
		alert('There was a problem in the processing.');
		return false;
	}
}

////////////   SUBMIT ITEM NOT IN DATABASE ////////////////

function submitArtInfo() {
	ColdFusion.Ajax.submitForm('itemInfoForm','models/orders.cfc?method=insertItemFromInfo',saveInsertResponse);
}

function saveInsertResponse(s){
	if(trim(s)== "true") {
		ColdFusion.Grid.refresh('data', true);
		ColdFusion.Window.hide('artInfoWindow');

	} else {
		alert('There was a problem in the processing.');
		return false;
	}

}

////////////   SUBMIT FRAMING ORDER ////////////////

function submitFramingInfo() {
	ColdFusion.Ajax.submitForm('framingInfoForm','models/orders.cfc?method=insertFramingInfo',saveFramingInsertResponse);
}

function saveFramingInsertResponse(s){
	if(trim(s)== "true") {
		ColdFusion.Grid.refresh('data', true);
		ColdFusion.Window.hide('framingInfoWindow');

	} else {
		alert('There was a problem in the processing.');
		return false;
	}

}

function editLexy(id,val){
	var edit = new admin.models.orders();
	var editLexy = edit.addDeleteLexy(id,val);
}


