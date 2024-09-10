<cfajaxproxy cfc="admin.models.customers" />
<cfajaxproxy bind="javascript:gridChange({data.id})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/customers.js.cfm" language="JavaScript"></script>'>
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
						<strong>First Name:</strong>
					</td>
					<td>
						<cfinput name="searchFname" id="searchFname" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
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
					<td align="right">
						<strong>Area Code:</strong>
					</td>
					<td>
						<cfinput name="searchAreacode" size="30" />

					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>City:</strong>
					</td>
					<td>
						<cfinput name="searchCity" size="30" />

					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>State:</strong>
					</td>
					<td>
						<select name="searchState">
							<option value="">Please Select</option>
							<cfoutput query="getStates">
								<option value="#stateAbb#">#state#</option>
							</cfoutput>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" /><input type="Button" value="Create Excel File" onclick="document.getElementById('createXls').src='views/exports/create_customer_xls.cfm'">
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.customers.getCustomers({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchFname},{searchLname},{searchEmail},{searchAreacode},{searchCity},{searchState})">
							<cfgridcolumn name="fname" header="First Name" width="100">
							<cfgridcolumn name="lname" header="Last Name" width="100">
							<cfgridcolumn name="customer_email" header="Email" width="175">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<cfform name="editForm">
			<cfinput type="hidden" name="id" id="id" bind="{data.id}">
			<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
				<tr>
					<td id="stuff" colspan="2"></td>
				</tr>
				<tr>
					<td width="100">
						First Name:
					</td>
					<td>
						<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Last Name:
					</td>
					<td>
						<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Email:
					</td>
					<td>
						<cfinput type="text" name="customer_email" id="customer_email"  bind="{data.customer_email}" size="30">&nbsp;
						<span  id="emailLink"></span>
					</td>
				</tr>
				<tr>
					<td>
						Phone:
					</td>
					<td>
						<cfinput type="text" name="Phone" id="Phone"  bind="{data.Phone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home phone number in the format (xxx) xxx-xxxx">&nbsp;(xxx) xxx-xxxx
					</td>
				</tr>
				<tr>
					<td>
						Cell Phone:
					</td>
					<td>
						<cfinput type="text" name="CellPhone" id="CellPhone"  bind="{data.cellphone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the cell phone number in the format (xxx) xxx-xxxx">&nbsp;(xxx) xxx-xxxx
					</td>
				</tr>
				<tr>
					<td>
						Work Phone:
					</td>
					<td>
						<cfinput type="text" name="WorkPhone" id="WorkPhone"  bind="{data.businessphone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the business phone number in the format (xxx) xxx-xxxx">&nbsp;(xxx) xxx-xxxx
					</td>
				</tr>
				<tr>
					<td>
						Phone Outside the US:
					</td>
					<td>
						<cfinput type="text" name="OtherPhone" id="OtherPhone"  bind="{data.otherphone}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top">
						Address:
					</td>
					<td>
						<cfinput type="text" name="Address1" id="Address1"  bind="{data.Address1}" size="30"><br>
						<cfinput type="text" name="Address2" id="Address2"  bind="{data.Address2}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						City, State, Zip:
					</td>
					<td>
						<cfinput type="text" name="City" id="City"  bind="{data.City}" size="25">&nbsp;<cfinput type="text" name="State" id="State"  bind="{data.State}" size="15">&nbsp;<cfinput type="text" name="Zip" id="Zip"  bind="{data.Zip}" size="10">
					</td>
				</tr>
				<tr>
					<td>
						Country:
					</td>
					<td>
						<cfinput type="text" name="Country" id="Country"  bind="{data.Country}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top">
						Shipping Address:
					</td>
					<td>
						<cfinput type="text" name="saddress1" id="saddress1"  bind="{data.saddress1}" size="30"><br>
						<cfinput type="text" name="saddress2" id="saddress2"  bind="{data.saddress2}" size="30"><br>
					</td>
				</tr>
				<tr>
					<td>
						City, State, Zip:
					</td>
					<td>
						<cfinput type="text" name="scity" id="scity"  bind="{data.scity}" size="25">&nbsp;<cfinput type="text" name="sstate" id="sstate"  bind="{data.sstate}" size="15">&nbsp;<cfinput type="text" name="szip" id="szip"  bind="{data.szip}" size="10">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Fax:
					</td>
					<td>
						<cfinput type="text" name="Fax" id="Fax"  bind="{data.Fax}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Drivers License Number:
					</td>
					<td>
						<cfinput type="text" name="DriversLicense" id="DriversLicense"  bind="{data.DriversLicense}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						On Mailing List:
					</td>
					<td>
						<input type="radio" name="maillist" value="1">Yes&nbsp;&nbsp;<input type="radio" name="maillist" value="0">No
					</td>
				</tr>
				<tr>
					<td>
						Opt Out Date:
					</td>
					<td>
						<cfinput type="text" name="optout" id="optout"  bind="{data.optout}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Comments:
					</td>
					<td>
						<cftextarea  name="comments"  id="comments"  bind="{data.comments}" />
					</td>
				</tr>
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
<iframe id="createXls" src="" frameborder="0"></iframe>
<!--- <cfset ajaxOnLoad("init")> --->
