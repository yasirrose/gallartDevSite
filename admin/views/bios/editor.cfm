<cfscript>
	param name='url.id' default='0';

	record = new admin.models.bios();

	if( url.keyExists( 'id' ) ) {
		bio = record.getBio( url.id );
	}

	if( form.keyExists( 'fieldnames' ) ) {
		result =record.saveBio(
			pk_bios=form.id
			,artist=form.txtArtist
			,bio=form.txtBio
		);

		if (result EQ "exists") {
            writeOutput("<script>alert('Artist already exists!');</script>");
        } else if (result EQ "nodata") {
			writeOutput("<script>alert('Please select the artist or add Bio');</script>");
		} else if (result EQ "Bio Added") {
            writeOutput("<script>alert('Bio added successfully'); window.opener.location.reload(); window.close();</script>");
        } else if (result EQ "Bio Updated") {
            writeOutput("<script>alert('Bio updated successfully'); window.opener.location.reload(); window.close();</script>");
        } else {
            writeOutput("<script>alert('Error: #result#');</script>");
        }
	}
</cfscript>

<cfoutput>

	<cfset selectedArtist = "">
	<cfif structKeyExists(url, "artist")>
		<cfset selectedArtist = url.artist>
	<cfelseif structKeyExists(bio, "artist")>
		<cfset selectedArtist = bio.artist>
	</cfif>

	<cfform name="frm" action="">
		<input type="hidden" name="id" value="#url.id#" />

		<table width="100%">
			<cfif url.id == 0>
				<tr>
					<td>
						<!--- <cfdump var='#cgi#' label='cgi' expand=0 abort=0> --->
						Artist: <select name="txtArtist">
							<cfloop query="getAllGallartArtists">
								<option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#</option>
							</cfloop>
						</select>
					</td>
				</tr>
			<cfelse>
				<input type="hidden" name="txtArtist" value="#HTMLEditFormat(url.artist)#" />
			</cfif>

			<!--- <tr>
				<td>
					Artist: <select name="txtArtist">
						<cfloop query="getAllGallartArtists">
							<cfset selected = ( trim(manufacturer) eq trim(selectedArtist) ) ? "selected" : "" >
							<option value="#HTMLEditFormat(manufacturer)#" #selected#>#HTMLEditFormat(manufacturer)#</option>
						</cfloop>
					</select>
				</td>
			</tr> --->

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
