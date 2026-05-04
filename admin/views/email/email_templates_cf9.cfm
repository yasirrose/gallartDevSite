<cfajaxproxy cfc="admin.models.email" jsclassname="cfcproxy_emailtemplate">
<cfoutput><script type="text/javascript" src="http://#server_name#/admin/scripts/validations.js"></script></cfoutput>

<script>

function saveemailtemplate()
{
	//send data to CFC to add email template, the result will be handled by handleResult function above
	//set dataproxy method to post, to avoid "url too long" error
	dataproxy.setHTTPMethod("POST");
	var frm = document.frmEmailTemplate;
	var richTextField = frm.txtEmailContent.id;
	contentValue = ColdFusion.getElementValue(richTextField, frm);
	dataproxy.saveEmailTemplate(
		 frm.pk_emailtemplate.value,
		 frm.txtEmailName.value,
		 contentValue
	);
	ColdFusion.Grid.refresh('emailTemplateGrid', true);	
	ColdFusion.Window.hide('editEmailTemplateWin');
}

</script>

<cfform name="frmEmailTemplate" method="post" action="">
    <input type="hidden" name="pk_emailtemplate" value="" />
		<table width="100%">
			<tr>
				<td colspan="2">
					Title:&nbsp;&nbsp;<cfinput name="txtEmailName" size="40">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<cftextarea name="txtEmailContent" id="txtEmailContent" width="725" height="625" richtext="yes" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" name="btnAction" value="Add">
				</td>
			</tr>
	</cfform>
