////////////   LOG IN ////////////////

function doLogin() {
	// alert();
	ColdFusion.Window.create('loginwindow','Login','views/login/index.cfm',{center:true,modal:true,width:250,height:120});
}

function handleLogin() {
	if (document.getElementById("login-password").value == "") {
		alert("Please enter a password");
		return false;
	}
	else {
		ColdFusion.Ajax.submitForm('loginform','models/employees.cfc?method=getEmployee',handleResponse);
	}
}

function handleResponse(s) {
	if(trim(s)== "true") {
		window.location.href='index.cfm?event=orders.manage';
	} else {
		alert('Your login didn\'t work. Please try again.');
	}
}

////////////   CHANGE PASSWORD ////////////////

function changePassword() {
	ColdFusion.Window.create('passwordChangeWindow','Login','views/orders/change_password.cfm',{center:true,modal:true,width:250,height:200});
}

function handleChangePassword() {
	ColdFusion.Ajax.submitForm('passwordForm','models/employees.cfc?method=changePassword',changePasswordResponse);
}

function changePasswordResponse(s) {
	if(trim(s)== "true") {
		alert('Your password has successfully been changed');
		ColdFusion.Window.hide('passwordChangeWindow');
	} else {
		alert('That\'s not a valid password. Please try again.');
	}
}


////////////   FIND EXISTING CUSTOMER INFORMATION FROM DROPDOWN ////////////////

var customerProxy = new getCustomerById();

function getCustomer(customerId) {
	var strCustomer = customerProxy.getCustomer(customerId);
		document.orderForm.fname.value 		= strCustomer['FNAME'];
		document.orderForm.lname.value 		= strCustomer['LNAME'];
		document.orderForm.Phone.value 		= strCustomer['PHONE'];
		document.orderForm.Address1.value 	= strCustomer['ADDRESS1'];
		document.orderForm.City.value 		= strCustomer['CITY'];
		document.orderForm.State.value 		= strCustomer['STATE'];
		document.orderForm.Country.value 	= strCustomer['COUNTRY'];
		document.orderForm.Zip.value 		= strCustomer['ZIP'];
		document.orderForm.Email.value 		= strCustomer['EMAIL'];
		document.orderForm.BusinessPhone.value 	= strCustomer['BUSINESSPHONE'];
		document.orderForm.CellPhone.value 	= strCustomer['CELLPHONE'];
		document.orderForm.website.value 	= strCustomer['WEBSITE'];
		document.orderForm.Fax.value 		= strCustomer['FAX'];
		document.orderForm.DriversLicense.value = strCustomer['DRIVERSLICENSE'];
		document.orderForm.Consultant.value = '';
		document.orderForm.assignedTo.value = 0;

}

////////////   FIND EXISTING LEAD INFORMATION FROM DROPDOWN ////////////////

var leadProxy = new getLeadById();

function getLead(leadId) {
	var strLead = leadProxy.getLead(leadId);
		document.orderForm.fname.value 		= strLead['FNAME'];
		document.orderForm.lname.value 		= strLead['LNAME'];
		document.orderForm.Phone.value 		= strLead['PHONE'];
		document.orderForm.Address1.value 	= strLead['ADDRESS'];
		document.orderForm.City.value 		= strLead['CITY'];
		document.orderForm.State.value 		= strLead['STATE'];
		document.orderForm.Country.value 	= strLead['COUNTRY'];
		document.orderForm.Zip.value 		= strLead['ZIP'];
		document.orderForm.Email.value 		= strLead['EMAIL'];
		document.orderForm.CellPhone.value 	= strLead['CELLPHONE'];
		document.orderForm.BusinessPhone.value 	= strLead['BUSINESSPHONE'];
		document.orderForm.website.value 	= strLead['WEBSITE'];
		document.orderForm.Fax.value 		= ''
		document.orderForm.DriversLicense.value = ''
		document.orderForm.Consultant.value = '';
		document.orderForm.assignedTo.value = strLead['FK_EMPLOYEES'];
}

////////////   SEARCH ALL CONTACTS WINDOW ////////////////


function openSearchAllContactsWindow() {
	document.getElementById('allcontacts_lname').value = '';
	document.getElementById('allcontacts_email').value = '';
	document.getElementById('displayAllContacts').innerHTML = '';
	ColdFusion.Window.show('searchAllContactsWindow');
}

