<cfajaxproxy cfc="admin.models.purchases_consignments" />
<cfajaxproxy bind="javascript:gridChange({data.pk_purchases_consignments})">

<cfhtmlhead text='
    <script type="text/javascript" src="/admin/scripts/purchases_consignments.js.cfm" language="JavaScript"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

	<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
'>
</cfhtmlhead>

<script type="text/javascript">

	function validEntries(frm) {

		if(editForm.medium.value == ''){
			alert('You must select a Medium.');
			return false;
		}

	}
</script>

<style>

	#imageDisplay {
		display: flex;
		align-items: center;
		flex-wrap: wrap;
	}
	#imageDisplay .image-container {
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
		margin: 6px;
		gap: 6px;
	}
	.date-field div {
		float: none !important;
		width: max-content;
		display: inline-block;
	}
	.date-field input.datefieldinput {
		padding-right: 18px;
		max-width: 178px;
	}

	.date-field div#searchFromDategridForm_cf_buttondiv, .date-field div#searchToDategridForm_cf_buttondiv {
		position: absolute;
		top: 2px;
		right: 2px;
		padding: 0 !important;
	}
</style>

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
    	<td colspan="2" style="font-size: 11px;"><strong>SEARCH BY:</strong></td>
  	</tr>
	<tr>
		<td valign="top" width="400">
			<cfform name="gridForm">
				<table cellspacing="0" cellpadding="1" border="0" width="100%">
					<tr>
						<td align="right" style="font-size: 10px;">
							<strong>Name:</strong>
							<cfinput name="searchName" maxlength="50" size="30" />
						</td>
						<!--- <td>
							
						</td> --->
						<td align="right" style="font-size: 10px;">
							<strong>Email:</strong>
							<cfinput name="searchEmail" maxlength="50" size="30" />
						</td>
						<!--- <td>
							
						</td> --->
						<td>&nbsp;</td>
					</tr>
					<!--- <tr>
						<td align="right" style="font-size: 10px;">
							<strong>Email:</strong>
						</td>
						<td>
							<cfinput name="searchEmail" size="30" />
						</td>
						<td>&nbsp;</td>
					</tr> --->
					<tr>
						<td align="right" class="date-field" style="font-size: 10px;">
							<strong>Date from:</strong>
							<cfinput name="searchFromDate" type="datefield" validate="date" maxlength="50" size="30" />
						</td>

						<td align="right" class="date-field" style="font-size: 10px;">
							<strong>Date to:</strong>
							<cfinput name="searchToDate" type="datefield" validate="date" maxlength="50" size="30" />
						</td>

						<td>&nbsp;</td>
					</tr>
					<tr>					
						<td align="right" colspan="2">
							<input type="Reset">
							<cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.purchases_consignments.getPurchasesConsignments({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchName},{searchEmail})">
								<!--- <cfgridcolumn name="name" header="Name" width="80"> --->
								<cfgridcolumn name="user_name" header="Name" width="200">
								<cfgridcolumn name="email" header="Email" width="175">
								<cfgridcolumn name="datestamp" header="Date" width="150">
							</cfgrid>
						</td>
					</tr>
				</table>
			</cfform>
		</td>
		<td valign="top">
			<!--- <input type="button" value="New" onclick="showNew()"> --->
			<cfform name="editForm" enctype="multipart/form-data" onsubmit="return CheckEntries()">
				<cfinput type="hidden" name="pk_purchases_consignments" id="pk_purchases_consignments" bind="{data.pk_purchases_consignments}">
				<cfinput type="hidden" name="moduleName" id="moduleName" value="admin/purchases_consignments">
				<table border = "0" width = "500" cellpadding = "1" cellspacing = "0" class="editBox form-width" style="margin-top: 70px;">
					<tr>
						<td>
							<table border = "0" width = "100%" cellpadding = "1" cellspacing = "0">
								<tr>
									<td width="100" style="font-size: 10px;">
										First Name:
										<br>
										<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" maxlength="25" size="25">
									</td>
									<td width="100" style="font-size: 10px;">
										Last Name:
										<br>
										<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" maxlength="25" size="25">
									</td>
									
								</tr>
								<!--- <tr>
									<td width="100" style="font-size: 10px;">
										Last Name:
									</td>
									<td>
										<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" maxlength="25" size="25">
									</td>
								</tr>
								<tr>
									<td width="100" style="font-size: 10px;">
										Name:
									</td>
									<td>
										<cfinput type="text" name="name" id="name"  bind="{data.user_name}" maxlength="25" size="25">
									</td>
								</tr> --->

								<tr>
									<td width="100" style="font-size: 10px;">
										Name:
										<br>
										<cfinput type="text" name="name" id="name"  bind="{data.user_name}" maxlength="25" size="25">
									</td>
									<td>
										Email:
										<br>
										<cfinput type="text" name="customer_email" id="customer_email"  bind="{data.customer_email}" maxlength="25" size="25">										
									</td>
									
								</tr>

								<!--- <tr>
									<td style="font-size: 10px;">
										Phone:
									</td>
									<td>
										<cfinput type="text" name="phone" id="phone"  bind="{data.phone}" maxlength="25" size="25">
										<!--- <span id="formatSign">(xxx) xxx-xxxx</span> --->
									</td>
								</tr> --->
								<!--- <tr>
									<td style="font-size: 10px;">
										Email:
									</td>
									<td>
										<cfinput type="text" name="customer_email" id="customer_email"  bind="{data.customer_email}" maxlength="25" size="25">
									</td>
								</tr> --->
								<tr>
									<td style="font-size: 10px;">
										Phone Type:
										<br>
										<select name="PhoneType"  id="PhoneType" style="font-size: 8pt; width: 100%;" >
											<option value="Cell Phone" >Mobile</option>
											<option value="Home Phone" >Home</option>
											<option value="Business Phone" >Business</option>
											<option value="OutsideUS" >Outside US</option>
										</select>
									</td>
									<td>
										Phone:
										<br>
										<cfinput type="text" name="phone" id="phone" bind="{data.phone}" maxlength="25" size="25">
										<!--- <span id="formatSign">(xxx) xxx-xxxx</span> --->
									</td>
									
								</tr>
								<!--- <tr>
									<td style="font-size: 10px;">
										Title:
									</td>
									<td>
										<cfinput type="text" name="title" id="title"  bind="{data.title}" maxlength="25" size="25">
									</td>
								</tr> --->
								<!--- <tr>
									<td style="font-size: 10px;">
										Medium:
									</td>
									<td>
										<select name="medium" style="font-size: 8pt;">
											<option value="">Please Select
											<cfoutput query="getAllMedium">
												<option value="#path#">#path#
											</cfoutput>
										</select>
									</td>
								</tr> --->
								<tr>
									<td style="font-size: 10px;">
										Artist:
										<br>
										<cfinput type="text" name="artist" id="artist"  bind="{data.artist}" maxlength="25" size="25">
									</td>
									<td>
										Title:
										<br>
										<cfinput type="text" name="title" id="title"  bind="{data.title}" maxlength="25" size="25">
									</td>
									
								</tr>
								<tr>
									<td class="multi-select-td">
										Medium:
										<br>
										<select name="medium" style="font-size: 8pt;" class="select2">
											<option value="">Please Select
											<cfoutput query="getAllMedium">
												<option value="#path#">#path#
											</cfoutput>
										</select>
									</td>
									<td style="font-size: 10px;">
										Price:
										<br>
										<cfinput type="text" name="size" id="size"  bind="{data.size}" maxlength="25" size="30">
									</td>
								</tr>
								<tr>
									<td valign="top" style="font-size: 10px; white-space: nowrap;">
										Additional Details
										<br>
										<cftextarea name="additional_details" id="additional_details" rows="5" bind="{data.additional_details}" maxlength="500" style="width:100%;"></cftextarea>
										<div id="additional_detailsCount" class="mb-3">0 / 500 characters</div>
									</td>
									<td height="150">
										<div id="imageDisplay">
											<div class="img-box">

												<img src="" name="mainImg" id="mainImg" border="0" width="100"  /><br>
												<a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge
											</div>
										</div>
									</td>
								</tr>
								<!--- <tr>
									<td  height="150" colspan="2">
										<div id="imageDisplay">
											<div class="img-box">

												<img src="" name="mainImg" id="mainImg" border="0" width="100"  /><br>
												<a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge
											</div>
										</div>
									</td>
								</tr> --->
								<tr>
									<td colspan="2">
										<cfinput type="button" name="edit" id="edit" value="Edit" onclick="doEdit('edit');" />
										<cfinput type="button" name="delete" id="delete" value="Delete" onclick="if (confirm('DELETE -- ARE YOU SURE?')){ doEdit('delete');}" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</cfform>
		</td>
	</tr>
