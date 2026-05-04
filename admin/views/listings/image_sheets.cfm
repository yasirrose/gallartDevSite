<style>
	@media screen {.PrintOnly {display:none; padding: 0px;}}
	@media print {.ScreenOnly {display:none}}
</style>
<cfajaxproxy cfc="admin.models.art" />
<cfhtmlhead text='

	<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

	<script type="text/javascript" src="/admin/scripts/listings.js.cfm" language="JavaScript"></script>
'>
<div class="ScreenOnly">
	<table width="100%" border="0">
		<tr>
			<td>
				<cfform name="imageSheetForm">
					<table width="500" border="0" class="editBox" style="margin-left: 25px; margin-top: 10px;">
						<tr>
							<td style="font-size: 10px;">
								<strong>Artist:</strong>
							</td>
							<td>
								<select name="artist" id="artist" class="select2" >
									<option value="">Please Select
									<cfoutput query="getAllArtists" group="manufacturer">
										<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
											<option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#
										</cfif>
									</cfoutput>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								Gallery Only: <cfinput type="checkbox" name="gallery_only" value="1" checked="checked" />
							</td>
						</tr>
						<tr>
							<td style="font-size: 10px;">
								Active/Inactive:
							</td >
							<td style="font-size: 10px;">
								<input type="radio" name="active" value="1" checked="checked">Active
								<input type="radio" name="active" value="0">Inactive
								<input type="radio" name="active" value="">All
							</td>

						</tr>
						<tr>
							<td colspan="2">
								<cfinput type="button" name="btnAction" value="Print Image Sheet" onClick="javascript:printImageSheet();">
							</td>
						</tr>
					</table>
				</cfform>
				<div id="imgSheetRecordcount"></div>
			</td>
		</tr>
	</table>
</div>
<div id="displaySheet" class="PrintOnly"></div>

<style>
	.PrintOnly {
		display: block !important;
		page-break-inside: avoid;
		overflow: visible !important;
	}

	body{
		overflow: visible !important;
	}

	@media screen {
		.PrintOnly {
			display: none;
		}
	}

	@media print {
		.PrintOnly {
			display: block !important;
		}
	}
</style>

<script>
	$(document).ready(function () {
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
	});
</script>