var allContactsProxy = new getAllContacts();

function submitSearchAllContacts(lname,email) {
	document.getElementById('displayAllContacts').innerHTML = '';
	var result = allContactsProxy.getAllContacts(lname,email);
	document.getElementById('displayAllContacts').innerHTML = result;
}


function getContact(email) {
	var strContact = allContactsProxy.getContact(email);
		document.orderForm.fname.value 		= strContact['FNAME'];
		document.orderForm.lname.value 		= strContact['LNAME'];
		document.orderForm.Phone.value 		= strContact['PHONE'];
		document.orderForm.Address1.value 	= strContact['ADDRESS'];
		document.orderForm.City.value 		= strContact['CITY'];
		document.orderForm.State.value 		= strContact['STATE'];
		document.orderForm.Country.value 	= strContact['COUNTRY'];
		document.orderForm.Zip.value 		= strContact['ZIP'];
		document.orderForm.Email.value 		= strContact['EMAIL'];
		document.orderForm.CellPhone.value 	= strContact['CELLPHONE'];
		document.orderForm.BusinessPhone.value 	= strContact['BUSINESSPHONE'];
		document.orderForm.website.value 	= strContact['WEBSITE'];
		document.orderForm.Fax.value 		= ''
		document.orderForm.DriversLicense.value = ''
		document.orderForm.Consultant.value = '';
		ColdFusion.Window.hide('searchAllContactsWindow');
}

////////////   FILL FORM FIELDS FROM AUTOSUGGEST ////////////////

/*
function fillLname(formname,fieldvalue){
	if(formname == 'orderform'){
		thisEmail = trim(fieldvalue.split('-')[1]);
		var strContact = allContactsProxy.getContact(thisEmail);
		document.orderForm.fname.value 		= strContact['FNAME'];
		document.orderForm.lname.value 		= strContact['LNAME'];
		document.orderForm.Phone.value 		= strContact['PHONE'];
		document.orderForm.Address1.value 	= strContact['ADDRESS'];
		document.orderForm.City.value 		= strContact['CITY'];
		document.orderForm.State.value 		= strContact['STATE'];
		document.orderForm.Country.value 	= strContact['COUNTRY'];
		document.orderForm.Zip.value 		= strContact['ZIP'];
		document.orderForm.Email.value 		= strContact['EMAIL'];
		document.orderForm.CellPhone.value 	= strContact['CELLPHONE'];
		document.orderForm.BusinessPhone.value 	= strContact['BUSINESSPHONE'];
		document.orderForm.website.value 	= strContact['WEBSITE'];
		document.orderForm.Fax.value 		= ''
		document.orderForm.DriversLicense.value = ''
		document.orderForm.Consultant.value = '';
	}
}
*/
function fillLname(formname,fieldvalue){
	if(formname == 'orderform'){
		var fieldValueArray = fieldvalue.split("|");
		var thisId = fieldValueArray[1];
		var thisTable = fieldValueArray[2];
		var strContact = allContactsProxy.getContactById(thisId,thisTable);
		document.orderForm.fname.value 		= strContact['FNAME'];
		document.orderForm.lname.value 		= strContact['LNAME'];
		document.orderForm.Phone.value 		= strContact['PHONE'];
		document.orderForm.Address1.value 	= strContact['ADDRESS'];
		document.orderForm.City.value 		= strContact['CITY'];
		document.orderForm.State.value 		= strContact['STATE'];
		document.orderForm.Country.value 	= strContact['COUNTRY'];
		document.orderForm.Zip.value 		= strContact['ZIP'];
		document.orderForm.Email.value 		= strContact['EMAIL'];
		document.orderForm.CellPhone.value 	= strContact['CELLPHONE'];
		document.orderForm.BusinessPhone.value 	= strContact['BUSINESSPHONE'];
		document.orderForm.website.value 	= strContact['WEBSITE'];
		document.orderForm.Fax.value 		= ''
		document.orderForm.DriversLicense.value = ''
		document.orderForm.Consultant.value = '';
	}
}
/*
function fillEmail(formname,fieldvalue){
	if(formname == 'orderform'){
		thisEmail = fieldvalue;
		var strContact = allContactsProxy.getContact(thisEmail);
		document.orderForm.fname.value 		= strContact['FNAME'];
		document.orderForm.lname.value 		= strContact['LNAME'];
		document.orderForm.Phone.value 		= strContact['PHONE'];
		document.orderForm.Address1.value 	= strContact['ADDRESS'];
		document.orderForm.City.value 		= strContact['CITY'];
		document.orderForm.State.value 		= strContact['STATE'];
		document.orderForm.Country.value 	= strContact['COUNTRY'];
		document.orderForm.Zip.value 		= strContact['ZIP'];
		document.orderForm.Email.value 		= strContact['EMAIL'];
		document.orderForm.CellPhone.value 	= strContact['CELLPHONE'];
		document.orderForm.BusinessPhone.value 	= strContact['BUSINESSPHONE'];
		document.orderForm.website.value 	= strContact['WEBSITE'];
		document.orderForm.Fax.value 		= ''
		document.orderForm.DriversLicense.value = ''
		document.orderForm.Consultant.value = '';
	}
}
*/
function fillEmail(formname,fieldvalue){
	var fieldValueArray = fieldvalue.split("|");
	var thisId = fieldValueArray[1];
	var thisTable = fieldValueArray[2];
	if(formname == 'orderform'){
		var strContact = allContactsProxy.getContactById(thisId,thisTable);
		document.orderForm.fname.value 		= strContact['FNAME'];
		document.orderForm.lname.value 		= strContact['LNAME'];
		document.orderForm.Phone.value 		= strContact['PHONE'];
		document.orderForm.Address1.value 	= strContact['ADDRESS'];
		document.orderForm.City.value 		= strContact['CITY'];
		document.orderForm.State.value 		= strContact['STATE'];
		document.orderForm.Country.value 	= strContact['COUNTRY'];
		document.orderForm.Zip.value 		= strContact['ZIP'];
		document.orderForm.Email.value 		= strContact['EMAIL'];
		document.orderForm.CellPhone.value 	= strContact['CELLPHONE'];
		document.orderForm.BusinessPhone.value 	= strContact['BUSINESSPHONE'];
		document.orderForm.website.value 	= strContact['WEBSITE'];
		document.orderForm.Fax.value 		= ''
		document.orderForm.DriversLicense.value = ''
		document.orderForm.Consultant.value = '';
	}
}


