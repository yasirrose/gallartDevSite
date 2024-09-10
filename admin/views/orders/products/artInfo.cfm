<cfajaximport>

<cfajaxproxy cfc="admin.models.art" jsclassname="getArtById">

<script>
	var artProxy = new getArtById();

	function submitArtInfo() {
		ColdFusion.Ajax.submitForm( 'artInfoForm', 'models/art.cfc?method=saveArtInfo', saveArtResponse );
	}

	function saveArtResponse(s){
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

	function formatPrice( artPrice ) {
		document.artInfoForm.price.value = artPrice.value;
	}
</script>

<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="#ffffff">
	<cfform method="post" action="" onsubmit="submitArtInfo(); return false;" name="artInfoForm">
		<input type="Hidden" name="price">
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
				$<input type="number" min="0" step="0.01" name="priceInput" id="priceInput" size="10" value="" onkeyup="formatPrice( this );">
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
