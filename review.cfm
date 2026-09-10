<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<!--- <script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script> --->
<script language="JavaScript" src="/js/utils.js"></script>
</cfoutput>

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
<style>
.SeeMore {
	max-width: unset;
}
.billing-section .billing-listing ul li:not(:last-child) {
    border-bottom: 1px solid #c7c8c9;
}
.billing-section .billing-listing ul li {
	padding-bottom: 10px;
}
.billing-section .billing-listing ul li b i {
	font-weight: normal;
}
.table-cart-detail {
	background: #F2F2F2;
    padding: 30px;
    border-radius: 15px;	
}
.table-cart-detail {
	background: #F2F2F2;
    padding: 30px;
    border-radius: 15px;	
}
.table-cart-detail tbody, .table-cart-detail td, .table-cart-detail tfoot, .table-cart-detail th, .table-cart-detail thead, .table-cart-detail tr {
	border-color: #c7c8c94f; 
    border-width: 1px;	
	padding: 10px;
}
table tr td, table tr td * {
	font-size: 13px !important;
}
.billing-section .billing-listing ul li * {
    width: 50%; 
    min-width: 50%;
}
@media (max-width: 991px) {
	.billing-section .billing-listing ul li * {
		min-width: 50%;
	}	
}
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--- Show current cart contents --->

<!--- Check if this is an error redirect --->
<cfif isDefined("url.error") and url.error eq 1 and isDefined("session.errorFormData")>
	<!--- Populate form scope with stored data --->
	<cfloop collection="#session.errorFormData#" item="key">
		<cfset form[key] = session.errorFormData[key]>
	</cfloop>
</cfif>

<cfif NOT structKeyExists(form, "checkout_token") OR NOT structKeyExists(session, "checkoutToken") OR form.checkout_token NEQ session.checkoutToken>
	<cflocation url="/checkout_new" addtoken="false">
</cfif>

<!--- Verify the existing checkout reCAPTCHA response before displaying review. --->
<cfif NOT (isDefined("url.error") AND url.error EQ 1)>
	<cfset captchaVerified = false>
	<cfset apikey = "6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">
	<cfif structKeyExists(form, "recaptcha_response")>
		<cftry>
			<cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post" timeout="10" throwonerror="true" result="recaptchaHttp">
				<cfhttpparam type="formField" name="secret" value="#apikey#">
				<cfhttpparam type="formField" name="response" value="#form.recaptcha_response#">
				<cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
			</cfhttp>
			<cfset captchaResponse = deserializeJson(recaptchaHttp.fileContent)>
			<cfset captchaVerified = structKeyExists(captchaResponse, "success") AND captchaResponse.success>
			<cfcatch type="any">
				<cfset captchaVerified = false>
			</cfcatch>
		</cftry>
	</cfif>

	<cfif NOT captchaVerified>
		<cflocation url="/checkout_new" addtoken="false">
	</cfif>

	<cflock scope="session" type="exclusive" timeout="5">
		<cfset session.checkoutCaptchaToken = session.checkoutToken>
	</cflock>
</cfif>

<cfquery name="contents" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	select * from cart  where trackerid='#session.xss#'
</cfquery>

<cfparam name="subtotal" default="0">

	<cfif form.AddressType EQ 'Outside'>
		<cfset BILLSTATE = form.billstateText>
		<cfset billcountry = form.billcountry>
	<cfelse>
		<cfset BILLSTATE = form.billstateDropdown>
		<cfset billcountry = ''>
	</cfif>

	<cfif form.ShipAddressType EQ 'Outside'>
		<cfset Shipstate = form.ShipstateText>
		<cfset shipcountry = form.Shipcountry>
	<cfelse>
		<cfset Shipstate = form.ShipstateDropdown>
		<cfset Shipcountry = ''>
	</cfif>

	 

<CFIF shipnamef GT 1>
	<CFSET shipnamef=#trim(shipnamef)#>
 <CFELSE>
	<CFSET shipnamef=#trim(billnamef)#>
</CFIF>

<CFIF shipname GT 1>
	<CFSET shipname=#trim(shipname)#>
 <CFELSE>
	<CFSET shipname=#trim(billname)#>