////////////   OPEN WINDOWS FOR PRODUCT ENTRY ON FORM PAGE ////////////////

function openProductIdWindow() {
	document.getElementById('modelno').value = '';
	ColdFusion.Window.show('artIdWindow');
}

function openProductTitleWindow() {
	document.getElementById('artTitle').value = '';
	ColdFusion.Window.show('artTitleWindow');
}

function openProductEntryWindow() {
	document.getElementById('title').value = '';
	document.getElementById('artist').value = '';
	document.getElementById('desc').value = '';
	document.getElementById('priceInput').value = '';
	ColdFusion.Window.show('artInfoWindow');
}

function openFramingEntryWindow() {
	document.getElementById('title').value = '';
	document.getElementById('artist').value = '';
	document.getElementById('desc').value = '';
	document.getElementById('priceInput').value = '';
	ColdFusion.Window.show('framingInfoWindow');
}

////////////   GET ART BY ART ID ////////////////

var artProxy = new getArtById();

function findArt(artId) {

	var result = artProxy.getArt(artId);
	if (result == true) {
		displayArtListings();
		ColdFusion.Window.hide('artIdWindow');
	}
	else {
		alert('That Art ID does not exist.');
		return false;
	}
}

function findArtTitle(name) {

	var result = artProxy.getArtByTitle(name);
	if (result == true) {
		displayArtListings();
		ColdFusion.Window.hide('artTitleWindow');
	}
	else {
		alert('That Product Title does not exist.');
		return false;
	}
}

function submitArtInfo() {
	ColdFusion.Ajax.submitForm('artInfoForm','models/art.cfc?method=saveArtInfo',saveArtResponse);
}

function saveArtResponse(s){
	if(trim(s)== "true") {
		displayArtListings();
		ColdFusion.Window.hide('artInfoWindow');

	} else {
		alert('There was a problem in the processing.');
		return false;
	}

}

function submitFramingInfo() {
	ColdFusion.Ajax.submitForm('framingInfoForm','models/art.cfc?method=saveFramingInfo',saveFramingResponse);
}

function saveFramingResponse(s){
	if(trim(s)== "true") {
		displayArtListings();
		ColdFusion.Window.hide('framingInfoWindow');

	} else {
		alert('There was a problem in the processing.');
		return false;
	}

}

