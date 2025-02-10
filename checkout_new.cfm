<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</cfoutput>

<SCRIPT LANGUAGE="JavaScript">
var formSubmited = 0;
function validEntries(frm){

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
			const cardnum = document.getElementById('cardnum').value.trim();


			if (!billnamef) {
				document.getElementById('billnamefError').textContent = 'We require the billing first name to process the order.';
				isValid = false;
			}
			
			// Validate LAST NAME
			if (!BillName) {
				document.getElementById('BillNameError').textContent = 'We require the billing last name to process the order.';
				isValid = false;
			}
			
			// Validate EMAIL
			if (!Email) {
				document.getElementById('EmailError').textContent = 'Email is required.';
				isValid = false;
			} else if (!/\S+@\S+\.\S+/.test(Email)) {
				document.getElementById('EmailError').textContent = 'Please enter a valid email address.';
				isValid = false;
			}
			
			// Validate CAPTCHA
			if (!BillAddress1) {
				document.getElementById('BillAddress1Error').textContent = 'We require the billing address';
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
				document.getElementById('cellphoneError').textContent = 'We require your cell phone number in the format (999) 999-9999.';
				isValid = false;
			}
			if (!cardnum) {
				document.getElementById('cardnumError').textContent = 'You must enter a proper Credit Card Number.';
				isValid = false;
			}


		 return isValid;

	if(formSubmited == 1) {
		alert('The form was submited, please wait ...'); return false;
	}
			else {
			formSubmited = 1;
			return true;
		}
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

<link href="stylesheet_.css" rel="stylesheet" type="text/css">
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
			WHERE trackerid='#xss#'
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
													<cfform action="review.cfm?xss=#xss#" method="post" name="frm1" onsubmit="javascript:return validEntries(document.frm1);" id="checkOutForm">
													<div class="top-heading text-left">
														<h3>VIEW CONTENTS OF YOUR CART:</h3>
													</div>
													<div class="table-responsive">
														<table border="0" cellspacing="0" cellpadding="2" align="center" style="width: 100%; margin-bottom: 20px;">
															<tr class="row0">
																<td width="50%" height="20" style="color: ##ffffff;"><b>Name</b></td>
																<td width="10%" align="center" style="color: ##ffffff;"><b>Qty</b></td>
																<td width="15%" align="Center" style="color: ##ffffff;"><b>Price</b></td>
																<td width="15%" align="Center" style="color: ##ffffff;"><b>Ext.</b></td>
																<td width="10%">&nbsp;
																	
																</td>
															</tr>
															<cfloop query="contents">
															<TR class="#this_row()#">
																<td valign="top">
																	#name#
																</td>
																<td align="center" valign="middle">
																	#qty#
																</td>
																<td align="right" valign="middle">
																	#dollarformat(charge)#
																</td>
																<cfset ext = #charge# * #qty#>
																<td align="right" valign="middle">
																	#dollarformat(Ext)#</td>
																	<cfset subtotal = #subtotal# + #ext#>
																<td align="right" valign="middle">&nbsp;
																	
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
													</div>
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
																	<select name="billstate">
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
																	<select name="billcountry" id="billcountry">
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
																	<cfinput type="text" name="cellphone" id="cellphone" size="35" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999">
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
																	<cfinput type="text" name="BillPhone" size="35" required="No" message="Your  home phone number must be in the format (999) 999-9999.." validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999">
																</div>
															</div>
														</div>
														<div class="input-field #this_row()#">
															<div class="row align-items-center">
																<div class="col-md-2">
																	<label><span class="required">&nbsp;</span><b>Business Phone</b></label>
																</div>
																<div class="col-md-10">
																	<cfinput type="text" name="businessphone" size="35" required="No" message="Your business number must be in the format (999) 999-9999.." validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999">
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
																	<select name="shipstate">
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
																	<select name="shipcountry">
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
																	<cfinput type="Text" name="cardnum" id="cardnum"  size="16" maxlength="16">
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

	

</body>
</html>