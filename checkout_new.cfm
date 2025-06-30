

<cfif isDefined('form.updateQty')>

	<cfset selectedQty = form["qty_" & form.selected_pid]>

	<cfif #selectedQty# eq 0 or #selectedQty# eq '' >
		<cfquery name="lineitem" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			Delete from cart where uid = '#form.SELECTED_PID#'
		</cfquery>
		<cfelse>
			<cfquery name="lineitem" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
				Update cart set qty = #selectedQty#
				where uid = '#form.SELECTED_PID#'
			</cfquery>
			
	</cfif>

	<!--- <cfdump var="#selectedQty#" >
	<cfdump var="#form.SELECTED_PID#" abort="true">  --->
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="/js/utils.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</cfoutput>

<SCRIPT LANGUAGE="JavaScript">
	var formSubmited = 0;

	var cardRules = {
    "Visa": { length: 19, pattern: /^4\d{15}$/, format: "#### #### #### ####", placeholder: "4111 1111 1111 1111" },
    "MC": { length: 19, pattern: /^5[1-5]\d{14}$/, format: "#### #### #### ####", placeholder: "5100 0000 0000 0000" },
    "Amex": { length: 17, pattern: /^3[47]\d{13}$/, format: "#### ###### #####", placeholder: "3712 345678 90123" },
    "Discover": { length: 19, pattern: /^6(?:011|5\d{2})\d{12}$/, format: "#### #### #### ####", placeholder: "6011 0000 0000 0000" }
};

