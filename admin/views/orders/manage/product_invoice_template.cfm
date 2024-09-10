
<cfoutput>
<link REL="STYLESHEET" TYPE="text/css" HREF="../../../../admin/css/main.css">
<table cellspacing="0" cellpadding="0" border="0" width="900">
	<tr>
		<td style="padding-bottom: 5px;">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td align="center">
						<cfif getOrder.lexy EQ 1 OR listFindNoCase(session.userinfo.roles,'international')>
							<div style="font-size: 50px; color: ##000000; font-weight: bold;">
								International Art Gallery, LLC
							</div>
							<div style="font-size: 22px; color: ##000000">
								20340 NE 15th CT, Unit 36 <br />
								Miami, FL 33179-2716
							</div>
						<cfelse>
							<img src="../../../images/Galleryartlogo.gif" border="0"/>
						</cfif>
					</td>
				</tr>
				<tr>
					<td align="center" class="orderTitle">
						<cfif listFindNoCase(session.userinfo.roles,'international')>
							<span style="font-size: 18px;">INVOICE ## #url.c_orders#</span>
						<cfelseif listFindNoCase(session.userinfo.roles,'b orders')>
							<span style="font-size: 18px;">INVOICE ## #url.b_orders#</span>
						<cfelse>
							<span style="font-size: 18px;">INVOICE ## #url.a_orders#</span>
						</cfif>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCell">
						<span class="label">HOME PHONE</span><br>
						<span class="data">#getOrder.customer_phone#</span>
					</td>
					<td class="formCell">
						<span class="label">BUSINESS PHONE</span><br>
						<span class="data">#getOrder.customer_businessphone#</span>
					</td>
					<td class="formCell">
						<span class="label">CELL PHONE</span><br>
						<span class="data">#getOrder.customer_cellphone#</span>
					</td>
					<td class="formCell">
						<span class="label">FAX</span><br>
						<span class="data">#getOrder.customer_fax#</span>
					</td>
					<td class="formCell">
						<span class="label">CONSULTANT</span><br>
						<span class="data">#getOrder.order_consultant#</span>
					</td>
					<td class="formCell">
						<span class="label">DATE</span><br>
						<span class="data">#dateFormat(getOrder.date,'mmmm dd yyyy')#</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCell" width="300">
						<span class="label">LAST NAME</span><br>
						<span class="data">#getOrder.customer_lname#</span>
					</td>
					<td class="formCell">
						<span class="label">FIRST NAME</span><br>
						<span class="data">#getOrder.customer_fname#</span>
					</td>
					<td class="formCell">
						<span class="label">COMPANY NAME</span><br>
						<span class="data">#getOrder.order_company#</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCell">
						<span class="label">ADDRESS</span><br>
						<span class="data">#getOrder.address1#</span>
					</td>
					<td class="formCell">
						<span class="label">CITY</span><br>
						<span class="data">#getOrder.city#</span>
					</td>
					<td class="formCell">
						<span class="label">STATE</span><br>
						<span class="data">#getOrder.state#</span>
					</td>
					<td class="formCell">
						<span class="label">COUNTRY</span><br>
						<span class="data">#getOrder.country#</span>
					</td>
					<td class="formCell">
						<span class="label">POSTAL CODE</span><br>
						<span class="data">#getOrder.zip#</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCell" width="40%">
						<span class="label">EMAIL ADDRESS</span><br>
						<span class="data">#getOrder.customer_email#</span>
					</td>
					<td class="formCell" width="40%">
						<span class="label">WEBSITE</span><br>
						<span class="data">#getOrder.customer_website#</span>
					</td>
					<td class="formCell" width="20%">
						<span class="label">DRIVER'S LICENSE ##</span><br>
						<span class="data">#getOrder.DriversLicense#</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCell" width="80%">
						<span class="label">METHOD OF PAYMENT</span><br>
						<span class="largeLabel">VISA/MC</span>
						<cfif getOrder.Payment_Method EQ "VISA/MC">
							<img src="checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="unchecked.gif" align="absmiddle" width="25">
						</cfif>&nbsp;&nbsp;
						<span class="largeLabel">AMEX</span>
						<cfif getOrder.Payment_Method EQ "AMEX">
							<img src="checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="unchecked.gif" align="absmiddle" width="25">
						</cfif>&nbsp;&nbsp;
						<span class="largeLabel">CHECK</span>
						<cfif getOrder.Payment_Method EQ "CHECK">
							<img src="checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="unchecked.gif" align="absmiddle" width="25">
						</cfif>&nbsp;&nbsp;
						<span class="largeLabel">CASH</span>
						<cfif getOrder.Payment_Method EQ "CASH">
							<img src="checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="unchecked.gif" align="absmiddle" width="25">
						</cfif>&nbsp;&nbsp;
						<span class="largeLabel">OTHER</span>
						<cfif getOrder.Payment_Method EQ "OTHER">
							<img src="checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="unchecked.gif" align="absmiddle" width="25">
						</cfif>
					</td>
					<td width="20%" class="formCell" style="padding-left: 10px;">
						<span class="label">ORIGIN</span><br>
						<span class="data">#getOrder.origin#</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCell" style="width: 50%">
						<span class="label">CREDIT CARD ##</span><br>
						<span class="data">xxxx-xxxx-xxxx-#right(getOrder.CardNumber,4)#</strong></span>
					</td>
					<td class="formCell" style="width: 7%">
						<span class="label">EXP.</span><br>
						<span class="data">#getOrder.cardexpiry#</span>
					</td>
					<td class="formCell">
						<span class="label" style="width: 8%">AUTH. CODE</span><br>
						<span class="data">#getOrder.authcode#</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCellNoBorder" align="center" width="5%">
						<span class="largeLabel">QUANTITY</span>
					</td>
					<td class="formCellNoBorder" align="center" width="15%">
						<span class="largeLabel">TITLE</span>
					</td>
					<td class="formCellNoBorder" align="center" width="10%">
						<span class="largeLabel">ARTIST</span>
					</td>
					<td class="formCellNoBorder" align="center" width="15%">
						<span class="largeLabel">DESCRIPTION</span>
					</td>
					<td class="formCellNoBorder" align="center" width="10%">
						<span class="largeLabel">ART ID</span>
					</td>
					<td class="formCellNoBorder" align="center" width="10%">
					</td>
					<td class="formCellNoBorder" align="center" width="12%">
						<span class="largeLabel">STATUS</span>
					</td>
					<td class="formCellNoBorder" align="center" width="12%">
						<span class="largeLabel">PRICE</span>
					</td>
					<td class="formCellNoBorder" align="center" width="11%" style="border-right:  1px solid ##000000;">
						<span class="largeLabel">EXT</span>
					</td>
					
				</tr>
				<tr>
					<td colspan="9" style="border-right: 1px solid ##000000; border-bottom: 1px solid ##000000;">&nbsp;</td>
				</tr>
				<cfif getItems.recordcount>
					<cfloop query="getItems">
					<cfset thisExt = quantity * price />
					<cfif len(productTitle)>
						<cfset thisTitle = productTitle /> 
					<cfelse>
						<cfset thisTitle = title /> 
					</cfif>
					<cfif len(productArtist)>
						<cfset thisArtist = productArtist /> 
					<cfelse>
						<cfset thisArtist = artist /> 
					</cfif>
					<tr>
						<td class="productCell" align="center">
							<span class="data">#quantity#</span>
						</td>
						<td class="productCell" align="center">
							<span class="data">#thisTitle#</span>
						</td>
						<td class="productCell" align="center">
							<span class="data">#thisArtist#</span>
						</td>
						<td class="productCell" style="padding-left: 3px;">
							<span class="data">#shortDesc#</span>
						</td>
						<td class="productCell" align="center">
							<span class="data">#modelno#</span>
						</td>
						<td class="productCell" align="center">
							<span class="data"><cfif itemFraming EQ 1>FRAMING</cfif></span>
						</td>
						<td class="productCell" align="center" style="padding-right: 2px;">
							<span class="data">#cancelcode#</span>
						</td>
						<td class="productCell" align="right" style="padding-right: 2px;">
							<span class="data">#dollarFormat(price)#</span>
						</td>
						<td class="productCell" align="right" style="padding-right: 2px;">
							<span class="data">#dollarFormat(thisExt)#</span>
						</td>
						
					</tr>
					</cfloop>
				<cfelse>
					<tr>
						<td colspan="9" align="center" style="color: ##ff0000;font-size: 15px;font-weight:bold;">
						<br><br><br>
						NO PRODUCTS HAVE BEEN LISTED
						<br><br>
						</td>
					</tr>
					<cfabort>
				</cfif>
				<tr>
					<td class="productCell" colspan="7" rowspan="9">
						<span class="label">SPECIAL INSTRUCTIONS</span><br>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td style="padding-left: 3px;"><br>
									<span class="data">#getOrder.comments#</span>
								</td>
							</tr>
						</table>						
						<cfif getOrder.tobeshipped EQ 1>
							<br>
							<span style="color: ##ff0000; font-size: 13px; font-weight: bold;">TO BE SHIPPED</span>
						</cfif>
					</td>
					<td class="productCell" align="center">
						<span class="largeLabel">AMOUNT OF SALE</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px;">
						<span class="data">#dollarFormat(getOrder.amountsale)#</span>
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">TAX</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<span class="data">#dollarFormat(getOrder.tax)#</span>
					</td>
				</tr>
				<cfset subtotal = getOrder.amountsale + getOrder.tax />
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">SUBTOTAL</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<span class="data">#dollarFormat(subtotal)#</span>
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">SHIPPING COST</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<span class="data">#dollarFormat(getOrder.shipCost)#</span>

					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">SHIPPING METHOD</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<span class="data">#getOrder.shipMethod#</span>

					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">INSURANCE</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<span class="data">#dollarFormat(getOrder.insurance)#</span>

					</td>
				</tr>
								<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">TOTAL SALE</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px;">
						<span class="data">#dollarFormat(getOrder.total)#</span>
					</td>
				</tr>
								<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">DISCOUNT</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px;">
						<span class="data">#dollarFormat(getOrder.discount)#</span>
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">AMOUNT PAID</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<span class="data">#dollarFormat(getOrder.amountpaid)#</span>
					</td>
				</tr>
				<tr>
					<td class="formCellBorderBottom" colspan="4">
						<span class="largeLabel">RECEIVED BY:</span>
					</td>
					<td class="formCellBorderBottom" align="center" colspan="3" style="border-right:  1px solid ##000000;">
						<span class="largeLabel">DATE:  #ucase(dateFormat(getOrder.date,'mmmm dd, yyyy'))#</span>
					</td>
					<td class="formCellBorderBottom" align="center" style="border-right:  1px solid ##000000;">
						<span class="largeLabel">BALANCE DUE</span>
					</td>
					<td class="formCellBorderBottom" align="right" style="border-right:  1px solid ##000000; padding-right: 2px;">
						<span class="data">#dollarFormat(getOrder.balanceDue)#</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" style="padding-top: 5px;">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td>
						<span class="largeLabel">ALL CLAIMS AND RETURNED GOODS <strong>MUST BE</strong> ACCOMPANIED BY THIS INVOICE</span>
					</td>
					<td align="right" valign="top" style="padding-right: 10px;">
						<span class="largeLabel"><em>THANK YOU</em></span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>