</CFIF>

<CFIF SHIPADDRESS1 GT 1>
	<CFSET SHIPADDRESS1=#trim(SHIPADDRESS1)#>
 <CFELSE>
	<CFSET SHIPADDRESS1=#trim(BILLADDRESS1)#>
</CFIF>

<CFIF SHIPADDRESS2 GT 1>
	<CFSET SHIPADDRESS2=#trim(SHIPADDRESS2)#>
 <CFELSE>
	<CFSET SHIPADDRESS2=#trim(BILLADDRESS2)#>
</CFIF>

<CFIF SHIPCITY GT 1>
	<CFSET SHIPCITY=#trim(SHIPCITY)#>
 <CFELSE>
	<CFSET SHIPCITY=#trim(BILLCITY)#>
</CFIF>

<CFIF SHIPSTATE GT 1>
	<CFSET SHIPSTATE=#trim(SHIPSTATE)#>
<CFELSE>
	<CFSET SHIPSTATE=#trim(BILLSTATE)#>
</CFIF>

<CFIF SHIPCOUNTRY GT 1>
	<CFSET SHIPCOUNTRY=#trim(SHIPCOUNTRY)#>
<CFELSE>
	<CFSET SHIPCOUNTRY=#trim(BILLCOUNTRY)#>
</CFIF>

<CFIF SHIPZIP GT 1>
	<CFSET SHIPZIP=#trim(SHIPZIP)#>
 <CFELSE>
	<CFSET SHIPZIP=#trim(BILLZIP)#>
</CFIF>

<!--- <CFIF SHIPPHONE GT 1>
<CFSET SHIPPHONE=#trim(SHIPPHONE)#>
<CFELSE>
<CFSET SHIPPHONE=#trim(BILLPHONE)#>
</CFIF> --->

<cfif SHIPZIP GT 1>
	<CFSET SHIPZIP=#trim(SHIPZIP)#>
<cfelse>
	<cfif isDefined('form.phoneNumber') and form.phoneNumber NEQ ''>
		<CFSET SHIPPHONE=#trim(form.phoneNumber)#>
	</cfif>
</cfif>



<CFSET SHIPMETHOD=''>

