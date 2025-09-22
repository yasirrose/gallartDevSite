<!--- <cfset temp = structDelete(session,'orderArray') /> --->
<cfhtmlhead text='
		<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

		<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
	
	'>

<table border = "0" width = "600" cellpadding = "5" cellspacing = "0" bgcolor="ffffff">
	<tr>
		<td align="center" valign="top">
			<span class="header">GALLART PRODUCT ORDER FORM</span><br><br>
			<span class="subheader">Enter your password to submit the order information.</span>
		</td>
	</tr>
</table>
<cfoutput>
<cfform action="index.cfm?event=orders.confirmInvoice" id="orderForm" name="orderForm">
<input type="hidden" name="invoiceNumber" id="invoiceNumber" value="0">
<input type="hidden" name="displayInvoiceNumber" id="displayInvoiceNumber" value="0">
<input type="hidden" name="assignedTo" id="assignedTo">
<table border = "0" width = "600" cellpadding = "5" cellspacing = "5" bgcolor="eeeeee">

	<cfif  session.loggedin EQ true >
		<tr>
			<td width="125">
				Search Existing Customers:
			</td>
			<td>
				<cfselect query="getCustomers" name="customerId" id="customerId" class="select2" display="full_customer_name" value="id" selected="#form.customerId#" onChange="getCustomer(this.value);" queryPosition="below">
				<option value="">Please Select</option>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td width="125">
				Search Leads:
			</td>
			<td>
				<cfselect query="getLeads" name="leadId" id="leadId" display="full_lead_name" class="select2" value="pk_leads" selected="#form.leadId#" onChange="getLead(this.value);" queryPosition="below">
				<option value="">Please Select</option>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="2">
				<input type="Button" value="Search All Contacts" onclick="openSearchAllContactsWindow();" />
			</td>
		</tr>
	</cfif>
	
	<cfoutput>
		<script>
			// $(document).ready(function() {
			// 	$('##customerId').select2({
			// 	placeholder: "Please Select",
			// 	allowClear: true
			// 	});
			// });

			 $(document).ready(function () {
                $('.select2').select2({
                    matcher: function (params, data) {
                        if ($.trim(params.term) === '') {
                            return data;
                        }

                        // Prevent matching placeholder during search
                        if (data.id === '') {
                            return null;
                        }

                        var term = params.term.toLowerCase();
                        var text = data.text.toLowerCase();

                        // Starts with match
                        if (text.startsWith(term)) {
                            return data;
                        }

                        // Contains match (less priority)
                        if (text.indexOf(term) > -1) {
                            var modifiedData = $.extend({}, data, true);
                            modifiedData.text = data.text + ' ';
                            return modifiedData;
                        }

                        return null;
                    },

                    sorter: function (data) {
                        var term = $('.select2-search__field').val().toLowerCase();
                        return data.sort(function (a, b) {
                            var aStarts = a.text.toLowerCase().startsWith(term);
                            var bStarts = b.text.toLowerCase().startsWith(term);

                            if (aStarts && !bStarts) return -1;
                            if (!aStarts && bStarts) return 1;
                            return 0;
                        });
                    }
                });
            });


			

		</script>
	</cfoutput>


	<tr>
		<td>
			First Name:
		</td>
		<td>
			<!--- <cfinput name="fname" id="fname" autosuggest="cfc:admin.models.leads.searchLeadsByFname({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0"  value="#form.fname#"> --->
			<input type="text" name="fname" id="fname"  size="50"  value="#form.fname#">
		</td>
	</tr>
	<tr>
		<td>
			Last Name:
		</td>
		<td>
			<cfinput name="lname" id="lname" autosuggest="cfc:admin.models.all_contacts.getAllContactsFromLname({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0" value="#form.lname#">
