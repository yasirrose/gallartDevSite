<table width="100%" border="0">
  	<tr>
        <td>
        	<form method="post" action="index.cfm?event=listings.image_sheets_display">
        	<table width="500" border="0">
                <tr>
					<td style="font-size: 10px;">
						<strong>Artist:</strong>
					</td>
					<td>
						<select name="artist" id="artist">
							<option value="">Please Select
							<cfoutput query="getAllArtists" group="manufacturer">
							<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
								<option value="#manufacturer#">#ucase(manufacturer)#
							</cfif>
							</cfoutput>
						</select>
					</td>
				</tr>
                <tr>
                	<td colspan="2">
                    	Gallery Only: <input type="checkbox" name="gallery_only" value="1" checked="checked" />
                    </td>
                </tr>
                <tr>
					<td style="font-size: 10px;">
						Active/Inactive:
					</td >
					<td style="font-size: 10px;">
						<input type="radio" name="active" value="1" checked="checked">Active
						<input type="radio" name="active" value="0">Inactive
						<input type="radio" name="active" value="">All
					</td>

				</tr>
                <tr>
                	<td colspan="2">
                    	<input type="submit" value="Submit" />
                    </td>
                </tr>
            </table>
            </form>
        </td>
  	</tr>
</table>

<iframe frameborder="1" src="" id="imageSheetsDisplay"></iframe>

<!---<cfdump var="#getImagesByArtist#"><cfabort>--->
