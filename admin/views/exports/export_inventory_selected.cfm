<cfoutput>

	<table border="0" cellpadding="0" cellspacing="0" width="90%">
		<tr>
			<td valign="top"><br>
				<h3>EXPORT INVENTORY TO EXCEL SPREADSHEET</h3>
				<br>
				
				<cfif isDefined('form.create')>
					
					<cfparam name="form.active" default="0">
		
					<iframe src="index.cfm?event=exports.createXlsFileSelected&active=#form.active#&displayFields=#form.displayFields#" frameborder="0"></iframe>
				
				 <cfelse>
				
					<form method="post" action="index.cfm?event=exports.selected" onsubmit="return validateAndDisable(this)">
						<input type="hidden" name="create" value="1"> 
						<table cellspacing="0" cellpadding="0" border="0" >
							<tr>
								<td colspan="2" style="font-size: 9pt;">
									<b>Choose Fields You Want To Export:</b>
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
									<input type="Checkbox" name="displayFields" value="Year">Year<br>
									<input type="Checkbox" name="displayFields" value="Size">Size<br>
									<input type="Checkbox" name="displayFields" value="Edition">Edition<br>
									<input type="Checkbox" name="displayFields" value="Low">Low Estimate<br>
									<input type="Checkbox" name="displayFields" value="High">High Estimate<br>
									<input type="Checkbox" name="displayFields" value="Desc">Description<br>
									<input type="Checkbox" name="displayFields" value="Thumbnail">Thumbnail<br>
									<input type="Checkbox" name="displayFields" value="Url">URL<br>
									<input type="Checkbox" name="active" value="1">Active Only --->


									<div class="checkbox-grid editBox">
										<label><input type="checkbox" name="displayFields" value="ModelNo"> Model No</label>
										<label><input type="checkbox" name="displayFields" value="Artist"> Artist</label>
										<label><input type="checkbox" name="displayFields" value="Medium"> Medium</label>

										<label><input type="checkbox" name="displayFields" value="Retail"> Retail Price</label>
										<label><input type="checkbox" name="displayFields" value="Gallery"> Gallery Price</label>
										<label><input type="checkbox" name="displayFields" value="Sale"> Sale Price</label>

										<label><input type="checkbox" name="displayFields" value="Year"> Year</label>
										<label><input type="checkbox" name="displayFields" value="Size"> Size</label>
										<label><input type="checkbox" name="displayFields" value="Edition"> Edition</label>

										<label><input type="checkbox" name="displayFields" value="Low"> Low Estimate</label>
										<label><input type="checkbox" name="displayFields" value="High"> High Estimate</label>
										<label><input type="checkbox" name="displayFields" value="Desc"> Description</label>

										<label><input type="checkbox" name="displayFields" value="Thumbnail"> Thumbnail</label>
										<label><input type="checkbox" name="displayFields" value="Url"> URL</label>
										<label><input type="checkbox" name="active" value="1"> Active Only</label>
									</div>

								</td>
							</tr>
							<tr>
								<td>
									<input type="Submit" value="CREATE EXCEL LISTING" >
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="Button" value="Back" onclick="location.href='index.cfm?event=exports.selected'" />
								</td>
							</tr>
						</table>
					</form>
				
				</cfif>
			</td>
		</tr>
		<!--- <tr>
			<td valign="top">
				<input type="Button" value="Back" onclick="location.href='index.cfm?event=exports.selected'" />
			</td>
		</tr> --->
	</table>
	
	 <script>

		function validateAndDisable(frm) {

			// ----------- Validation -----------
			
			var checkboxes = frm.querySelectorAll("input[name='displayFields']:checked");
			
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
			grid-template-columns: repeat(3, 1fr);
			gap: 6px 20px;
		}
		.checkbox-grid label {
			white-space: nowrap;
			cursor: pointer;
		}
	</style>
	
</cfoutput>