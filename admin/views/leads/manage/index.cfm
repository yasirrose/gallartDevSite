<cfparam name="fromDate" default="">
<cfparam name="toDate" default="">

<cfhtmlhead text='
	<script type="text/javascript" src="/admin/scripts/leads.js.cfm" language="JavaScript"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
	'>
<script language="javascript" src="../js/jquery-1.3.2.js"></script>
<script type="text/javascript">
	function exportLeads(){
		$('#leadExport').attr('src','index.cfm?event=exports.exportLeads');
	}
</script>
<cfajaxproxy cfc="admin.models.leads" />

<div class="leads-module leads-main-module">
	<div class="container-fluid">
		<div class="form-section">
			<div class="row">
				<div class="col-md-6">
					<div class="main-heading">
						<h3><span>SEARCH BY:</span></h3>
					</div>
					<div class="form-content">
						<cfform name="gridForm">
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label><span>First Name:</span></label>
										<cfinput name="searchFname" id="searchFname" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label><span>Last Name:</span></label>
										<cfinput name="searchLname" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label><span>Email:</span></label>
										<cfinput name="searchEmail" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label><span>Area Code:</span></label>
										<cfinput name="searchAreacode" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label><span>City:</span></label>
										<cfinput name="searchCity" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label><span>State:</span></label>
										<select name="searchState">
											<option value="">Please Select</option>
											<cfoutput query="getStates">
												<option value="#stateAbb#">#state#</option>
											</cfoutput>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label><span>Employee:</span></label>
										<cfselect query="getEmployees" name="searchEmployeeId" display="emp_name" value="pk_employees" selected="#form.searchEmployeeId#" queryPosition="below">
											<option value="">All</option>
										</cfselect>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label><span>Comments entered:</span></label>
										<select name="searchComments">
											<option value="">All</option>
											<option value="1">Yes</option>
											<option value="0">No</option>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label>
											<span>Keyword search:</span>
										</label>
										<cfinput type="text" name="searchKeywords" aria-placeholder="Searches artists, titles and notes" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group date-filed">
										<label><span>Date from:</span></label>
										<cfinput name="searchFromDate" type="datefield" validate="date" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group date-filed">
										<label><span>Date to:</span></label>
										<cfinput name="searchToDate" type="datefield" validate="date" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group reset-search-btn">
										<input type="Reset" class="reset-btn">
										<cfinput type="button" class="delete-btn" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('leadGrid', false);" />
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-buttons">
										<input type="button" value="Export All Leads" onclick="exportLeads()" />
										<input type="button" value="Export Filtered Leads" onclick="document.getElementById('createXls').src='views/exports/create_lead_xls.cfm'" />
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-table">
										<cfgrid format="html" name="leadGrid" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.leads.getLeads({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchFname},{searchLname},{searchEmail},{searchAreacode},{searchCity},{searchState},{searchEmployeeId},{searchComments},{searchFromDate},{searchToDate},{searchKeywords})">
											<!--- <cfgridcolumn name="fname" header="First Name" width="80"> --->
											<!--- <cfgridcolumn name="lname" header="Last Name" width="80"> --->
											<cfgridcolumn name="user_name" header="Name">
											<cfgridcolumn name="leadEmail" header="Email">
											<cfgridcolumn name="leadDate" header="Date">
											<cfgridcolumn name="pk_leads" header="ID" display="false" dataalign="center">
										</cfgrid>
									</div>
								</div>
							</div>
						</cfform>
					</div>
				</div>
				<div class="col-md-6">
					<div class="new-btn">
						<input type="button" value="New" onclick="showNew()">
					</div>
					<div class="required-text">
						<span>* Required</span>
					</div>
					<div class="form-content right-form">
						<cfform name="editForm">
							<cfinput type="hidden" name="pk_leads" id="pk_leads" bind="{leadGrid.pk_leads}">
							<cfinput type="hidden" name="fname" id="fname" bind="{leadGrid.fname}">
							<cfinput type="hidden" name="lname" id="lname" bind="{leadGrid.lname}">
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<cfif session.loggedin EQ true AND session.userinfo.sa EQ 1>
											<label><span>EMPLOYEE:</span></label>
											<cfoutput>
												<select name="fk_employees" id="fk_employees">
													<option value="0">Unassigned
													<cfloop query="getEmployees">
														<option value="#pk_employees#">#emp_lname#, #emp_fname#
			
												</cfloop></select>
												</cfoutput>
												<span  id="empDisplay" style="display: none;"></span>
											<cfelse>
											<label><span>EMPLOYEE:</span></label>
											<span  id="empDisplay"></span>
											<cfinput type="hidden" name="fk_employees" id="fk_employees" bind="{leadGrid.fk_employees}">
										</cfif>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label><span> Name*:</span></label>
										<cfinput type="text" name="name" id="name"  bind="{leadGrid.user_name}" maxlength="30">
									</div>
								</div>
								<div class="col-md-4"></div>
								<div class="col-md-8">
									<div class="form-group">
										<label>Email:</label>
										<cfinput type="text" name="leadEmail" id="leadEmail" maxlength="30" bind="{leadGrid.leadEmail}">&nbsp;
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<input type="Button" id="emailButton" value="Send Email To Lead" onclick="openLeadEmailWindow();" />
									</div>
								</div>
								<!--- <div class="col-md-4">
									<div class="form-group">
										<label>Cell Phone:</label>
										<cfinput type="text" name="cellphone" id="cellphone"  bind="{leadGrid.cellphone}" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the cell phone number in the format (xxx) xxx-xxxx"> 
									</div>
								</div> --->
								<!--- <div class="col-md-4">
									<div class="form-group">
										<label>Home Phone:</label>
										<cfinput type="text" name="phone" id="phone"  bind="{leadGrid.phone}" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home phone number in the format (xxx) xxx-xxxx"> <span>(xxx) xxx-xxxx</span>
									</div>
								</div> --->
								<!--- <div class="col-md-4">
									<div class="form-group">
										<label>Business Phone:</label>
										<cfinput type="text" name="businessphone" id="businessphone"  bind="{leadGrid.businessphone}" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the business phone number in the format (xxx) xxx-xxxx"> <span>(xxx) xxx-xxxx</span>
									</div>
								</div> --->

								

								<div class="col-md-4">
									<div class="form-group">
										<label>Phone Type:</label>
										<select name="PhoneType" id="PhoneType">
											<option value="Home Phone" >Home</option>
											<option value="Cell Phone">Mobile</option>
											<option value="Business Phone">Business</option>
											<option value="OutsideUS">Outside US</option>
										</select>
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label>Phone Number:</label>
										<cfinput type="text" name="phoneNumber" id="phoneNumber" >
										<span id="formatSign">(xxx) xxx-xxxx</span>
									</div>
								</div>

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

								<!--- <div class="col-md-4">
									<div class="form-group">
										<label>Phone Outside the US:</label>
										<cfinput type="text" name="otherphone" id="otherphone"  bind="{leadGrid.otherphone}">
									</div>
								</div> --->


								<div class="col-md-4">
									<div class="form-group">
										<label>Address Type:</label>
										<cfset Addtype = "USA,Outside" />
										<cfoutput>
											<select name="Addresstype" id="Addresstype" onchange="toggleStateField();">
												<option value="">Please Select</option>
												<cfloop list="#Addtype#" index="idx">
													<option value="#idx#">#idx#</option>
												</cfloop>
											</select>
										</cfoutput>
									</div>
								</div>

								<div class="col-md-4" id="stateTextRow" style="display:none;">
									<div class="form-group">
										<label>State:</label>
										<cfinput type="text" name="State_Outside" id="State_Outside" maxlength="30"  bind="{leadGrid.state}">
									</div>
								</div>
								<div class="col-md-4" id="stateTextRow1" style="display:none;">
									<div class="form-group">
										<label>Country:</label>
										<cfinput type="text" name="country" id="country" maxlength="30" bind="{leadGrid.country}">
									</div>
								</div>

								<div class="col-md-4" id="stateDropdownRow" style="display:none;">
									<div class="form-group">
										<label>State:</label>
										<cfoutput>
											<select name="state" id="state">
												<option value="">Please Select</option>
												<cfloop query="getStates">
													<option value="#getStates.stateAbb#">#getStates.state#</option>
												</cfloop>
											</select>
										</cfoutput>
									</div>
								</div>

								
								<div class="col-md-4">
									<div class="form-group">
										<label>Address:</label>
										<cfinput type="text" name="address" id="address"  bind="{leadGrid.address}">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label>City:</label>
										<cfinput type="text" name="city" id="city" maxlength="30" bind="{leadGrid.city}">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label>Best Time To Call:</label>
										<cfinput type="text" name="besttime" id="besttime" maxlength="30"  bind="{leadGrid.besttime}">
									</div>
								</div>
								
								<div class="col-md-4">
									<div class="form-group">
										<label>Zip Code:</label>
										<cfinput type="text" name="zip" id="zip" maxlength="30" bind="{leadGrid.zip}">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label>Company:</label>
										<cfinput type="text" name="company" id="company" maxlength="30" bind="{leadGrid.company}">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label>Website:</label>
										<cfinput type="text" name="website" id="website" maxlength="30" bind="{leadGrid.website}">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label>Artists:</label>
										<cftextarea name="theartists" id="artists" cols="40" rows="3" maxlength="30" bind="{leadGrid.artists}"></cftextarea>
										<div id="artistsCount" class="mb-3">0 / 100 characters</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label>Titles:</label>
										<cftextarea name="titles" id="titles" cols="40" rows="3" maxlength="30" bind="{leadGrid.titles}"></cftextarea>
										<div id="titlesCount" class="mb-3">0 / 100 characters</div> 
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label>Notes:</label>
										<cftextarea name="notes" id="notes" cols="40" rows="10" maxlength="30" bind="{leadGrid.notes}"></cftextarea>
										<div id="notesCount" class="mb-3">0 / 500 characters</div> 
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label>Orign:</label>
										<cfset originValues = "WALK-IN,WEBSITE,PHONE,OTHER" />
											<cfoutput>
											<select name="origin" id="origin">
												<option value="">Please Select</option>
												<cfloop list="#originValues#" index="idx">
													<option value="#idx#">#idx#</option>
												</cfloop>
											</select>
										</cfoutput>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group mail-list">
										<label>Mail list:</label>
										<input type="Checkbox" name="maillist" id="maillist" value="1">
										<input type="hidden" name="maillist" value="">
									</div>
								</div>
								<div class="col-md-4"></div>
								<div class="col-md-12">
									<div class="reset-search-btn">
										<cfinput type="button" name="edit" class="reset-btn" id="edit" value="Edit" onclick="doEdit('edit');" />
										<cfif session.loggedin EQ true AND session.userinfo.sa EQ 1>
											<cfinput type="button" name="delete" class="delete-btn" id="delete" value="Delete" onclick="if (confirm('DELETE -- ARE YOU SURE?')){ doEdit('delete');}" />
										</cfif>
									</div>
								</div>
							</div>
						</cfform>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div>
