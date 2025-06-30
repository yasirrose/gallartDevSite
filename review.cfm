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

<cfquery name="contents" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	select * from cart  where trackerid='#session.xss#'
</cfquery>

<cfparam name="subtotal" default="0">

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
<CFIF SHIPPHONE GT 1>
<CFSET SHIPPHONE=#trim(SHIPPHONE)#>
<CFELSE>
<CFSET SHIPPHONE=#trim(BILLPHONE)#>
</CFIF>

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
		<cfif contents.recordcount>
		<!--- content starts --->

					<div class="my-5">
						<div class="table-cart-detail mt-4">
						 <h5>	<strong>REVIEW YOUR ORDER:</strong></h5>
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
							<TR>
							<cfquery name="get_name" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
								SELECT * from products where uid='#pid#'
							</cfquery>
								<td valign="top">
									<a onMouseOver="javascript:popUpWin('#get_name.imageURL#')" onMouseOut="myWin.close();">#get_name.name#</a>
								</td>
								<td align="center" valign="middle">
									#qty#
								</td>
								<td align="center" valign="middle">
									#dollarformat(charge)#
								</td>
								<cfset ext = #charge# * #qty#>
								<td align="center" valign="middle">
									#dollarformat(Ext)#</td>
									<cfset subtotal = #subtotal# + #ext#>
									
							</tr>
							
							</cfoutput>
							<!--- Calculate and Enter Taxes --->
							<cfif #form.billstate# is #taxst#>
								<cfset tax = (taxamount*0.01)*subtotal />
							<cfelse>
								<cfset tax = 0 />
							</cfif>
							<Cfset total = tax + insurance + subtotal />
							<!-- <tr>
								<td colspan="4">
									<hr>
								</td>
							</tr> -->
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
									<b>City, St Zip</b> #form.billcity#, #form.billstate# #form.billzip#
								</li>
								<li>
									<b>Country:</b> #form.billcountry#
								</li>
								<li>
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
							   <b>City, St Zip</b>  
								#shipcity#, #shipstate# #shipzip# 
							</li>
							<li>
								 <b>Country:</b> 
								 #shipcountry# 
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
						<form method="post" action="/purchase">
							<input type="Hidden" name="shipMethod" value="#shipMethod#">
							<input type="Hidden" name="origin" value="WEBSITE">
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
										<input type="Button" value="Make Changes" onClick="javascript:self.history.go(-1);" class="Seemore">
										<input type="submit" value="Purchase!" class="Seemore">
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

<cfinclude template="frmxss.cfm">

</body>
</html>