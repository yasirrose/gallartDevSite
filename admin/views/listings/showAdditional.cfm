<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Untitled Document</title>
</head>

<body>

<style>
	.deleteImg{
		cursor: pointer;
		border: 0;
		
	}
	.addImg {
		margin-bottom: 5px;	
	}
</style>

<cfoutput>
    <script type="text/javascript" src="http://#server_name#/js/jquery-1.3.2.js"></script>
</cfoutput>

<cfif isDefined('form.deleteImg')>
	<CFQUERY NAME="qImages"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        select ADDITIONAL_IMAGES from products
        where uid = #url.pid#
    </CFQUERY>
	<cfset uploaddir = "#application.uploaddir#" />
    <cfset delImage = listGetAt(qImages.additional_images,form.imgIndex + 1) />
	<cffile action="delete" file="#uploaddir#\#delImage#">
	
	<cfset newImageList = listDeleteAt(qImages.additional_images,form.imgIndex + 1) />
    <CFQUERY NAME="qImages"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        UPDATE products SET
        ADDITIONAL_IMAGES = '#newImageList#'
        where uid = #url.pid#
    </CFQUERY>
</cfif>

<CFQUERY NAME="qImages"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	select ADDITIONAL_IMAGES from products
    where uid = #url.pid#
</CFQUERY>

<cfoutput>

<cfloop list="#qImages.additional_images#" index="idx">

    <img src="http://#server_name#/img/#idx#" width="100" class="addImg" /><img src="#imgpath#/trash.gif" class="deleteImg" onclick="return confirm('DELETE -- ARE YOU SURE?')" />

</cfloop>

<form method="post" action="showAdditional.cfm?pid=#url.pid#" name="deleteFrm">
    <input type="hidden" name="imgIndex" id="imgIndex" />
    <input type="hidden" name="deleteImg" />
</form>

</cfoutput>

<script>
$(document).ready(function(){
	$('.deleteImg').each(function(idx){
		$(this).attr('index',idx)
	});
	$('.deleteImg').click(function(){ 
		$('#imgIndex').val($(this).attr('index'));
		deleteFrm.submit();
	});
	
});
</script>


</body>
</html>