<!--- <cfoutput>
<form method="post" action="" name="assignLeadForm">
	<input type="text" name="assignLeadId" id="assignLeadId">
	<input type="text" name="assignEmpId" id="assignEmpId" value="#session.userinfo.pk_employees#">
</form>
</cfoutput> --->
<cfwindow name="leadEmailWindow" center="true" modal="true" resizable="false" closable="true" title="Send Email To Lead" width="650" height="550" headerStyle="background-color:##dd3a7d;">

	<!--- <cfoutput>

	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="##ffffff">
		<cfform method="post" action="" name="emailLeadForm"  onsubmit="submitLeadEmailInfo(); return false;">
		<input type="hidden" name="sender" id="sender" value="#session.userinfo.email#">
		<input type="hidden" name="senderFname" id="senderFname" value="#session.userinfo.fname#">
		<input type="hidden" name="senderLname" id="senderLname" value="#session.userinfo.lname#">
		<input type="hidden" name="currEmpId" id="currEmpId" value="#session.userinfo.pk_employees#">
		<input type="hidden" name="recipient" id="recipient">
		<input type="hidden" name="salutation" id="salutation" />
		<input type="hidden" name="closer" id="closer" />
		<!--<input type="hidden" name="body" id="body">-->
		<tr>
			<td style="font-family: Arial; font-size: 12px; width: 75px;">
				Subject:&nbsp;&nbsp;
			</td>
			<td>
				<input type="Text" name="subject" value="Gallart - Response To Your Inquiry" size="50">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<!--<textarea name="bodyContent" id="bodyContent" cols="65" rows="12" onkeyup="compileBody( this.value );"></textarea>-->
				<cftextarea name="body" id="body" height="300" width="600" richtext="yes" toolbar="Basic" />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-family: Arial; font-size: 12px;">
				Sincerely,<br><br>
				#session.userinfo.fname# #session.userinfo.lname#<br>
				Gallery Art<br>
				20633 Biscayne Blvd<br>
				Aventura FL 33180<br>
				305 932 6166 gallery<br>
				305 937 2125 fax<br>

			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Submit" value="SEND EMAIL" />
			</td>
		</tr>
		</cfform>
	</table>

	</cfoutput> --->
