<cfoutput>
<cfif isDefined('printFields')>
	<link REL="STYLESHEET" TYPE="text/css" HREF="http://#server_name#/admin/css/main.css">
</cfif>
<table cellspacing="0" cellpadding="0" border="0" width="900">
	<tr>
		<td style="padding-bottom: 5px;">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td align="center">
						<cfif isDefined('session.userinfo.roles') AND listFindNoCase(session.userinfo.roles,'international')>
							<div style="font-size: 50px; color: ##000000; font-weight: bold;">
								International Art Gallery, LLC
							</div>
							<div style="font-size: 22px; color: ##000000">
								20340 NE 15th CT, Unit 36 <br />
								Miami, FL 33179-2716
							</div>
						<cfelse>
							<img src="images/Galleryartlogo.gif" border="0"/>
						</cfif>
					</td>
				</tr>
				<tr>
					<td align="center" class="orderTitle">
						<span style="font-size: 18px;">INVOICE ## <cfif isDefined('session.invoiceinfo.displayInvoiceNumber')>#session.invoiceinfo.displayInvoiceNumber#</cfif></span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="0" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCell" width="14%">
						<span class="label">HOME PHONE</span><br>
						<span class="data">#session.invoiceinfo.Phone#</span>
					</td>
					<td class="formCell" width="14%">
						<span class="label">BUSINESS PHONE</span><br>
						<span class="data">#session.invoiceinfo.BusinessPhone#</span>
					</td>
					<td class="formCell" width="14%">
						<span class="label">CELL PHONE</span><br>
						<span class="data">#session.invoiceinfo.CellPhone#</span>
					</td>
					<td class="formCell" width="14%">
						<span class="label">PHONE OUTSIDE THE US</span><br>
						<span class="data">#session.invoiceinfo.OtherPhone#</span>
					</td>
					<td class="formCell" width="14%">
						<span class="label">FAX</span><br>
						<span class="data">#session.invoiceinfo.Fax#</span>
					</td>
					<td class="formCell" width="14%">
						<span class="label">CONSULTANT</span><br>
						<span class="data">#session.invoiceinfo.Consultant#</span>
					</td>
					<td class="formCell" width="14%">
						<span class="label">DATE</span><br>
						<span class="data">#dateFormat(createodbcdate(now()),'mmmm dd yyyy')#</span>
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
						<span class="data">#session.invoiceinfo.lname#</span>
					</td>
					<td class="formCell">
						<span class="label">FIRST NAME</span><br>
						<span class="data">#session.invoiceinfo.fname#</span>
					</td>
					<td class="formCell">
						<span class="label">COMPANY NAME</span><br>
						<span class="data">#session.invoiceinfo.Company#</span>
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
						<span class="data">#session.invoiceinfo.Address1#</span>
					</td>
					<td class="formCell">
						<span class="label">CITY</span><br>
						<span class="data">#session.invoiceinfo.City#</span>
					</td>
					<td class="formCell">
						<span class="label">STATE</span><br>
						<span class="data"><cfif isDefined('session.invoiceinfo.State')>#session.invoiceinfo.State#</cfif></span>
					</td>
					<td class="formCell">
						<span class="label">COUNTRY</span><br>
						<span class="data">#session.invoiceinfo.Country#</span>
					</td>
					<td class="formCell">
						<span class="label">POSTAL CODE</span><br>
						<span class="data">#session.invoiceinfo.Zip#</span>
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
						<span class="data">#session.invoiceinfo.Email#</span>
					</td>
					<td class="formCell" width="40%">
						<span class="label">WEBSITE</span><br>
						<span class="data">#session.invoiceinfo.website#</span>
					</td>
					<td class="formCell" width="20%">
						<span class="label">DRIVER'S LICENSE ##</span><br>
						<span class="data">#session.invoiceinfo.DriversLicense#</span>
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
						<cfif session.invoiceinfo.Payment_Method EQ "VISA/MC">
							<img src="#imgpath#/checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="#imgpath#/unchecked.gif" align="absmiddle" width="25">
						</cfif>&nbsp;&nbsp;
						<span class="largeLabel">AMEX</span>
						<cfif session.invoiceinfo.Payment_Method EQ "AMEX">
							<img src="#imgpath#/checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="#imgpath#/unchecked.gif" align="absmiddle" width="25">
						</cfif>&nbsp;&nbsp;
						<span class="largeLabel">CHECK</span>
						<cfif session.invoiceinfo.Payment_Method EQ "CHECK">
							<img src="#imgpath#/checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="#imgpath#/unchecked.gif" align="absmiddle" width="25">
						</cfif>&nbsp;&nbsp;
						<span class="largeLabel">CASH</span>
						<cfif session.invoiceinfo.Payment_Method EQ "CASH">
							<img src="#imgpath#/checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="#imgpath#/unchecked.gif" align="absmiddle" width="25">
						</cfif>&nbsp;&nbsp;
						<span class="largeLabel">OTHER</span>
						<cfif session.invoiceinfo.Payment_Method EQ "OTHER">
							<img src="#imgpath#/checked.gif" align="absmiddle" width="25">
						<cfelse>
							<img src="#imgpath#/unchecked.gif" align="absmiddle" width="25">
						</cfif>
					</td>
					<td width="20%" class="formCell" style="padding-left: 10px;">
						<span class="label">ORIGIN</span><br>
						<span class="data">#session.invoiceinfo.origin#</span>
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
						<span class="data" style="font-size:16px;"><strong>xxxx-xxxx-xxxx-#right(session.invoiceinfo.CardNumber,4)#</strong></span> 
					</td>
					<td class="formCell" style="width: 7%">
						<span class="label">EXP.</span><br>
						<span class="data">#session.invoiceinfo.cardexpm#/#session.invoiceinfo.cardexpy#</span>
					</td>
					<td class="formCell">
						<span class="label" style="width: 8%">AUTH. CODE</span><br>
						<span class="data">#session.invoiceinfo.authcode#</span>
					</td>
					<td class="formCell">
						<span class="label" style="width: 8%">ESTIMATE</span><br>
						<span class="data">
							<cfif session.invoiceinfo.estimate EQ 1>
								<img src="#imgpath#/checked.gif" align="absmiddle" width="25">
							<cfelse>
								<img src="#imgpath#/unchecked.gif" align="absmiddle" width="25">
							</cfif>
							</span>
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
					<td class="formCellNoBorder" align="center" width="15%">
						<span class="largeLabel">ARTIST</span>
					</td>
					<td class="formCellNoBorder" align="center" width="20%">
						<span class="largeLabel">DESCRIPTION</span>
					</td>
					<td class="formCellNoBorder" align="center" width="10%">
						<span class="largeLabel">ART ID</span>
					</td>
					<td class="formCellNoBorder" align="center" width="10%">
					</td>
					<td class="formCellNoBorder" align="center" width="12%">
						<span class="largeLabel">PRICE</span>
					</td>
					<td class="formCellNoBorder" align="center" width="13%" style="border-right:  1px solid ##000000;">
						<span class="largeLabel">EXT</span>
					</td>
				</tr>
				<tr>
					<td colspan="8" style="border-right: 1px solid ##000000; border-bottom: 1px solid ##000000;">&nbsp;</td>
				</tr>
				<cfif structKeyExists(session,'orderArray') AND isDefined('session.invoiceInfo.QUANTITY_1')>
					<cfset amountSale = 0 />
					<cfloop from="1" to="#arrayLen(session.orderArray)#" index="idx">
					<cfset thisQuantity = evaluate('session.invoiceinfo.QUANTITY_'&idx) />
					<cfset thisPrice = evaluate('session.invoiceinfo.PRICE_'&idx) />
					<cfset thisExt = thisQuantity * thisPrice />
					<tr>
						<td class="productCell" align="center">
							<span class="data">#thisQuantity#</span>
						</td>
						<td class="productCell" align="center">
							<span class="data">#session.orderArray[idx][2]#</span>
						</td>
						<td class="productCell" align="center">
							<span class="data">#session.orderArray[idx][3]#</span>
						</td>
						<td class="productCell" style="padding-left: 3px;">
							<span class="data">#session.orderArray[idx][4]#</span>
						</td>
						<td class="productCell" align="center">
							<span class="data">#session.orderArray[idx][5]#</span>
						</td>
						<td class="productCell" align="center">
							<span class="data"><cfif session.orderArray[idx][8] EQ 1>FRAMING</cfif></span>
						</td>
						<td class="productCell" align="right" style="padding-right: 2px;">
							<span class="data">#dollarFormat(thisPrice)#</span>
						</td>
						<td class="productCell" align="right" style="padding-right: 2px;">
							<span class="data">#dollarFormat(thisExt)#</span>
						</td>
					</tr>
					<cfset amountSale = amountSale + thisExt />
					</cfloop>
				<cfelse>
					<tr>
						<td colspan="8" align="center" style="color: ##ff0000;font-size: 15px;font-weight:bold;">
						<br><br><br>
						NO PRODUCTS HAVE BEEN LISTED - PLEASE GO BACK!!
						<br><br>
						<input type="button" value="Back" onclick="location.href='index.cfm?event=orders.productForm'">
						</td>
					</tr>
					<cfabort>
				</cfif>
				<tr>
					<td class="productCell" colspan="6" rowspan="5">
						<span class="label">SPECIAL INSTRUCTIONS</span><br>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td style="padding-left: 3px;">
									#session.invoiceinfo.special_instructions#
								</td>
							</tr>
						</table>	
						<cfif session.invoiceinfo.tobeshipped EQ 1>
							<br>
							<span style="color: ##ff0000; font-size: 13px; font-weight: bold;">TO BE SHIPPED</span>
						</cfif> 					
					</td>
					<td class="productCell" align="center">
						<span class="largeLabel">AMOUNT OF SALE</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px;">
						<cfif isDefined('printFields')>
							<span class="data">#dollarFormat(session.invoiceInfo.amountsalevalue)#</span>
						<cfelse>
							<span class="data" id="amountSale"></span>
						</cfif>
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">TAX</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<cfif isDefined('printFields')>
							<span class="data">#dollarFormat(session.invoiceInfo.tax)#</span>
						<cfelse>
							$<input type="Text" name="tax" id="tax" size="5" onkeyup="computeAmount();" style="font-size: 15px; text-align:right;" />
						
						</cfif>
						
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">TOTAL SALE</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px;">
						<cfif isDefined('printFields')>
							<span class="data">#dollarFormat(session.invoiceInfo.totalSaleValue)#</span>
						<cfelse>
							<span class="data" id="totalSale"></span>
						</cfif>
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">SHIPPING</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<cfif isDefined('printFields')>
							<span class="data">#dollarFormat(session.invoiceInfo.shipping)#</span>
						<cfelse>
							$<input type="Text" name="shipping" id="shipping" size="5" onkeyup="computeAmount();" style="font-size: 15px; text-align:right;" />
						</cfif>
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largeLabel">AMOUNT PAID</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 15px;">
						<cfif isDefined('printFields')>
							<span class="data">#dollarFormat(session.invoiceInfo.amountpaid)#</span>
						<cfelse>
							$<input type="Text" name="amountPaid" id="amountPaid" size="5" onkeyup="computeAmount();" style="font-size: 15px; text-align:right;" />
						</cfif>
					</td>
				</tr>
				<tr>
					<td class="formCellBorderBottom" colspan="4">
						<span class="largeLabel">RECEIVED BY:</span>
					</td>
					<td class="formCellBorderBottom" align="center" colspan="2" style="border-right:  1px solid ##000000;">
						<span class="largeLabel">DATE:  #ucase(dateFormat(createodbcdate(now()),'mmmm dd, yyyy'))#</span>
					</td>
					<td class="formCellBorderBottom" align="center" style="border-right:  1px solid ##000000;">
						<span class="largeLabel">BALANCE DUE</span>
					</td>
					<td class="formCellBorderBottom" align="right" style="border-right:  1px solid ##000000; padding-right: 2px;">
						<cfif isDefined('printFields')>
							<span class="data">#dollarFormat(session.invoiceInfo.balanceDueValue)#</span>
						<cfelse>
							<span class="data" id="balanceDue"></span>
						</cfif>
						
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