function delArt(rowNum) {
	var result = artProxy.deleteArtListing(rowNum);
	if (result == true) {
		displayArtListings();
	}
	else {
		alert('There was a problem in the processing.');
		return false;
	}
}

////////////   DISPLAY PRODUCT LISTINGS ON FORM PAGE ////////////////

function displayArtListings() {
	var display = artProxy.createArtDisplay();
	document.getElementById('artListings').innerHTML = display;
}

////////////   CHANGE QUANTITY OF PRODUCT LISTINGS ON FORM PAGE ////////////////

function addQuantity(thisIndex,thisValue) {
	var setItemQuantity = artProxy.setItemQuantity(thisIndex,thisValue);
}

////////////   CHANGE PRICE OF PRODUCT LISTINGS ON FORM PAGE ////////////////

function addPrice(thisIndex,thisValue) {
	var setItemPrice = artProxy.setItemPrice(thisIndex,thisValue);
}

////////////   CHECK PASSWORD ON LEAD PAGE ////////////////

function checkPasswordLead() {
	// remove lname validation
	/*if(document.leadForm.lname.value == ''){alert('Please enter a last name for the lead')}
	else{ColdFusion.Ajax.submitForm('leadForm','models/employees.cfc?method=checkPassword',passwordResponseLead);}
	return false;*/
	ColdFusion.Ajax.submitForm('leadForm','models/employees.cfc?method=checkPassword',passwordResponseLead);
}

function passwordResponseLead(s) {
	if(trim(s)== "true") {
		document.leadForm.submit();
	} else {
		alert('That\'s not a valid password. Please try again.');
		return false;
	}
}

////////////   CHECK PASSWORD ON ORDER PAGE ////////////////

function checkPasswordOrder() {
	if(document.orderForm.lname.value == ''){alert('Please enter a last name on the order')}
	if(document.orderForm.Email.value == ''){alert('Please enter an email address for the customer on the order')}
	else{ColdFusion.Ajax.submitForm('orderForm','models/employees.cfc?method=checkPassword',passwordResponseOrder);}
	return false;
}

function passwordResponseOrder(s) {
	if(trim(s)== "true") {
		document.orderForm.submit();
	} else {
		alert('That\'s not a valid password. Please try again.');
		return false;
	}
}


////////////   COMPUTE AMOUNTS ON CONFIRM PAGE ////////////////

function computeAmount() {

	document.getElementById('totalSale').innerHTML =
	formatAsDollars
		(
			1*document.confirmForm.amountSaleValue.value +
			//1*document.confirmForm.framingAmount.value +
			1*document.confirmForm.tax.value
		);
	document.confirmForm.totalSaleValue.value =
			1*document.confirmForm.amountSaleValue.value +
			//1*document.confirmForm.framingAmount.value +
			1*document.confirmForm.tax.value;

	document.getElementById('balanceDue').innerHTML =
	formatAsDollars
		(
			1*document.confirmForm.amountSaleValue.value +
			//1*document.confirmForm.framingAmount.value +
			1*document.confirmForm.tax.value +
			1*document.confirmForm.shipping.value -
			1*document.confirmForm.amountPaid.value
		);

	document.confirmForm.balanceDueValue.value =
			1*document.confirmForm.amountSaleValue.value +
			//1*document.confirmForm.framingAmount.value +
			1*document.confirmForm.tax.value +
			1*document.confirmForm.shipping.value -
			1*document.confirmForm.amountPaid.value

}


////////////   PRINT INVOICE ////////////////