document.addEventListener("DOMContentLoaded", function () {
    const cardInput = document.getElementById("cardnum");
    const cardTypeSelect = document.querySelector("[name='cardtype']");

    // Function to update card validation rules on card type change
    function updateCardValidation() {
        const selectedCardType = cardTypeSelect.value;
        if (cardRules[selectedCardType]) {
            cardInput.maxLength = cardRules[selectedCardType].length;
            cardInput.setAttribute("data-pattern", cardRules[selectedCardType].pattern);
            cardInput.placeholder = cardRules[selectedCardType].placeholder;
            cardInput.value = ""; // Reset input on type change
        }
    }

    // Format card number according to selected card type
    function formatCardNumber(value, selectedCardType) {
        let cleanValue = value.replace(/\D/g, ''); // Remove non-numeric characters
        let format = cardRules[selectedCardType] ? cardRules[selectedCardType].format : "#### #### #### ####";
        let formattedValue = "";
        let index = 0;

        for (let char of format) {
            if (char === "#") {
                if (index < cleanValue.length) {
                    formattedValue += cleanValue[index++];
                } else {
                    break;
                }
            } else {
                formattedValue += char;
            }
        }

        return formattedValue;
    }

    // Event listener for card type change
    if (cardTypeSelect) {
        cardTypeSelect.addEventListener("change", updateCardValidation);
    }

    // Event listener for card input to format number
    if (cardInput) {
        cardInput.addEventListener("input", function (e) {
            let selectedCardType = cardTypeSelect.value;
            e.target.value = formatCardNumber(e.target.value, selectedCardType);
        });
    }
});
	
	// Move validEntries outside event listener
	function validEntries(frm) {
		let isValid = true;
	
		document.querySelectorAll('.error-message').forEach(error => error.textContent = '');
	
		const billnamef = document.getElementById('billnamef').value.trim();
		const BillName = document.getElementById('BillName').value.trim();
		const BillAddress1 = document.getElementById('BillAddress1').value.trim();
		const billcity = document.getElementById('billcity').value.trim();
		const billzip = document.getElementById('billzip').value.trim();
		const billcountry = document.getElementById('billcountry').value.trim();
		const cellphone = document.getElementById('cellphone').value.trim();
		const Email = document.getElementById('Email').value.trim();
		const BillPhone = document.getElementById('BillPhone').value.trim();
		const businessphone = document.getElementById('businessphone').value.trim();
		const cardInput = document.getElementById("cardnum");
		const cardnum = cardInput.value.replace(/\s+/g, '').trim();
		const selectedCardType = document.querySelector("[name='cardtype']").value;
	
		const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;
	
		if (!billnamef) {
			document.getElementById('billnamefError').textContent = 'We require the billing first name to process the order.';
			isValid = false;
		}
	
		if (!BillName) {
			document.getElementById('BillNameError').textContent = 'We require the billing last name to process the order.';
			isValid = false;
		}
	
		if (!Email) {
			document.getElementById('EmailError').textContent = 'Email is required.';
			isValid = false;
		} else if (!/\S+@\S+\.\S+/.test(Email)) {
			document.getElementById('EmailError').textContent = 'Please enter a valid email address.';
			isValid = false;
		}
	
		if (!BillAddress1) {
			document.getElementById('BillAddress1Error').textContent = 'We require the billing address.';
			isValid = false;
		}
	
		if (!billcity) {
			document.getElementById('billcityError').textContent = 'We require the billing city.';
			isValid = false;
		}
	
		if (!billzip) {
			document.getElementById('billzipError').textContent = 'We require the billing postal code.';
			isValid = false;
		}
	
		if (!billcountry) {
			document.getElementById('billcountryError').textContent = 'We require the billing country.';
			isValid = false;
		}
	
		if (!cellphone) {
			document.getElementById('cellphoneError').textContent = 'We require your cell phone number ';
			isValid = false;
		} 
		// else if (!phoneRegex.test(cellphone)) {
		// 	document.getElementById('cellphoneError').textContent = 'We require your cell phone number in the format (xxx) xxx-xxxx.';
		// 	isValid = false;
		// }
	
		if (BillPhone && !phoneRegex.test(BillPhone)) {
			document.getElementById('BillphoneError').textContent = 'Please enter a valid phone number in the format (xxx) xxx-xxxx.';
			isValid = false;
		}
	
		if (businessphone && !phoneRegex.test(businessphone)) {
			document.getElementById('businessphoneError').textContent = 'Please enter a valid phone number in the format (xxx) xxx-xxxx.';
			isValid = false;
		}
	
		if (!cardnum) {
			document.getElementById('cardnumError').textContent = 'You must enter a Credit Card Number.';
			isValid = false;
		} else if (cardRules[selectedCardType] && !cardRules[selectedCardType].pattern.test(cardnum)) {
			document.getElementById('cardnumError').textContent = `Invalid ${selectedCardType} Card Number.`;
			isValid = false;
		}
	
		if (!isValid) {
			return false;
		}

		return isValid;
	
		if (formSubmited === 1) {
			alert('The form was submitted, please wait ...');
			return false;
		} else {
			formSubmited = 1;
			return true;
		}
	}
	
	// Credit card validation using Luhn algorithm
	function isValidCreditCard(number) {
		let sum = 0;
		let shouldDouble = false;
		
		for (let i = number.length - 1; i >= 0; i--) {
			let digit = parseInt(number[i]);
	
			if (shouldDouble) {
				digit *= 2;
				if (digit > 9) digit -= 9;
			}
	
			sum += digit;
			shouldDouble = !shouldDouble;
		}
	
		return sum % 10 === 0;
	}
	</SCRIPT>
	

<style>
	.error-message {
	color: #ff0000;
	font-size: 0.9em;
	/* margin-top: 5px; */
	display: block;
	}
	.input-field {
	margin-bottom: 15px;
	}
</style>

<link href="/stylesheet_.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34565365-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!-- BEGIN ROBLY WIDGET CODE -->
<script type='text/javascript'>
  var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
  (function(w, d, p, s, s2) {
    w[p] = w[p] || function() { (w[p].q = w[p].q || []).push(arguments) };
    s = d.createElement('script'); s.async = 1; s.src = '//s3.amazonaws.com/roblyimages/accounts/20559/forms/29541/signup_popup.js';
    s2 = d.getElementsByTagName('script')[0]; s2.parentNode.insertBefore(s, s2);
  })(window, document, 'Robly');
