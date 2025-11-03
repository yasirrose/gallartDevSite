<script>
function limitText(limitField, limitNum) {
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    } 
}
</script>


<style>
	td {
		font-family: Arial;
		font-size: 11px;
	}
	p {
		margin: 0;
		padding: 0;
	}
	h1 {
		font-size: 18px;
	}
	td.box {
		width: 120px;
	}
	.box {
		border: 1px solid #000;
		padding: 3px 0;
		text-align: center;
		font-size: 11px;
		font-weight: bold;
	}
	.wideCell {
		width: 175px;
	}
	.wideCell input {
		width: 170px;
	}
	.narrowCell {
		width: 65px;
	}
	.narrowCell input {
		width: 60px;
	}
	.label {
		font-weight: bold;
		font-size: 10px;
	}
	.spacer {
		width: 10px;
	}
</style>
<cfoutput>
	<cfform method="post" action="index.cfm?event=forms.framingpdf" onsubmit="return validationForm();">
		<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr>
				<td>
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr>
							<td>
								<table cellspacing="0" cellpadding="0" border="0" width="612">
									<tr>
										<td>
											<img src="http://#server_name#/admin/images/gallart_letterhead_logo.jpg">
										</td>
									</tr>
									<tr>
										<td style="padding: 20px 0 0 10px;">
											<table cellspacing="0" cellpadding="0" border="0" width="100%">
												<tr>
													<td width="400">
														<h1>FRAMING ORDER</h1>
													</td>
													<td width="212" style="padding-bottom: 20px; line-height: 25px; font-size: 11px;">
														Invoice ##:&nbsp;&nbsp;&nbsp;&nbsp;
														<input type="Text" name="invoice_number" id="invoice_number" style="width: 160px;"><br />
														Consultant:&nbsp;
														<input type="Text" name="consultant" id="consultant" style="width: 160px;">
													</td>
												</tr>
												<tr>
													<td colspan="2">
														<table cellspacing="0" cellpadding="2" border="0" width="100%">
															<tr>
																<td class="box">
																	CLIENT
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	<input type="Text" name="client_last_name" id="client_last_name" maxlength="25"/>
																</td>
																<td class="wideCell label">
																	<input type="Text" name="client_first_name" id="client_first_name" maxlength="25"/>
																</td>
																<td class="narrowCell label">
																	<input type="Text" name="client_date_in" maxlength="25"/>
																</td>
																<td class="narrowCell label">
																	<input type="Text" name="client_date_due" maxlength="25"/>
																</td>
															</tr>
															<tr>
																<td>

																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	LAST NAME
																</td>
																<td class="wideCell label">
																	FIRST NAME
																</td>
																<td class="narrowCell label">
																	DATE IN
																</td>
																<td class="narrowCell label">
																	DATE DUE
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
															<tr>
																<td class="box">
																	PHONE
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	<input type="Text" name="home_phone" maxlength="20"/>
																</td>
																<td class="wideCell label">
																	<input type="Text" name="business_phone" maxlength="20"/>
																</td>
																<td class="narrowCell label">&nbsp;
																	
																</td>
																<td class="narrowCell label">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td>

																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	HOME PHONE
																</td>
																<td class="wideCell label">
																	BUSINESS PHONE
																</td>
																<td class="narrowCell label">&nbsp;
																	
																</td>
																<td class="narrowCell label">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
															<tr>
																<td class="box">
																	ART
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label" colspan="2">
																	<input type="Text" name="description" maxlength="100" style="width: 350px;" />
																</td>
																<td class="narrowCell label" nowrap="nowrap">
																	<input type="Text" name="size1" style="width: 25px;" maxlength="4" />
																	&nbsp;x&nbsp;
																	<input type="Text" name="size2" style="width: 25px;" maxlength="4" />
																</td>
																<td class="narrowCell label">
																	<input type="Text" name="condition" maxlength="10" />
																</td>
															</tr>
															<tr>
																<td>

																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label" colspan="2">
																	DESCRIPTION (BE SPECIFIC)
																</td>
																<td class="narrowCell label">
																	SIZE
																</td>
																<td class="narrowCell label">
																	CONDITION
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
															<tr>
																<td class="box">
																	FRAME
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	<input type="Text" name="stock" maxlength="25"/>
																</td>
																<td class="wideCell label">
																	<input type="Text" name="frame_no" maxlength="25"/>
																</td>
																<td class="wideCell label" colspan="2">
																	<input type="Text" name="color" maxlength="25"/>
																</td>
															</tr>
															<tr>
																<td>

																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	STOCK OR CO. NAME
																</td>
																<td class="wideCell label">
																	NO.
																</td>
																<td colspan="2" class="wideCell label">
																	COLOR
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
															<tr>
																<td class="box">
																	LINER
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	<input type="Text" name="liner_co_name" maxlength="25"/>
																</td>
																<td class="wideCell label">
																	<input type="Text" name="liner_no" maxlength="25"/>
																</td>
																<td class="narrowCell label">&nbsp;
																	
																</td>
																<td class="narrowCell label">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td>

																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	CO. NAME
																</td>
																<td class="wideCell label">
																	NO.
																</td>
																<td class="narrowCell label">&nbsp;
																	
																</td>
																<td class="narrowCell label">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
															<tr>
																<td class="box">
																	LINEN
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	<input type="Text" name="linen_size" maxlength="15" />
																</td>
																<td class="wideCell label">
																	<input type="Text" name="linen_color" maxlength="15"/>
																</td>
																<td class="wideCell label" colspan="2">
																	<input type="Text" name="linen_float" maxlength="15"/>
																</td>
															</tr>
															<tr>
																<td>

																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	SIZE
																</td>
																<td class="wideCell label">
																	COLOR
																</td>
																<td colspan="2" class="wideCell label">
																	FLOAT
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
															<tr>
																<td class="box">
																	FILLET
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	<input type="Text" name="fillet_co" maxlength="25"/>
																</td>
																<td class="wideCell label">
																	<input type="Text" name="fillet_no" maxlength="15"/>
																</td>
																<td class="wideCell label" colspan="2">
																	HPF
																</td>
															</tr>
															<tr>
																<td>

																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	CO. NAME
																</td>
																<td class="wideCell label">
																	NO.
																</td>
																<td colspan="2" class="wideCell label">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
															<tr>
																<td class="box">
																	MATS
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	<input type="Text" name="mats_innercolor1" maxlength="15"/>
																</td>
																<td class="wideCell label">
																	<input type="Text" name="mats_innercolor1" maxlength="15"/>
																</td>
																<td class="wideCell label" colspan="2">
																	<input type="Text" name="mats_outercolor" maxlength="15"/>
																</td>
															</tr>
															<tr>
																<td>

																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	1ST INNER - COLOR
																</td>
																<td class="wideCell label">
																	2ND INNER - COLOR
																</td>
																<td colspan="2" class="wideCell label">
																	OUTER - COLOR
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
															<tr>
																<td>&nbsp;
																	
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="wideCell label">
																	<input type="Text" name="blank1" />
																</td>
																<td class="wideCell label">
																	<input type="Text" name="blank2" />
																</td>
																<td class="wideCell label" colspan="2">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td colspan="5">
																	<br>
																</td>
															</tr>
														</table>		
													</td>	
												</tr>
												<tr>
													<td colspan="2">
														<table cellspacing="0" cellpadding="2" border="0" width="100%">
															<tr>
																<td class="box" style="width: 125px;">
																	MOUNTING
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="label">
																	DRY MOUNT:
																</td>
																<td class="label">
																	YES&nbsp;<input type="Checkbox" name="drymount_yes">
																</td>
																<td class="label">
																	NO&nbsp;<input type="Checkbox" name="drymount_no">
																</td>
																<td class="label">
																	ARCHIVAL&nbsp;<input type="Checkbox" name="drymount_archival">
																</td>
																<td class="label">
																	SPRAY&nbsp;<input type="Checkbox" name="drymount_spray">
																</td>
															</tr>
															<tr>
																<td colspan="7">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td class="box" style="width: 125px;">
																	GLAZING
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="label">
																	PLEXI&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="plexi">
																</td>
																<td class="label" colspan="2">
																	NON-GLARE PLEXI&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="nonglare_plexi">
																</td>
																<td class="label" colspan="2">
																	U.V. PLEXI&nbsp;<input type="Checkbox" name="uv_plexi">
																</td>
															</tr>
															<tr>
																<td>&nbsp;
																	
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="label">
																	GLASS&nbsp;<input type="Checkbox" name="glass">
																</td>
																<td class="label" colspan="2">
																	NON-GLARE GLASS&nbsp;<input type="Checkbox" name="nonglare_glass">
																</td>
																<td class="label" colspan="2">
																	NONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="none">
																</td>
															</tr>
															<tr>
																<td colspan="7">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td class="box" style="width: 125px;">
																	CANVASES
																</td>
																<td class="spacer">&nbsp;
																	
																</td>
																<td class="label" colspan="2">
																	STRETCHER BARS&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="stretcher_bars">
																</td>
																<td class="label" colspan="3">
																	STRETCH ON FOAMCORE&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="stretch_on_foamcore">
																</td>
															</tr>
															<tr>
																<td colspan="7">&nbsp;
																	
																</td>
															</tr>
															<tr>
																<td colspan="3" valign="top">
																	<div class="box" style="width: 250px;">SPECIAL INSTRUCTIONS</div>
																</td>
																<td class="label" colspan="4" valign="top">
																	&nbsp;&nbsp;&nbsp;
																	<textarea name="special_instructions" cols="50" rows="2" onKeyDown="limitText(this,400);" onKeyUp="limitText(this,400);"></textarea>
																</td>
															</tr>
															<tr>
																<td colspan="7">&nbsp;
																	<table cellspacing="0" cellpadding="2" border="0" width="100%">
																		<tr>
																			<td class="box" style="width: 150px; height: 30px;">
																				TOTAL SALE
																			</td>
																			<td style="width: 130px; text-align: center;">
																				<input type="Text" name="toal_sale" maxlength="15" style="width: 120px;" />
																			</td>
																			<td class="box" style="width: 150px;">
																				BALANCE DUE
																			</td>
																			<td style="width: 130px; text-align: center;">
																				<input type="Text" name="balance_due" maxlength="15" style="width: 125px;" />
																			</td>
																			<td class="box" style="width: 150px;">
																				QUANTITY
																			</td>
																			<td style="width: 85px; text-align: center;">
																				<input type="Text" name="quantity" maxlength="15" style="width: 75px;" />
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td colspan="7">&nbsp;
																	<table cellspacing="0" cellpadding="2" border="0" width="100%">
																		<tr>
																			<td class="box" style="width: 150px; height: 30px;">
																				INSPECTED BY
																			</td>
																			<td style="width: 250px; text-align: center;">
																				<input type="Text" name="inspected_by" maxlength="25" style="width: 245px;" />
																			</td>
																			<td class="box" style="width: 150px;">
																				DATE
																			</td>
																			<td style="width: 130px; text-align: center;">
																				<input type="Text" name="date" maxlength="25" style="width: 125px;" />
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td colspan="7">&nbsp;
																	<br/>
																</td>
															</tr>
														</table>											
													</td>							
												</tr>
											</table>								
										</td>
									</tr>
									<tr>
										<td align="center">
											<img src="http://#server_name#/admin/images/letterhead_footer.jpg">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><br />
					<input type="Submit" id="submitBtn" value="     CREATE PDF     ">
					<input type="Reset" value="RESET">
				</td>
			</tr>
		</table>
	</cfform>

		<script>
			function validationForm() {
				console.log('test: ')
				
				var first_Name = document.getElementById("client_first_name").value.trim();				
				var last_Name = document.getElementById("client_last_name").value.trim();
				var invoice_number = document.getElementById("invoice_number").value.trim();
				var consultant = document.getElementById("consultant").value.trim();
				var submitBtn = document.getElementById("submitBtn");


				if (first_Name === "") {
					alert("Please enter First Name. ");
					return false; 
				}
				if (last_Name === "") {
					alert("Please enter Last Name. ");
					return false; 
				}
				if (invoice_number === "") {
					alert("Please enter Invoice Number. ");
					return false; 
				}
				if (consultant === "") {
					alert("Please enter Consultant. ");
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

</cfoutput>