<div id="Table_01" >
	<div class="main-container registration-page">
		<div class="header-section">
			<div class="top-header">
				<cfinclude template="top_.cfm">
			</div>
			<div class="navbar-section">
				<cfinclude template="navbar_.cfm">
			</div>
		</div> 
		<div class="main-content pb-4"> 
			<div class="content-section">
				<!--- Display error message if present --->
				<cfif isDefined("url.error") and url.error eq 1 and isDefined("session.errorMessage")>
					<!--- <div class="alert alert-danger" role="alert">
						<strong>Error:</strong> <cfoutput>#session.errorMessage#</cfoutput>
					</div> --->

					<cfoutput>
						<script language="JavaScript">
							alert('Error occurred: #JSStringFormat(session.errorMessage)#');
						</script>
					</cfoutput>

				</cfif>

				<cfif contents.recordcount>
					<!--- content starts --->

					<div class="my-5">
						<div class="table-cart-detail mt-4">
							<h5>
								<strong>REVIEW YOUR ORDER:</strong>
							</h5>
							<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
								<!-- <tr>
									<td colspan="4" height="40">
										
									</td>
								</tr> -->
								<tr>
									<td width="50%" height="20"><b>Name</b></td>
									<td width="10%" align="center"><b>Qty</b></td>
									<td width="15%" align="Center"><b>Price</b></td>
									<td width="15%" align="Center"><b>Ext.</b></td>
								</tr>
								<Cfoutput query="contents">
									<tr>
										<cfquery name="get_name" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
											SELECT * from products where uid='#pid#'
										</cfquery>
										
										<td valign="top">
											<a onMouseOver="javascript:popUpWin('#get_name.imageURL#')" onMouseOut="myWin.close();">
												#get_name.name#
											</a>
										</td>
										<td align="center" valign="middle">
											#qty#
										</td>
										<td align="center" valign="middle">
											#dollarformat(charge)#
										</td>
										<cfset ext = #charge# * #qty#>
										<td align="center" valign="middle">
											#dollarformat(Ext)#
										</td>
											<cfset subtotal = #subtotal# + #ext#>
											
									</tr>
								
								</cfoutput>
								<!--- Calculate and Enter Taxes --->
								<cfif #billstate# is #taxst#>
									<cfset tax = (taxamount*0.01)*subtotal />
								<cfelse>
									<cfset tax = 0 />
								</cfif>
								<Cfset total = tax + insurance + subtotal />
								<!--- <tr>
									<td colspan="4">
										<hr>
									</td>
								</tr> --->
								<cfoutput>
								<tr>
									<td colspan="2">&nbsp;
										
									</td>
									<td>
										<b>Sub Total:</b>
									</td>
									<td align="right">
										<b>#dollarformat(subtotal)#</b>
									</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;
										
									</td>
									<td>
										<b>Tax:</b>
									</td>
									<td align="right">
										<b>#dollarformat(tax)#</b>
									</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;
										
									</td>
									<td>
										<b>Insurance:</b>
									</td>
									<td align="right">
										<b>#dollarformat(insurance)#</b>
									</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;
										
									</td>
									<td>
										<b>Total:</b>
									</td>
									<td align="right">
										<b>#dollarformat(total)#</b>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="right" style="color: ##ff0000;">
										We will contact you with the shipping cost.
									</td>
								</tr>
								</cfoutput>
							</table>
						<cfoutput> 
						</tr>
					</table>
				    </div>

					<div class="billing-section mt-5"> 
						<div class="billing-listing">
							<div class="main-title mb-4">
								<h5>BILLING INFORMATION</h5>
							</div>
							<ul>  
								<li>
									<b>Name <i>(First Last)</i></b> #form.billnamef# #form.BillName#
									
								</li>
								<li>
									<b>Address 1</b> #form.BillAddress1#
									
								</li>
								<li>
									<b>Address 2</b> #form.BillAddress2#
								</li>

								<li>
									<b>Address Type,</b> #form.AddressType#
								</li>

								<li>
									<b> City, Zip</b>  #form.billcity#, #form.billzip#
								</li>
								<li>
									<cfif form.AddressType EQ 'Outside'>
										<b>State/Province ,Country:</b> #form.billstateText# ,#form.billcountry#
									<cfelse>
										<b>State: </b> #form.billstateDropdown#
									</cfif>

								</li>
								<!--- <li>
									<b>Cell Phone</b> #form.cellphone# 
								</li>
								<li>
									<b>Home Phone</b> #form.BillPhone# 
								</li>
								<li>
									<b>Business Phone</b> #form.businessphone#
								</li>
								<li>
									<b>Phone In The US</b> #form.otherphone#
								</li> --->

								<li>
									<cfif form.phoneNumber NEQ '' and form.phoneType EQ 'Cell Phone'>
										<b>Cell Phone</b> #form.phoneNumber#
									<cfelseif form.phoneNumber NEQ '' and form.phoneType EQ 'Home Phone'>
										<b>Home Phone</b> #form.phoneNumber#
									<cfelseif form.phoneNumber NEQ '' and form.phoneType EQ 'Business Phone'>
										<b>Business Phone</b> #form.phoneNumber#
									<cfelseif form.phoneNumber NEQ '' and form.phoneType EQ 'OutsideUS'>
										<b>Phone In The US</b> #form.phoneNumber#
									<cfelse>

									</cfif>
								</li>

								<li>
									<b>Email</b> #form.Email#
								</li>
								<li>
									<b>Website</b> #form.website#
								</li> 
							</ul>
						</div>

						<div class="billing-listing">
                             <div> 
							<div class="main-title mb-4">
								<h5>SHIPPING INFORMATION</h5>
							</div>
							<ul>
							<li>
								<b>Name <i>(First Last)</i></b> #shipNamef# #shipname#
							</li>
							<li>
								<b>Address 1</b> #shipAddress1# 
							</li>
							<li>
								<b>Address 2</b> #shipAddress2#
							</li>

							<li>
								<b>Address Type</b> #form.ShipAddressType#
							</li>

							<li>
							   <b>City, Zip</b>  
								#shipcity#,  #shipzip# 
							</li>
							<li>
								 <!--- <b>Country:</b> 
								 #shipcountry#  --->

								 <cfif form.ShipaddressType EQ 'Outside'>
									<b>State/Province ,Country:</b> #form.ShipstateText# ,#form.shipcountry#
								<cfelse>
									<b>State: </b> #form.ShipstateDropdown#
								</cfif>

							</li>
							<li>
								 <b>Phone</b> 
								 #shipPhone# 
							</li>
							<!--- <Tr>
								<td><b>Shipping Method</b>
								</td>
								<td>#shipMethod#
								</td>
							</tr> --->
							</ul>
						</div>

						<div>
							<div class="main-title mt-4 mb-4">
								<h5>PAYMENT INFORMATION</h5>
							</div> 
							<cfquery name="coptions" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
								select * from cardtypes
								where requirenumber = 1
							</cfquery>
							
							<ul> 
								<li>
									<b>Card Type</b>  
									<cfloop query="coptions">
										<cfif cardcode eq form.cardtype>#showtype#</cfif>
									</cfloop> 
								</li>
								<li>
									<b>Card Number</b>  
										xxxx-xxxx-xxxx-#Right(form.cardnum,4)# 
								</li>
								<li>
									<b>CVC</b>  
										#form.cardCVC# 
								</li>
								<li>
									<b>Expiration Date</b>  
										#form.cardexpm#/#form.cardexpy# 
								</li>
								<!-- <li>
									<td colspan="2">
									<hr>
									</td>
								</li> -->
								<li>
									<b>Special Instructions:</b> 
									#form.comments# 
								</li>
							
							</ul>
							<form method="post" name="purcahseForm" action="/purchase" onsubmit="disableSubmitBtn()">
								<input type="Hidden" name="shipMethod" value="#shipMethod#">
								<input type="Hidden" name="origin" value="WEBSITE">
								<input type="hidden" name="return_to_checkout" value="1">
								<cfloop collection="#form#" item="idx">
									<input type="Hidden" name="#idx#" value="#evaluate('form.'&idx)#">
								</cfloop>

								<!--- <input type="Button" value="Make Changes" onClick="javascript:self.history.go(-1);" class="Seemore">
								<input type="submit" value="Purchase!" class="Seemore"><br><br>
									<font face="verdana, arial" size="1">
										<b>
											Press PURCHASE only Once, or the transaction may fail
										</b>
									</font> ---> 
									<div>
										<div class="d-flex gap-3">
											<input type="Button" value="Make Changes" onClick="returnToCheckout();" class="Seemore">
											<input type="submit" value="Purchase!" id="submitBtn" class="Seemore">
										</div> 
										<font face="verdana, arial" size="1">
											<b>
												Press PURCHASE only Once, or the transaction may fail
											</b>
										</font>
									</div> 
							</form>
						</div>
					</div>
					 
						
						</div>
						</cfoutput>
					</div>

				 <cfelse>
					<table cellpadding="0" cellspacing="0" border=0 width="600" align="center">
						<tr>
							<td align="center" style="padding-top: 10px;">
								<strong>There are no items in your cart. <br>Please choose item(s) to purchase before checking out.</strong>
							</td>
						</tr>
					</table>
				</cfif>
				<!--- content ends --->
			</div>
		</div>
	<div> 
			<cfinclude template="footer_.cfm"> 
</div>

</div>
</div> 

<!--- Clear session data after page processing --->
<cfif isDefined("url.error") and url.error eq 1 and isDefined("session.errorFormData")>
	<cfset structDelete(session, "errorFormData")>
	<cfset structDelete(session, "errorMessage")>
</cfif>

<cfinclude template="frmxss.cfm">

<script>
	function returnToCheckout() {
		const checkoutForm = document.forms.purcahseForm;
		checkoutForm.action = "/checkout_new";
		checkoutForm.submit();
	}

	function disableSubmitBtn() {
		console.log('test 1: ')
		const btn = document.getElementById('submitBtn');
		btn.disabled = true;          // disable button immediately
		btn.value = 'Processing…';    // optional: change text
		return true;                  // allow form to continue submitting
	}
</script>

</body>
</html>

