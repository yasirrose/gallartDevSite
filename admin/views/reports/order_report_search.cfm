<cfhtmlhead text='

	<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

	
'>
<cfform method="post" action="index.cfm?event=reports.orderReportResults">
	<table cellspacing="0" cellpadding="2" border="0" width="50%" class="editBox" style="margin-top: 20px; margin-right: auto; width: max-content; margin-left: 100px;">
		<tr>
			<td><strong>REPORT SEARCH:</strong></td>
		</tr>
		<tr>
			<td valign="top">
				<table cellspacing="0" cellpadding="4" border="0" width="400">
					<tr>
						<td colspan="2">
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td width="106" style="font-size: 10px;">
										<strong>Date Range from:</strong>
									</td>
									<td width="100">
										<cfinput name="FromDate" type="datefield" validate="date" size="10" />
									</td>
									<td width="25" style="font-size: 10px;">
										<strong>to:</strong>
									</td>
									<td nowrap>
										<cfinput name="ToDate" type="datefield" validate="date" size="10" />
									</td>
								</tr>
							</table>					
						</td>
					</tr>
					<tr>
						<td colspan="2">
							Or choose from the following:
						</td>
					</tr>
					<tr>
						<td colspan="2" style="font-size: 10px;">
							
							<strong>
								<input type="Radio" name="previous" value="wednesday" >Previous Wednesday to Wednesday<br>
								<input type="Radio" name="previous" value="week">Previous Week<br>
								<input type="Radio" name="previous" value="month">Previous Month<br>
								<input type="Radio" name="previous" value="year">Previous Year
							</strong>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<strong>Employee:</strong>&nbsp;
							<select name="employeeId" class="select2">
								<option value="">All
								<cfoutput query="getAllEmployees">
									<option value="#pk_employees#">#emp_lname#, #emp_fname#
								</cfoutput>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 10px;">
				<input type="Reset" value="Reset"><input type="Submit" value="Create Report">
			</td>
		</tr>
	</table>
</cfform>

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