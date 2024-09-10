<style>
@media screen {.PrintOnly {display:none; padding: 0px;}}
@media print {.ScreenOnly {display:none}
</style>
<cfajaxproxy cfc="admin.models.art" />
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/listings.js.cfm" language="JavaScript"></script>'>
<div class="ScreenOnly">
<table width="100%" border="0">
  	<tr>
        <td>
        	<cfform name="imageSheetForm">
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
                    	Gallery Only: <cfinput type="checkbox" name="gallery_only" value="1" checked="checked" />
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
                    	<cfinput type="button" name="btnAction" value="Print Image Sheet" onClick="javascript:printImageSheet();">
                    </td>
                </tr>
            </table>
            </cfform>
			<div id="imgSheetRecordcount"></div>
        </td>
  	</tr>
</table>
</div>
<div id="displaySheet" class="PrintOnly"></div>
