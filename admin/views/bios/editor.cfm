<cfscript>
	param name='url.id' default='0';

	record = new admin.models.bios();

	if( url.keyExists( 'id' ) ) {
		bio = record.getBio( url.id );
	}

	if( form.keyExists( 'fieldnames' ) ) {
		record.saveBio(
			pk_bios=form.id
			,artist=form.txtArtist
			,bio=form.txtBio
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
	<cfform name="frm" action="">
		<input type="hidden" name="id" value="#url.id#" />

		<table width="100%">
			<cfif url.id == 0>
				<tr>
					<td>
						<cfdump var='#cgi#' label='cgi' expand=0 abort=0>
						Artist: <select name="txtArtist">
							<cfloop query="getAllGallartArtists">
								<option value="#manufacturer#">#manufacturer#</option>
							</cfloop>
						</select>
					</td>
				</tr>
			<cfelse>
				<input type="hidden" name="txtArtist" value="#url.artist#" />
			</cfif>
			<tr>
				<td colspan="2">
					<cftextarea name="txtBio" id="txtBio" width="725" height="525" richtext="yes" toolbar="Basic">#bio.bio#</cftextarea>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" name="btnAction" value="Update"></td>
			</tr>
		</table>
	</cfform>
</cfoutput>
