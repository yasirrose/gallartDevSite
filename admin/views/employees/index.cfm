<cfajaxproxy cfc="admin.models.employees" />
<cfajaxproxy bind="javascript:gridChange({data.pk_employees})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/employees.js.cfm" language="JavaScript"></script>'>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr>
<td valign="top">
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
    	<td colspan="2" style="font-size: 11px;"><strong>SEARCH BY:</strong></td>
  	</tr>
	<tr>
		<td valign="top" width="400">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr>
					<td align="right">
						<strong>Last Name:</strong>
					</td>
					<td>
						<cfinput name="searchLname" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Email:</strong>
					</td>
					<td>
						<cfinput name="searchEmail" size="30" />

					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.employees.getEmployees({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail})">
							<cfgridcolumn name="emp_fname" header="First Name" width="100">
							<cfgridcolumn name="emp_lname" header="Last Name" width="100">
							<cfgridcolumn name="emp_email" header="Email" width="175">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<cfif session.userinfo.sa EQ 1>
			<input type="button" value="New" onclick="showNew()">
			</cfif>
			<cfform name="editForm">
			<cfinput type="hidden" name="pk_employees" id="pk_employees" bind="{data.pk_employees}">
			<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
				<tr>
					<td id="stuff" colspan="2"></td>
				</tr>
				<tr>
					<td width="100">
						First Name:
					</td>
					<td>
						<cfinput type="text" name="emp_fname" id="emp_fname"  bind="{data.emp_fname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Last Name:
					</td>
					<td>
						<cfinput type="text" name="emp_lname" id="emp_lname"  bind="{data.emp_lname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Email:
					</td>
					<td>
						<cfinput type="text" name="emp_email" id="emp_email"  bind="{data.emp_email}" size="30">&nbsp;
						<span  id="emailLink"></span>
					</td>
				</tr>
				<tr>
					<td>
						Phone:
					</td>
					<td>
						<cfinput type="text" name="emp_phone" id="emp_phone"  bind="{data.emp_phone}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Password:
					</td>
					<td>
						<cfinput type="text" name="password" id="password"  bind="{data.password}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top">
						Roles:
					</td>
					<td>
						<cfoutput>
							<cfloop query="getRoles">
								<cfinput type="Checkbox" name="roles" id="roles" value="#pk_roles#">#role#<br>
							</cfloop>
						</cfoutput>
					</td>
				</tr>
				<cfif session.userinfo.sa EQ 1>
				<tr>
					<td colspan="2">
						<strong>COMMISSION</strong>
					</td>
				</tr>
				<tr>
					<td>
						Minus amount (from total sales):
					</td>
					<td>
						$<cfinput type="text" name="commission_minus" id="commission_minus"  bind="{data.commission_minus}" size="30" validate="float" message="You must enter a dollar amount for the minus amount - no $ or ,">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Percentage:
					</td>
					<td>
						<cfinput type="text" name="commission_percent" id="commission_percent"  bind="{data.commission_percent}" size="30" validate="integer" message="You must enter an integer for the commission.">&nbsp;
					</td>
				</tr>
				<cfelse>
				<cfinput type="hidden" name="commission_minus"  bind="{data.commission_minus}">
				<cfinput type="hidden" name="commission_percent"  bind="{data.commission_percent}">
				</cfif>
				<tr>
					<td colspan="2" >
						<cfinput type="button" name="edit" id="edit" value="Edit" onclick="doEdit('edit');" />
						<cfinput type="button" name="delete" id="delete" value="Delete" onclick="if (confirm('DELETE -- ARE YOU SURE?')){ doEdit('delete');}" />
					</td>
				</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>
<!--- <cfset ajaxOnLoad("init")> --->
