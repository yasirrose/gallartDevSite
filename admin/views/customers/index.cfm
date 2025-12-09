<cfajaxproxy cfc="admin.models.customers" />
<cfajaxproxy bind="javascript:gridChange({data.id})">
<cfhtmlhead text='
	<script type="text/javascript" src="/admin/scripts/customers.js.cfm" language="JavaScript"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
'>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
	<tr>
		<td valign="top">
			<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
				<tr>
					<td colspan="2" style="font-size: 11px;"><strong>SEARCH BY:</strong></td>
				</tr>
				<tr>
					<td valign="top" width="400">
						<cfform name="gridForm">
							<table cellspacing="0" cellpadding="1" border="0" width="100%">
								<tr>
									<td align="left">
										<strong>First Name:</strong>
										<cfinput name="searchFname" id="searchFname" size="30" maxlength="30"/>
									</td>
									<td align="left">
										<strong>Last Name:</strong>
										<cfinput name="searchLname" size="30" maxlength="30"/>
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td align="left">
										<strong>Email:</strong>
										<cfinput name="searchEmail" size="30" maxlength="30"/>
									</td>
									<td align="left">
										<strong>Area Code:</strong>
										<cfinput name="searchAreacode" size="30" maxlength="30"/>
									</td>
									<td>&nbsp;</td>
								</tr>
								<!--- <tr>
									<td align="right">
										<strong>Email:</strong>
									</td>
									<td>
										<cfinput name="searchEmail" size="30" maxlength="30"/>

									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td align="right">
										<strong>Area Code:</strong>
									</td>
									<td>
										<cfinput name="searchAreacode" size="30" maxlength="30"/>

									</td>
									<td>&nbsp;</td>
								</tr> --->
								<tr>
									<td align="left">
										<strong>City:</strong>
										<cfinput name="searchCity" size="30" maxlength="30"/>
									</td>
									<td align="left">
										<strong>State------------:</strong>
										<select name="searchState">
											<option value="">Please Select</option>
											<cfoutput query="getStates">
												<option value="#stateAbb#">#state#</option>
											</cfoutput>
										</select>
									</td>
									<td>&nbsp;</td>
								</tr>
								<!--- <tr>
									<td align="right">
										<strong>State:</strong>
									</td>
									<td>
										<select name="searchState">
											<option value="">Please Select</option>
											<cfoutput query="getStates">
												<option value="#stateAbb#">#state#</option>
											</cfoutput>
										</select>
									</td>
									<td>&nbsp;</td>
								</tr> --->
								<tr>
									<td colspan="3" align="center">
										<input type="Reset" onclick="setTimeout(function(){location.reload();},100);">
										<cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" style="margin-top:6px;"/>
										<!--- <input type="Button" value="Create Excel File" onclick="document.getElementById('createXls').src='views/exports/create_customer_xls.cfm'"> --->
										<input type="Button" value="Create Excel File" onclick="exportCustomers(this)">
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td colspan="3">
										<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.customers.getCustomers({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchFname},{searchLname},{searchEmail},{searchAreacode},{searchCity},{searchState})">
											<cfgridcolumn name="fname" header="First Name" width="100">
											<cfgridcolumn name="lname" header="Last Name" width="100">
											<cfgridcolumn name="customer_email" header="Email" width="175">
										</cfgrid>
									</td>
								</tr>
							</table>
						</cfform>
					</td>
					<td valign="top">
						<cfform name="editForm">
							<cfinput type="hidden" name="id" id="id" bind="{data.id}">
							<cfinput type="hidden" name="moduleName" id="moduleName" value="Customer Module">
							<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
								<tr>
									<td id="stuff" colspan="2"></td>
								</tr>
								<tr>
									<td width="100">
										First Name:
									</td>
									<td>
										<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" maxlength="30" size="30">
									</td>
								</tr>
								<tr>
									<td>
										Last Name:
									</td>
									<td>
										<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" maxlength="30" size="30">
									</td>
								</tr>
								<tr>
									<td>
										Email:
									</td>
									<td>
										<cfinput type="text" name="customer_email" id="customer_email" maxlength="30" bind="{data.customer_email}" size="30">&nbsp;
										<span  id="emailLink"></span>
									</td>
								</tr>


								<!--- <tr>
									<td>
										Phone:
									</td>
									<td>
										<cfinput type="text" name="Phone" id="Phone"  bind="{data.Phone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home phone number in the format (xxx) xxx-xxxx">&nbsp;(xxx) xxx-xxxx
									</td>
								</tr>
								<tr>
									<td>
										Cell Phone:
									</td>
									<td>
										<cfinput type="text" name="CellPhone" id="CellPhone"  bind="{data.cellphone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the cell phone number in the format (xxx) xxx-xxxx">&nbsp;(xxx) xxx-xxxx
									</td>
								</tr>
								<tr>
									<td>
										Work Phone:
									</td>
									<td>
										<cfinput type="text" name="WorkPhone" id="WorkPhone"  bind="{data.businessphone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the business phone number in the format (xxx) xxx-xxxx">&nbsp;(xxx) xxx-xxxx
									</td>
								</tr>
								<tr>
									<td>
										Phone Outside the US:
									</td>
									<td>
										<cfinput type="text" name="OtherPhone" id="OtherPhone"  bind="{data.otherphone}" size="30">&nbsp;
									</td>
								</tr> --->

								<tr>
									<td>
										Select Phone Number type:
									</td>
									<td>		

										<select name="PhoneType" id="PhoneType">
											<option value="Cell Phone" >Mobile</option>
											<option value="Home Phone" >Home</option>
											<option value="Business Phone" >Business</option>
											<option value="OutsideUS" >Outside US</option>
										</select>
									</td>
								</tr>

								<tr>
									<td>
										Phone Number:
									</td>
									<td>
										<cfinput type="text" name="phoneNumber" id="phoneNumber" maxlength="30" size="30">&nbsp;
										<span id="formatSign">(xxx) xxx-xxxx</span>
									</td>
								</tr>

								<cfoutput>
									<script>
										document.addEventListener("DOMContentLoaded", function() {
											const phoneInput = document.getElementById("phoneNumber");
											const phoneType = document.getElementById("PhoneType");
											const formatSign = document.getElementById("formatSign");

											function toggleFormatSign() {
												if (phoneType.value === "OutsideUS") {
													formatSign.style.display = "none";
												} else {
													formatSign.style.display = "inline";
												}
											}

											// run on load (in case form already has value)
											toggleFormatSign();

											// run on change
											phoneType.addEventListener("change", toggleFormatSign);

											phoneInput.addEventListener("input", function(e) {
												// If type is OutsideUS → skip formatting
												if (phoneType.value === "OutsideUS") {
													return;
												}

												let value = e.target.value.replace(/\D/g, ""); // only digits
												if (value.length > 10) value = value.substring(0, 10);

												// Apply formatting as user types
												if (value.length > 6) {
													e.target.value = `(${value.substring(0,3)}) ${value.substring(3,6)}-${value.substring(6)}`;
												} else if (value.length > 3) {
													e.target.value = `(${value.substring(0,3)}) ${value.substring(3)}`;
												} else if (value.length > 0) {
													e.target.value = `(${value}`;
												} else {
													e.target.value = "";
												}
											});
										});

									</script>
								</cfoutput>
								
								<tr>
									<td style="font-size: 10px;">
										Address Type:
									</td>
									<td>
										<cfset Addtype = "USA,Outside" />
										<cfoutput>
											<select name="Addresstype" id="Addresstype" onchange="toggleStateField();">
												<option value="">Please Select</option>
												<cfloop list="#Addtype#" index="idx">
													<option value="#idx#">#idx#</option>
												</cfloop>
											</select>
										</cfoutput>
									</td>	
								</tr>

								<tr>
									<td valign="top">
										Address:
									</td>
									<td>
										<cfinput type="text" name="Address1" id="Address1" maxlength="30" bind="{data.Address1}" size="30"><br>
										<cfinput type="text" name="Address2" id="Address2" maxlength="30" bind="{data.Address2}" size="30">
									</td>
								</tr>
								<tr>
									<td>
										City, Zip:
									</td>
									<td>
										<cfinput type="text" name="City" id="City"  bind="{data.City}" maxlength="25" size="25">&nbsp;
										<!--- <cfinput type="text" name="State" id="State"  bind="{data.State}" size="15">&nbsp; --->
										<cfinput type="text" name="Zip" id="Zip"  bind="{data.Zip}" maxlength="10" size="10">
									</td>
								</tr>
								<!--- <tr>
									<td>
										Country:
									</td>
									<td>
										<cfinput type="text" name="Country" id="Country"  bind="{data.Country}" size="30">&nbsp;
									</td>
								</tr> --->

								<tr id="stateTextRow" style="display:none;">
									<td style="font-size: 10px;">
										State/Province, Country
									</td>
									<td>
										<cfinput type="text" name="state" id="state"  bind="{data.state}" maxlength="25" size="25" class="displayInput"> &nbsp;
										<cfinput type="text" name="country" id="country"  bind="{data.country}" maxlength="25" size="25" class="displayInput">

									</td>
								</tr>
								
								<tr id="stateDropdownRow" style="display:none;">
									<td style="font-size: 10px;">
										State
									</td>
									<td>
										<cfoutput>
											<select name="state_dropdown" id="state_dropdown">
												<option value="">Please Select</option>
												<cfloop query="getStates">
													<option value="#getStates.stateAbb#">#getStates.state#</option>
												</cfloop>
											</select>
										</cfoutput>
									</td>	
								</tr>

								<tr>
									<td valign="top">
										Shipping Address:
									</td>
									<td>
										<cfinput type="text" name="saddress1" id="saddress1"  bind="{data.saddress1}" maxlength="30" size="30"><br>
										<cfinput type="text" name="saddress2" id="saddress2"  bind="{data.saddress2}" maxlength="30" size="30"><br>
									</td>
								</tr>
								<tr>
									<td>
										City, State, Zip:
									</td>
									<td>
										<cfinput type="text" name="scity" id="scity"  bind="{data.scity}" maxlength="25" size="25">
										&nbsp;
										<cfinput type="text" name="sstate" id="sstate"  bind="{data.sstate}" maxlength="15" size="15">
										&nbsp;
										<cfinput type="text" name="szip" id="szip"  bind="{data.szip}" maxlength="10" size="10">&nbsp;
									</td>
								</tr>
								<tr>
									<td>
										Fax:
									</td>
									<td>
										<cfinput type="text" name="Fax" id="Fax" maxlength="30" bind="{data.Fax}" size="30">&nbsp;
									</td>
								</tr>
								<tr>
									<td>
										Drivers License Number:
									</td>
									<td>
										<cfinput type="text" name="DriversLicense" id="DriversLicense" maxlength="30"  bind="{data.DriversLicense}" size="30">&nbsp;
									</td>
								</tr>
								<tr>
									<td>
										On Mailing List:
									</td>
									<td>
										<input type="radio" name="maillist" value="1">Yes
										&nbsp;&nbsp;
										<input type="radio" name="maillist" value="0">No
									</td>
								</tr>
								<tr>
									<td>
										Opt Out Date:
									</td>
									<td>
										<cfinput type="text" name="optout" id="optout" maxlength="30" bind="{data.optout}" size="30">&nbsp;
									</td>
								</tr>
								<tr>
									<td>
										Comments:
									</td>
									<td>
										<cftextarea  name="comments"  id="comments" maxlength="500" cols="50" rows="3" bind="{data.comments}" />
										<div id="commentsCount" class="mb-3">0 / 500 characters</div>
									</td>
								</tr>
								<tr>
									<td colspan="2" >
										<cfinput type="button" name="edit" id="edit" value="Edit" onclick="doEdit('edit');" />
										<cfinput type="button" name="delete" id="delete" value="Delete" onclick="doEdit('delete');" />
									</td>
								</tr>
							</table>
						</cfform>
					</td>
				</tr>
			</table>

	<script>
		function toggleStateField() {
			var addressType = document.getElementById("Addresstype").value;

			if (addressType === "Outside") {
				// Show text field, hide dropdown
				document.getElementById("stateTextRow").style.display = "";
				document.getElementById("stateDropdownRow").style.display = "none";
			} else if (addressType === "USA") {
				// Show dropdown, hide text field
				document.getElementById("stateDropdownRow").style.display = "";
				document.getElementById("stateTextRow").style.display = "none";
			} else {
				// Hide both if nothing selected
				document.getElementById("stateTextRow").style.display = "none";
				document.getElementById("stateDropdownRow").style.display = "none";
			}
		}

		function exportCustomers(btn) {
			// disable button
			btn.disabled = true;
			btn.value = "Exporting...";

			// trigger export via iframe
			document.getElementById('createXls').src = 'views/exports/create_customer_xls.cfm';

			// re-enable after 5 seconds
			setTimeout(function(){
				btn.disabled = false;
				btn.value = "Create Excel Sheet";
			}, 5000);
		}

	</script>

	<script>
		/* ---------- global counter function ---------- */
		function updateAdditionalDetailsCounter() {
			var textarea = document.getElementById('comments');
			var counter = document.getElementById('commentsCount');
			var maxLength = 500;
			if (!textarea || !counter) return;
			var len = textarea.value ? textarea.value.length : 0;
			counter.textContent = len + ' / ' + maxLength + ' characters';

			// optional red warning
			if (len > maxLength) {
				counter.style.color = 'red';
			} else {
				counter.style.color = '';
			}
		}

		/* ---------- run on page load and attach input handler ---------- */
		document.addEventListener("DOMContentLoaded", function() {
			const textarea = document.getElementById("comments");
			const maxLength = 500;

			textarea.addEventListener("input", function() {
				if (this.value.length > maxLength) {
					this.value = this.value.substring(0, maxLength); // trim extra text
				}
				updateAdditionalDetailsCounter();
			});
		});
	</script>

	<style>
		.toast-center {
			top: 50% !important;
			left: 50% !important;
			transform: translate(-50%, -50%) !important;
			position: fixed !important;
			z-index: 999999 !important;
		}

		#toast-container > .toast {
			background-color: #ff4da6 !important;
			color: white !important;
		}
	</style>

<iframe id="createXls" src="" frameborder="0"></iframe>
<!--- <cfset ajaxOnLoad("init")> --->
