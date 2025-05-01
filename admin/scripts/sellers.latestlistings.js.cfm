// get search values


getActive = function(){
	   var s = ColdFusion.getElementValue('searchActive');
	   return s;
}

getTimeframe = function(){
	   var s = ColdFusion.getElementValue('searchTimeframe');
	   return s;
}


// get current row id - latest listings 
function latestGridChange(thisId) {
	populateLatestForm(thisId);
}

// populate edit form using row id
 function populateLatestForm(thisId){
 	var edit = new admin.models.art();
 	var frm = document.forms["latestEditForm"];
	strLatest = edit.getListingFromId(thisId);
	email = strLatest['SELLER_EMAIL'];
	frm.seller_email.value = email;
	document.getElementById('emailLink').innerHTML = '<a href="mailto: '+email+'" style="color: #000000; text-decoration: none;">[SEND EMAIL]</a>';
	active	= strLatest['ACTIVE'];
	for(i = 0; i < frm.active.length; i++){
		if(frm.active[i].value == active){
			frm.active[i].checked = true;
		}
		else{
			frm.active[i].checked = false;
		}
	}
	manufacturer	= strLatest['MANUFACTURER'];
	for(i = 0; i < frm.manufacturer.options.length; i++){
		if(frm.manufacturer.options[i].value == manufacturer){
			frm.manufacturer.options[i].selected = true;
		}
		else{
			frm.manufacturer.options[i].selected = false;
		}
	}
	path	= strLatest['PATH'];
	for(i = 0; i < frm.path.options.length; i++){
		if(frm.path.options[i].value == path){
			frm.path.options[i].selected = true;
		}
		else{
			frm.path.options[i].selected = false;
		}
	}
 	document.getElementById('clickEnlarge').href = 'http://<cfoutput>#server_name#</cfoutput>/img/'+thisId+'.jpg?'+new Date().getTime();
	document.getElementById('mainImg').src = 'http://<cfoutput>#server_name#</cfoutput>/img/thumbnails/'+thisId+'.jpg?'+new Date().getTime();
	//ColdFusion.Grid.refresh('data',true);
}

  function doEdit(type) {
	  var frm = document.forms["latestEditForm"];
      var edit = new admin.models.art();
      edit.setForm("latestEditForm");
	  if (frm.active[0].checked == true){
		  var mailer = new admin.models.mailer();
		  var sender = 'info@gallart.com';
		  var recipient = document.getElementById('seller_email').value;
		  var subject = 'Your listing was accepted';
		  var body = 
		  'Dear ' + document.getElementById('fname').value + 
		  ' ' + document.getElementById('lname').value + ',<br><br>' +
		  'Your listing, ' + 
		  document.getElementById('name').value +
		  ' by \"' + document.getElementById('manufacturer').value +
		  '\", was accepted by www.gallart.com and is now viewable on the website.<br><br>' +
		  'Thank you,<br> WWW.GALLART.COM';
		  mailer.sendMail(sender,recipient,subject,body)
      }
	  
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
  
  