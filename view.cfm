<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

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
<div class="main-container registration-page">
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
					<div class="sidebar web-sidebar-modal">	
						<cfinclude template="left_.cfm">
					</div>
					<div class="content-section">
						<div class="bottom-content-sec">
							<div class="banner-section">
								<div class="art-work-content">
									<div class="bottom-content">
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