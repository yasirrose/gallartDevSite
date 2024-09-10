<cfoutput>
<style>
.data{
	font-size: 9px;
	color: ##000000;
}
.largedata{
	font-size: 9px;
	color: ##000000;
}
.formTable{
	border-top: 1px solid ##000000;
	border-left: 1px solid ##000000;
}

.formCell{
	height: 40px;
	margin: 0px 0px 0px 0px;
	padding: 5px 0px 0px 0px;
	vertical-align: top;
	border-right: 1px solid ##000000;
}

.productCell{
	height: 30px;
	margin: 0px 0px 0px 0px;
	padding: 5px 0px 0px 0px;
	vertical-align: top;
	border-right: 1px solid ##000000;
	border-bottom: 1px solid ##000000;
}

.formCellNoBorder{
	height: 20px;
	margin: 0px 0px 0px 0px;
	padding: 5px 0px 0px 0px;
}

.formCellBorderBottom {
	height: 30px;
	margin: 0px 0px 0px 0px;
	padding: 5px 0px 5px 0px;
	border-bottom: 1px solid ##000000;
}

</style>
<table cellspacing="0" cellpadding="0" border="0" width="600">
	<tr>
		<td style="padding-bottom: 5px;">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td align="center" class="orderTitle">
						<span style="font-size: 18px;">INVOICE ## #session.invoiceinfo.displayInvoiceNumber#</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellspacing="0" cellpadding="2" border="0" width="97%" class="formTable">
				<tr>
					<td class="formCell">
						<span class="data">HOME PHONE</span><br>
						<span class="data">#session.invoiceinfo.Phone#</span>
					</td>
					<td class="formCell">
						<span class="data">CELL PHONE</span><br>
						<span class="data">#session.invoiceinfo.CellPhone#</span>
					</td>
					<td class="formCell">
						<span class="data">FAX</span><br>
						<span class="data">#session.invoiceinfo.Fax#</span>
					</td>
					<td class="formCell">
						<span class="data">CONSULTANT</span><br>
						<span class="data">#session.invoiceinfo.Consultant#</span>
					</td>
					<td class="formCell">
						<span class="data">DATE</span><br>
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
					<td class="formCell" width="50%">
						<span class="data">LAST NAME</span><br>
						<span class="data">#session.invoiceinfo.lname#</span>
					</td>
					<td class="formCell">
						<span class="data">FIRST NAME</span><br>
						<span class="data">#session.invoiceinfo.fname#</span>
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
						<span class="data">ADDRESS</span><br>
						<span class="data">#session.invoiceinfo.Address1#</span>
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
						<span class="data">CITY</span><br>
						<span class="data">#session.invoiceinfo.City#</span>
					</td>
					<td class="formCell">
						<span class="data">STATE</span><br>
						<span class="data">#session.invoiceinfo.State#</span>
					</td>
					<td class="formCell">
						<span class="data">COUNTRY</span><br>
						<span class="data">#session.invoiceinfo.Country#</span>
					</td>
					<td class="formCell">
						<span class="data">POSTAL CODE</span><br>
						<span class="data">#session.invoiceinfo.Zip#</span>
					</td>
					<td class="formCell">
						<span class="data">EMAIL ADDRESS</span><br>
						<span class="data">#session.invoiceinfo.Email#</span>
					</td>
					<td class="formCell">
						<span class="data">COMPANY NAME</span><br>
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
					<td class="formCell" width="80%">
						<span class="data">METHOD OF PAYMENT</span><br>
						<span class="largedata">#session.invoiceinfo.Payment_Method#</span>
					</td>
					<td width="20%" class="formCell" style="padding-left: 10px;">
						<span class="data">ORIGIN</span><br>
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
						<span class="data">CREDIT CARD ##</span><br>
						<span class="data" style="font-size:16px;"><strong>#session.invoiceinfo.CardNumber#</strong></span>
					</td>
					<td class="formCell" style="width: 7%">
						<span class="data">EXP.</span><br>
						<span class="data">#session.invoiceinfo.cardexpm#/#session.invoiceinfo.cardexpy#</span>
					</td>
					<td class="formCell">
						<span class="data" style="width: 8%">AUTH. CODE</span><br>
						<span class="data">#session.invoiceinfo.authcode#</span>
					</td>
					<td class="formCell" style="width: 35%">
						<span class="data">DRIVER'S LICENSE ##</span><br>
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
					<td class="formCellNoBorder" align="center" width="5%">
						<span class="largedata">QUANTITY</span>
					</td>
					<td class="formCellNoBorder" align="center" width="15%">
						<span class="largedata">TITLE</span>
					</td>
					<td class="formCellNoBorder" align="center" width="15%">
						<span class="largedata">ARTIST</span>
					</td>
					<td class="formCellNoBorder" align="center" width="20%">
						<span class="largedata">DESCRIPTION</span>
					</td>
					<td class="formCellNoBorder" align="center" width="10%">
						<span class="largedata">ART ID</span>
					</td>
					<td class="formCellNoBorder" align="center" width="10%">
					</td>
					<td class="formCellNoBorder" align="center" width="12%">
						<span class="largedata">PRICE</span>
					</td>
					<td class="formCellNoBorder" align="center" width="13%" style="border-right:  1px solid ##000000;">
						<span class="largedata">EXT</span>
					</td>
				</tr>
				<tr>
					<td colspan="8" style="border-right: 1px solid ##000000; border-bottom: 1px solid ##000000;">&nbsp;</td>
				</tr>
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
				<tr>
					<td class="productCell" colspan="6" rowspan="5">
						<span class="data">SPECIAL INSTRUCTIONS</span><br>
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
						<span class="largedata">AMOUNT OF SALE</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 9px;">
						#dollarFormat(session.invoiceInfo.amountsalevalue)#
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largedata">TAX</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 9px;">
						#dollarFormat(session.invoiceInfo.tax)#
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largedata">TOTAL SALE</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 9px;">
						#dollarFormat(session.invoiceInfo.totalSaleValue)#
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largedata">SHIPPING</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 9px;">
						#dollarFormat(session.invoiceInfo.shipping)#
					</td>
				</tr>
				<tr>
					<td class="productCell" align="center">
						<span class="largedata">AMOUNT PAID</span>
					</td>
					<td class="productCell" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 9px;">
						#dollarFormat(session.invoiceInfo.amountpaid)#
					</td>
				</tr>
				<tr>
					<td class="formCellBorderBottom" colspan="3">
						<span class="largedata">RECEIVED BY:</span>
					</td>
					<td class="formCellBorderBottom" align="center" colspan="3" style="border-right:  1px solid ##000000;">
						<span class="largedata">DATE:  #ucase(dateFormat(createodbcdate(now()),'mmmm dd, yyyy'))#</span>
					</td>
					<td class="formCellBorderBottom" align="center" style="border-right:  1px solid ##000000;">
						<span class="largedata">BALANCE DUE</span>
					</td>
					<td class="formCellBorderBottom" align="right" style="border-right:  1px solid ##000000; padding-right: 2px; font-size: 9px;">
						#dollarFormat(session.invoiceInfo.balanceDueValue)#
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>

