<table border = "0" width = "600" cellpadding = "5" cellspacing = "0" bgcolor="ffffff">
	<cfif structKeyExists(url,'leadInserted')>
	<tr>
		<td align="center" style="color: #ff0000; font-size: 13px;">
			A new lead has been successfully added to the database under your ID.
		</td>
	</tr>
	</cfif>
	<tr>
		<td align="center" valign="top">
			<span class="header">LEAD SYSTEM</span>
		</td>
	</tr>
	<tr>
		<td align="center" valign="top">
			<span class="subheader">ENTER ALL AVALABLE INFORMATION
			<cfif session.loggedin NEQ true>
			<br> AND KEY IN YOUR PASSWORD TO SUBMIT TO THE DATABASE
			</cfif>
			</span>
		</td>
	</tr>
</table>



	


<cfform action="index.cfm?event=leads.insertLead" id="leadForm" name="leadForm">
<cfinput type="hidden" name="pk_leads" id="pk_leads" value="">
<!--- <cfinput type="hidden" name="fk_employees" id="fk_employees" value="#session.userinfo.pk_employees#"> --->
<table border = "0" width = "600" cellpadding = "5" cellspacing = "5" bgcolor="eeeeee">
	<tr>
		<td width="100">
			First Name:
		</td>
		<td>
			<cfinput name="fname" id="fname" autosuggest="cfc:admin.models.leads.searchLeadsByFname({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0">
			<!--- <cfinput type="text" name="fname" id="fname"  size="30"> --->
		</td>
	</tr>
	<tr>
		<td>
			<!---<span style="color: #ff0000;">*</span>&nbsp;--->Last Name<!--- (required):--->
		</td>
		<td>
			<cfinput name="lname" id="lname" autosuggest="cfc:admin.models.leads.searchLeadsByLname({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0">
			<!--- cfinput type="text" name="lname" id="lname"  size="30"> --->
		</td>
	</tr>
	<tr>
		<td>
			Email:
		</td>
		<td>
			<cfinput name="leadEmail" id="leadEmail" autosuggest="cfc:admin.models.leads.searchLeadsByEmail({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0">
			<!--- <cfinput type="text" name="leadEmail" id="leadEmail"  size="30"> --->
		</td>
	</tr>
	<!--- <tr>
		<td>
			Cell Phone:
		</td>
		<td>
			<cfinput type="text" name="CellPhone" id="CellPhone" size="30" mask="(999) 999-9999">
		</td>
	</tr>
	<tr>
		<td>
			Home Phone:
		</td>
		<td>
			<cfinput type="text" name="phone" id="phone" size="30" mask="(999) 999-9999">
		</td>
	</tr>
	<tr>
		<td>
			Business Phone:
		</td>
		<td>
			<cfinput type="text" name="businessphone" id="businessphone" size="30" mask="(999) 999-9999">
		</td>
	</tr>
	<tr>
		<td>
			Phone Outside the US:
		</td>
		<td>
			<cfinput type="text" name="otherphone" id="otherphone" size="30">
		</td>
	</tr> --->

	

	<tr>
		<td>
			Select Phone Number type
		</td>
		<td>		

			 <select name="PhoneType" id="PhoneType">
				<option value="Home Phone" >Home</option>
				<option value="Cell Phone" >Mobile</option>
				<option value="Business Phone" >Business</option>
				<option value="OutsideUS" >Outside US</option>
			</select>
		</td>
	</tr>


	<tr>
		<td>
			Phone Number
		</td>
		<td>

			<input type="text" name="PhoneNumber" id="PhoneNumber"  size="50" >
			<span id="formatSign">(xxx) xxx-xxxx</span>
		</td>
	</tr>

	<cfoutput>
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				const phoneInput = document.getElementById("PhoneNumber");
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
		<td>
			Best Time To Call:
		</td>
		<td>
			<cfinput type="text" name="besttime" id="besttime" size="30">
		</td>
	</tr>
	<!--- <tr>
		<td>
			Address:
		</td>
		<td>
			<cfinput type="text" name="address" id="address" size="30">
		</td>
	</tr>
	<tr>
		<td>
			City:
		</td>
		<td>
			<cfinput type="text" name="city" id="city" size="30">
		</td>
	</tr>
	<tr>
		<td>
			State:
		</td>
		<td>
        	<cfoutput>
        	<select name="state" id="state">
            <cfloop query="getStates">
                <option value="#stateAbb#">#state#</option>
            </cfloop>
            </select>
            </cfoutput>
			<!---<cfinput type="text" name="state" id="state" size="30">--->
		</td>
	</tr>
	<tr>
		<td>
			Country:
		</td>
		<td>
			<cfinput type="text" name="country" id="country" size="30">
		</td>
	</tr>
	<tr>
		<td>
			Zip Code:
		</td>
		<td>
			<cfinput type="text" name="zip" id="zip" size="30" value="">
		</td>
	</tr> --->


	<tr>
		<td>
			Address Type:
		</td>
		<td>
			<select name="AddressType" id="AddressType" onchange="toggleAddressFields()">
				<option value="">Please Select</option>
				<option value="USA"  >USA Address</option>
				<option value="Outside" >Outside USA</option>
			</select>
		</td>
	</tr>

	<!-- USA Address Section -->
	<tbody id="USAAddress" style="display:none;">
		<tr>
			<td>Street Address:</td>
			<td><input type="text" name="Address1" id="Address1" size="50" ></td>
		</tr>
		<tr>
			<td>City:</td>
			<td><input type="text" name="City" id="City" size="50" ></td>
		</tr>
		<tr>
			<td>State:</td>
			<td>
				<cfoutput>
					<select name="State" id="State">
						<option value="">Please Select</option>
						<cfloop query="getStates">
							<option value="#stateAbb#" >#state#</option>
						</cfloop>
					</select>
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td>Zip Code:</td>
			<td><input type="text" name="Zip" id="Zip" size="50" ></td>
		</tr>
	</tbody>

	<!-- Outside USA Address Section -->
	<tbody id="OutsideAddress" style="display:none;">
		<tr>
			<td>Street Address:</td>
			<td><input type="text" name="Address1_Outside" id="Address1_Outside" size="50" ></td>
		</tr>
		<tr>
			<td>City:</td>
			<td><input type="text" name="City_Outside" id="City_Outside" size="50" ></td>
		</tr>
		<tr>
			<td>State/Province:</td>
			<td><input type="text" name="State_Outside" id="State_Outside" size="50"></td>
		</tr>
		<tr>
			<td>Zip Code:</td>
			<td><input type="text" name="Zip_Outside" id="Zip_Outside" size="50" ></td>
		</tr>
		<tr>
			<td>Country:</td>
			<td><input type="text" name="Country" id="Country" size="50" ></td>
		</tr>
	</tbody>

	<script>
		function toggleAddressFields() {
			var type = document.getElementById("AddressType").value;
			document.getElementById("USAAddress").style.display = (type === "USA") ? "" : "none";
			document.getElementById("OutsideAddress").style.display = (type === "Outside") ? "" : "none";
		}

		// Run on page load if form already has a value
		window.onload = toggleAddressFields;
	</script>


	<tr>
		<td>
			Company:
		</td>
		<td>
			<cfinput type="text" name="company" id="company" size="30" value="">
		</td>
	</tr>
	<tr>
		<td>
			Website:
		</td>
		<td>
			<cfinput type="text" name="website" id="website" size="30" value="">
		</td>
	</tr>
	<tr>
		<td valign="top">
			Artists:
		</td>
		<td>
			<cftextarea name="artists" cols="40" rows="3"></cftextarea> 
		</td>
	</tr>
	<tr>
		<td valign="top">
			Titles:
		</td>
		<td>
			<cftextarea name="titles" cols="40" rows="3"></cftextarea> 
		</td>
	</tr>
	<tr>
		<td valign="top">
			Comments:
		</td>
		<td>
			<cftextarea name="notes" cols="40" rows="3"></cftextarea> 
		</td>
	</tr>
	<tr>
		<td valign="top">
			Origin:
		</td>
		<td>
			<cfset originValues = "WALK-IN,WEBSITE,PHONE,HOUSE,OTHER" />
			<cfoutput>
			<select name="origin">
				<option value="">Please Select</option>
				<cfloop list="#originValues#" index="idx">
					<option value="#idx#">#idx#</option>
				</cfloop>
			</select>
			</cfoutput>
		</td>
	</tr>
	<cfif session.loggedin EQ true AND (listFindNoCase(session.userinfo.roles,'leads') OR session.userinfo.sa EQ 1)>
		<cfinput type="hidden" name="password" value="#session.userinfo.password#">
	<cfelse>
	<tr>
		<td>
			Employee password:
		</td>
		<td>
			<cfinput type="password" name="password" id="password" size="30" required="Yes" message="You must enter your password.">
		</td>
	</tr>
	</cfif>
	<tr>
		<td colspan="2">
			<input type="Reset" value="Reset">
			<input type="Button" value="Submit" onClick="checkPasswordLead(); return false;" >
		</td>
	</tr>
	
</table>		
</cfform>


