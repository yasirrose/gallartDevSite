<cfscript>
	param name='url.id' default='0';

	email = new admin.models.email();

	if (url.keyExists('id')) {
		emailTemplate = email.getEmailTemplate(url.id);
	}

	// Variables to store response
	resultMessage = "";
	success = false; // default is false

	if (structKeyExists(form, 'fieldnames')) {
		try {
			// Attempt to save email template
			resultMessage = email.saveEmailTemplate(
				pk_emailtemplate=form.id,
				email_name=form.txtEmailName,
				email_content=form.txtEmailContent
			);
			
			// If saveEmailTemplate executes without throwing, success = true
			// success = true;
			if (listFindNoCase("EmailTemplate Added,EmailTemplate Updated", resultMessage)) {
				success = true;
			} else {
				success = false;
			}
		} catch (any e) {
			// If any error occurs, set success = false
			resultMessage = e.message; // or e.detail
			success = false;
		}
	}
</cfscript>


<cfoutput>

	     <cfif len(resultMessage)>
			<script>
				alert("#JSStringFormat(resultMessage)#"); // show the actual error message
				// Only close window if operation was successful
				<cfif success>
					window.opener.location.reload();
					window.close();
				</cfif>
			</script>
		</cfif>
	<cfform name="frmEmailTemplate" onsubmit="return validateEmailForm()">
		<input type="hidden" name="id" value="#url.id#" />
		<input type="hidden" name="fieldnames" value="1">

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
