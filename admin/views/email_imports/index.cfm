<cfajaxproxy cfc="admin.models.email_imports" />
<cfajaxproxy bind="javascript:gridChange({data.pk_email_imports})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/email_imports.js?r=765" language="JavaScript"></script>'>

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
						<strong>Last Name:</strong>
					</td>
					<td>
						<cfinput name="searchLname" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right" style="font-size: 10px;">
						<strong>Email:</strong>
					</td>
					<td>
						<cfinput name="searchEmail" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.email_imports.getImports({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail})">
							<cfgridcolumn name="lname" header="Last Name" width="200">
							<cfgridcolumn name="email" header="Email" width="200">
							<cfgridcolumn name="pk_email_imports" header="ID" width="150">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<cfform name="editForm">
			<cfinput type="hidden" name="pk_email_imports" id="pk_email_imports" bind="{data.pk_email_imports}">
			<cfinput type="hidden" name="fk_email_imports_list" id="fk_email_imports_list" bind="{data.fk_email_imports_list}">
			<table border = "0" width = "600" cellpadding = "1" cellspacing = "0" class="editBox">
				<tr>
					<td>
						<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
							<tr>
								<td width="100" style="font-size: 10px;">
									First Name:
								</td>
								<td>
									<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Last Name:
								</td>
								<td>
									<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Email:
								</td>
								<td>
									<cfinput type="text" name="user_email" id="user_email"  bind="{data.email}" size="30">
								</td>
							</tr>
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

