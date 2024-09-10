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
	<cfform name="frmEmailTemplate">
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
</cfoutput>
