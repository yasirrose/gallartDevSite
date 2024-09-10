<cfajaximport>

<cfajaxproxy cfc="admin.models.orders" jsclassname="getArtById">

<script>
	function submitArtInfo() {
		ColdFusion.Ajax.submitForm('itemInfoForm','models/orders.cfc?method=insertItemFromInfo',saveInsertResponse);
	}

	function saveInsertResponse(s){
		if( s ) {
			window.opener.location.reload();
			window.close();
		} else {
			alert('There was a problem in the processing.');
			return false;
		}
	}
</script>

<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
	<cfform method="post" action="" onsubmit="submitArtInfo(); return false;" name="itemInfoForm">
	<input type="hidden" name="orderId" id="orderId_info" value="<cfoutput>#url.order#</cfoutput>">
	<tr>
		<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
			Enter Product Info:<br><br>
		</td>
	</tr>
	<tr>
		<td>Title:</td>
		<td>
			<input type="text" name="title" id="title" size="40" value="">
		</td>
	</tr>
	<tr>
		<td>Artist:</td>
		<td>
			<input type="text" name="artist" id="artist" size="40" value="">
		</td>
	</tr>
	<tr>
		<td>Short Description:</td>
		<td>
			<input type="text" name="desc" id="desc" size="40" value="">
		</td>
	</tr>
	<tr>
		<td>Price:</td>
		<td>
			$<input type="number" min="0" step="0.01" name="price" id="infoPriceInput" size="10" value="" message="Please enter a numeric value for the price with no dollar sign.">
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
			<input type="Submit" value="ADD" />
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2" style="padding-top: 10px;">
			<input type="Button" value="Close" onclick="window.close();" style="font-size: 10px;">
		</td>
	</tr>
	</cfform>
</table>
