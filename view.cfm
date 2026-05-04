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
			.user-registrations {
				max-width: 800px;
				margin: 0 auto;
			}
			.user-registrations table tr td {
				padding: 10px;
				vertical-align: baseline;
			}
			.SeeMore {
				margin: 10px 0 10 auto;
			}
		</style>
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
			<cfif form.action EQ "Remove">
				<cfquery name="deleteItem" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					DELETE FROM cart WHERE uid = <cfqueryparam value="#uid#" cfsqltype="cf_sql_integer">
				</cfquery>
			 <cfelseif form.action EQ "update">
				<cfif #qty# eq 0 or #qty# eq ''>
					<cfquery name="lineitem" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
						Delete from cart where uid = '#uid#'
					</cfquery>
				 <cfelse>
						<cfquery name="lineitem" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
							Update cart set qty = #qty# where uid = '#uid#'
						</cfquery>
				</cfif>
			</cfif>

			<cflocation url="/view-cart" addtoken="No">
		</cfif>



		<cfquery name="contents" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			select * from cart  where trackerid='#session.xss#'
		</cfquery>
		<cfquery name="states" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			Select * from States order by Stateabb
		</cfquery>


		<cfset subtotal = 0>
		<cfset tax = 0>
		<cfset total = 0>


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
							<!--- <div class="sidebar web-sidebar-modal">	
								<cfinclude template="left_.cfm">
							</div> --->
							<div class="content-section">
								<div class="bottom-content-sec">
									<div class="banner-section">
										<div class="art-work-content">

											<div aria-label="breadcrumb">
												<ol class="breadcrumb">
												<li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
												<li class="breadcrumb-item active" aria-current="page">View Cart</li>
												</ol>
											</div>
											<cfset subtotal = 0> <!-- Initialize subtotal -->
											<div class="bottom-content">
												<div class="user-registrations">
													
													<div class="table-responsive">
														<table cellpadding="0" cellspacing="0" border="0" width="100%">
															<tr>
																<td valign="top" style="padding-top: 10px;">
																	<cfif #contents.recordcount# Lt 1>
																		<!-- Show EMPTY CART message -->
																		<div class="top-heading" style="text-align:center; padding:20px;">
																			<p>
																				<strong>There are no items in your cart.<br>Please choose item(s) to purchase before checking out.</strong>
																			</p>
																		</div>
																	 <cfelse>
																		
																		<table border="0" cellspacing="0" cellpadding="2" align="center" width="100%">
																			<tr>
																				<td colspan="5" height="40">
																					<strong>VIEW CONTENTS OF YOUR CART:</strong>
																				</td>
																			</tr>
																			<tr class="row0">
																				<td width="30%" style="color: #ffffff;"><b>Name</b></td>
																				<td width="10%" align="center" style="color: #ffffff;"><b>Qty</b></td>
																				<td width="15%" align="center" style="color: #ffffff;"><b>Price</b></td>
																				<td width="15%" align="center" style="color: #ffffff;"><b>Ext.</b></td>
																				<td width="10%" align="center" style="color: #ffffff;"> Action</td>
																				<td width="10%" align="center" style="color: #ffffff;"> </td>
																			</tr>
																			<cfoutput query="contents">
																				<cfquery name="get_name" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
																					SELECT * FROM products WHERE uid='#pid#'
																				</cfquery>

																				<form action="/view-cart/#uid#/y" method="post" onsubmit="return validateForm(this)">
																					<tr class="#this_row()#">
																						<td valign="top">
																							<a onmouseover="popUpWin('/img/#get_name.uid#.jpg')" onmouseout="myWin.close();">#get_name.name#</a>
																						</td>
																						<td align="center">
																							<input type="text" name="qty" maxlength="4" value="#qty#" size="2" style="font-size: 14px;">
																						</td>
																						<td align="center">
																							#dollarformat(charge)#
																						</td>
																						<cfset ext = charge * qty>
																						<td align="center">
																							#dollarformat(ext)#
																						</td>
																						<cfset subtotal = subtotal + ext>
																						<input type="hidden" name="productQty" id="productQty" value="#get_name.quantity#">
																						<td>
																							<input type="submit"  name="action" value="Update">
																							<!--- <button type="submit" class="Seemore " name="action" value="update" >Update</button> --->
																						</td>
																						<td>
																							<input type="submit" name="action" value="Remove" style="color: red;" onclick="return confirmDelete();">
																							<!--- <button type="submit" class="Seemore " name="action" value="delete"  onclick="return confirmDelete();">Remove</button> --->
																						</td>
																					</tr>
																				</form>
																			</cfoutput>
																			
																			<tr>
																				<td colspan="10">
																					<hr>
																				</td>
																			</tr>
																			<cfoutput>
																				<tr>
																					<td colspan="2"></td>
																					<td>
																						<b>Sub Total:</b>
																					</td>
																					<td align="right">
																						<b>#dollarformat(subtotal)#</b>
																					</td> <!-- ✅ Subtotal output -->
																					<td></td>
																				</tr>
																			</cfoutput>
																			<tr>
																				<td colspan="5" align="center" style="padding-top:10px;">
																					<form action="/checkout_new" method="post">
																						<input type="submit" value="Continue >>">
																					</form>
																				</td>
																			</tr>
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
			</div>
		</div>
		<tr>
			<td colspan="2" valign="baseline">
				<cfinclude template="footer_.cfm">
			</td>
		</tr>
		<cfinclude template="frmxss.cfm">

		<script>
			function validateForm(form) {
				var qtyValue  = form.qty.value;
				var productQty  = form.productQty.value;

				console.log('test: ' + productQty);

				 // Check if empty
				if (qtyValue === "") {
					alert("Please enter a quantity before updating.");
					return false;
				}

				// Check if NOT numeric (only digits allowed)
				if (!/^[0-9]+$/.test(qtyValue)) {
					alert("Please enter numbers only for the quantity.");
					return false;
				}


				var qty = parseInt(qtyValue, 10);
				var pQty = parseInt(productQty, 10);

				// Check if zero or negative
				if (qty <= 0) {
					alert("Please enter a valid quantity. The quantity must be at least 1.");
					return false;
				}

				if (productQty !== null && productQty !== "" && pQty !== 0) {
					if (qty > pQty) {
						alert("You can select a maximum of " + pQty + " item(s). Please enter a quantity within the available limit.");
						return false;
					}
				}

				return true;
			}

			function confirmDelete() {
				return confirm("Are you sure you want to delete this item?");
			}
		</script>

	</body>
</html>