function CheckIsIE()
{
if (navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER') { return true;}
else { return false; }
}


function PrintThisPage() {
	if (CheckIsIE() == true){
	document.ifWorkspace.focus();
	document.ifWorkspace.print();
	}
	else {
	frames['printFrame'].focus();
	frames['printFrame'].print();
	}
	document.getElementById('waitAlert').style.display = 'none';
}

function printWait(){setTimeout ( "PrintThisPage()", 1000 )}


////////////   OPEN EMAIL WINDOW ON LEAD PAGE ////////////////


function submitLeadEmailInfo() {
	ColdFusion.Ajax.submitForm('emailLeadForm','models/mailer.cfc?method=sendMail',saveEmailResponseLead);
}

function saveEmailResponseLead( strReturn ){
	var oReturn = eval('(' + strReturn + ')');
	thisSuccess = oReturn['SUCCESS'];
	if(thisSuccess == 1) {
		ColdFusion.Grid.refresh('leadGrid', true);
		ColdFusion.Window.hide('leadEmailWindow');
	} else {
		alert('There was a problem in the processing.');
		return false;
	}
}

function submitCustomerEmailInfo() {
	ColdFusion.Ajax.submitForm('emailCustomerForm','models/mailer.cfc?method=sendMail',saveEmailResponseCustomer);
}

function saveEmailResponseCustomer( strReturn ){
	var oReturn = eval('(' + strReturn + ')');
	thisSuccess = oReturn['SUCCESS'];
	if(thisSuccess == 1) {
		ColdFusion.Grid.refresh('data', true);
		ColdFusion.Window.hide('customerEmailWindow');
	} else {
		alert('There was a problem in the processing.');
		return false;
	}
}


function openLeadEmailWindow() {
	// if(document.getElementById('sender').value == ''){alert('You must have a valid email address in the system to use this feature.');return false;}
	//compileBody( '' );
	// var frm = document.emailLeadForm;
	emailLeadWindow = window.open('index.cfm?event=leads.sendEmailToLead&id=', 'editor', 'width=800,height=800,left=0,top=0,resizable=yes,scrollbars=yes');

	emailLeadWindow.onload = function () {
		emailLeadWindow.document.getElementById('recipient').value = document.getElementById('leadEmail').value;
		emailLeadWindow.document.getElementById('salutation').value = 'Dear ' + document.getElementById('fname').value + ' ' + document.getElementById('lname').value + ',<br /><br />';
		emailLeadWindow.document.getElementById('closer').value = '<br /><br /> Sincerely, <br /><br />' +
		emailLeadWindow.document.getElementById('senderFname').value + ' ' + emailLeadWindow.document.getElementById('senderLname').value + '<br />' +
			'<a href="http://www.gallart.com">Gallery Art</a><br />' +
			'20633 Biscayne Blvd<br />' +
			'Aventura FL 33180<br />' +
			'305 932 6166 gallery<br />' +
			'305 937 2125 fax';
	}
	// CLEAR BODY CONTENT
	// var page_content = 'Enter email content . . .';
	// contentId = frm.body.id;
	// ColdFusion.RichText.setValue(contentId, page_content);

	// ColdFusion.Window.show('leadEmailWindow');




	/*if( document.getElementById('fk_employees').value == 0 ||
		(document.getElementById('fk_employees').value != 0 && (document.getElementById('fk_employees').value == document.emailLeadForm.currEmpId.value))){
			document.getElementById('recipient').value = document.getElementById('leadEmail').value;
			document.getElementById('assignLeadId').value = document.getElementById('pk_leads').value;
			// CLEAR BODY CONTENT
			document.getElementById('bodyContent').value = 'Enter email content . . .';
			// ASSIGN EMPLOYEE TO LEAD
			ColdFusion.Ajax.submitForm('assignLeadForm','models/leads.cfc?method=assignLead');
			ColdFusion.Window.show('leadEmailWindow');
	}
	else{
		document.getElementById('assignedTo').innerHTML = 'This lead has already been assigned to: <br>' + document.getElementById('empDisplay').innerHTML;
		ColdFusion.Window.show('alreadyAssignedWindow');
	}*/
}

function openCustomerEmailWindow() {
	emailCustomerWindow = window.open('index.cfm?event=orders.sendEmailToCustomer&id=', 'editor', 'width=800,height=800,left=0,top=0,resizable=yes,scrollbars=yes');

	emailCustomerWindow.onload = function () {
		emailCustomerWindow.document.getElementById('recipient').value = document.getElementById('customer_email').value;
		emailCustomerWindow.document.getElementById('salutation').value = 'Dear ' + document.getElementById('fname').value + ' ' + document.getElementById('lname').value + ',<br /><br />';
		emailCustomerWindow.document.getElementById('closer').value = '<br /><br /> Sincerely, <br /><br />' +
		emailCustomerWindow.document.getElementById('senderFname').value + ' ' + emailCustomerWindow.document.getElementById('senderLname').value + '<br />' +
			'<a href="http://www.gallart.com">Gallery Art</a><br />' +
			'20633 Biscayne Blvd<br />' +
			'Aventura FL 33180<br />' +
			'305 932 6166 gallery<br />' +
			'305 937 2125 fax';
	}

/*
	if(document.getElementById('sender').value == ''){alert('You must have a valid email address in the system to use this feature.');return false;}
	//compileBody( '' );
	var frm = document.emailCustomerForm;
	document.getElementById('recipient').value = document.getElementById('customer_email').value;
	document.getElementById('salutation').value = 'Dear ' + document.getElementById('fname').value + ' ' + document.getElementById('lname').value + ',<br /><br />';
	document.getElementById('closer').value = '<br /><br /> Sincerely, <br /><br />' + document.getElementById('senderFname').value + ' ' + document.getElementById('senderLname').value + '<br />' +
	'<a href="http://www.gallart.com">Gallery Art</a><br />' +
	'20633 Biscayne Blvd<br />' +
	'Aventura FL 33180<br />' +
	'305 932 6166 gallery<br />' +
	'305 937 2125 fax'
	// CLEAR BODY CONTENT
	var page_content = 'Enter email content . . .';
	contentId = frm.body.id;
	ColdFusion.RichText.setValue(contentId, page_content);
	ColdFusion.Window.show('customerEmailWindow');
*/
}

/*function compileBody( enterText ){
	var defaultSalutation = 'Dear ' + document.editForm.fname.value + ' ' + document.editForm.lname.value + ',<br /><br />';
	var defaultCloser = '<br /><br /> Sincerely, <br /><br />' + document.emailLeadForm.senderFname.value + ' ' + document.emailLeadForm.senderLname.value + '<br />' +
	'<a href="http://www.gallart.com">Gallery Art</a><br />' +
	'20633 Biscayne Blvd<br />' +
	'Aventura FL 33180<br />' +
	'305 932 6166 gallery<br />' +
	'305 937 2125 fax'
	document.getElementById('body').value = defaultSalutation + enterText + defaultCloser;
}*/

////////////   EMAIL LOG ////////////////

function openMailLogWindow(pk_employees,pk_modules,moduleId,recipientEmail) {
	document.getElementById('viewMailLog').src = 'index.cfm?event=mail_log&pk_employees=' + pk_employees + '&pk_modules=' + pk_modules + '&moduleId=' + moduleId + '&recipientEmail=' + recipientEmail;
	document.getElementById('viewMailLog').style.display = 'block';
}

function closeMailLog(){
	document.getElementById('viewMailLog').style.display = 'none';
}

////////////   DISPLAY IMAGE FROM AUTOSUGGEST (COA FORM) ////////////////

function findImageByTitle(name){
	var thisImagePath = artProxy.getImagePathByTitle(name);
	document.getElementById('imageDisplay').src = thisImagePath;
	document.getElementById('imagePath').value = thisImagePath;
}


////////////   GENERAL FUNCTIONS ////////////////

function trim(str) {
	var trimmed = str.replace(/^\s+|\s+$/g, '') ;
	return trimmed;

}

function formatAsDollars(amount){

// return a 0 dollar value if amount is not valid
// (you may optionally want to return an empty string)
if (isNaN(amount)) {
return "$0.00";
}
// round the amount to the nearest 100th
amount = Math.round(amount*100)/100;

// convert the number to a string
var amount_str = String(amount);

// split the string by the decimal point, separating the
// whole dollar value from the cents. Dollars are in
// amount_array[0], cents in amount_array[1]
var amount_array = amount_str.split(".");

// if there are no cents, add them using "00"
if (amount_array[1] == undefined) {
amount_array[1] = "00";
}
// if the cents are too short, add necessary "0"
if (amount_array[1].length == 1) {
amount_array[1] += "0";
}
// add the dollars portion of the amount to an
// array in sections of 3 to separate with commas
var dollar_array = new Array();
var start;
var end = amount_array[0].length;
while (end>0) {
start = Math.max(end-3, 0);
dollar_array.unshift(amount_array[0].slice(start, end));
end = start;
}

// assign dollar value back in amount_array with
// the a comma delimited value from dollar_array
amount_array[0] = dollar_array.join(",");

// finally construct the return string joining
// dollars with cents in amount_array
return ("$"+amount_array.join("."));
}

function decimalFormat(amount) {
	var decimalAmount = amount.replace('$','');
	decimalAmount = decimalAmount.replace(',','');
	decimalAmount = 1*decimalAmount;
	return decimalAmount;
}