</table>

<style>
	.toast-center {
		top: 50% !important;
		left: 50% !important;
		transform: translate(-50%, -50%) !important;
		position: fixed !important;
		z-index: 999999 !important;
	}

	#toast-container > .toast {
		background-color: #ff4da6 !important;
		color: white !important;
	}
	.multi-select-td span.select2-container
		{
			width: 100% !important;
		}
	.form-width input:not([type="button"]),
	.form-width select select:not(.select2 ),
	.form-width textarea {
		width: 100% !important;
		box-sizing: border-box;

	}
</style>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		const phoneInput = document.getElementById("phone");
		const phoneType = document.getElementById("PhoneType");
		// const formatSign = document.getElementById("formatSign");

		// function toggleFormatSign() {
		// 	if (phoneType.value === "OutsideUS") {
		// 		formatSign.style.display = "none";
		// 	} else {
		// 		formatSign.style.display = "inline";
		// 	}
		// }

		// run on load (in case form already has value)
		// toggleFormatSign();

		// run on change
		// phoneType.addEventListener("change", toggleFormatSign);

		phoneType.addEventListener("change", function() {
			if (this.value === "OutsideUS" && phoneInput.value === '') {
				phoneInput.value = "+1"; 
			} 
		});

		phoneInput.addEventListener("input", function(e) {
			// If type is OutsideUS → skip formatting
			if (phoneType.value === "OutsideUS") {
				return;
			}

			let value = e.target.value.replace(/\D/g, ""); // only digits
			if (value.length > 10) value = value.substring(0, 10);

			// Apply formatting as user types
			if (value.length > 6) {
				e.target.value = `(${value.substring(0,3)}) ${value.substring(3,6)}-${value.substring(6)}`;
			} else if (value.length > 3) {
				e.target.value = `(${value.substring(0,3)}) ${value.substring(3)}`;
			} else if (value.length > 0) {
				e.target.value = `(${value}`;
			} else {
				e.target.value = "";
			}
		});
	});
