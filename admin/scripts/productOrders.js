	getLname = function(){
		   var s = ColdFusion.getElementValue('searchLname');
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
	getFromDate = function(){
		   var s = ColdFusion.getElementValue('searchFromDate');
		   return s;
		}
	getToDate = function(){
		   var s = ColdFusion.getElementValue('searchToDate');
		   return s;
		}

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
 

 function populateForm(record){
	var edit = new admin.models.orders();
	var frm = document.forms["editForm"];
 	aOrder = edit.getOrder(document.getElementById('orderuid').value);
	paymentMethod = aOrder[1];
	for(i = 0; i < frm.Payment_Method.options.length; i++){
		if(frm.Payment_Method.options[i].value == paymentMethod){
			frm.Payment_Method.options[i].selected = true;
		}
		else{
			frm.Payment_Method.options[i].selected = false;
		}
	}
	shippingMethod = aOrder[2];
	for(i = 0; i < frm.shipMethod.options.length; i++){
		if(frm.shipMethod.options[i].value == shippingMethod){
			frm.shipMethod.options[i].selected = true;
		}
		else{
			frm.shipMethod.options[i].selected = false;
		}
	}
	origin = aOrder[3];
	for(i = 0; i < frm.origin.options.length; i++){
		if(frm.origin.options[i].value == origin){
			frm.origin.options[i].selected = true;
		}
		else{
			frm.origin.options[i].selected = false;
		}
	}
	document.getElementById('productTable').innerHTML = aOrder[0];
	document.getElementById('amountSaleDisplay').value = formatAsDollars(1*document.getElementById('amountSaleValue').value);
	document.getElementById('taxDisplay').value = formatAsDollars(1*document.getElementById('taxValue').value);
	document.getElementById('subtotalDisplay').value = formatAsDollars(1*document.getElementById('amountSaleValue').value + 1*document.getElementById('taxValue').value);
	document.getElementById('insuranceDisplay').value = formatAsDollars(1*document.getElementById('insuranceValue').value);
	document.getElementById('shipCostDisplay').value = formatAsDollars(1*document.getElementById('shipCostValue').value);
	document.getElementById('totalDisplay').value = formatAsDollars(1*document.getElementById('totalValue').value);
	document.getElementById('discountDisplay').value = formatAsDollars(1*document.getElementById('discountValue').value);
	document.getElementById('amountPaidDisplay').value = formatAsDollars(1*document.getElementById('amountPaidValue').value);
	document.getElementById('balanceDueDisplay').value = formatAsDollars(1*document.getElementById('balanceDueValue').value);
	document.getElementById('searchLnameValue').value = getLname();
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


