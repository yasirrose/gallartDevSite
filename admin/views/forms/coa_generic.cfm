<style>
	.inputText{
		font-family: Times New Roman;
		font-size: 12px;
	}
	p {
		margin: 0;
		padding: 0;
	}
</style>

<cfform method="post" action="index.cfm?event=forms.coa_generic_pdf" enctype="multipart/form-data" onsubmit="return validationCOAGenericForm();">
	<input type="Hidden" name="imagePath" id="imagePath" />
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
			<td style="padding-top: 10px;">
				Enter the title of the piece, one character at at time:<br>
				<cfinput name="name" id="name" autosuggest="cfc:admin.models.art.searchArtDropdown({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0">&nbsp;<input type="Button" value="Show Image" onclick="findImageByTitle(document.getElementById('name').value)">
			</td>
		</tr>
		<tr>
			<td style="padding-top: 10px;">
				Or, upload image from another location:&nbsp;<input type="File" name="coa_image">&nbsp;(.jpg only)<br><br>
				<ul>
					<li>Go to a website and select an image.</li>
					<li>Right click the image and select "Save Image As".</li>
					<li>Save the image to your local system.  (You may want to create a folder on your desktop)</li>
					<li>Click "Browse" above and find the image at the location to which it was saved.</li>
					<li>Double click the image, or select the image and click Open.</li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
				<table cellspacing="0" cellpadding="0" border="0" width="612">
					<tr>
						<td background="http://gallart.com/admin/images/forms/coa_generic_bkg.jpg" width="612" height="350" style="background-repeat: no-repeat;" valign="top">
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td colspan="3" align="center"  style="padding: 250px 0 20px 0;">
										<textarea name="coa_desc" cols="62" rows="3">The work of art described herein is certified as an Authentic, Hand Signed and Numbered by the Artist, and that the information below is true and correct to the best of our knowledge.</textarea>
									</td>
								</tr>
								<tr>
									<td width="350">
										<table cellspacing="0" cellpadding="0" border="0" width="100%">
											<tr>
												<td align="center" style="padding-left: 60px;">
													<img id="imageDisplay" src="images/blank.gif" width="130">
												</td>
											</tr>
										</table>
									</td>
									<td width="250" valign="top">
										<table cellspacing="0" cellpadding="6" border="0" width="100%">
											<tr>
												<td class="inputText">
													ARTIST:&nbsp;
												</td>
												<td align="right">
													<input type="Text" name="artist" id="artist" maxlength="30" style="width: 150px;">
												</td>
											</tr>
											<tr>
												<td class="inputText">
													TITLE:&nbsp;
												</td>
												<td align="right">
													<input type="Text" name="title" id="title" maxlength="30" style="width: 150px;">
												</td>
											</tr>
											<tr>
												<td class="inputText">
													MEDIUM:&nbsp;
												</td>
												<td align="right">
													<input type="Text" name="medium" id="medium" maxlength="50" style="width: 150px;">
												</td>
											</tr>
											<tr>
												<td class="inputText">
													SIZE:&nbsp;
												</td>
												<td align="right">
													<input type="Text" name="size" id="size" maxlength="20" style="width: 150px;">
												</td>
											</tr>
											<tr>
												<td class="inputText">
													EDITION:&nbsp;
												</td>
												<td align="right">
													<input type="Text" name="edition" id="edition" maxlength="15" style="width: 150px;">
												</td>
											</tr>
											<tr>
												<td class="inputText">
													YEAR:&nbsp;
												</td>
												<td align="right">
													<input type="Text" name="year" id="year" maxlength="10" style="width: 150px;">
												</td>
											</tr>
										</table>
									</td>
									<td width="62">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td colspan="3" style="padding-top: 100px;">
										<table cellspacing="0" cellpadding="0" border="0" width="100%">
											<tr>
												<td width="380">&nbsp;</td>
												<td width="130" style="border-top: 2px solid #000; font-style: italic; font-size: 11px;">
													<input type="Text" name="signature_name" value="Kenneth Hendel" style="width: 300px;"><br><br>
													<input type="Text" name="signature_title" value="Purveyors of Fine Art" style="width: 300px;"><br><br>
													<input type="Text" name="signature_address" value="20633 Biscayne Blvd. Aventura, FL" style="width: 300px;">
								
												</td>
												<td width="112">&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<input type="Submit" id="submitBtn" value="     CREATE PDF     ">
				<input type="Reset" value="RESET">
			</td>
		</tr>
	</table>
</cfform>

<script>
	function validationCOAGenericForm() {
		console.log('test: ')
		
		var artist = document.getElementById("artist").value.trim();				
		var title = document.getElementById("title").value.trim();
		var medium = document.getElementById("medium").value.trim();
		var size = document.getElementById("size").value.trim();
		var submitBtn = document.getElementById("submitBtn");


		if (artist === "") {
			alert("Please enter Artist Name. ");
			return false; 
		}
		if (title === "") {
			alert("Please enter Title. ");
			return false; 
		}
		if (medium === "") {
			alert("Please enter Medium. ");
			return false; 
		}
		if (size === "") {
			alert("Please enter Size. ");
			return false; 
		}

		var sizePattern = /^\d+(\.\d+)?\s*x\s*\d+(\.\d+)?(\s*x\s*\d+(\.\d+)?)?$/i;
		if (!sizePattern.test(size)) {
			alert("Please enter in format: HEIGHT x WIDTH (e.g., 24 x 36)");
			document.getElementById("size").focus();
			return false;
		}

		submitBtn.disabled = true;
		submitBtn.value = "Processing...";

		setTimeout(function() {
			submitBtn.disabled = false;
			submitBtn.value = "     CREATE PDF     ";
		}, 5000);

		return true; 
	}
</script>
