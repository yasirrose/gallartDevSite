<script type="text/javascript">
	function validate() {
		if(document.artistForm.artist.value == '') {
			alert('You must select an artist');
			return false;
		}
	}
</script>

<table cellspacing="0" cellpadding="0" border="0" width="500" align="left">
    <tr>
		<td colspan="2">
			<cfform method="post" action="index.cfm?event=pricetags.pricetagsResults" onsubmit="return validate()" name="artistForm">
            <input type="hidden" name="gallery_only" value="1" />
			<table cellspacing="0" cellpadding="10" border="0" width="100%" align="left">
				<tr>
			    	<td colspan="2" style="font-size: 13px;"><strong>PRICE TAGS</strong><br /><br />
					</td>
			  	</tr>
				<tr>
			    	<td colspan="2" style="font-size: 11px;">Choose artist for whose listings you'd like to create price tags and click Submit:
					</td>
			  	</tr>
                <tr>
			    	<td colspan="2" style="font-size: 10px;">(This only applies to Gallart listings.  Artist dropdown only includes artists for which there are active listings.)
					</td>
			  	</tr>
				<tr>
					<td style="font-size: 10px;">
						<strong>Artist:</strong>
					</td>
					<td>
						<select name="artist" multiple size="10">
							<option value="">Please Select</option>
							<cfoutput query="getAllArtists" group="manufacturer">
							<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
								<option value="#listFirst(manufacturer)#">#ucase(manufacturer)#</option>
							</cfif>
							</cfoutput>
						</select>
					</td>
				</tr>
                <!--<tr>
					<td style="font-size: 10px;" colspan="2">
						<strong>Show Retail Price:</strong>&nbsp;&nbsp;
						<input type="checkbox" name="show_retail" value="1" checked>
					</td>
				</tr>
                <tr>
					<td style="font-size: 10px;" colspan="2">
						<strong>Show Gallery Price:</strong>&nbsp;&nbsp;
						<input type="checkbox" name="show_gallery" value="1" checked>
					</td>
				</tr>
                <tr>
					<td style="font-size: 10px;" colspan="2">
						<strong>Show Sale Price:</strong>&nbsp;&nbsp;
						<input type="checkbox" name="show_sale" value="1" checked>
					</td>
				</tr>-->
				<!--<tr>
					<td style="font-size: 10px;" colspan="2">
						<strong>Gallery Listings Only:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="gallery_only" value="1" checked>
					</td>

				</tr>-->
				<tr>
			    	<td colspan="2" style="padding: 10px 0;">
						<input type="Submit" value="Submit">&nbsp;&nbsp;<input type="reset" value="Reset Values">
					</td>
			  	</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>