&nbsp;
<input type="Button" value="Fill" onclick="fillLname('orderform',document.getElementById('lname').value)">
			<!--- <input type="text" name="lname" id="lname"  size="50"  value="#form.lname#"> --->
		</td>
	</tr>
	<tr>
		<td valign="top">
			Email Address:
		</td>
		<td>
			<cfinput name="Email" id="Email" autosuggest="cfc:admin.models.all_contacts.getAllContactsFromEmail({cfautosuggestvalue})" maxResultsDisplay="10"  size="50" align="left" style="z-index:1000;" tabindex="0" value="#form.Email#">&nbsp;
			<input type="Button" value="Fill" onclick="fillEmail('orderform',document.getElementById('Email').value)">
			<!--- <input type="text" name="Email" id="Email" size="50" value="#form.Email#"> --->
		</td>
	</tr>
	<!--- <tr>
		<td>
			<span style="color: ##ff0000;">Cell Phone</span>
		</td>
		<td>
			<cfinput type="text" name="CellPhone" id="CellPhone"  size="50"  value="#form.CellPhone#" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home cell number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
		</td>
	</tr>
	<tr>
		<td width="125">
			Home Phone:
		</td>
		<td>
			<cfinput type="text" name="Phone" id="Phone"  size="50"  value="#form.Phone#" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
		</td>
	</tr>
	<tr>
		<td>
			Business Phone
		</td>
		<td>
			<cfinput type="text" name="BusinessPhone" id="BusinessPhone"  size="50"  value="#form.BusinessPhone#" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the business phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
		</td>
	</tr>
	<tr>
		<td>
			Phone Outside the US
		</td>
		<td>
			<input type="text" name="OtherPhone" id="OtherPhone"  size="50"  value="#form.OtherPhone#">
		</td>
	</tr> --->

	<tr>
		<td>
			Select Phone Number type
		</td>
		<td>		

			 <select name="PhoneType" id="PhoneType">
				<option value="Home Phone" <cfif form.PhoneType EQ "Home Phone">selected</cfif>>Home</option>
				<option value="Cell Phone" <cfif form.PhoneType EQ "Cell Phone">selected</cfif>>Mobile</option>
				<option value="Business Phone" <cfif form.PhoneType EQ "Business Phone">selected</cfif>>Business</option>
				<option value="OutsideUS" <cfif form.PhoneType EQ "OutsideUS">selected</cfif>>Outside US</option>
			</select>
		</td>
	</tr>

	<tr>
		<td>
			Phone Number
		</td>
		<td>

			<input type="text" name="PhoneNumber" id="PhoneNumber" maxlength="20"  size="20" value="#form.PhoneNumber#">
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

	

	<!--- <tr>
		<td>
			Fax:
		</td>
		<td>
			<input type="text" name="Fax" id="Fax" size="50"  value="#form.Fax#">
		</td>
	</tr> --->

	<tr>
		<td>
			Consultant:
		</td>
		<td>			
			
			<input type="text" name="Consultant" id="Consultant"  size="50"  value="#form.Consultant#">
		</td>
	</tr>
	<tr>
		<td>
			Company Name:
		</td>
		<td>
			<input type="text" name="Company" id="Company"  size="50"  value="#form.Company#">
		</td>
	</tr>
	<!--- <tr>
		<td>
			Address:
		</td>
		<td>
			<input type="text" name="Address1" id="Address1" size="50" value="#form.Address1#">
		</td>
	</tr>
	<tr>
		<td>
			City:
		</td>
		<td>
			<input type="text" name="City" id="City" size="50" value="#form.City#">
		</td>
	</tr>
	<tr>
		<td>
			State:
		</td>
		<td>
        	<select name="State" id="State">
            <option value="">Please Select</option>
            <cfloop query="getStates">
                <option value="#stateAbb#" <cfif form.State EQ stateAbb>selected</cfif>>#state#</option>
            </cfloop>
            </select>
			<!---<input type="text" name="State" id="State" size="50" value="#form.State#">--->
		</td>
	</tr>
	<tr>
		<td>
			Country:
		</td>
		<td>
			<input type="text" name="Country" id="Country" size="50" value="#form.Country#">
		</td>
	</tr>
	<tr>
		<td>
			Zip Code:
		</td>
		<td>
			<input type="text" name="Zip" id="Zip" size="50" value="#form.Zip#">
		</td>
	</tr> --->

	<tr>
		<td>
			Address Type:
		</td>
		<td>
			<select name="AddressType" id="AddressType" onchange="toggleAddressFields()">
				<option value="">Please Select</option>
				<option value="USA" <cfif form.AddressType eq 'USA'>selected</cfif> >USA Address</option>
				<option value="Outside" <cfif form.AddressType eq 'Outside'>selected</cfif>>Outside USA</option>
			</select>
		</td>
	</tr>

	<!-- USA Address Section -->
	<tbody id="USAAddress" style="display:none;">
		<tr>
			<td>Street Address:</td>
			<td><input type="text" name="Address1" id="Address1" size="50" value="#form.Address1#"></td>
		</tr>
		<tr>
			<td>City:</td>
			<td><input type="text" name="City" id="City" size="50" value="#form.City#"></td>
		</tr>
		<tr>
			<td>State:</td>
			<td>
				<select name="State" id="State">
					<option value="">Please Select</option>
					<cfloop query="getStates">
						<option value="#stateAbb#" <cfif form.State EQ stateAbb>selected</cfif> >#state#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<td>Zip Code:</td>
			<td><input type="text" name="Zip" id="Zip" size="50" value="#form.Zip#"></td>
		</tr>
	</tbody>

	<!-- Outside USA Address Section -->
	<tbody id="OutsideAddress" style="display:none;">
		<tr>
			<td>Street Address:</td>
			<td><input type="text" name="Address1_Outside" id="Address1_Outside" size="50" value="#form.Address1_Outside#"></td>
		</tr>
		<tr>
			<td>City:</td>
			<td><input type="text" name="City_Outside" id="City_Outside" size="50" value="#form.City_Outside#"></td>
		</tr>
		<tr>
			<td>State/Province:</td>
			<td><input type="text" name="State_Outside" id="State_Outside" size="50" value="#form.State_Outside#"></td>
		</tr>
		<tr>
			<td>Zip Code:</td>
			<td><input type="text" name="Zip_Outside" id="Zip_Outside" size="50" value="#form.Zip_Outside#"></td>
		</tr>
		<tr>
			<td>Country:</td>
			<td><input type="text" name="Country" id="Country" size="50" value="#form.Country#"></td>
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
			Website:
		</td>
		<td>
			<input type="text" name="website" id="website" size="50" value="#form.website#">
		</td>
	</tr>
	<tr>
		<td valign="top">
			Method of Payment:
		</td>
		<td>
			<cfset paymentOptions = "VISA/MC,AMEX,CHECK,CASH,OTHER" />
			<select name="Payment_Method" id="Payment_Method">
				<option value="">Please Select</option>
				<cfloop list="#paymentOptions#" index="idx">
					<option value="#idx#" <cfif idx EQ form.Payment_Method>selected</cfif>>#idx#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td valign="top">
			Credit Card Number:
		</td>
		<td>
			
			<input type="text" name="CardNumber" id="CardNumber" size="50" value="#form.CardNumber#">
		</td>
	</tr>
	<tr>
		<td valign="top">
			Expiration Date:
		</td>
		<td>
			
			MM&nbsp;
			<select name="cardexpm">
				<cfloop from="1" to="12" index="monthis">
					<cfif len(monthis) EQ 1>
						<option value="0#monthis#" <cfif monthis EQ form.cardexpm>selected</cfif>>0#monthis#</option>
					<cfelse>
						<option value="#monthis#" <cfif monthis EQ form.cardexpm>selected</cfif>>#monthis#</option>
					</cfif>
				</cfloop>
			</select>
			YY&nbsp;
			<select name="cardexpy">
				<cfset toyear = #Year(Now())# + 10>
				<cfloop from="#Year(Now())#" to="#toyear#" index="yearis">
					<option value="#right(yearis,2)#" <cfif right(yearis,2) EQ form.cardexpy>selected</cfif>>#right(yearis,2)#</option>

				</cfloop>
			</td>
	</tr>
	<tr>
		<td valign="top">
			Auth Code:
		</td>
		<td>
			<input type="text" name="authcode" id="authcode" size="50" value="#form.authcode#">
		</td>
	</tr>
	<tr>
		<td valign="top">
			Driver's License Number:
		</td>
		<td>
			<input type="text" name="DriversLicense" id="DriversLicense" size="50" value="#form.DriversLicense#">
		</td>
	</tr>
	<tr>
		<td valign="bottom">
			TO BE SHIPPED:
		</td>
		<td valign="top">
			<input type="checkbox" name="tobeshipped" align="texttop" id="tobeshipped" <cfif form.tobeshipped EQ 1>checked</cfif> >
			<input type="Hidden" name="tobeshipped">
		</td>
	</tr>
	<tr>
		<td valign="bottom">
			ESTIMATE:
		</td>
		<td valign="top">
			<input type="checkbox" name="estimate" align="texttop" id="estimate" value="1" <cfif form.estimate EQ 1>checked</cfif> >
			<input type="Hidden" name="estimate">
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Add Product By Art ID" onclick="openProductIdWindow();" />
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Add Product By Product Title" onclick="openProductTitleWindow();" />
		</td>
	</tr>

