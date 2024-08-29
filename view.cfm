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
					<!--- Counter for the Back Button --->
<cfif parameterexists(url.jcount)>
<cfset jcount = #url.jcount# +1>
<cfset goback = "javascript:history.go(-#jcount#)">
<cfelse>
<cfset goback="javascript:history.go(-1)">
<cfset jcount="2">
</cfif>
<!--- End Back Button Counter --->
<!---  Process within this page ie change quantity or remove item from cart --->
<Cfif parameterexists(uid)>
<cfif #qty# eq 0 or #qty# eq ''>
<cfquery name="lineitem" datasource="#dsource#" dbtype="ODBC" 
	username="#uname#" password="#pword#">
Delete from cart 
where uid = '#uid#'
</cfquery>
<cfelse>
<cfquery name="lineitem" datasource="#dsource#" dbtype="ODBC" 
	username="#uname#" password="#pword#">
Update cart
	set qty = #qty#
where uid = '#uid#'
</cfquery>
</cfif>
</cfif>
<!--- End page process  --->

<!--- Show current cart contents --->
<cfquery name="contents" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	select * from cart  where trackerid='#xss#'
</cfquery>
<cfquery name="states" datasource="#dsource#" dbtype="ODBC" 
	username="#uname#" password="#pword#">
Select * from States
order by Stateabb
</cfquery>
<!--- End of query section --->
<!--- Set variables --->
<cfset subtotal = 0>
<cfset tax = 0>
<cfset total = 0>
<!--- End variable set, start page output --->
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
		<td valign="top" width="173" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr height="100%">
					<td valign="top" height="100%">	
						<cfinclude template="left.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" width="727" height="100%">
			<!--- content starts --->
			<!--- Customer Entry --->
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td  valign="top" style="padding-top: 10px;">
				<cfif #contents.recordcount# Lt 1>
					<table cellpadding="0" cellspacing="0" border=0 width="600" align="center">
						<tr>
							<td align="center">
								<strong>There are no items in your cart. <br>Please choose item(s) to purchase before checking out.</strong>
							</td>
						</tr>
					</table>
				<cfelse>
					<table width="600" border="0" cellspacing="0" cellpadding="2" align="center">
						<tr>
							<td colspan="5" height="40">
								<strong>VIEW CONTENTS OF YOUR CART:</strong>
							</td>
						</tr>
						<tr class="row0">
							<td width="50%" height="20" style="color: #ffffff;"><b>Name</b></td>
							<td width="10%" align="center" style="color: #ffffff;"><b>Qty</b></td>
							<td width="15%" align="Center" style="color: #ffffff;"><b>Price</b></td>
							<td width="15%" align="Center" style="color: #ffffff;"><b>Ext.</b></td>
							<td width="10%">&nbsp;
								
							</td>
						</tr>
						<Cfoutput query="contents">
						<FORM ACTION="#securepage#/view.cfm?xss=#xss#&uid=#uid#&co=y" method="post">
						<TR class="#this_row()#">
						<cfquery name="get_name" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
							SELECT * from products where uid='#pid#'
						</cfquery>
							<td valign="top">
								<a onMouseOver="javascript:popUpWin('#get_name.imageURL#')" onMouseOut="myWin.close();">#get_name.name#</a>
							</td>
							<td align="center" valign="middle">
								<input type="text" name="qty" value="#qty#" size="2" style="font-size: 7pt;">
							</td>
							<td align="right" valign="middle">
								#dollarformat(charge)#
							</td>
							<cfset ext = #charge# * #qty#>
							<td align="right" valign="middle">
								#dollarformat(Ext)#</td>
								<cfset subtotal = #subtotal# + #ext#>
							<td align="right" valign="middle">
								<input type="image" src="/img/update.gif" border="0" style="border: 1px solid ##ffffff;">
							</td>
						</tr>
						</form>
						</cfoutput>
						<tr>
							<td colspan="5">
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
							<td>&nbsp;
								
							</td>
						</tr>
						<tr>
							<td colspan="5" align="center" style="padding-top:10px;">
								<form action="checkout_new.cfm?xss=#xss#&co=y" method="post">
								<table cellpadding="0" cellspacing="0" border="0" width="100%">
									<tr>
										<td colspan="2" align="Center">
											<input type="submit" value="Continue >>">
										</td>
									</tr>
								</table>
								</form>
							</td>
						</tr>
						</cfoutput>
					</table>
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