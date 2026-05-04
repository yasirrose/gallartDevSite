<cfajaximport>

<cfajaxproxy cfc="admin.models.orders" jsclassname="getArtById">

<script>
	function submitFramingInfo() {

		if (!validateFramingForm()) {
			return false; 
		}

		ColdFusion.Ajax.submitForm('framingInfoForm','models/orders.cfc?method=insertFramingInfo',saveFramingInsertResponse);
	}

	function validateFramingForm() {
		
		var title = document.getElementById('titleFraming').value.trim();
		var artist = document.getElementById('artistFraming').value.trim();
		var desc = document.getElementById('descFraming').value.trim();
		var priceInput = document.getElementById('priceInputFraming').value.trim();
		var addButton = document.querySelector('#addBtn');

		if (title === '') {
			alert('Please enter the Title.');
			document.getElementById('titleFraming').focus();
			return false;
		}
		if (artist === '') {
			alert('Please enter the Artist.');
			document.getElementById('artistFraming').focus();
			return false;
		}
		if (desc === '') {
			alert('Please enter the Short Description.');
			document.getElementById('descFraming').focus();
			return false;
		}
		if (priceInput === '' || isNaN(priceInput)) {
			alert('Please enter a valid Price.');
			document.getElementById('priceInput').focus();
			return false;
		}

		isSubmitting = true;
		addButton.disabled = true;
		addButton.value = 'Adding...';

		return true;
	}


	function saveFramingInsertResponse(s){
		if( s ) {
			window.opener.location.reload();
			window.close();
		} else {
			alert('There was a problem in the processing.');
			return false;
		}
	}
</script>

<cfparam name="url.order" default="">

<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
	<cfform method="post" action="" onsubmit="submitFramingInfo(); return false;" name="framingInfoForm">
	<input type="hidden" name="orderId" id="orderId_framing" value="<cfoutput>#url.order#</cfoutput>">
	<tr>
		<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
			Enter Framing Info:<br><br>
		</td>
	</tr>
	<tr>
		<td>Title:</td>
		<td>
			<input type="text" name="title" id="titleFraming" maxlength="40" size="40" value="">
		</td>
	</tr>
	<tr>
		<td>Artist:</td>
		<td>
			<input type="text" name="artist" id="artistFraming" maxlength="40" size="40" value="">
		</td>
	</tr>
	<tr>
		<td>Short Description:</td>
		<td>
			<input type="text" name="desc" id="descFraming" maxlength="40" size="40" value="">
		</td>
	</tr>
	<tr>
		<td>Price:</td>
		<td>
			$<input type="number" min="-9999" step="0.01" name="price" id="priceInputFraming" maxlength="5" size="10" value="" message="Please enter a numeric value for the price with no dollar sign.">
			<input type="Submit" id="addBtn" value="Add" />
			<input type="Button" value="Close" onclick="window.close();" >
		</td>
	</tr>
	<!--- <tr>
		<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
			<input type="Submit" id="addBtn" value="ADD" />
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2" style="padding-top: 10px;">
			<input type="Button" value="Close" onclick="window.close();" style="font-size: 10px;">
		</td>
	</tr> --->
	</cfform>
</table>
