<cfhtmlhead text='<script type="text/javascript" src="../js/jquery-1.3.2.js" language="JavaScript"></script>'>
<cfif session.loggedin EQ false>
	<cflocation url="index.cfm">
</cfif>
<script language="JavaScript">
function popupWin(url) {
	orderuidVal = $('#orderuid').val();
	aOrderVal = "";
	bOrderVal = "";
	cOrderVal = "";
	if ($('#a_orders').val() != undefined) {
		aOrderVal = $('#a_orders').val();
	}
	if ($('#b_orders').val() != undefined) {
		bOrderVal = $('#b_orders').val();
	}
	if ($('#c_orders').val() != undefined) {
		cOrderVal = $('#c_orders').val();
	}
	url = url + '?orderuid=' + orderuidVal + '&a_orders=' + aOrderVal + '&b_orders=' + bOrderVal + '&c_orders=' + cOrderVal;
	w = 1000;  // width
	h = 1000;  // height
	var features =	'scrollbars=yes, toolbar=no, status=no, menubar=no ' +
					',resizable=yes, location=no, directories=no ' +
					',left=' + ((screen.width-w)/2) +
					',top='  + ((screen.height-h)/2) +
					',width=' + w + ',height=' + h;

	myWin =	window.open(url,'WinName',features);
}
function popupWinEmail(url) {
	qString = document.getElementById('orderuid').value;
	url = url + '?orderuid=' + qString;
	w = 200;  // width
	h = 100;  // height
	var features =	'scrollbars=yes, toolbar=no, status=no, menubar=no ' +
					',resizable=yes, location=no, directories=no ' +
					',left=' + ((screen.width-w)/2) +
					',top='  + ((screen.height-h)/2) +
					',width=' + w + ',height=' + h;

	myWin =	window.open(url,'WinName',features);
}
</script>



<script>
    function doEdit(type) {

       var edit = new admin.models.orders();

       edit.setForm("editForm");

       if (type == 'edit'){

        if ( edit.editOrderFromForm()) {
            ColdFusion.Grid.refresh('data',true);
        }
        else { alert( 'There was a problem in the processing.')}
	        }
	     //else if (type == 'delete'){
	     	//console.log('delete')
	     	// if ( edit.deleteOrder()) {
       //      ColdFusion.Grid.refresh('data',true);
        // }
        // else { alert( 'There was a problem in the processing.')}
	       //  }
	document.getElementById('edit').value = 'Edit';
   	document.getElementById('delete').style.display = '';
   }


</script>




<cfajaxproxy cfc="admin.models.orders" />
<cfajaxproxy bind="javascript:gridChange({data.orderuid})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/orders.js.cfm" language="JavaScript"></script>'>


