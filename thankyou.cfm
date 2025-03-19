<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<cfquery name="GetuserInfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT  * FROM tracker WHERE sessionid = '#xss#'
</cfquery>
<html>
<head>
	<cfoutput>
		<title>#companyname# - #titletext#</title>
		<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	 </cfoutput>

<cfinclude template="meta.cfm">

<style>
	table tr td * {
		font-size: 13px !important;
	}
	.billing-section .billing-listing ul li:not(:last-child) {
		border-bottom: 1px solid #c7c8c9;
	}
	.billing-section .billing-listing ul li {
		padding-bottom: 10px;
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

<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

<link href="stylesheet_.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
									<div class="art-work-content mb-5">
										<div class="bottom-content">
											<div class="thankyou-screen">
												<cfif parameterexists(val)>
												<cfif val is "y">
												<!--- Find order --->
												<cfquery name="get_items" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
												SELECT items.product_code as pid, items.quantity as qty, * FROM items
												left join products on products.code =  items.product_code
													WHERE items.order_id='#getuserinfo.orderid#' 
													order by line_id
													</cfquery>
													<cfquery name="get_order_info" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
												SELECT * FROM orders
													WHERE orderid='#getuserinfo.orderid#'
													</cfquery>

                                          <!--- <cfdump var="#get_order_info#"> --->

													<Cfoutput>
														<div class="top-heading">
															<h4>Thank you for your order. Your order number is #getuserinfo.orderid#</h4>
															<p>You may print out the following for your records:</p>
														</div>
														</cfoutput>
															<div class="billing-section">
																<cfoutput query="get_order_info">
																<div class="billing-listing">
																	<div class="main-title mb-4">
																		<h2>Billing Information</h2>
																	</div>
																	<ul>
																		<li><b>Name:</b> #billname#</li>
																		<li>
																			<b>Address1:</b>
																			#billaddress1#
																		</li>
																		<li>
																			<b>Address2:</b>
																			#billaddress2#
																		</li>
																		<li>
																			<b>City, State, Zip:</b>
																			#billcity#, #billstate#&nbsp;&nbsp;#billzip#
																			
																		</li>
																		<li>
																			<b>Country:</b>
																			#billcountry#
																		</li>
																		<li>
																			<b>Cell Phone:</b>
																			#cellphone#
																		</li>
																		<li>
																			<b>Home Phone:</b>
																			#billphone#
																		</li>
																		<li>
																			<b>Business Phone:</b>
																			#businessphone#
																		</li>
																		<li>
																			<b>Phone Outside the US:</b>
																			#otherphone#
																		</li>
																		<li>
																			<b>Email:</b>
																			#email#
																		</li>
																		<li>
																			<b>Website:</b>
																			#website#
																		</li>
																	</ul>
																	<div class="main-title">
																		<h2>Payment Information</h2>
																	</div>
																	<ul>
																		<li>
																			<b>Card Type:</b>
																			#payment_method#
																		</li>
																		<li>
																			<b>Card Number:</b>
																			xxxx-xxxx-xxxx-#Right(CardNumber,4)#
																		</li>
																		<li>
																			<b>Expiration Date:</b>
																			#CardExpiry#
																		</li>
																	</ul>
																</div>
																<div class="billing-listing">
																	<div class="mb-4">
																	<div class="main-title mb-4">
																		<h2>Shipping Information</h2>
																	</div>
																	<ul>
																		
																		
																		<li>
																			<b>Name:</b>
																			<cfif shipname lt "1">#billname#<cfelse>#shipname#</cfif>
																		</li>
																		<li>
																			<b>Address1:</b>
																			<cfif shipaddress1 lt "1">#billaddress1#<Cfelse>#shipaddress1#</Cfif>
																		</li>
																		<li>
																			<b>Address2:</b>
																			<Cfif shipaddress2 lt "1">#billaddress2#<cfelse>#shipaddress2#</cfif>
																		</li>
																		<li>
																			<b>City, State,  Zip</b>
																			<cfif shipcity lt "1">#billcity#, #billstate# #billzip#<cfelse>#shipcity#, #shipstate#&nbsp;&nbsp;#shipzip#</cfif>
																		</li>
																		<li>
																			<b>Phone:</b>
																			<cfif shipphone lt "1">#billphone#<cfelse>#shipphone#</cfif>
																		</li>
																		<li>
																			<b>Shipping Method:</b>
																			#shipMethod#
																		</li>
																	</ul>
																</div> 
																<div>
																	<div class="main-title">
																		<h2>Payment Information</h2>
																	</div>
																	<ul>
																		<li>
																			<b>Card Type:</b>
																			#payment_method#
																		</li>
																		<li>
																			<b>Card Number:</b>
																			xxxx-xxxx-xxxx-#Right(CardNumber,4)#
																		</li>
																		<li>
																			<b>Expiration Date:</b>
																			#CardExpiry#
																		</li>
																	</ul>
																</div> 
																</div>
															</div>
															<div class="table-cart-detail mt-4">
															<table cellpadding="0" cellspacing="0" border="0" width="100%">
																</cfoutput>		
																	<!--- <tr>
																		<td colspan=4 align="center"><hr>
																		</td>
																	</tr> --->
																	<tr>
																		<td width="13%"><font size="1" face="verdana, arial, helvetica"><b>Number</b></font></td>
																		<td width="55%"><font size="1" face="verdana, arial, helvetica"><b>Name</b></font></td>
																		
																		<td align="Center" width="5%"><font size="1" face="verdana, arial, helvetica"><b>Qty</b></font></td>
																		<td width="20%" align="center"><font size="1" face="verdana, arial, helvetica"><b>Price</b></font></td>
																	</tr>
																	<!--- <tr>
																		<td colspan=4 align="center"><hr>
																		</td>
																	</tr> --->
																	<cfloop query="get_items">
																	<cfoutput>
																		<tr>
																			<td valign="top"><font size="1" face="arial, helvetica">#PID#</font></td>
																			<td valign="top"><font size="1" face="arial, helvetica">#name#</font></td>
											
																							
																			<td  valign="top" align="center"><font size="1" face="arial, helvetica">#get_items.qty#</font></td>
											
																			<td valign="top" align="right"><font size="1" face="arial, helvetica">#DollarFormat(Unit_Price)#</font></td>
																		</tr>				
																</cfoutput>
															</cfloop>
															<cfoutput query="get_order_info">
																<!--- <tr>
																	<td colspan=4 align="right"><hr>
																	</td>
																</tr> --->
																<tr>
																	<td colspan=4 align="right"><font size="2" color="##ff0000" face="arial, helvetica">We will contact you with the shipping cost.</font>
																	</td>
																</tr>
																<tr>
																	<td colspan=4 align="right"><font size="2" face="arial, helvetica">Insurance: #DollarFormat(insurance)#</font>
																	</td>
																</tr>
																<tr>
																	<td colspan=4 align="right"><font size="2" face="arial, helvetica"><b>Total Price: #DollarFormat(total)#</b></font>
																	</td>
																</tr>
															</cfoutput>
																<!--- <tr>
																	<td colspan=4 align="center"><br><br>
																	</td>
																</tr> --->
															</table>
														</div>
														
															<cfelse>
																<table cellpadding="0" cellspacing="0" border="0" width="100%">
																	<tr>
																		<td align="center"><font size="3" face="arial, helvetica"><b>There was an error in your credit card processing.  Please contact your bank or try a different credit card.</b></font>
																		</td>
																	</tr>
																	<cfif parameterexists(errormsg)>
																	<tr>
																		<td align="center"><br><br>
																		</td>
																	</tr>
																	<tr>
																		<td align="center"><font size="3" face="arial, helvetica"><b><cfoutput>#errormsg#</cfoutput></b></font>
																		</td>
																	</tr>
																	</cfif>
																</table>
															</cfif>
															<cfelse>
																<table cellpadding="0" cellspacing="0" border="0" width="100%">
																	<tr>
																		<td align="center"><font size="3" face="arial, helvetica"><b>You are not authorized to view this page at this time.</b></font>
																		</td>
																	</tr>
																</table>
															</cfif>
																</td>
																</tr>
															</table>
															
															<!--- end content --->
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

	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer_.cfm">
		</td>
	</tr>

<cfinclude template="frmxss.cfm">

</body>
</html>