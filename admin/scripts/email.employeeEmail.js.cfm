
 function emailOrderContacts(){
 	if($('#emailTemplates').val() == ''){
		alert('Please select an email template');
		return false;
	} else {
		setTimeout(function(){
			sendOrderEmail('');
		},2000);
	}
}

 function completeEmail(){
 	setTimeout(function(){
		sendOrderEmail('latest')
	},2000)
}

 function sendEmailToMe(){
 	if($('#emailTemplates').val() == ''){
		alert('Please select an email template');
		return false;
	} else {
		setTimeout(function(){
			sendOrderEmail('emailToMe');
		},2000);
	}
}

sendOrderEmail = function(p){
	var edit = new admin.models.email();
	procEmail = edit.emailEmployeeContactsOrders(p);
	ColdFusion.Window.show('emailProgress');
	if(p != 'emailToMe'){
		$('#emailProgressDisplay').append('<div>' + procEmail['EMAIL'] + '</div>');
		if(procEmail['RECORDCOUNT'] == 1){
			if(p == 'latest'){
				completeEmail();
			} else {
				emailOrderContacts();
			}
		} else {
			$('#emailProgressDisplay').append('<div>EMAIL COMPLETE!</div>');
			$('#completeLatest').hide();
		}
	} else {
		$('#emailProgressDisplay').append('<div>EMAIL COMPLETE!</div>');
		$('#completeLatest').hide();
	}
}

 function emailLeadContacts(){
	setTimeout(sendLeadEmail,2000);
}

sendLeadEmail = function(){
	var edit = new admin.models.email();
	procEmail = edit.emailEmployeeContactsLeads();
	ColdFusion.Window.show('emailProgress');
	$('#emailProgressDisplay').append('<div>' + procEmail['EMAIL'] + '</div>');
	if(procEmail['RECORDCOUNT'] == 1) emailLeadContacts();
}

selectEmailTemplate = function(t){
	if(t != ''){
		window.open('index.cfm?event=email.editorEmailTemplate&id=' + t, 'editor', 'width=800,height=800,left=0,top=0,resizable=yes,scrollbars=yes');

		/*
		var edit = new admin.models.email();
		getTemplate = edit.getEmailTemplate(t);
		emailContent = getTemplate.DATA[0][2];
		var emailContentId = document.forms['contentForm'].emailContent.id;
		// ColdFusion.RichText.setValue(emailContentId, emailContent);
		$('.emailTemplateSubmit').show();
		ColdFusion.Window.show('emailTemplateWin'); */
	}
}

chooseTemplate = function(){
	ColdFusion.Window.hide('emailTemplateWin');
}

viewLatestEmailTemplate = function(){
	var edit = new admin.models.email();
	getTemplate = edit.getLatestEmployeeOrderEmail();
	emailContent = getTemplate.DATA[0][3];
	$('.emailTemplateSubmit').hide();
	var emailContentId = document.forms['contentForm'].emailContent.id;
	ColdFusion.RichText.setValue(emailContentId, emailContent);
	ColdFusion.Window.show('emailTemplateWin');
}

mailToMe = function(){
	sendEmailToMe()
}