<script>
	function openArtInfo() {
		window.open('index.cfm?event=orders.artInfo', 'artInfo', 'width=500,height=250,left=0,top=0,resizable=yes,scrollbars=yes');
	}

	function openFramingInfo() {
		window.open('index.cfm?event=orders.framingInfo', 'framingInfo', 'width=500,height=250,left=0,top=0,resizable=yes,scrollbars=yes');
	}
</script>

	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Add Product Not In Database" onclick="openArtInfo();" />
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<input type="Button" value="Add Framing Order" onclick="openFramingInfo();" />
		</td>
	</tr>
	<tr>
		<td colspan="2" id="artListings">
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			Special Instructions:
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<textarea name="special_instructions" cols="50" rows="3">#form.special_instructions#</textarea>
		</td>
	</tr>
	<tr>
		<td valign="top">
			Origin:
		</td>
		<td>
			<cfset originValues = "WALK-IN,WEBSITE,PHONE,HOUSE,OTHER" />
			<select name="origin">
				<option value="">Please Select</option>
				<cfloop list="#originValues#" index="idx">
					<option value="#idx#" <cfif idx EQ form.origin>selected</cfif>>#idx#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<cfif session.loggedin EQ true AND (listFindNoCase(session.userinfo.roles,'orders') OR session.userinfo.sa EQ 1)>
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
			<input type="Button" value="Submit" onClick="checkPasswordOrder(); return false;" >
		</td>
	</tr>
