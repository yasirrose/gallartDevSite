<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<link href="stylesheet.css" rel="stylesheet" type="text/css">
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
<!--- Show current cart contents --->

<cfquery name="contents" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	select * from cart  where trackerid='#xss#'
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

<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="#000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" valign="top" height="37" bgcolor="#000000">
			<cfinclude template="navbar.cfm">
		</td>
	</tr>
	<tr height="100%">
		<td valign="top" height="100%" align="center">
		<cfif contents.recordcount>
		<!--- content starts --->
			<table width="600" border="0" cellspacing="0" cellpadding="2" align="center">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
							<tr>
								<td colspan="4" height="40">
									<strong>REVIEW YOUR ORDER:</strong>
								</td>
							</tr>
							<tr bgcolor="#db3a7d">
								<td width="50%" height="20" style="color: #ffffff;"><b>Name</b></td>
								<td width="10%" align="center" style="color: #ffffff;"><b>Qty</b></td>
								<td width="15%" align="Center" style="color: #ffffff;"><b>Price</b></td>
								<td width="15%" align="Center" style="color: #ffffff;"><b>Ext.</b></td>
							</tr>
							<Cfoutput query="contents">
							<TR bgcolor="#IIf(CurrentRow Mod 2, DE('ffffff'), DE('e7eef4'))#">
							<cfquery name="get_name" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
								SELECT * from products where uid='#pid#'
							</cfquery>
								<td valign="top">
									<a onMouseOver="javascript:popUpWin('#get_name.imageURL#')" onMouseOut="myWin.close();">#get_name.name#</a>
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
									
							</tr>
							
							</cfoutput>
							<!--- Calculate and Enter Taxes --->
							<cfif #form.billstate# is #taxst#>
								<cfset tax = (taxamount*0.01)*subtotal />
							<cfelse>
								<cfset tax = 0 />
							</cfif>
							<Cfset total = tax + insurance + subtotal />
							<tr>
								<td colspan="4">
									<hr>
								</td>
							</tr>
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
						<table cellpadding="2" cellspacing="0" border="0" width="100%">
							<tr>
								<Td colspan="2" align="Center">
									<hr>
								</td>
							</tr>
							<tr>
								<Td colspan="2" align="Center">
									<h5>BILLING INFORMATION</h5>
								</td>
							</tr>
							<Tr>
								<td><b>Name</b> <i>(First Last)</i>
								</td>
								<td>#form.billnamef# #form.BillName#
								</td>
							</tr>
							<Tr>
								<td><b>Address 1</b>
								</td>
								<td>#form.BillAddress1#
								</td>
							</tr>
							<Tr>
								<td><b>Address 2</b>
								</td>
								<td>#form.BillAddress2#
								</td>
							</tr>
							<Tr>
								<td><b>City, St Zip</b>
								</td>
								<td>
								#form.billcity#, #form.billstate# #form.billzip#
								
								</td>
							</tr>
							<Tr>
								<td><b>Country:</b></td>
								<td>#form.billcountry#</td>
							</tr>
							<Tr>
								<td><b>Cell Phone</b>
								</td>
								<td>#form.cellphone#
								</td>
							</tr>
							<Tr>
								<td><b>Home Phone</b>
								</td>
								<td>#form.BillPhone#
								</td>
							</tr>
							<Tr>
								<td><b>Business Phone</b>
								</td>
								<td>#form.businessphone#
								</td>
							</tr>
							<Tr>
								<td><b>Phone In The US</b>
								</td>
								<td>#form.otherphone#
								</td>
							</tr>
							<Tr>
								<td><b>Email</b>
								</td>
								<td>#form.Email#
								</td>
							</tr>
							<Tr>
								<td><b>Website</b>
								</td>
								<td>#form.website#
								</td>
							</tr>
							<tr>
								<Td colspan="2" align="Center" style="padding-top: 20px;">
									<h5>SHIPPING INFORMATION</h5>
								</td>
							</tr>
							
							<Tr>
								<td><b>Name</b> <i>(First Last)</i>
								</td>
								<td>#shipNamef# #shipname#
								</td>
							</tr>
							<Tr>
								<td><b>Address 1</b>
								</td>
								<td>#shipAddress1#
								</td>
							</tr>
							<Tr>
								<td><b>Address 2</b>
								</td>
								<td>#shipAddress2#
								</td>
							</tr>
							<Tr>
								<td><b>City, St Zip</b>
								</td>
								<td>
								#shipcity#, #shipstate# #shipzip#
								
								</td>
							</tr>
							<Tr>
								<td><b>Country:</b></td>
								<td>#shipcountry#</td>
							</tr>
							<Tr>
								<td><b>Phone</b>
								</td>
								<td>#shipPhone#
								</td>
							</tr>
							<!--- <Tr>
								<td><b>Shipping Method</b>
								</td>
								<td>#shipMethod#
								</td>
							</tr> --->
				
							<cfquery name="coptions" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
								select * from cardtypes
								where requirenumber = 1
							</cfquery>
							<tr>
								<Td colspan="2" align="Center" style="padding-top: 20px;">
									<h5>PAYMENT INFORMATION</h5>
								</td>
							</tr>
							<Tr>
								<td><b>Card Type</b>
								</td>
								<td>
								<cfloop query="coptions">
									<cfif cardcode eq form.cardtype>#showtype#</cfif>
								</cfloop>
							   	
								</td>
							</tr>
							<Tr>
								<td><b>Card Number</b>
								</td>
								<td>
									xxxx-xxxx-xxxx-#Right(form.cardnum,4)#
								</td>
							</tr>
							<Tr>
								<td><b>Expiration Date</b>
								</td>
								<td>
									#form.cardexpm#/#form.cardexpy#
								</td>
							</tr>
							<tr>
								<td colspan="2">
								<hr>
								</td>
							</tr>
							<Tr>
								<td colspan="2"><b>Special Instructions:</b><Br>
							#form.comments#
								</td>
							</tr>
							<form method="post" action="purchase.cfm?xss=#xss#">
							<input type="Hidden" name="shipMethod" value="#shipMethod#">
							<input type="Hidden" name="origin" value="WEBSITE">
							<cfloop collection="#form#" item="idx">
								<input type="Hidden" name="#idx#" value="#evaluate('form.'&idx)#">
							</cfloop>
							<Tr>
								<td colspan="2" align="center" style="padding-top: 20px;">
								<input type="Button" value="Make Changes" onClick="javascript:self.history.go(-1);" class="pinkSubmit">&nbsp;&nbsp;
								<input type="submit" value="Purchase!" class="pinkSubmit"><br><br>
	<font face="verdana, arial" size="1"><b>Press PURCHASE only Once, or the transaction may fail</b></font>
								</td>
							</tr>
							</form>
						</table>
						</cfoutput>
					</td>
				</tr>
			</table>
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
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>