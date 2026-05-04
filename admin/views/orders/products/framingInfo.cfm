<cfajaximport>

<cfajaxproxy cfc="admin.models.art" jsclassname="getArtById">

<script>
	var artProxy = new getArtById();

	function submitFramingInfo() {

		if (!validateFramingForm()) {
			return false; 
		}

		ColdFusion.Ajax.submitForm( 'framingInfoForm', 'models/art.cfc?method=saveFramingInfo', saveFramingResponse);
	}

	function validateFramingForm() {
		
		var title = document.getElementById('title').value.trim();
		var artist = document.getElementById('artist').value.trim();
		var desc = document.getElementById('desc').value.trim();
		var priceInput = document.getElementById('priceInput').value.trim();
		var addButton = document.querySelector('#addBtn');

		if (title === '') {
			alert('Please enter the Title.');
			document.getElementById('title').focus();
			return false;
		}
		if (artist === '') {
			alert('Please enter the Artist.');
			document.getElementById('artist').focus();
			return false;
		}
		if (desc === '') {
			alert('Please enter the Short Description.');
			document.getElementById('desc').focus();
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

	function saveFramingResponse(s){
		if( s == "true" ) {
			displayArtListings();
			window.close();
		} else {
			alert('There was a problem in the processing.');
			return false;
		}
	}

	function displayArtListings() {
		var display = artProxy.createArtDisplay();

		opener.document.getElementById( 'artListings' ).innerHTML = display;
	}

	function formatPrice( framePrice ) {
		document.framingInfoForm.price.value = framePrice.value;
	}
</script>

<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
	<cfform method="post" action="" onsubmit="submitFramingInfo(); return false;" name="framingInfoForm">
		<input type="Hidden" name="price">

		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				Enter Framing Info:<br><br>
			</td>
		</tr>
		<tr>
			<td>Title:</td>
			<td>
				<input type="text" name="title" id="title" maxlength="40" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Artist:</td>
			<td>
				<input type="text" name="artist" id="artist" maxlength="40" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Short Description:</td>
			<td>
				<input type="text" name="desc" id="desc" maxlength="40" size="40" value="">
			</td>
		</tr>
		<tr>
			<td>Price:</td>
			<td>
				$<input type="number" min="-9999" step="0.01" name="priceInput" id="priceInput" size="10" value="" onkeyup="limitLength(this,10); formatPrice( this );">
				<input type="Submit" id="addBtn" value="Add" style="font-family: Arial; font-size: 11px;" />
				<input type="Button" value="Close" onclick="window.close();" style="font-family: Arial; font-size: 11px;">
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

<script>
	function limitLength(el, max) {
		if (el.value.length > max) {
			el.value = el.value.slice(0, max);
		}
	}
</script>
