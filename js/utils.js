function goxss(url){
	document.frmxss.action = url;
	document.frmxss.submit();
}

function popUpWin(url) {
	w = 500;  // width
	h = 600;  // height
	var features =	'scrollbars=yes, toolbar=no, status=no, menubar=no ' +
					',resizable=no, location=no, directories=no ' +
					',left=' + ((screen.width-w)/2) +
					',top='  + ((screen.height-h)/2) +
					',width=' + w + ',height=' + h;

	myWin =	window.open(url,'WinName',features);
}

function gonext(url){
	var paginationForm = document.forms.pagination_form;
    if (paginationForm && paginationForm.pagego) {
		var next = document.pagination_form.pagego.options[document.pagination_form.pagego.selectedIndex].value;
		document.frm.action = url + next;
		document.frm.submit();
	} else {
        console.error('Form or select element not found.');
    }
}
function gonext2(url){
	document.frm.action = url;
	document.frm.submit();
}

function trim(s) {
	// remove leading and trailing spaces
	while(s.charAt(0) == ' ') s = s.substring(1);
	while(s.charAt(s.length-1) == ' ') s = s.substring(0,s.length-1);
	return s;
}

function jstrim(str) {
	var trimmed = str.replace(/^\s+|\s+$/g, '') ;
	return trimmed;

}