</script>

<script>
	/* ---------- global counter function ---------- */
	function updateAdditionalDetailsCounter() {
		var textarea = document.getElementById('additional_details');
		var counter = document.getElementById('additional_detailsCount');
		var maxLength = 500;
		if (!textarea || !counter) return;
		var len = textarea.value ? textarea.value.length : 0;
		counter.textContent = len + ' / ' + maxLength + ' characters';

		// optional red warning
		if (len > maxLength) {
			counter.style.color = 'red';
		} else {
			counter.style.color = '';
		}
	}

	/* ---------- run on page load and attach input handler ---------- */
	document.addEventListener("DOMContentLoaded", function() {
		const textarea = document.getElementById("additional_details");
		const maxLength = 500;

		textarea.addEventListener("input", function() {
			if (this.value.length > maxLength) {
				this.value = this.value.substring(0, maxLength); // trim extra text
			}
			updateAdditionalDetailsCounter();
		});
	});

	$('.select2').select2({
		matcher: function (params, data) {
			if ($.trim(params.term) === '') {
				return data;
			}

			// Prevent matching placeholder during search
			if (data.id === '') {
				return null;
			}

			var term = params.term.toLowerCase();
			var text = data.text.toLowerCase();

			// Starts with match
			if (text.startsWith(term)) {
				return data;
			}

			// Contains match (less priority)
			if (text.indexOf(term) > -1) {
				var modifiedData = $.extend({}, data, true);
				modifiedData.text = data.text + ' ';
				return modifiedData;
			}

			return null;
		},

		sorter: function (data) {
			var term = $('.select2-search__field').val().toLowerCase();
			return data.sort(function (a, b) {
				var aStarts = a.text.toLowerCase().startsWith(term);
				var bStarts = b.text.toLowerCase().startsWith(term);

				if (aStarts && !bStarts) return -1;
				if (!aStarts && bStarts) return 1;
				return 0;
			});
		}
	});

	$('form').on('reset', function () {
		// Wait a tiny bit for the form to actually reset its elements
		setTimeout(function () {
			$('.select2').val(null).trigger('change'); // clear the select2
		}, 0);
	});

</script>
