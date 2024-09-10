<cfscript>
	pages = new admin.models.pages();
	page = pages.getPage( url.id );

	if( form.keyExists( 'fieldnames' ) ) {
		pages.savePage(
			pk_pages=form.pk_pages
			,page_content=form.txtPageContent
		);

		writeOutput( '
			<script>
				window.close();
			</script>
		' );
	}
</cfscript>

<cfoutput>
	<cfform name="frmPage" action="">
		<input type="hidden" name="pk_pages" value="#url.id#" />

		<table width="100%">
			<tr>
				<td colspan="2">
					<cftextarea name="txtPageContent" id="txtPageContent" height="600" width="750" richtext="yes" toolbar="Basic">#page.PAGE_CONTENT#</cftextarea>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" name="btnAction" value="Update Page"></td>
			</tr>
		</table>
	</cfform>
</cfoutput>