</table>
</cfform>

</cfoutput>
<script language="JavaScript">
	displayArtListings();
</script>

<div id="cfWindows">
<cfwindow name="artIdWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Art ID" width="250" height="200" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="0" border="0" width="100%" bgcolor="#ffffff">
		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px;">
				Enter Art ID:<br><br>
			</td>
		</tr>

		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px;">
				<input list="artIdList" name="modelno" id="modelno" size="20" value="">&nbsp;&nbsp;<input type="Button" value="ADD" onclick="findArt(document.getElementById('modelno').value);" />

				<cfquery name="artIds" datasource="#application.dsource#">
					SELECT modelno   /* or the column name for Art ID */
					FROM products
					WHERE active = 1
					AND modelno <> ''
				</cfquery>

				<datalist id="artIdList">
					<cfoutput query="artIds">
						<option value="#artIds.modelno#">
					</cfoutput>
				</datalist>

			</td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artIdWindow');" style="font-size: 10px;">
			</td>
		</tr>
	</table>
</cfwindow>

<style>
	div.autosuggestcontainer .yui-ac-content {
		*left: -5;
	}
</style>

<cfwindow name="artTitleWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Product Title" width="400" height="400" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="0" border="0" width="100%" bgcolor="#ffffff">
		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px;">
				As you enter the title, the system will try to find the listing that you are looking for:<br><br>
			</td>
		</tr>
		<tr>
			<td align="center">
				<input list="artTitles" name="artTitle" id="artTitle" size="50" align="left" style="z-index:1000;" tabindex="0">

				<cfquery name="data" datasource="#application.dsource#">
					SELECT name FROM products
					WHERE active = 1
					AND name <> ''
				</cfquery>

				<datalist id="artTitles">
					<cfoutput query="data">
						<option value="#data.name#">
					</cfoutput>
				</datalist>
			</td>
		</tr>
		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px; padding-top: 15px;">
				<input type="Button" value="ADD" onclick="findArtTitle(document.getElementById('artTitle').value);" />
			</td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artTitleWindow');" style="font-size: 10px;">
			</td>
		</tr>
	</table>
</cfwindow>

<!--- <script language="JavaScript">
	function formatPrice(){
		document.artInfoForm.price.value = decimalFormat(document.artInfoForm.priceInput.value);
	}
	function formatFramingPrice(){
		document.framingInfoForm.price.value = decimalFormat(document.framingInfoForm.priceInput.value);
	}
</script> --->

