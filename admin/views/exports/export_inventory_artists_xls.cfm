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
				
					<form method="post" action="index.cfm?event=exports.artistsXls" onsubmit="return validateAndDisable(this)">
						<table>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td>
												<strong>ENTER LIST OF ARTIST NAMES:</strong>
												<br>
												<textarea name="artists" cols="40" rows="5"></textarea>
											</td>
										</tr>
										<!--- <tr>
											<td>
												<textarea name="artists" cols="40" rows="5"></textarea>
											</td>
										</tr> --->
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
												<!--- <input type="Checkbox" name="displayFields" value="ModelNo">Model No<br>
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
												<input type="Checkbox" name="displayFields" value="Thumbnail">Thumbnail --->

												<div class="checkbox-grid editBox">
													<label><input type="checkbox" name="displayFields" value="ModelNo"> Model No</label>
													<label><input type="checkbox" name="displayFields" value="Artist"> Artist</label>
													<label><input type="checkbox" name="displayFields" value="Medium"> Medium</label>
													<label><input type="checkbox" name="displayFields" value="Retail"> Retail Price</label>

													<label><input type="checkbox" name="displayFields" value="Gallery"> Gallery Price</label>
													<label><input type="checkbox" name="displayFields" value="Sale"> Sale Price</label>
													<label><input type="checkbox" name="displayFields" value="Trump"> Trump Price</label>
													<label><input type="checkbox" name="displayFields" value="Year"> Year</label>

													<label><input type="checkbox" name="displayFields" value="Size"> Size</label>
													<label><input type="checkbox" name="displayFields" value="Edition"> Edition</label>
													<label><input type="checkbox" name="displayFields" value="Low"> Low Estimate</label>
													<label><input type="checkbox" name="displayFields" value="High"> High Estimate</label>

													<label><input type="checkbox" name="displayFields" value="Thumbnail"> Thumbnail</label>
												</div>

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

	<script>
		function validateAndDisable(frm) {

			// ----------- Validation -----------
			var artists = frm.artists.value.trim();
			var checkboxes = frm.querySelectorAll("input[name='displayFields']:checked");

			if (artists === "") {
				alert("Please add artist.");
				return false;
			}

			
			if (checkboxes.length === 0) {
				alert("Please check at least one field name.");
				return false;
			}

			// ----------- If valid → disable button -----------
			disableSubmit(frm);
			return true; // submit form
		}

		function disableSubmit(form) {
			const button = form.querySelector('input[type="submit"]');
			button.disabled = true;
			button.value = "Processing...";
		}
	</script>

	<style>
		.checkbox-grid {
			display: grid;
			grid-template-columns: repeat(4, 1fr);
			gap: 6px 12px;
		}

		.checkbox-grid label {
			white-space: nowrap;
			cursor: pointer;
		}
	</style>


</cfoutput>