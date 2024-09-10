<cfscript>
	param name='url.id' default='0';

	email = new admin.models.email();

	if( url.keyExists( 'id' ) ) {
        // emailTemplate = email.getEmailTemplate( url.id );
        getData = queryExecute(
            "SELECT * FROM emailTemplateDesign WHERE id = ?", 
            [url.id],
            {datasource = application.dsource}
        );
	}

	// if( form.keyExists( 'fieldnames' ) ) {
	// 	email.saveEmployeeEmail(
	// 		// pk_emailtemplate=form.id
	// 		// ,email_name=form.txtEmailName
	// 		emailContent=form.emailContent
	// 	);

	// 	writeOutput( '
	// 		<script>
	// 			window.opener.location.reload();
	// 			window.close();
	// 		</script>
	// 	' );
	// }
</cfscript>

<cfoutput>
	<cfform name="contentForm" id="contentForm">
		<input type="hidden" name="id" value="#url.id#">

		<cftextarea name="emailContent" id="emailContent" richtext="yes" toolbar="Basic" width="650" height="500">#getData.emailtemplate#</cftextarea>
		<input type="submit" class="emailTemplateSubmit" value="Save Template" />
	</cfform>
</cfoutput>