</cfwindow>
<cfwindow name="alreadyAssignedWindow" center="true" modal="true" resizable="false" closable="true" title="Already Assigned" width="600" height="400" headerStyle="background-color:##dd3a7d;">

		<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr>
				<td id="assignedTo" style="padding: 25px; font-size: 12px; font-weight: bold;">ALREADY ASSIGNED</td>
			</tr>
		</table>

</cfwindow>
</div>

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


<script>
	function toggleStateField() {
		var addressType = document.getElementById("Addresstype").value;

		if (addressType === "Outside") {
			// Show text field, hide dropdown
			document.getElementById("stateTextRow").style.display = "";
			document.getElementById("stateTextRow1").style.display = "";
			document.getElementById("stateDropdownRow").style.display = "none";
		} else if (addressType === "USA") {
			// Show dropdown, hide text field
			document.getElementById("stateDropdownRow").style.display = "";
			document.getElementById("stateTextRow").style.display = "none";
			document.getElementById("stateTextRow1").style.display = "none";
		} else {
			// Hide both if nothing selected
			document.getElementById("stateTextRow").style.display = "none";
			document.getElementById("stateTextRow1").style.display = "none";
			document.getElementById("stateDropdownRow").style.display = "none";
		}
	}
</script> 

<script>
	function setupCharCounter(textareaId, counterId, maxLength) {
		const textarea = document.getElementById(textareaId);
		const counter = document.getElementById(counterId);

		if (!textarea || !counter) return;

		function updateCount() {
			let currentLength = textarea.value.length;

			// Agar limit cross ho gayi to cut kar do
			if (currentLength > maxLength) {
				textarea.value = textarea.value.substring(0, maxLength);
				currentLength = maxLength;
			}

			counter.textContent = `${currentLength} / ${maxLength} characters`;
		}

		// Initial call
		updateCount();

		// Update on typing/paste
		textarea.addEventListener("input", updateCount);

		return updateCount;
	}

	// Initialize counters on page load
	document.addEventListener("DOMContentLoaded", function() {
		window.updateArtists = setupCharCounter("artists", "artistsCount", 100);
		window.updateTitles  = setupCharCounter("titles", "titlesCount", 100);
		window.updateNotes   = setupCharCounter("notes", "notesCount", 500);
	});
</script>





<iframe id="leadExport" src="" frameborder="0"></iframe>
<iframe id="createXls" src="" frameborder="0"></iframe>

<cfset ajaxOnLoad("init")>