<!--- <cfwindow name="artInfoWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Product Info" width="400" height="300" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" onsubmit="submitArtInfo(); return false;" name="artInfoForm">
		<input type="Hidden" name="price">
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Enter Product Info:<br><br>
			</td>
		</tr>
		<tr>
			<td>Title:</td>
			<td>
				<input type="text" name="title" id="title" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Artist:</td>
			<td>
				<input type="text" name="artist" id="artist" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Short Description:</td>
			<td>
				<input type="text" name="desc" id="desc" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Price:</td>
			<td>
				$<cfinput type="text" name="priceInput" id="priceInput" size="10" value="" validate="float" message="Please enter a numeric value for the price with no dollar sign." onkeyup="formatPrice();">
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Submit" value="ADD" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artInfoWindow');" style="font-size: 10px;">
			</td>
		</tr>
		</cfform>
	</table>
</cfwindow> --->

<!--- <cfwindow name="framingInfoWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Framing Info" width="350" height="250" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" onsubmit="submitFramingInfo(); return false;" name="framingInfoForm">
		<input type="Hidden" name="price">
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Enter Framing Info:<br><br>
			</td>
		</tr>
		<tr>
			<td>Title:</td>
			<td>
				<input type="text" name="title" id="title" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Artist:</td>
			<td>
				<input type="text" name="artist" id="artist" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Short Description:</td>
			<td>
				<input type="text" name="desc" id="desc" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Price:</td>
			<td>
				$<cfinput type="text" name="priceInput" id="priceInput" size="10" value="" validate="float" message="Please enter a numeric value for the price with no dollar sign." onkeyup="formatFramingPrice();">
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Submit" value="ADD" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('framingInfoWindow');" style="font-size: 10px;">
			</td>
		</tr>
		</cfform>
	</table>
</cfwindow> --->


<!--- <script>
  // yeh code aapke getCustomer() / getLead() ko bilkul change nahi karta
  document.addEventListener('DOMContentLoaded', function () {
    var $cust = window.jQuery ? jQuery('#customerId') : null;
    var $lead = window.jQuery ? jQuery('#leadId') : null;

    // Agar jQuery/Select2 hai to yeh path; warna plain JS fallback niche hai
    if ($cust && $lead && $cust.length && $lead.length) {
      function disableLead(disable) {
        $lead.prop('disabled', disable).trigger('change.select2');
      }
      function disableCustomer(disable) {
        $cust.prop('disabled', disable).trigger('change.select2');
      }

      // Page load par existing values check
      if ($cust.val()) disableLead(true);
      if ($lead.val()) disableCustomer(true);

      // Customer change -> Leads disable/enable
      $cust.on('change', function () {
        if (this.value) {
          disableLead(true);
        } else {
          disableLead(false);
        }
      });

      // Lead change -> Customers disable/enable
      $lead.on('change', function () {
        if (this.value) {
          disableCustomer(true);
        } else {
          disableCustomer(false);
        }
      });
      return; // jQuery branch done
    }

    // ------- Plain JS fallback (agar jQuery/Select2 nahi laga) -------
    var customerDropdown = document.getElementById('customerId');
    var leadDropdown = document.getElementById('leadId');
    if (!customerDropdown || !leadDropdown) return;

    if (customerDropdown.value) leadDropdown.disabled = true;
    if (leadDropdown.value) customerDropdown.disabled = true;

    customerDropdown.addEventListener('change', function () {
      leadDropdown.disabled = !!this.value;
    });

    leadDropdown.addEventListener('change', function () {
      customerDropdown.disabled = !!this.value;
    });
  });
</script> --->



<script>
document.addEventListener("DOMContentLoaded", function() {
    const customerSelect = $("#customerId");
    const leadSelect = $("#leadId");

    function toggleDropdowns() {
        const customerVal = customerSelect.val();
        const leadVal = leadSelect.val();

        if (customerVal) {
            // Customer selected → disable leads
            leadSelect.prop("disabled", true).trigger("change.select2");
            customerSelect.prop("disabled", false).trigger("change.select2");
        } 
        else if (leadVal) {
            // Lead selected → disable customers
            customerSelect.prop("disabled", true).trigger("change.select2");
            leadSelect.prop("disabled", false).trigger("change.select2");
        } 
        else {
            // Both empty → enable both
            customerSelect.prop("disabled", false).trigger("change.select2");
            leadSelect.prop("disabled", false).trigger("change.select2");
        }
    }

    // Run once on page load
    toggleDropdowns();

    // Run on change
    customerSelect.on("change", toggleDropdowns);
    leadSelect.on("change", toggleDropdowns);
});
</script>








