
 function emailOrderContacts(){
 	//var edit = new admin.models.email();
	//setTimeout(edit.emailEmployeeContactsOrders,1000);
 	//strEmployee = edit.emailEmployeeContactsOrders();
	setTimeout(sendIt,1000);
	
}

sendIt = function(){
	var edit = new admin.models.email();
	procEmail = edit.emailEmployeeContactsOrders();
	
	if(procEmail == 1) emailOrderContacts();
}

	
