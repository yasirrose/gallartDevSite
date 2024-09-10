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
<cfform method="post" action="index.cfm?event=forms.appraisal_generic_Pdf" enctype="multipart/form-data">
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
		<td style="padding-left: 150px;">
			<table cellspacing="0" cellpadding="0" border="0" width="576">
				<tr>
					<td background="http://gallart.com/admin/images/forms/appraisal_generic_bkg.jpg" width="576" height="720" style="background-repeat: no-repeat;" valign="top">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td valign="top" style="padding-top: 180px;">
									<table cellspacing="0" cellpadding="3" border="0" width="275">
										<tr>
											<td class="inputText">
												Date:&nbsp; 
											</td>
											<td>
												<input type="Text" name="date" style="width: 150px;">
											</td>
										</tr>
										<tr>
											<td class="inputText">
												Client Name:&nbsp;
											</td>
											<td>
												<input type="Text" name="client" style="width: 150px;">
											</td>
										</tr>
										<tr>
											<td class="inputText">
												Address:&nbsp;
											</td>
											<td>
												<input type="Text" name="address" style="width: 150px;">
											</td>
										</tr>
										<tr>
											<td class="inputText">
												&nbsp;
											</td>
											<td>
												<input type="Text" name="city" style="width: 80px;">,&nbsp;<input type="Text" name="state" style="width: 20px;">&nbsp;<input type="Text" name="zip" style="width: 40px;">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="inputText" style="padding-top: 10px;">
									Objective:&nbsp; 
									<input type="Text" name="objective" style="width: 350px;" value="To Determine the Suggested Retail Value of Artist's __________">
								</td>
							</tr>
							<tr>
								<td style="padding-top: 50px;">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="348">
												<table cellspacing="0" cellpadding="8" border="0" width="250">
													<tr>
														<td class="inputText">
															Artist:&nbsp;
														</td>
														<td align="right">
															<input type="Text" name="artist" style="width: 150px;">
														</td>
													</tr>
													<tr>
														<td class="inputText">
															Title:&nbsp;
														</td>
														<td align="right">
															<input type="Text" name="title" style="width: 150px;">
														</td>
													</tr>
													<tr>
														<td class="inputText">
															Medium:&nbsp;
														</td>
														<td align="right">
															<input type="Text" name="medium" style="width: 150px;">
														</td>
													</tr>
													<tr>
														<td class="inputText">
															Condition:&nbsp;
														</td>
														<td align="right">
															<input type="Text" name="condition" style="width: 150px;">
														</td>
													</tr>
													<tr>
														<td colspan="2" class="inputText">
															Suggested Retail Value:&nbsp;
															$<input type="Text" name="value" style="width: 60px;">
														</td>
													</tr>
												</table>
											</td>
											<td width="226">
												<table cellspacing="0" cellpadding="0" border="0" width="100%">
													<tr>
														<td align="center" style="padding-left: 60px;">
															<img id="imageDisplay" src="images/blank.gif" width="130">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>								
								</td>
							</tr>
							<tr>
								<td style="padding-top: 10px;">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td align="center">
												<input type="Text" name="signature_name" value="Kenneth Hendel" style="width: 300px;"><br><br>
												<input type="Text" name="signature_title" value="Purveyors of Fine Art" style="width: 300px;"><br><br>
												<input type="Text" name="signature_address" value="20633 Biscayne Blvd. Aventura, FL" style="width: 300px;">
							
											</td>
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
			<input type="Submit" value="     CREATE PDF     ">
			<input type="Reset" value="RESET">	
		</td>
	</tr>
</table>
</cfform>