<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="90%">
	<tr>
		<td valign="top"><br>
		<h3>EXPORT INVENTORY TO EXCEL SPREADSHEET</h3>
		<br>
		<cfif isDefined('form.artists')>

			<cfparam name="form.displayFields" default="" />
		
			<iframe src="index.cfm?event=exports.createXlsFile&artists=#form.artists#&displayFields=#form.displayFields#" frameborder="0"></iframe>
	
			<cfelse>
			
			<form method="post" action="index.cfm?event=exports.artistsXls">
			<table>
				<tr>
					<td valign="top">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td>
									<strong>ENTER LIST OF ARTIST NAMES:</strong>
								</td>
							</tr>
							<tr>
								<td>
									<textarea name="artists" cols="40" rows="5"></textarea>
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
							<td colspan="2" style="font-size: 9pt;">
								<b>Show fields: Artist, Art ID, Title, Medium, Size, Gallery Price</b>
								</br></br>
								<b>Or, choose Fields You Want To Export:</b>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="font-size: 9pt;">
								<input type="Checkbox" name="displayFields" value="ModelNo">Model No<br>
								<input type="Checkbox" name="displayFields" value="Artist">Artist<br>
								<input type="Checkbox" name="displayFields" value="Medium">Medium<br>
								<input type="Checkbox" name="displayFields" value="Retail">Retail Price<br>
								<input type="Checkbox" name="displayFields" value="Gallery">Gallery Price<br>
								<input type="Checkbox" name="displayFields" value="Sale">Sale Price<br>
								<input type="Checkbox" name="displayFields" value="Trump">Trump Price<br>
								<input type="Checkbox" name="displayFields" value="Year">Year<br>
								<input type="Checkbox" name="displayFields" value="Size">Size<br>
								<input type="Checkbox" name="displayFields" value="Edition">Edition<br>
								<input type="Checkbox" name="displayFields" value="Low">Low Estimate<br>
								<input type="Checkbox" name="displayFields" value="High">High Estimate<br>
								<input type="Checkbox" name="displayFields" value="Thumbnail">Thumbnail
							</td>
						</tr>
							<tr>
								<td>
									<input type="Submit" value="CREATE EXCEL LISTING" name="create">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</form>
			</cfif>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<input type="Button" value="Back" onclick="location.href='index.cfm?event=exports.artistsXls'" />
		</td>
	</tr>
</table>	
</cfoutput>