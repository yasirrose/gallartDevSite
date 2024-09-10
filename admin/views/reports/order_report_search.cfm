<cfform method="post" action="index.cfm?event=reports.orderReportResults">
<table cellspacing="0" cellpadding="2" border="0" width="100%">
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
							<input type="Radio" name="previous" value="wednesday">Previous Wednesday to Wednesday<br>
							<input type="Radio" name="previous" value="week">Previous Week<br>
							<input type="Radio" name="previous" value="month">Previous Month<br>
							<input type="Radio" name="previous" value="year">Previous Year
						</strong>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<strong>Employee:</strong>&nbsp;
						<select name="employeeId">
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