</script>
<!-- END ROBLY WIDGET CODE -->

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<div class="main-container registration-page">
		<!--- Show current cart contents --->
		<cfquery name="contents" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * from cart C
			INNER JOIN products P on C.pid = P.uid
			WHERE trackerid='#session.xss#'
		</cfquery>

		<cfquery name="countries" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * from countries
		</cfquery>
		<cfquery name="states" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * from states
		</cfquery>
		<!--- Set variables --->
		<cfset subtotal = 0>
		<cfset tax = 0>
		<cfset total = 0>
		<div id="Table_01">
			<div class="header-section">
				<div class="top-header">
					<cfinclude template="top_.cfm">
				</div>
				<div class="navbar-section">
					<cfinclude template="navbar_.cfm">
				</div>
			</div>
			<div class="inner-section">
				<div class="container-fluid">
					<div class="main-content">
						<div class="mobile-sidebar-logo">
							<div class="sidebar-Icon">
								<i class="fas fa-bars"></i>
							</div>
						</div>
						<!--- <div class="sidebar web-sidebar-modal">
							<cfinclude template="left_.cfm">
						</div> --->
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">
										<div class="bottom-content">
											<div class="user-registrations">
												<cfif #contents.recordcount# Lt 1>
													<font face="arial,helvetica" size="2"><b>There are no items in your cart.  Please choose item(s) to purchase before checking out.</b>
													<cfelse>
													<cfoutput>
													
													<div class="top-heading text-left">
														<h3>VIEW CONTENTS OF YOUR CART:</h3>
													</div>
													<div class="table-responsive">
														<cfform action="checkout_new" Method="post">
														<table border="0" cellspacing="0" cellpadding="2" align="center" style="width: 100%; margin-bottom: 20px;">
															<tr class="row0">
																<td width="50%" height="20" style="color: ##ffffff;"><b>Name</b></td>
																<td width="10%" align="center" style="color: ##ffffff;"><b>Qty</b></td>
																<td width="15%" align="Center" style="color: ##ffffff;"><b>Price</b></td>
																<td width="15%" align="Center" style="color: ##ffffff;"><b>Ext.</b></td>
																<td width="10%">&nbsp;
																	<!--- Update --->
																</td>
															</tr>
															<cfloop query="contents">
															<TR class="#this_row()#">
																<td valign="center">
																	#name#
																</td>
																<td align="center" valign="middle">
																	<!--- <input type="text" name="qty_#uid#" value="#qty#" size="2">
																	<input type="hidden" name="uid" value="#uid#" > --->
																	<!--- <cfdump var="#pid#"> --->

																	#qty#
																</td>
																<td align="right" valign="middle">
																	#dollarformat(charge)#
																</td>
																<cfset ext = #charge# * #qty#>
																<td align="right" valign="middle">
																	#dollarformat(Ext)#</td>
																	<cfset subtotal = #subtotal# + #ext#>
																	<td align="right" valign="middle">
																		<!--- <input type="submit" class="Seemore" name="updateQty" value="Update"  onclick="document.getElementById('selected_pid').value='#uid#'"> --->
																	</td>
															</tr>
															</cfloop>
															<tr>
																<td colspan="5">
																	<hr>
																</td>
															</tr>
															<tr>
																<td colspan="2">&nbsp;
																	
																</td>
																<td>
																	<b>Sub Total:</b>
																</td>
																<td align="right">
																	<b>#dollarformat(subtotal)#</b>
																</td>
																<td>&nbsp;
																	
																</td>
															</tr>
														</table>
														<input type="hidden" id="selected_pid" name="selected_pid" value="">
														
													</cfform>

													</div>


													<!--- <cfform name="addressForm" onsubmit="return validateAddress();">
														<div class="row align-items-center">
															<div class="col-md-2">
																<label><span class="required">*</span><b>Address 1</b></label>
															</div>
															<div class="col-md-10">
																<cfinput type="text" name="dummyaddress" id="dummyaddress" size="35">
																<span class="error-message" id="dummyaddressError"></span>
															</div>
														</div>
														<input type="submit" name="addressValidation" class="btn btn-primary btn-sm">
													</cfform>


													<script>
														async function validateAddress() {
															const address = document.getElementById("dummyaddress").value.trim();
													
															if (!address) {
																alert("Please enter your address.");
																return false;
															}
													
															try {
																const response = await fetch("validateAddress.cfm", {
																	method: "POST",
																	headers: {
																		"Content-Type": "application/x-www-form-urlencoded"
																	},
																	body: `address=${encodeURIComponent(address)}`
																});
													
																const result = await response.json();
													
																if (result.valid) {
																	return true; // Proceed with form submit
																} else {
																	alert("Invalid address. Please enter a valid address.");
																	return false; // Prevent form submission
																}
													
															} catch (error) {
																console.error("Address validation error:", error);
																alert("Error validating address. Please try again.");
																return false;
															}
														}
													</script> --->

													<cfform action="review" method="post" name="frm1" onsubmit="javascript:return validEntries(document.frm1);" id="checkOutForm">
													<div class="required-field">
														<span class="required">* REQUIRED FIELDS</span>
													</div>
													<div class="billing-info text-center">
														<strong>BILLING INFORMATION</strong>
													</div>
													<div class="input-form">
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2"><label><span class="required">*</span><b>Name</b> <i>(First Last)</i></label></div>
																<div class="col-md-5">
																	<cfinput type="text" name="billnamef" id="billnamef" size="15" >
																	<span class="error-message" id="billnamefError"></span>
																</div>
																<div class="col-md-5">
																	<cfinput type="text" name="BillName" id="BillName" size="25">
																	<span class="error-message" id="BillNameError"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">*</span><b>Address 1</b></label>
																</div>
																<div class="col-md-10">
																	<cfinput type="text" name="BillAddress1" id="BillAddress1" size="35" >
																	<span class="error-message" id="BillAddress1Error"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Address 2</b></label>
																</div>
																<div class="col-md-10">
																	<input type="text" name="BillAddress2" size="35">
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">*</span><b>City, St Zip</b></label>
																</div>
																<div class="col-md-4">
																	<cfinput type="text" name="billcity" id="billcity" size="25" >
																	<span class="error-message" id="billcityError"></span>
																</div>
																<div class="col-md-3">
																	<select name="billstate" class="select2">
																		<option value="">Please Select</option>
																		<cfloop query="states">
																			<option value="#stateAbb#">#state#</option>
																		</cfloop>
																	</select>
																</div>
																<div class="col-md-3">
																	<cfinput type="text" name="billzip" size="13" id="billzip" >
																	<span class="error-message" id="billzipError"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">*</span><b>Country:</b></label>
																</div>
																<div class="col-md-10">
																	<select name="billcountry" id="billcountry" class="select2">
																		<cfloop query="countries">
																			<option value="#CountryCode#">#Country#</option>
																		</cfloop>
																	</select>
																	<span class="error-message" id="billcountryError"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">*</span><b>Cell Phone</b></label>
																</div>
																<div class="col-md-10">
																	<cfinput type="text" name="cellphone" id="cellphone" >
																	<span class="error-message" id="cellphoneError"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Home Phone</b></label>
																</div>
																<div class="col-md-10">
																	<cfinput type="text" name="BillPhone" size="35" required="No" id="BillPhone" mask="(999) 999-9999">
																	<span class="error-message" id="BillphoneError"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Business Phone</b></label>
																</div>
																<div class="col-md-10">
																	<cfinput type="text" name="businessphone" size="35" id="businessphone" mask="(999) 999-9999">
																	<span class="error-message" id="businessphoneError"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Phone Outside the US</b></label>
																</div>
																<div class="col-md-10">
																	<cfinput type="text" name="otherphone" size="35" required="No">
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">*</span><b>Email</b></label>
																</div>
																<div class="col-md-10">
																	<cfinput type="text" name="Email" id="Email" size="35"  validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" >
																	<span class="error-message" id="EmailError"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Website</b></label>
																</div>
																<div class="col-md-10">
																	<input type="text" name="website" size="35">
																</div>
															</div>
														</div>
													</div>
													<div class="top-heading m-0 mt-3">
														<h4>SHIPPING INFORMATION</h4>
														<p><i>(if different from Billing Info)</i></p>
													</div>
													<div class="input-form">
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Name</b> <i>(First Last)</i></label>
																</div>
																<div class="col-md-5">
																	<input type="text" name="shipNamef" size="15">
																</div>
																<div class="col-md-5">
																	<input type="text" name="shipName" size="25">
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Address 1</b></label>
																</div>
																<div class="col-md-10">
																	<input type="text" name="shipAddress1" size="35">
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Address 2</b></label>
																</div>
																<div class="col-md-10">
																	<input type="text" name="shipAddress2" size="35">
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>City, St Zip</b></label>
																</div>
																<div class="col-md-4">
																	<input type="text" name="shipcity" size="25">
																</div>
																<div class="col-md-3">
																	<select name="shipstate" class="select2">
																		<cfloop query="states">
																			<option value="#stateAbb#">#state#</option>
																		</cfloop>
																	</select>
																</div>
																<div class="col-md-3">
																	<input type="text" name="shipzip" size="13">
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Country:</b></label>
																</div>
																<div class="col-md-10">
																	<select name="shipcountry" class="select2">
																		<cfloop query="countries">
																			<option value="#CountryCode#">#Country#</option>
																		</cfloop>
																	</select>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Phone</b></label>
																</div>
																<div class="col-md-10">
																	<input type="text" name="shipPhone" size="35">
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Shipping Method</b></label>
																</div>
																<div class="col-md-10">
																	<select name="shipMethod">
																		<option value="">Please Select</option>
																		<option value="UPS">UPS</option>
																		<option value="FedEx">FedEx</option>
																		<option value="USPS">USPS</option>
																	</select>
																</div>
															</div>
														</div>
													</div>
													<cfquery name="coptions" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
														select * from cardtypes
														where requirenumber = 1
													</cfquery>
													<div class="top-heading m-0 mt-3">
														<h4>PAYMENT INFORMATION</h4>
													</div>
													<div class="input-form">
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">*</span><b>Card Type</b></label>
																</div>
																<div class="col-md-10">
																	<cfselect name="cardtype">
																	<cfloop query="coptions">
																	<option value="#cardcode#">#showtype#
																	</cfloop>
																	</cfselect>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">*</span><b>Card Number</b></label>
																</div>
																<div class="col-md-10">
																	<cfinput type="Text" name="cardnum" id="cardnum"  placeholder="3712 345678 90123">
																	<span class="error-message" id="cardnumError"></span>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">*</span><b>Expiration Date</b></label>
																</div>
																<div class="col-md-2">
																	MM&nbsp;
																	<select name="cardexpm">
																	<cfloop from="1" to="12" index="monthis">
																	<cfif len(monthis) EQ 1>
																	<option value="0#monthis#">0#monthis#
																	<cfelse>
																	<option value="#monthis#">#monthis#
																	</cfif>
																	</cfloop>
																	<!--- cfloop tag must go AFTER closing cfif --->
																	</select>
																</div>
																<div class="col-md-2">
																	YY&nbsp;
																	<select name="cardexpy">
																	<cfset toyear = #Year(Now())# + 10>
																	<cfloop from="#Year(Now())#" to="#toyear#" index="yearis">
																	<option value="#right(yearis,2)#">#right(yearis,2)#
																	</cfloop>
																	</select>
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Special Instructions:</b></label>
																</div>
																<div class="col-md-10">
																	<textarea cols="52" rows="3" name="comments" wrap="soft"></textarea>
																</div>
															</div>
														</div>
													</div>
													<div class="text-center mt-3">
														<input type="submit" value="Review Order" class="pinkSubmit">
														<input type="reset" value="Reset Form" class="pinkSubmit">
													</div>
													<input type="Hidden" name="fk_locations" value="1">
													</cfform>
													</cfoutput>
													</cfif>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<tr>
	<td colspan="2" valign="baseline">
		<cfinclude template="footer_.cfm">
	</td>
</tr>
<cfinclude template="frmxss.cfm">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
    $(document).ready(function() {
        $('.select2').select2();
    });
</script>

<style>

	body{
		overflow-x: hidden;
	}

	.select2-container--default .select2-selection--single {
		background-color: #fff;
		border: 1px solid #bbbbbb;
		border-radius: 0;
		height: 40px;
		padding: 5px 10px;
		font-size: 14px;
		font-family: inherit;
		box-sizing: border-box;
		margin-bottom: 10px;
    }

    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 28px;
        color: #333;
    }

    .select2-container--default .select2-selection--single .select2-selection__arrow {
        height: 36px;
        top: 1px;
        right: 10px;
        width: 20px;
    }

    /* Ensure full width */
    .select2-container {
        width: 100% !important;
    }


    .select2-container--default .select2-search--dropdown .select2-search__field {
        border: 1px solid #aaa;
        height: 30px;
        font-size: 14px;
    }
	.user-registrations .input-form .input-field input, .user-registrations .input-form .input-field select, .user-registrations .input-form .input-field textarea{
		width: 100% !important;
	}
    /* Styleing of Select2 dropdown end */
</style>
	

</body>
</html>