<cfwindow name="searchAllContactsWindow" center="true" modal="true" resizable="false" closable="false" title="Search All Contacts" width="500" height="500" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" name="searchAllContactsForm">
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Use the following to search all contacts in the database:<br><br>
			</td>
		</tr>
		<tr>
			<td>Last Name:</td>
			<td>
				<input type="text" name="allcontacts_lname" id="allcontacts_lname" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Email:</td>
			<td>
				<input type="text" name="allcontacts_email" id="allcontacts_email" size="40" value="">
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Reset" value="RESET"  onclick="document.forms['searchAllContactsForm'].reset(); 
          document.getElementById('allcontacts_lname').value='';
          document.getElementById('allcontacts_email').value='';" /> 
				<!--- <input type="Submit" value="SEARCH" /> --->
				<input type="button" value="SEARCH" 
       onclick="submitSearchAllContacts(
         document.getElementById('allcontacts_lname').value,
         document.getElementById('allcontacts_email').value
       )">
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('searchAllContactsWindow');" style="font-size: 10px;">
			</td>
		</tr>
		</cfform>
		<tr>
			<td colspan="2" id="displayAllContacts">
			</td>
		</tr>
	</table>
</cfwindow>
</div>


<script>

	var cardRules = {
		"VISA/MC": { length: 19, pattern: /^(4\d{15}|5[1-5]\d{14})$/, format: "#### #### #### ####", placeholder: "4111 1111 1111 1111 or 5100 0000 0000 0000" },
		// "MC": { length: 19, pattern: /^5[1-5]\d{14}$/, format: "#### #### #### ####", placeholder: "5100 0000 0000 0000" },
		"AMEX": { length: 17, pattern: /^3[47]\d{13}$/, format: "#### ###### #####", placeholder: "3712 345678 90123" },
		// "Discover": { length: 19, pattern: /^6(?:011|5\d{2})\d{12}$/, format: "#### #### #### ####", placeholder: "6011 0000 0000 0000" }
	};

	document.addEventListener("DOMContentLoaded", function () {
		const cardInput = document.getElementById("CardNumber");
		const cardTypeSelect = document.querySelector("[name='Payment_Method']");

		// Function to update card validation rules on card type change
		function updateCardValidation() {
			const selectedCardType = cardTypeSelect.value;
			if (cardRules[selectedCardType]) {
				cardInput.maxLength = cardRules[selectedCardType].length;
				cardInput.setAttribute("data-pattern", cardRules[selectedCardType].pattern);
				cardInput.placeholder = cardRules[selectedCardType].placeholder;
				cardInput.value = ""; // Reset input on type change
			} else{
				cardInput.removeAttribute("maxLength");
				cardInput.removeAttribute("data-pattern");

				// yahan placeholder hata dein
				cardInput.placeholder = "";
			}
		}

		// Format card number according to selected card type
		  // Format card number according to selected card type's format mask
        function formatCardNumber(value, selectedCardType) {
            const rule = cardRules[selectedCardType];
            if (!rule) return value; // no formatting if no rule

            let cleanValue = value.replace(/\D/g, ''); // digits only
            let format = rule.format || "#### #### #### ####";
            let formattedValue = "";
            let index = 0;

            for (let i = 0; i < format.length && index < cleanValue.length; i++) {
                let ch = format.charAt(i);
                if (ch === "#") {
                    formattedValue += cleanValue.charAt(index++);
                } else {
                    formattedValue += ch;
                }
            }

            return formattedValue;
        }

        // Only format while typing if selected payment method has a rule (Visa/Amex)
        if (cardInput) {
            cardInput.addEventListener("input", function (e) {
                const selectedCardType = cardTypeSelect ? cardTypeSelect.value : "";
                if (cardRules[selectedCardType]) {
                    // format the value
                    e.target.value = formatCardNumber(e.target.value, selectedCardType);
                } else {
                    // do nothing (leave the user's input as-is)
                }
            });
        }

        if (cardTypeSelect) {
            cardTypeSelect.addEventListener("change", updateCardValidation);
        }

        // run once at load to set initial state (in case form has a saved value)
        updateCardValidation();
    });
</script>

