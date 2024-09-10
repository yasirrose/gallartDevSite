<script src="scripts/functions.js" type="text/javascript"></script>

<cfscript>
	orders = new admin.models.orders();
 	order = orders.getItem(url.id);
</cfscript>

<cfajaximport>

<cfajaxproxy cfc="admin.models.orders" jsclassname="getArtById">

<script>
	function submitItemEdit() {
		ColdFusion.Ajax.submitForm( 'itemEditForm','models/orders.cfc?method=editItemInfo',saveEditResponse );
	}

	function saveEditResponse( s ) {
		if( trim( s )== 'true' ) {
			window.opener.location.reload();
			window.close();
		} else {
			alert( 'There was a problem in the processing.' );
			return false;
		}
	}

	/* function computeAmountProductOrder() {
		document.editForm.subtotalDisplay.value = formatAsDollars(
			decimalFormat(document.editForm.amountSaleDisplay.value) +
			decimalFormat(document.editForm.taxDisplay.value)
		);

		document.editForm.totalDisplay.value = formatAsDollars(
			decimalFormat(document.editForm.amountSaleDisplay.value) +
			decimalFormat(document.editForm.taxDisplay.value) +
			decimalFormat(document.editForm.shipCostDisplay.value) +
			decimalFormat(document.editForm.insuranceDisplay.value)
		);

		// set total value so that it appears as form value (totalDisplay is disabled)
		document.editForm.totalValue.value =
			decimalFormat(document.editForm.amountSaleDisplay.value) +
			decimalFormat(document.editForm.taxDisplay.value) +
			decimalFormat(document.editForm.shipCostDisplay.value) +
			decimalFormat(document.editForm.insuranceDisplay.value)

		document.editForm.balanceDueDisplay.value = formatAsDollars(
			decimalFormat(document.editForm.amountSaleDisplay.value) -
			decimalFormat(document.editForm.discountDisplay.value) +
			decimalFormat(document.editForm.taxDisplay.value) +
			decimalFormat(document.editForm.shipCostDisplay.value) +
			decimalFormat(document.editForm.insuranceDisplay.value) -
			decimalFormat(document.editForm.amountPaidDisplay.value)
		);

		// set balanceDue value so that it appears as form value (balanceDueDisplay is disabled)
		document.editForm.balanceDueValue.value =
			decimalFormat(document.editForm.amountSaleDisplay.value) -
			decimalFormat(document.editForm.discountDisplay.value) +
			decimalFormat(document.editForm.taxDisplay.value) +
			decimalFormat(document.editForm.shipCostDisplay.value) +
			decimalFormat(document.editForm.insuranceDisplay.value) -
			decimalFormat(document.editForm.amountPaidDisplay.value)
	} */
</script>

<cfoutput>
<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="##ffffff">
	<cfform method="post" action="/models/orders.cfc?method=editItemInfo" onsubmit="submitItemEdit(); return false;" name="itemEditForm">
		<input type="hidden" name="orderId" id="orderId" value="#order['ORDERID']#">
		<input type="hidden" name="itemId" id="itemId" value="#url.id#">

		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Edit Item:<br><br>
			</td>
		</tr>
		<tr>
			<td>Title:</td>
			<td>
				<input type="text" name="item_title" id="item_title" size="40" value="#order['ITEM_TITLE']#">
			</td>
		</tr>
		<tr>
			<td>Artist:</td>
			<td>
				<input type="text" name="item_artist" id="item_artist" size="40" value="#order['ITEM_ARTIST']#">
			</td>
		</tr>
		<tr>
			<td>Price:</td>
			<td>
				$<input type="number" min="0" step="0.01" name="price" id="price" size="10" value="#order['ITEM_PRICE']#" message="Please enter a numeric value for the price with no dollar sign.">
			</td>
		</tr>

		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Submit" value="EDIT" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="padding-top: 10px;">
				<input type="Button" value="Close" onclick="window.close();" style="font-size: 10px;">
			</td>
		</tr>
	</cfform>
</table>
</cfoutput>
