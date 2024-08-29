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
function popUpWin(urlPage){
	var features =	'scrollbars=yes, toolbar=no, status=no, menubar=no,' +
					'resizable=no, location=no, directories=no,' +
					'left=100, top=100, width=793, height=400';

	myWin =	window.open(urlPage,'WinName',features);
}
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
	select * from cart  where trackerid='#xss#'
</cfquery>

<table id="Table_01" width="800" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="800" height="125" valign="top">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="800" valign="top" height="37">
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
			
						<table cellpadding="2" cellspacing="0" border="0" width="100%">
							<tr>
								<Td colspan="2" align="Center">
									<h5>BILLING INFORMATION</h5>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Name</b> <i>(First Last)</i>
								</td>
								<td><cfinput type="text" name="billnamef" size="15" required="Yes" message="We require the billing first name to process the order.">&nbsp;<cfinput type="text" name="BillName" size="25" required="Yes" message="We require the billing last name to process the order.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Address 1</b>
								</td>
								<td><cfinput type="text" name="BillAddress1" size="35" required="Yes" message="We require the billing address.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Address 2</b>
								</td>
								<td><input type="text" name="BillAddress2" size="35">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>City, St Zip</b>
								</td>
								<td><cfinput type="text" name="billcity" size="25" required="Yes" message="We require the billing city.">, <cfinput type="text" name="billstate" required="Yes" size="2" maxlength="2" message="We require the billing state."> <cfinput type="text" name="billzip" size="13" required="Yes" message="We require the billing postal code.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Country:</b></td>
								<td><cfinput type="text" name="billcountry" size="10" required="Yes" message="We require the billing country."></td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Phone</b>
								</td>
								<td><cfinput type="text" name="BillPhone" size="35" required="Yes" message="We require the Phone number for the billing contact.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Email</b>
								</td>
								<td><cfinput type="text" name="Email" size="35" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Email is required." >
								</td>
							</tr>
							<tr>
								<Td colspan="2" align="Center" style="padding-top: 20px;">
									<h5>SHIPPING INFORMATION</h5><br><i>(if different from Billing Info)</i>
								</td>
							</tr>
							
							<tr class="#this_row()#">
								<td><b>Name</b> <i>(First Last)</i>
								</td>
								<td><input type="text" name="shipNamef" size="15">&nbsp;<input type="text" name="shipName" size="25">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Address 1</b>
								</td>
								<td><input type="text" name="shipAddress1" size="35">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Address 2</b>
								</td>
								<td><input type="text" name="shipAddress2" size="35">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>City, St Zip</b>
								</td>
								<td><input type="text" name="shipcity" size="25"><input type="text" name="shipstate" size="2" maxlength="2"><input type="text" name="shipzip" size="13">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Country:</b></td>
								<td><input type="text" name="shipcountry" size="10"></td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Phone</b>
								</td>
								<td><input type="text" name="shipPhone" size="35">
								</td>
							</tr>
				
							<cfquery name="coptions" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
								select * from cardtypes
								where requirenumber = 1
							</cfquery>
							<tr>
								<Td colspan="2" align="Center" style="padding-top: 20px;">
									<h5>PAYMENT INFORMATION</h5>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Card Type</b>
								</td>
								<td>
								<cfselect name="cardtype">
								<cfloop query="coptions">
								<option value="#cardcode#">#showtype#
								</cfloop>
							   	</cfselect>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Card Number</b>
								</td>
								<td>
								<cfinput type="Text" name="cardnum" message="You must enter a proper Credit Card Number." validate="creditcard" required="Yes" size="16" maxlength="16">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Expiration Date</b>
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
								</select>
								YY&nbsp;
								<select name="cardexpy">
								<cfset toyear = #Year(Now())# + 10>
								<cfloop from="#Year(Now())#" to="#toyear#" index="yearis">
								<option value="#right(yearis,2)#">#right(yearis,2)#
								</cfloop>
								
								</td>
							</tr>
							<tr>
								<td colspan="2">
								<hr>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td colspan="2"><b>Special Instructions:</b><Br>
							<textarea cols="52" rows="3" name="comments" wrap="soft"> </textarea>
								</td>
							</tr>
							<Tr>
								<td colspan="2" align="center" style="padding-top: 20px;">
								<input type="submit" value="Review Order">&nbsp;&nbsp;<input type="reset" value="Reset Form">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
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