<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
	 	<td colspan="2" style="font-size: 11px;"><strong>SEARCH BY:</strong>
			<!--- <span style="padding-left: 250px;">
				<input type="button" value="Create Order Report" onclick="createReport();" />
			</span> --->
		</td>
	</tr>
	<tr>
		<td valign="top" width="400">
			<cfform name="gridForm">
			<table cellspacing="5" cellpadding="1" border="0" width="100%">
				<tr>
					<td align="left" style="font-size: 10px;">
						<strong>Last Name:</strong>
						<br>
						<cfinput name="searchLname" size="35" maxlength="50" value="#form.searchLname#" />
					</td>
					<td align="left" style="font-size: 10px;">
						<strong>First Name:</strong>
						<br>
						<cfinput name="searchFname" size="35" maxlength="50" />

					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="left" style="font-size: 10px;">
						<strong>Company Name:</strong>
						<br>
						<cfinput name="searchCompany" size="35" maxlength="50" value="#form.searchCompany#" />
					</td>
					<td align="left" style="font-size: 10px;">
						<strong>Price:</strong>
						<br>
						<cfinput name="searchprice" size="35" maxlength="50" />
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td align="left" style="font-size: 10px;">	
						<strong>Amount Sale:</strong>
						<br>
						<cfinput name="searchAmountSale" size="35" maxlength="35" value="#form.searchAmountSale#" />												
					</td>
					<td align="left" style="font-size: 10px;">
						<strong>Country:</strong>
						<br>
						<cfinput name="searchcountry" size="35" maxlength="50" />
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td align="left" style="font-size: 10px;">
						<strong>Email:</strong>
						<br>
						<cfinput name="searchEmail" size="35" maxlength="50" value="#form.searchEmail#" />
					</td>
					<td align="left" style="font-size: 10px;">
						<strong>Employee:</strong>
						<br>
						<cfselect query="getEmployees" name="searchEmployeeId" display="emp_name" value="pk_employees" selected="#form.searchEmployeeId#" queryPosition="below">
							<option value="">All</option>
						</cfselect>
					</td>
					<td>&nbsp;</td>
				</tr>
				<!--- <tr>
					<td align="right" style="font-size: 10px;">
						<strong>Company Name:</strong>
					</td>
					<td>
						<cfinput name="searchCompany" size="35" value="#form.searchCompany#" />
					</td>
					<td>&nbsp;</td>
				</tr> --->
				<!--- <tr>
					<td align="right" style="font-size: 10px;">
						<strong>Amount Sale:</strong>
					</td>
					<td>
						<cfinput name="searchAmountSale" size="35" value="#form.searchAmountSale#" />
					</td>
					<td>&nbsp;</td>
				</tr> --->
				<!--- <tr>
					<td align="right" style="font-size: 10px;">
						<strong>Email:</strong>
					</td>
					<td>
						<cfinput name="searchEmail" size="35" value="#form.searchEmail#" />
					</td>
					<td>&nbsp;</td>
				</tr> --->
				<!--- <tr>
					<td align="right" style="font-size: 10px;">
						<strong>Employee:</strong>
					</td>
					<td>
						<cfselect query="getEmployees" name="searchEmployeeId" display="emp_name" value="pk_employees" selected="#form.searchEmployeeId#" queryPosition="below">
							<option value="">All</option>
						</cfselect>
					</td>
					<td>&nbsp;</td>
				</tr> --->
				<tr>
					<td align="left" style="font-size: 10px;">
						<strong>Title:</strong>
						<br>
						<cfinput name="searchTitle" size="35" maxlength="60" value="#form.searchTitle#" />
					</td>
					<td align="left" style="font-size: 10px;">
						<strong>Artist:</strong>
						<br>
						<cfinput name="searchArtist" size="35" maxlength="60" value="#form.searchArtist#" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<!--- <tr>
					<td align="right" style="font-size: 10px;">
						<strong>Artist:</strong>
					</td>
					<td>
						<cfinput name="searchArtist" size="35" value="#form.searchArtist#" />
					</td>
					<td>&nbsp;</td>
				</tr> --->
				
				<tr>
					<td align="left" style="font-size: 10px;">
						<strong>Origin:</strong>
						<br>
						<cfset originValues = "WALK-IN,WEBSITE,PHONE,OTHER" />

						<cfoutput>
							<select name="searchOrigin">
								<option value="">All</option>
								<cfloop list="#originValues#" index="idx">
									<option value="#idx#">#idx#</option>
								</cfloop>
							</select>
						</cfoutput>
					</td>
					<td  align="left" style="font-size: 10px;">
						<strong>State:</strong>
						<br>
						<cfselect query="getStates" name="searchStates" display="state" value="stateAbb" selected="#form.searchStates#" queryPosition="below">
							<option value="0">All</option>
						</cfselect>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="left" class="date-field" style="font-size: 10px;" nowrap>
						<strong>Date from:</strong>
						<cfinput name="searchFromDate" type="datefield" validate="date" size="10" maxlength="25" value="#form.searchFromDate#" />
					</td>
					<td align="left" class="date-field" style="font-size: 10px;" nowrap>
						<strong>Date to:</strong>
						<cfinput name="searchToDate" type="datefield" validate="date" size="10" maxlength="25" value="#form.searchToDate#" />
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td align="left" style="font-size: 10px;">
						<strong>Balance Due:</strong>
						<input type="Checkbox" name="searchBalancedue">
						<input type="Hidden" name="searchBalancedue">
					</td>
					<td align="left" style="font-size: 10px;">
						<image src="<cfoutput>#imgpath#</cfoutput>/checkmark-bw.png" border="0" width="12" />
						<input type="Checkbox" name="searchLexy">
						<input type="Hidden" name="searchLexy">
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<!--- <td align="right" class="date-field" style="font-size: 10px;">
						<strong>Date to:</strong>
					</td>
					<td nowrap>
						<cfinput name="searchToDate" type="datefield" validate="date" size="10" value="#form.searchToDate#" />
						
					</td> --->
					<td>
						<input type="Reset" onclick="setTimeout(function(){location.reload();},100);">
						<cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr>
                <!--- <tr>
					<td align="right" style="font-size: 10px;">
						<strong>State:</strong>
					</td>
					<td>
						<cfselect query="getStates" name="searchStates" display="state" value="stateAbb" selected="#form.searchStates#" queryPosition="below">
							<option value="0">All</option>
						</cfselect>
					</td>
					<td>&nbsp;</td>
				</tr> --->
				<!--- <tr>
					<td align="right" style="font-size: 10px;">
						<image src="<cfoutput>#imgpath#</cfoutput>/checkmark-bw.png" border="0" width="12" />
					</td>
					<td>
						<input type="Checkbox" name="searchLexy">
						<input type="Hidden" name="searchLexy">
					</td>
					<td>&nbsp;</td>
				</tr> --->
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.orders.getOrders({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchCompany},{searchAmountSale},{searchEmail},{searchEmployeeId},{searchTitle},{searchArtist},{searchBalancedue},{searchOrigin},{searchFromDate},{searchToDate},{searchStates},{searchLexy},{searchcountry},{searchFname},{searchprice})">
							<cfgridcolumn name="orderuid" display="false">
							<!--- <cfif listFindNoCase(session.userinfo.roles,'special admin')>
								<cfgridcolumn name="row_number" header="Order ID" width="80">
							<cfelse>
								<cfgridcolumn name="orderuid" header="Order ID" width="80">
							</cfif> --->
							<cfif listFindNoCase(session.userinfo.roles,'b orders')>
								<cfgridcolumn name="b_orders" header="Order ID" width="80">
							<cfelseif listFindNoCase(session.userinfo.roles,'international')>
								<cfgridcolumn name="c_orders" header="Order ID" width="80">
							<cfelse>
								<cfgridcolumn name="a_orders" header="Order ID" width="80">
							</cfif>
							<cfgridcolumn name="customer_fname" header="First Name" width="100">
							<cfgridcolumn name="customer_lname" header="Last Name" width="100">
							<cfgridcolumn name="customer_email" header="Email" width="180">
							<cfgridcolumn name="orderDate" header="Date" width="60">
                            <cfgridcolumn name="state" header="State" width="60">
						</cfgrid>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center"><br>
						<cfinput type="submit" name="exportBtn" value="Export to CSV" formaction="http://23.20.226.157/admin/views/orders/manage/exportOrder.cfm" formmethod="post"  onclick="disableExportBtn(this);"/>
					</td>
				</tr>
			</table>
			</cfform>

			<!--- <span>
				<input type="button" value="Create Order Report" onclick="createReport();" />
			</span> --->
		</td>

		<script type="text/javascript">
			function disableExportBtn(btn) {
				btn.disabled = true;             

				btn.form.action = btn.getAttribute("formaction");  
        		btn.form.method = btn.getAttribute("formmethod"); 

				btn.value = "Exporting...";      
				btn.form.submit();  
				
				setTimeout(function(){
					btn.disabled = false;
					btn.value = "Export to CSV";
				}, 5000); 
				
			}
		</script>

		<td valign="top">

			<cfform name="editForm" method="POST" id="editForm" action="index.cfm?event=orders.productOrdersProcess" onsubmit="return validateOrderForm();">
			<cfinput type="hidden" name="orderuid" id="orderuid" bind="{data.orderuid}">
			<cfinput type="hidden" name="a_orders" id="a_orders" bind="{data.a_orders}">
			<cfinput type="hidden" name="b_orders" id="b_orders" bind="{data.b_orders}">
			<cfinput type="hidden" name="c_orders" id="c_orders" bind="{data.c_orders}">
			<cfinput type="hidden" name="customerid" id="customerid" bind="{data.customerid}">
			<cfinput type="hidden" name="amountSaleValue" id="amountSaleValue" bind="{data.amountSale}">
			<cfinput type="hidden" name="framingAmountValue" id="framingAmountValue" bind="{data.framingAmount}">
			<cfinput type="hidden" name="taxValue" id="taxValue" bind="{data.tax}">
			<cfinput type="hidden" name="insuranceValue" id="insuranceValue" bind="{data.insurance}">
			<cfinput type="hidden" name="totalValue" id="totalValue" bind="{data.total}">
			<cfinput type="hidden" name="discountValue" id="discountValue" bind="{data.discount}">
			<cfinput type="hidden" name="amountPaidValue" id="amountPaidValue" bind="{data.amountPaid}">
			<cfinput type="hidden" name="balanceDueValue" id="balanceDueValue" bind="{data.balanceDue}">
			<cfinput type="hidden" name="shipCostValue" id="shipCostValue" bind="{data.shipCost}">
			<cfinput type="hidden" name="searchLnameValue">
			<cfinput type="hidden" name="searchCompanyValue">
			<cfinput type="hidden" name="searchAmountSaleValue">
			<cfinput type="hidden" name="searchEmailValue">
			<cfinput type="hidden" name="searchFromDateValue">
			<cfinput type="hidden" name="searchToDateValue">

			<cfinput type="hidden" name="moduleName" id="moduleName" value="Order Module">

			<table border = "0" width = "700" cellpadding = "1" cellspacing = "0" class="editBox">
				<tr>
					<td>
						<table border = "0" width = "100%" cellpadding = "3" cellspacing = "5">
							<tr>
								<td colspan="2">
									<div id="showIncomplete" style="display: none;">
										<span style="color: red; margin-right: 50px;">INCOMPLETE ORDER</span>Check when order is complete:&nbsp;<input type="checkbox" name="complete" id="complete" value="1" class="displayInput">
									</div>
								</td>
							</tr>
							<tr>
								<td width="150" class="title">
									<strong>ORDER TAKEN BY:</strong>
									<br>
									<cfinput type="text" name="emp_name" id="emp_name"  bind="{data.emp_name}" size="35" class="displayInput" disabled>
								</td>
								<td>
									<strong>LEAD ASSIGNED TO:</strong>
									<br>
									<cfinput type="text" name="assignedto_name" id="assignedto_name"  bind="{data.assignedto_name}" size="35" class="displayInput" disabled>
								</td>
							</tr>
							<!--- <tr>
								<td class="title">
									<strong>LEAD ASSIGNED TO:</strong>
								</td>
								<td>
									<cfinput type="text" name="assignedto_name" id="assignedto_name"  bind="{data.assignedto_name}" size="35" class="displayInput" disabled>
								</td>
							</tr> --->
							<tr>
								<td colspan="2" class="title">
									<strong>CUSTOMER INFO</strong>
								</td>
							</tr>
							<tr>
								<td>
									First Name:
									<br>
									<cfinput type="text" name="fname" id="fname"  bind="{data.customer_fname}" size="35" class="displayInput" maxlength="35">
								</td>
								<td>
									Last Name:
									<br>
									<cfinput type="text" name="lname" id="lname" maxlength="35" bind="{data.customer_lname}" size="35" class="displayInput">
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Last Name:
								</td>
								<td>
									<cfinput type="text" name="lname" id="lname" maxlength="35" bind="{data.customer_lname}" size="35" class="displayInput">
								</td>
							</tr> --->

							<tr>
								<td style="font-size: 10px;">
									Address Type:
									<br>
									<cfset Addtype = "USA,Outside" />
									<cfoutput>
										<select name="Addresstype" id="Addresstype" onchange="toggleStateField();" style="width: 100%;">
											<option value="">Please Select</option>
											<cfloop list="#Addtype#" index="idx">
												<option value="#idx#">#idx#</option>
											</cfloop>
										</select>
									</cfoutput>
								</td>
								<td>
									Address:
									<br>
									<cfinput type="text" name="address1" id="address1" maxlength="35"  bind="{data.address1}" size="35" class="displayInput">
								</td>	
							</tr>

							<!--- <tr>
								<td style="font-size: 10px;">
									Address
								</td>
								<td>
									<cfinput type="text" name="address1" id="address1" maxlength="35"  bind="{data.address1}" size="35" class="displayInput">
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									City:
									<br>
									<cfinput type="text" name="city" id="city" maxlength="35" bind="{data.city}" size="35" class="displayInput">
								</td>
								<td>
									ZipCode:
									<br>
									<cfinput type="text" name="zip" id="zip" size="35" maxlength="35" class="displayInput">
								</td>
							</tr>

							<!--- <tr>
								<td style="font-size: 10px;">
									State
								</td>
								<td>
									<cfinput type="text" name="state" id="state"  bind="{data.state}" size="35" class="displayInput">
								</td>
							</tr> --->

							<tr id="stateTextRow" style="display:none;">
								<td style="font-size: 10px;">
									State/Province
									<br>
									<cfinput type="text" name="state" id="state" maxlength="35" bind="{data.state}" size="35" class="displayInput"> 
								</td>
								<td>
									Country:
									<br>
									<cfinput type="text" name="country" id="country" maxlength="35" bind="{data.country}" size="35" class="displayInput">
								</td>
							</tr>
							
							<tr id="stateDropdownRow" style="display:none;">
								<td style="font-size: 10px;">
									State:
									<br>
									<cfoutput>
										<select name="state_dropdown" id="state_dropdown" style="width: 100;">
											<option value="">Please Select</option>
											<cfloop query="getStates">
												<option value="#getStates.stateAbb#">#getStates.state#</option>
											</cfloop>
										</select>
									</cfoutput>
								</td>
									
							</tr>

							
							<!--- <tr>
								<td style="font-size: 10px;">
									Zipcode
								</td>
								<td>
									<cfinput type="text" name="zip" id="zip" size="35" maxlength="35" class="displayInput">
								</td>
							</tr> --->

							<!--- <tr id="OutsideCountry" style="display:none;">
								<td style="font-size: 10px;">
									Country
								</td>
								<td>
									<cfinput type="text" name="country" id="country" maxlength="35" bind="{data.country}" size="35" class="displayInput">
								</td>
							</tr> --->

							<tr>
								<td>
									Consultant:
									<br>
									<cfinput type="text" name="consultant" id="consultant"  bind="{data.order_consultant}" size="35" class="displayInput" maxlength="35">
								</td>
								<td style="font-size: 10px;">
									Email:
									<br>
									<cfinput type="text" name="customer_email" id="customer_email"  bind="{data.customer_email}" size="35" class="displayInput">&nbsp;
                                    <input type="Button" id="emailButton" value="Send Email To Customer" onclick="openCustomerEmailWindow();" />
									<!--<span  id="emailLink"></span>-->
								</td>
								
							</tr>

							

							<tr>
								<td style="font-size: 10px;">
									Phone Type:
									<br>
									<select name="PhoneType" id="PhoneType" style="width: 100%;">
										<option value="Home Phone" >Home</option>
										<option value="Cell Phone">Mobile</option>
										<option value="Business Phone">Business</option>
										<option value="OutsideUS">Outside US</option>
									</select>
								</td>
								<td>
									Phone Number:
									<br>
									<cfinput type="text" name="phoneNumber" id="phoneNumber" maxlength="20" >
									<!--- <span id="formatSign">(xxx) xxx-xxxx</span> --->
								</td>
							</tr>

							<!--- <tr>
								<td style="font-size: 10px;">
									Phone Number:
								</td>
								<td>
									<cfinput type="text" name="phoneNumber" id="phoneNumber" maxlength="20" >
									<!--- <span id="formatSign">(xxx) xxx-xxxx</span> --->
								</td>
							</tr> --->

							<cfoutput>
								<script>
									document.addEventListener("DOMContentLoaded", function() {
										const phoneInput = document.getElementById("phoneNumber");
										const phoneType = document.getElementById("PhoneType");
										// const formatSign = document.getElementById("formatSign");

										// function toggleFormatSign() {
										// 	if (phoneType.value === "OutsideUS") {
										// 		formatSign.style.display = "none";
										// 	} else {
										// 		formatSign.style.display = "inline";
										// 	}
										// }

										// // run on load (in case form already has value)
										// toggleFormatSign();

										// // run on change
										// phoneType.addEventListener("change", toggleFormatSign);

										phoneType.addEventListener("change", function() {
											if (this.value === "OutsideUS" && phoneInput.value === '') {
												phoneInput.value = "+1"; 
											} 
										});

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
								<td style="font-size: 10px;">
									Home Phone:
								</td>
								<td>
									<cfinput type="text" name="customer_phone" id="customer_phone"  bind="{data.customer_phone}" size="35" class="displayInput" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home phone number in the format (xxx) xxx-xxxx">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Cell Phone:
								</td>
								<td>
									<cfinput type="text" name="customer_cellphone" id="customer_cellphone"  bind="{data.customer_cellphone}" size="35" class="displayInput" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the cell phone number in the format (xxx) xxx-xxxx">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Business Phone:
								</td>
								<td>
									<cfinput type="text" name="customer_businessphone" id="customer_businessphone"  bind="{data.customer_businessphone}" size="35" class="displayInput" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the business phone number in the format (xxx) xxx-xxxx">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Phone Outside the US:
								</td>
								<td>
									<cfinput type="text" name="customer_otherphone" id="customer_otherphone"  bind="{data.customer_otherphone}" size="35" class="displayInput">
								</td>
							</tr> --->
							<!--- <tr>
								<td style="font-size: 10px;">
									Fax:
								</td>
								<td>
									<cfinput type="text" name="customer_fax" id="customer_fax"  bind="{data.customer_fax}" size="35" class="displayInput" maxlength="35">
								</td>
							</tr> --->
							<!--- <tr>
								<td style="font-size: 10px;">
									Consultant:
								</td>
								<td>
									<cfinput type="text" name="consultant" id="consultant"  bind="{data.order_consultant}" size="35" class="displayInput" maxlength="35">
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									Company Name:
									<br>
									<cfinput type="text" name="company" id="company"  bind="{data.order_company}" size="35" class="displayInput" maxlength="35">
								</td>
								<td>
									Website:
									<br>
									<cfinput type="text" name="customer_website" id="customer_website"  bind="{data.customer_website}" size="35" class="displayInput" maxlength="35">
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Website:
								</td>
								<td>
									<cfinput type="text" name="customer_website" id="customer_website"  bind="{data.customer_website}" size="35" class="displayInput" maxlength="35">
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									Drivers License:
									<br>
									<cfinput type="text" name="customer_driverslicense" id="customer_driverslicense"  bind="{data.customer_driverslicense}" size="35" class="displayInput" maxlength="35">
								</td>
								
							</tr>
							<tr>
								<td colspan="2" class="title">
									<strong>PAYMENT INFO</strong>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Payment Method:
									<br>
									<cfset paymentOptions = "VISA/MC,AMEX,CHECK,CASH,OTHER" />
									<cfoutput>
										<select name="Payment_Method" style="width: 100%;">
											<option value="">Please Select</option>
											<cfloop list="#paymentOptions#" index="idx">
												<option value="#idx#">#idx#</option>
											</cfloop>
										</select>
									</cfoutput>
								</td>
								<td>
									Card Number:  
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
									&nbsp; &nbsp; &nbsp; &nbsp;  
									Expiration Date:
									<br>
									<cfinput type="text" name="CardNumber" id="CardNumber"  bind="{data.CardNumber}" size="25" class="displayInput" maxlength="35">
									&nbsp;&nbsp;&nbsp;
									<cfinput type="text" name="CardExpiry" id="CardExpiry"  bind="{data.CardExpiry}" size="25" class="displayInput" maxlength="35">
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Card Number:
								</td>
								<td>
									<cfinput type="text" name="CardNumber" id="CardNumber"  bind="{data.CardNumber}" size="35" class="displayInput" maxlength="35">
								</td>
							</tr> --->
							<!--- <tr>
								<td style="font-size: 10px;">
									Expiration Date:
								</td>
								<td>
									<cfinput type="text" name="CardExpiry" id="CardExpiry"  bind="{data.CardExpiry}" size="35" class="displayInput" maxlength="35">
								</td>
							</tr> --->
							<tr>
								<td colspan="2" class="title">
									<strong>ORDER INFO</strong>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Order ID:
									<br>
									<cfif listFindNoCase(session.userinfo.roles,'b orders')>
										<cfinput type="text" name="orderuidDisplay" id="orderuidDisplay"  bind="{data.b_orders}" size="35" class="displayInput" disabled>
									<cfelseif listFindNoCase(session.userinfo.roles,'international')>
										<cfinput type="text" name="orderuidDisplay" id="orderuidDisplay"  bind="{data.c_orders}" size="35" class="displayInput" disabled>
									<cfelse>
										<cfinput type="text" name="orderuidDisplay" id="orderuidDisplay"  bind="{data.a_orders}" size="35" class="displayInput" disabled>
									</cfif>
								</td>
								<td>
									Date:
									<br>
									<cfinput type="datefield" name="date" id="date"  bind="{data.date}" size="35" class="displayInput">
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Date:
								</td>
								<td>
									<cfinput type="datefield" name="date" id="date"  bind="{data.date}" size="35" class="displayInput">
								</td>
							</tr> --->
							<tr>
								<td valign="top" style="font-size: 10px;">
									Items Ordered:
								</td>
								<td id="productTable">

								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Location:
									<br>
									<cfinput type="text" name="location_name" id="location_name" maxlength="35" bind="{data.location_name}" size="15" class="displayInput" disabled>
								</td>
								<td>
									Amount of Sale:
									<br>
									<cfinput type="text" name="amountSaleDisplay" id="amountSaleDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Amount of Sale:
								</td>
								<td>
									<cfinput type="text" name="amountSaleDisplay" id="amountSaleDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
							</tr> --->
							<!--- <tr>
								<td style="font-size: 10px;">
									Framing:
								</td>
								<td>
									<cfinput type="text" name="framingAmountDisplay" id="framingAmountDisplay" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									Tax:
									<br>
									<cfinput type="text" name="taxDisplay" id="taxDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
								<td>
									Subtotal:
									<br>
									<cfinput type="text" name="subtotalDisplay" id="subtotalDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" disabled>
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Subtotal:
								</td>
								<td>
									<cfinput type="text" name="subtotalDisplay" id="subtotalDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" disabled>
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									Shipping Cost:
									<br>
									<cfinput type="text" name="shipCostDisplay" id="shipCostDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
								<td>
									Shipping Method:
									<br>
									<cfset paymentOptions = "UPS,FedEx,USPS,Other" />
									<cfoutput>
										<select name="shipMethod">
											<option value="">Please Select</option>
											<cfloop list="#paymentOptions#" index="idx">
												<option value="#idx#">#idx#</option>
											</cfloop>
										</select>
									</cfoutput>
									<span id="tobeshipped" style="color: #ff0000;"></span>
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Shipping Method:
								</td>
								<td>
									<cfset paymentOptions = "UPS,FedEx,USPS,Other" />
									<cfoutput>
									<select name="shipMethod">
										<option value="">Please Select</option>
										<cfloop list="#paymentOptions#" index="idx">
											<option value="#idx#">#idx#</option>
										</cfloop>
									</select>
									</cfoutput>
									<span id="tobeshipped" style="color: #ff0000;"></span>
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									Insurance:
									<br>
									<cfinput type="text" name="insuranceDisplay" id="insuranceDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
								<td>
									Total:
									<br>
									<cfinput type="text" name="totalDisplay" id="totalDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" disabled>
								</td>
								
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Total:
								</td>
								<td>
									<cfinput type="text" name="totalDisplay" id="totalDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" disabled>
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									Discount:
									<br>
									<cfinput type="text" name="discountDisplay" id="discountDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
								<td>
									Amount Paid:
									<br>
									<cfinput type="text" name="amountPaidDisplay" id="amountPaidDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Amount Paid:
								</td>
								<td>
									<cfinput type="text" name="amountPaidDisplay" id="amountPaidDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" onkeyup="computeAmountProductOrder();">
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									Balance Due:
									<br>
									<cfinput type="text" name="balanceDueDisplay" id="balanceDueDisplay" maxlength="15" size="15" class="displayInput" style="text-align:right;" disabled>
								</td>
								<td>
									Tracking Number:
									<br>
									<cfinput type="text" name="tracking_number" id="tracking_number" maxlength="35" bind="{data.tracking_number}"  size="35" class="displayInput">
								</td>
							</tr>
							<!--- <tr>
								<td style="font-size: 10px;">
									Tracking Number:
								</td>
								<td>
									<cfinput type="text" name="tracking_number" id="tracking_number" maxlength="35" bind="{data.tracking_number}"  size="35" class="displayInput">
								</td>
							</tr> --->
							<tr>
								<td valign="top" style="font-size: 10px;">
									Special Instructions:
									<br>
									<cftextarea name="comments" id="comments" style="width: 100%;"  class="displayInput" maxlength="500" />
								</td>
								<td valign="top" style="font-size: 10px;">
									Estimate (1 for estimate, 0 for standard order):
									<br>
									<cfinput type="text" name="estimate" id="estimate"  bind="{data.estimate}" maxlength="1" size="1" class="displayInput">
								</td>
							</tr>
							<!--- <tr>
								<td valign="top" style="font-size: 10px;">
									Estimate (1 for estimate, 0 for standard order):
								</td>
								<td>
									<cfinput type="text" name="estimate" id="estimate"  bind="{data.estimate}" maxlength="1" size="1" class="displayInput">
								</td>
							</tr> --->
							<tr>
								<td style="font-size: 10px;">
									Origin:
								</td>
								<td>
									<cfset originValues = "WALK-IN,WEBSITE,PHONE,OTHER" />
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
							<!--- <tr>
								<td valign="top" style="font-size: 10px;">
									Lexy:
								</td>
								<td>
									<input type="checkbox" name="lexy" id="lexy" />
								</td>
							</tr> --->

							<tr>
								<td valign="top" style="font-size: 10px;">
									<image src="<cfoutput>#imgpath#</cfoutput>/checkmark-bw.png" border="0" width="12" />
								</td>
								<td>
									<input type="checkbox" name="lexy" id="lexy" />
								</td>
							</tr>

							<!--- <tr>
								<td valign="top" style="font-size: 10px;">
									Test:
								</td>
								<td>
									<input type="checkbox" name="test" id="test" />
								</td>
							</tr> --->
							<tr>
								<td>
									<cfinput type="submit" name="edit" id="edit" value="Save Changes" />
								</td>
								<td align="right">
									<cfif session.userinfo.sa EQ 1>
										<cfinput type="button" name="delete" id="delete" value="Delete Order" onclick="javascript:deleteOrder(document.editForm.orderuid.value);" />&nbsp;
									</cfif>
									<cfinput type="button" name="printInvoice" id="printInvoice" value="Print Invoice" onclick="if (confirm('Save your changes before printing - continue?')) { popupWin('http://#server_name#/admin/views/orders/manage/print_product_invoice.cfm'); };" />
									<cfif NOT listFindNoCase(session.userinfo.roles,'special admin')>
										<cfinput type="button" style="display:none;" name="emailInvoice" id="emailInvoice" value="Email Invoice" onclick="if (confirm('Save your changes before emailing - continue?')) { popupWinEmail('http://#server_name#/admin/views/orders/manage/email_product_invoice.cfm'); };" />
									</cfif>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>



<!--- <cfset ajaxOnLoad("init")> --->
<script language="JavaScript">
	function formatPriceEdit(){
		document.itemEditForm.price.value = decimalFormat(document.itemEditForm.priceInputEdit.value);
	}

	function validateOrderForm() {
		let phoneType = document.getElementById("PhoneType").value;
		let phone = document.getElementById("phoneNumber").value.trim();

		// Agar phone empty hai aur required nahi, to skip
		if (phone === "") {
			return true;
		}

		// Sirf Home / Cell / Business ke liye format check
		if (phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone") {
			let phonePattern = /^\(\d{3}\)\s\d{3}-\d{4}$/;   // (123) 456-7890 format
			if (!phonePattern.test(phone)) {
				alert("Please enter phone number in format: (xxx) xxx-xxxx");
				document.getElementById("phoneNumber").focus();
				return false;
			}
		}

		document.getElementById("edit").disabled = true;
		let deleteBtn = document.getElementById("delete");
		if (deleteBtn) {
			deleteBtn.disabled = true;
		}

		

		// OutsideUS ke liye koi restriction nahi
		return true;
	}


</script>
<!--- <cfwindow name="itemEditWindow" center="true" modal="true" resizable="false" closable="false" title="Edit Item" width="350" height="250" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" onsubmit="submitItemEdit(); return false;" name="itemEditForm">
		<input type="hidden" name="orderId" id="orderId">
		<input type="hidden" name="itemId" id="itemId">
		<input type="hidden" name="price">
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Edit Item:<br><br>
			</td>
		</tr>
		<tr>
			<td>Title:</td>
			<td>
				<input type="text" name="item_title" id="item_title" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Artist:</td>
			<td>
				<input type="text" name="item_artist" id="item_artist" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Price:</td>
			<td>
				$<cfinput type="text" name="priceInputEdit" id="priceInputEdit" size="10" value="" validate="float" message="Please enter a numeric value for the price with no dollar sign." onkeyup="formatPriceEdit();">
			</td>
		</tr>
        <!---<tr>
			<td>Status:</td>
			<td>
				<input type="radio" name="active" value="1" checked="checked" />Active&nbsp;&nbsp;<input type="radio" name="active" value="0" />Inactive
			</td>
		</tr>--->
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Submit" value="EDIT" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('itemEditWindow');" style="font-size: 10px;">
			</td>
		</tr>
		</cfform>
	</table>
</cfwindow> --->

<script>
	function openProductEntryWindowAdmin( id ) {
		window.open('index.cfm?event=orders.artInfoManage&order=' + id, 'artInfo', 'width=500,height=250,left=500,top=200,resizable=yes,scrollbars=yes');
	}

	function openFramingEntryWindowAdmin( id ) {
		window.open('index.cfm?event=orders.framingInfoManage&order=' + id, 'framingInfo', 'width=500,height=250,left=500,top=200,resizable=yes,scrollbars=yes');
	}
</script>

<cfwindow name="newItemWindow" center="true" modal="true" resizable="false" closable="false" title="New Item" width="400" height="300" headerStyle="background-color:##dd3a7d;">
	<input type="hidden" name="orderId" id="orderId_mainWindow">
	<table cellspacing="0" cellpadding="15" border="0" width="100%" bgcolor="#ffffff">
		<tr>
			<td valign="top" colspan="2">
				<input type="Button" value="Add Product By Art ID" onclick="openProductIdWindowAdmin(document.getElementById('orderId_mainWindow').value);" />
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="2">
				<input type="Button" value="Add Product By Product Title" onclick="openProductTitleWindowAdmin(document.getElementById('orderId_mainWindow').value);" />
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="2">
				<input type="Button" value="Add Product Not In Database" onclick="openProductEntryWindowAdmin(document.getElementById('orderId_mainWindow').value);" />
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="2">
				<input type="Button" value="Add Framing Order" onclick="openFramingEntryWindowAdmin(document.getElementById('orderId_mainWindow').value);" />
			</td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('newItemWindow');" style="font-size: 10px;">
			</td>
		</tr>
	</table>
</cfwindow>

<cfwindow name="artIdWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Art ID" width="400" height="300" headerStyle="background-color:##dd3a7d;">
	<input type="hidden" name="orderId" id="orderId_artId">
	<table cellspacing="0" cellpadding="0" border="0" width="100%" bgcolor="#ffffff">
		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px;">
				Enter Art ID:<br><br>
			</td>
		</tr>

		<tr>
			<td align="center" style="font-family: Arial; font-size: 11px;">
				<input type="text" name="modelno" id="modelno" size="20" value="">
				&nbsp;
				<input type="Button" value="ADD" onclick="findArt(document.getElementById('modelno').value,document.getElementById('orderId_artId').value);" />
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artIdWindow');" style="font-size: 10px;">
			</td>
		</tr>
		<!--- <tr>
			<td align="center" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artIdWindow');" style="font-size: 10px;">
			</td>
		</tr> --->
	</table>
</cfwindow>

<style>
	div.autosuggestcontainer .yui-ac-content {
		*left: -5;
	}
	.x-window-default, .x-css-shadow {
		top: 50% !important;
		left: 50% !important;
		transform: translate(-50%, -50%);
	}
	.x-body {
		position: relative;
	}
</style>

<cfwindow name="artTitleWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Product Title" width="400" height="300" headerStyle="background-color:##dd3a7d;">
	<input type="hidden" name="orderId" id="orderId_title">
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
				<input type="Button" value="ADD" onclick="insertArtFromTitle(document.getElementById('artTitle').value,document.getElementById('orderId_title').value);" />
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artTitleWindow');" style="font-size: 10px;">
			</td>
		</tr>
		<!--- <tr>
			<td align="center" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="ColdFusion.Window.hide('artTitleWindow');" style="font-size: 10px;">
			</td>
		</tr> --->
	</table>
</cfwindow>

<script language="JavaScript">
	function formatPrice(){
		document.itemInfoForm.price.value = decimalFormat(document.itemInfoForm.infoPriceInput.value);
	}
	function formatFramingPrice(){
		document.framingInfoForm.price.value = decimalFormat(document.framingInfoForm.priceInputFraming.value);
	}
</script>

<!--- <cfwindow name="artInfoWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Product Info" width="400" height="300" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" onsubmit="submitArtInfo(); return false;" name="itemInfoForm">
		<input type="hidden" name="orderId" id="orderId_info">
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
				$<cfinput type="text" name="priceInput" id="infoPriceInput" size="10" value="" validate="float" message="Please enter a numeric value for the price with no dollar sign." onkeyup="formatPrice();">
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


<!--- <cfwindow name="framingInfoWindow" center="true" modal="true" resizable="false" closable="false" title="Enter Framing Info" width="400" height="300" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
		<cfform method="post" action="" onsubmit="submitFramingInfo(); return false;" name="framingInfoForm">
		<input type="hidden" name="orderId" id="orderId_framing">
		<input type="Hidden" name="price">
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Enter Framing Info:<br><br>
			</td>
		</tr>
		<tr>
			<td>Title:</td>
			<td>
				<input type="text" name="title" id="titleFraming" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Artist:</td>
			<td>
				<input type="text" name="artist" id="artistFraming" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Short Description:</td>
			<td>
				<input type="text" name="desc" id="descFraming" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Price:</td>
			<td>
				$<cfinput type="text" name="priceInput" id="priceInputFraming" size="10" value="" validate="float" message="Please enter a numeric value for the price with no dollar sign." onkeyup="formatFramingPrice();">
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

<!--- <cfwindow name="customerEmailWindow" center="true" modal="true" resizable="false" closable="true" title="Send Email To Customer" width="650" height="550" headerStyle="background-color:##dd3a7d;">

	<cfoutput>

	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="##ffffff">
		<cfform method="post" action="" name="emailCustomerForm"  onsubmit="submitCustomerEmailInfo(); return false;">
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

	</cfoutput>
</cfwindow> --->

<script>
	$('#lexy').change(function(){
		var c = this.checked ? 1 : 0;
	    editLexy($('#orderuid').val(),c)
	});
</script>


<script>
	function toggleStateField() {
		var addressType = document.getElementById("Addresstype").value;

		if (addressType === "Outside") {
			// Show text field, hide dropdown
			document.getElementById("stateTextRow").style.display = "";
			// document.getElementById("OutsideCountry").style.display = "";
			document.getElementById("stateDropdownRow").style.display = "none";
		} else if (addressType === "USA") {
			// Show dropdown, hide text field
			document.getElementById("stateDropdownRow").style.display = "";
			// document.getElementById("OutsideCountry").style.display = "none";
			document.getElementById("stateTextRow").style.display = "none";
		} else {
			// Hide both if nothing selected
			document.getElementById("stateTextRow").style.display = "none";
			document.getElementById("stateDropdownRow").style.display = "none";
			// document.getElementById("OutsideCountry").style.display = "none";
		}
	}
</script>

<style>

	#imageDisplay {
		display: flex;
		align-items: center;
		flex-wrap: wrap;
	}
	#imageDisplay .image-container {
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
		margin: 6px;
		gap: 6px;
	}
	.date-field div {
		float: none !important;
		width: max-content;
		display: inline-block;
	}
	.date-field input.datefieldinput {
		padding-right: 18px;
		max-width: 178px;
	}

	.date-field div#searchFromDategridForm_cf_buttondiv, .date-field div#searchToDategridForm_cf_buttondiv {
		position: absolute;
		top: 2px;
		right: 2px;
		padding: 0 !important;
	}
</style>

