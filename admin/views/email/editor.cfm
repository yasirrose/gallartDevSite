<cfscript>
	param name='url.id' default='0';

	email = new admin.models.email();

	if( url.keyExists( 'id' ) ) {
		emailTemplate = email.getEmailTemplate( url.id );
	}

	if( form.keyExists( 'fieldnames' ) ) {
		email.saveEmailTemplate(
			pk_emailtemplate=form.id
			,email_name=form.txtEmailName
			,email_content=form.txtEmailContent
		);

		writeOutput( '
			<script>
				window.opener.location.reload();
				window.close();
			</script>
		' );
	}
</cfscript>

<cfoutput>
	<cfform name="frmEmailTemplate" onsubmit="return validateEmailForm()">
		<input type="hidden" name="id" value="#url.id#" />

		<table width="100%">
			<tr>
				<td colspan="2">
					Title:&nbsp;&nbsp;<cfinput name="txtEmailName" size="40" value="#emailTemplate.email_name#">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<cftextarea name="txtEmailContent" id="txtEmailContent" width="725" height="525" richtext="yes">#emailTemplate.email_content#</cftextarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" name="btnAction" value="Update">
				</td>
			</tr>
		</table>
	</cfform>

	<script>
		function validateEmailForm() {

			if (window.CKEDITOR) {
				for (var instance in CKEDITOR.instances) {
					CKEDITOR.instances[instance].updateElement();
				}
			}

			var name = document.forms["frmEmailTemplate"]["txtEmailName"].value.trim();
			var content = document.forms["frmEmailTemplate"]["txtEmailContent"].value.trim();

			if (name === "") {
				alert("Please Add the Email Title.");
				return false;
			}

			
			if (content === "") {
				alert("Please Add the Email Content.");
				return false;
			}

			return true;
		}
	</script>

</cfoutput>
