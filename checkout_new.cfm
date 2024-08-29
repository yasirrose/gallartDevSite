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
</cfoutput>

<SCRIPT LANGUAGE="JavaScript">
var formSubmited = 0;
function validEntries(frm){
	if(formSubmited == 1) {
		alert('The form was submited, please wait ...'); return false;
	}
			else {
			formSubmited = 1;
			return true;
		}
}
	
</SCRIPT>

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
		<!--- content starts --->
			<!--- Customer Entry --->
			<table cellpadding="0" cellspacing="0" border="0" width="600">
			<Tr>
				<Td  valign="top">
			<cfif #contents.recordcount# Lt 1>
				<font face="arial,helvetica" size="2"><b>There are no items in your cart.  Please choose item(s) to purchase before checking out.</b>
			<cfelse>
			<cfoutput>
			<cfform action="review.cfm?xss=#xss#" method="post" name="frm1" onsubmit="javascript:return validEntries(document.frm1);">
			<table cellpadding="5" cellspacing="0" border="0" width="100%">
				<tr>
					<td>
						<table width="600" border="0" cellspacing="0" cellpadding="2" align="center">
							<tr>
								<td colspan="5" height="40">
									<strong>VIEW CONTENTS OF YOUR CART:</strong>
								</td>
							</tr>
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
						<table cellpadding="2" cellspacing="0" border="0" width="100%" style="padding-top: 10px;">
							<tr>
								<td colspan="2">
									<span class="required">* REQUIRED FIELDS</span>
								</td>
							</tr>
							<tr>
								<Td colspan="2" align="Center">
									<strong>BILLING INFORMATION</strong>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>Name</b> <i>(First Last)</i>
								</td>
								<td><cfinput type="text" name="billnamef" size="15" required="Yes" message="We require the billing first name to process the order.">&nbsp;<cfinput type="text" name="BillName" size="25" required="Yes" message="We require the billing last name to process the order.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>Address 1</b>
								</td>
								<td><cfinput type="text" name="BillAddress1" size="35" required="Yes" message="We require the billing address.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Address 2</b>
								</td>
								<td><input type="text" name="BillAddress2" size="35">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>City, St Zip</b>
								</td>
								<td><cfinput type="text" name="billcity" size="25" required="Yes" message="We require the billing city.">, 
                                <select name="billstate">
                                <option value="">Please Select</option>
                                <cfloop query="states">
                                    <option value="#stateAbb#">#state#</option>
                                </cfloop>
                                </select>
                                 <cfinput type="text" name="billzip" size="13" required="Yes" message="We require the billing postal code.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>Country:</b></td>
								<td>
									<select name="billcountry">
										<cfloop query="countries">
											<option value="#CountryCode#">#Country#</option>
										</cfloop>
									</select>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>Cell Phone</b>
								</td>
								<td><cfinput type="text" name="cellphone" size="35" required="Yes" message="We require your cell phone number in the format (999) 999-9999." validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Home Phone</b>
								</td>
								<td><cfinput type="text" name="BillPhone" size="35" required="No" message="Your  home phone number must be in the format (999) 999-9999.." validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Business Phone</b>
								</td>
								<td><cfinput type="text" name="businessphone" size="35" required="No" message="Your business number must be in the format (999) 999-9999.." validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Phone Outside the US</b>
								</td>
								<td><cfinput type="text" name="otherphone" size="35" required="No">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>Email</b>
								</td>
								<td><cfinput type="text" name="Email" size="35" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Email is required." >
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Website</b>
								</td>
								<td><input type="text" name="website" size="35">
								</td>
							</tr>
							<tr>
								<Td colspan="2" align="Center" style="padding-top: 20px;">
									<strong>SHIPPING INFORMATION</strong><br><i>(if different from Billing Info)</i>
								</td>
							</tr>
							
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Name</b> <i>(First Last)</i>
								</td>
								<td><input type="text" name="shipNamef" size="15">&nbsp;<input type="text" name="shipName" size="25">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Address 1</b>
								</td>
								<td><input type="text" name="shipAddress1" size="35">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Address 2</b>
								</td>
								<td><input type="text" name="shipAddress2" size="35">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>City, St Zip</b>
								</td>
								<td><input type="text" name="shipcity" size="25">
                                <select name="shipstate">
                                <cfloop query="states">
                                    <option value="#stateAbb#">#state#</option>
                                </cfloop>
                                </select>
                                <input type="text" name="shipzip" size="13">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Country:</b></td>
								<td>
									<select name="shipcountry">
										<cfloop query="countries">
											<option value="#CountryCode#">#Country#</option>
										</cfloop>
									</select>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Phone</b>
								</td>
								<td><input type="text" name="shipPhone" size="35">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">&nbsp;</span><b>Shipping Method</b>
								</td>
								<td>
									<select name="shipMethod">
										<option value="">Please Select</option>
										<option value="UPS">UPS</option>
										<option value="FedEx">FedEx</option>
										<option value="USPS">USPS</option>
									</select>
								</td>
							</tr>
				
							<cfquery name="coptions" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
								select * from cardtypes
								where requirenumber = 1
							</cfquery>
							<tr>
								<Td colspan="2" align="Center" style="padding-top: 20px;">
									<strong>PAYMENT INFORMATION</strong>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>Card Type</b>
								</td>
								<td>
								<cfselect name="cardtype">
								<cfloop query="coptions">
								<option value="#cardcode#">#showtype#
								</cfloop>
								</cfselect>
								<!--- cfselect tag must go AFTER closing cfloop --->
							   	</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>Card Number</b>
								</td>
								<td>
								<cfinput type="Text" name="cardnum" message="You must enter a proper Credit Card Number." validate="creditcard" required="Yes" size="16" maxlength="16">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><span class="required">*</span><b>Expiration Date</b>
								</td>
								<td>
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
								YY&nbsp;
								<select name="cardexpy">
								<cfset toyear = #Year(Now())# + 10>
								<cfloop from="#Year(Now())#" to="#toyear#" index="yearis">
								<option value="#right(yearis,2)#">#right(yearis,2)#
								
								
								</cfloop></td>
							</tr>
							<tr>
								<td colspan="2">
								<hr>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td colspan="2"><span class="required">&nbsp;</span><b>Special Instructions:</b><Br>
							<textarea cols="52" rows="3" name="comments" wrap="soft"></textarea>
								</td>
							</tr>
							<Tr>
								<td colspan="2" align="center" style="padding-top: 20px;">
								<input type="submit" value="Review Order" class="pinkSubmit">&nbsp;&nbsp;<input type="reset" value="Reset Form" class="pinkSubmit">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="Hidden" name="fk_locations" value="1">
			</cfform>
			</cfoutput>
			</cfif>
			</td>
			</tr>
			</table>
			
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