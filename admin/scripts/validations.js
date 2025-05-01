function CheckEntries(){
	// EMAIL TEMPLATE FORM
	if(document.frmEmailTemplate != 'undefined'){
		if(document.frmEmailTemplate.txtEmailName.value == ''){
			alert('You must enter a title for the Email Template');
			return false;
		}
		else{
			return true;
		}
	}

}
