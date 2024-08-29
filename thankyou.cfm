<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<cfquery name="GetuserInfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT  * FROM tracker WHERE sessionid = '#xss#'
</cfquery>
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

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
			<!--- content --->
			<table cellpadding="5" cellspacing="0" border="0" width="100%">
				<Tr>
					<Td  valign="top">
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
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<Cfoutput>
									<tr>
										<td colspan=6 align="center"><font size="2" face="arial, helvetica"><b>Thank you for your order.  	Your order number is <b>#getuserinfo.orderid#</b></font>
										</td>
									</tr>	
						</cfoutput>
									<tr>
										<td colspan=6 align="center"><font size="1" face="arial, helvetica"><b>You may print out the following for your records:</b></font><br>
										</td>
									</tr>	
									<tr>
										<td colspan=6 align="center"><br><br>
										</td>
									</tr>	
									<Tr>
										<td colspan="6">
									<table cellpadding="0" cellspacing="0" border="0" width="100%">
									<Tr>
											<td colspan=3 width="50%" valign="top">
											<cfoutput query="get_order_info">
												<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<Td colspan="3" align="center"><font face="arial, helvetica" size="2"><b>Billing Information</b></font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Name:</font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#billname#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Address1:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#billaddress1#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Address2:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#billaddress2#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>City, State, Zip:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#billcity#, #billstate#&nbsp;&nbsp;#billzip#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Country:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#billcountry#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Cell Phone:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#cellphone#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Home Phone:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#billphone#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Business Phone:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#businessphone#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Phone Outside the US:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#otherphone#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Email:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#email#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Website:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#website#</font>
				</td>
			</tr>
			<tr>
				<Td colspan="3" align="center"><font face="arial, helvetica" size="2"><b>Payment Information</b></font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Card Type:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#payment_method#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Card Number:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">xxxx-xxxx-xxxx-#Right(CardNumber,4)#</font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Expiration Date:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#CardExpiry#</font>
				</td>
			</tr>
			</table>
			</td>
			<td colspan="3" valign="top" width="50%">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<Td colspan="3" align="center"><font face="arial, helvetica" size="2"><b>Shipping Information</b></font>
				</td>
			</tr>
			
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Name:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1"><cfif shipname lt "1">#billname#<cfelse>#shipname#</cfif></font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Address1:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1"><cfif shipaddress1 lt "1">#billaddress1#<Cfelse>#shipaddress1#</Cfif></font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Address2:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1"><Cfif shipaddress2 lt "1">#billaddress2#<cfelse>#shipaddress2#</cfif></font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>City, State,  Zip</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1"><cfif shipcity lt "1">#billcity#, #billstate# #billzip#<cfelse>#shipcity#, #shipstate#&nbsp;&nbsp;#shipzip#</cfif></font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Phone:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1"><cfif shipphone lt "1">#billphone#<cfelse>#shipphone#</cfif></font>
				</td>
			</tr>
			<Tr>
				<td><font face="verdana, arial, helvetica" size="1"><b>Shipping Method:</b></font>
				</td>
				<td>&nbsp;
				</td>
				<td><font face="verdana, arial, helvetica" size="1">#shipMethod#</font>
				</td>
			</tr>
			</table>
				</td>
				</tr>
				</table>
										</td>
									</tr>
							</cfoutput>		
										<tr>
											<td colspan=4 align="center"><hr>
											</td>
										</tr>
										<tr>
											<td width="13%"><font size="1" face="verdana, arial, helvetica"><b>Number</b></font></td>
											<td width="55%"><font size="1" face="verdana, arial, helvetica"><b>Name</b></font></td>
											
											<td align="Center" width="5%"><font size="1" face="verdana, arial, helvetica"><b>Qty</b></font></td>
											<td width="20%" align="center"><font size="1" face="verdana, arial, helvetica"><b>Price</b></font></td>
										</tr>
										<tr>
											<td colspan=4 align="center"><hr>
											</td>
										</tr>
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
				<tr>
											<td colspan=4 align="right"><hr>
											</td>
										</tr>
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
										<tr>
											<td colspan=4 align="center"><br><br>
											</td>
										</tr>
						</table>
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
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>