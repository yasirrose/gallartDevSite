<cfparam name="fromDate" default="">
<cfparam name="toDate" default="">

<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/leads.js.cfm" language="JavaScript"></script>'>
<script language="javascript" src="../js/jquery-1.3.2.js"></script>
<script type="text/javascript">
	function exportLeads(){
		$('#leadExport').attr('src','index.cfm?event=exports.exportLeads');
	}
</script>
<cfajaxproxy cfc="admin.models.leads" />

<table border="0" cellpadding="0" cellspacing="0" width="1000" height="100%">
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
								<td align="right" style="font-size: 10px;">
									<strong>Employee:</strong>
								</td>
								<td>
									<cfselect query="getEmployees" name="searchEmployeeId" display="emp_name" value="pk_employees" selected="#form.searchEmployeeId#" queryPosition="below">
										<option value="">All</option>
									</cfselect>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="right" style="font-size: 10px;">
									<strong>Comments entered:</strong>
								</td>
								<td>
									<select name="searchComments">
										<option value="">All</option>
										<option value="1">Yes</option>
										<option value="0">No</option>
									</select>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="right" style="font-size: 10px;">
									<strong>Keyword search:</strong><br>
									(Searches artists, titles and notes)
								</td>
								<td>
									<cfinput type="text" name="searchKeywords" size="30" />
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="right" style="font-size: 10px;">
									<strong>Date from:</strong>
								</td>
								<td nowrap>
									<cfinput name="searchFromDate" type="datefield" validate="date" size="10" />
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="right" style="font-size: 10px;">
									<strong>Date to:</strong>
								</td>
								<td nowrap>
									<cfinput name="searchToDate" type="datefield" validate="date" size="10" />
								</td>
								<td>
									<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('leadGrid', false);" />
								</td>
							</tr>
                            <tr>
                            	<td colspan="3">
                                	<input type="button" value="Export All Leads" onclick="exportLeads()" />
									<input type="button" value="Export Filtered Leads" onclick="document.getElementById('createXls').src='views/exports/create_lead_xls.cfm'" />
                                </td>
                            </tr>
							<tr>
								<td colspan="3">
									<cfgrid format="html" name="leadGrid" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.leads.getLeads({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchFname},{searchLname},{searchEmail},{searchAreacode},{searchCity},{searchState},{searchEmployeeId},{searchComments},{searchFromDate},{searchToDate},{searchKeywords})">
									    <cfgridcolumn name="fname" header="First Name" width="80">
										<cfgridcolumn name="lname" header="Last Name" width="80">
										<cfgridcolumn name="leadEmail" header="Email" width="175">
										<cfgridcolumn name="leadDate" header="Date" width="80">
									</cfgrid>
								</td>
							</tr>
						</table>
						</cfform>
					</td>
					<td valign="top">
						<input type="button" value="New" onclick="showNew()">
						<cfform name="editForm">
						<cfinput type="hidden" name="pk_leads" id="pk_leads" bind="{leadGrid.pk_leads}">
						<table border = "0" width = "550" cellpadding = "5" cellspacing = "0" class="editBox">
							<cfif session.loggedin EQ true AND session.userinfo.sa EQ 1>
							<tr>
								<td width="150" class="title">
									<strong>EMPLOYEE:</strong>
								</td>
								<td>
									<cfoutput>
									<select name="fk_employees" id="fk_employees" style="font-size: 8pt;">
										<option value="0">Unassigned
										<cfloop query="getEmployees">
											<option value="#pk_employees#">#emp_lname#, #emp_fname#

									</cfloop></select>
									</cfoutput>
									<span  id="empDisplay" style="display: none;"></span>
								</td>
							</tr>
							<cfelse>
							<tr>
								<td width="150" class="title">
									<strong>EMPLOYEE:</strong>
								</td>
								<td>
									<span  id="empDisplay"></span>
									<cfinput type="hidden" name="fk_employees" id="fk_employees" bind="{leadGrid.fk_employees}">
								</td>
							</tr>
							</cfif>
							<tr>
								<td width="100" style="font-size: 10px;">
									First Name:
								</td>
								<td>
									<cfinput type="text" name="fname" id="fname"  bind="{leadGrid.fname}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Last Name:
								</td>
								<td>
									<cfinput type="text" name="lname" id="lname"  bind="{leadGrid.lname}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Email:
								</td>
								<td>
									<cfinput type="text" name="leadEmail" id="leadEmail"  bind="{leadGrid.leadEmail}" size="30">&nbsp;
									<input type="Button" id="emailButton" value="Send Email To Lead" onclick="openLeadEmailWindow();" />
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Cell Phone:
								</td>
								<td>
									<cfinput type="text" name="cellphone" id="cellphone"  bind="{leadGrid.cellphone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the cell phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Home Phone:
								</td>
								<td>
									<cfinput type="text" name="phone" id="phone"  bind="{leadGrid.phone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Business Phone:
								</td>
								<td>
									<cfinput type="text" name="businessphone" id="businessphone"  bind="{leadGrid.businessphone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the business phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Phone Outside the US:
								</td>
								<td>
									<cfinput type="text" name="otherphone" id="otherphone"  bind="{leadGrid.otherphone}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Best Time To Call:
								</td>
								<td>
									<cfinput type="text" name="besttime" id="besttime"  bind="{leadGrid.besttime}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Address:
								</td>
								<td>
									<cfinput type="text" name="address" id="address"  bind="{leadGrid.address}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									City:
								</td>
								<td>
									<cfinput type="text" name="city" id="city"  bind="{leadGrid.city}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									State:
								</td>
								<td>
									<cfinput type="text" name="state" id="state"  bind="{leadGrid.state}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Country:
								</td>
								<td>
									<cfinput type="text" name="country" id="country"  bind="{leadGrid.country}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Zip Code:
								</td>
								<td>
									<cfinput type="text" name="zip" id="zip"  bind="{leadGrid.zip}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Company:
								</td>
								<td>
									<cfinput type="text" name="company" id="company"  bind="{leadGrid.company}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Website:
								</td>
								<td>
									<cfinput type="text" name="website" id="website"  bind="{leadGrid.website}" size="30">
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Artists:
								</td>
								<td>
									<cftextarea name="theartists" cols="40" rows="3"  bind="{leadGrid.artists}"></cftextarea>
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Titles:
								</td>
								<td>
									<cftextarea name="titles" cols="40" rows="3"  bind="{leadGrid.titles}"></cftextarea>
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Notes:
								</td>
								<td>
									<cftextarea name="notes" cols="40" rows="10" bind="{leadGrid.notes}"></cftextarea>
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Orign:
								</td>
								<td>
									<cfset originValues = "WALK-IN,WEBSITE,PHONE,OTHER" />
									<cfoutput>
									<select name="origin" id="origin">
										<option value="">Please Select</option>
										<cfloop list="#originValues#" index="idx">
											<option value="#idx#">#idx#</option>
										</cfloop>
									</select>
									</cfoutput>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Mail list:
								</td>
								<td>
									<input type="Checkbox" name="maillist" id="maillist" value="1">
									<input type="hidden" name="maillist" value="">
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<cfinput type="button" name="edit" id="edit" value="Edit" onclick="doEdit('edit');" />
									<cfif session.loggedin EQ true AND session.userinfo.sa EQ 1>
										<cfinput type="button" name="delete" id="delete" value="Delete" onclick="if (confirm('DELETE -- ARE YOU SURE?')){ doEdit('delete');}" />
									</cfif>
								</td>
							</tr>
						</table>
						</cfform>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<div>
<!--- <cfoutput>
<form method="post" action="" name="assignLeadForm">
	<input type="text" name="assignLeadId" id="assignLeadId">
	<input type="text" name="assignEmpId" id="assignEmpId" value="#session.userinfo.pk_employees#">
</form>
</cfoutput> --->
<cfwindow name="leadEmailWindow" center="true" modal="true" resizable="false" closable="true" title="Send Email To Lead" width="650" height="550" headerStyle="background-color:##dd3a7d;">

	<!--- <cfoutput>

	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="##ffffff">
		<cfform method="post" action="" name="emailLeadForm"  onsubmit="submitLeadEmailInfo(); return false;">
		<input type="hidden" name="sender" id="sender" value="#session.userinfo.email#">
		<input type="hidden" name="senderFname" id="senderFname" value="#session.userinfo.fname#">
		<input type="hidden" name="senderLname" id="senderLname" value="#session.userinfo.lname#">
		<input type="hidden" name="currEmpId" id="currEmpId" value="#session.userinfo.pk_employees#">
		<input type="hidden" name="recipient" id="recipient">
		<input type="hidden" name="salutation" id="salutation" />
		<input type="hidden" name="closer" id="closer" />
		<!--<input type="hidden" name="body" id="body">-->
		<tr>
			<td style="font-family: Arial; font-size: 12px; width: 75px;">
				Subject:&nbsp;&nbsp;
			</td>
			<td>
				<input type="Text" name="subject" value="Gallart - Response To Your Inquiry" size="50">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<!--<textarea name="bodyContent" id="bodyContent" cols="65" rows="12" onkeyup="compileBody( this.value );"></textarea>-->
				<cftextarea name="body" id="body" height="300" width="600" richtext="yes" toolbar="Basic" />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-family: Arial; font-size: 12px;">
				Sincerely,<br><br>
				#session.userinfo.fname# #session.userinfo.lname#<br>
				Gallery Art<br>
				20633 Biscayne Blvd<br>
				Aventura FL 33180<br>
				305 932 6166 gallery<br>
				305 937 2125 fax<br>

			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
				<input type="Submit" value="SEND EMAIL" />
			</td>
		</tr>
		</cfform>
	</table>

	</cfoutput> --->
</cfwindow>
<cfwindow name="alreadyAssignedWindow" center="true" modal="true" resizable="false" closable="true" title="Already Assigned" width="600" height="400" headerStyle="background-color:##dd3a7d;">

		<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr>
				<td id="assignedTo" style="padding: 25px; font-size: 12px; font-weight: bold;">ALREADY ASSIGNED</td>
			</tr>
		</table>

</cfwindow>
</div>

<iframe id="leadExport" src="" frameborder="0"></iframe>
<iframe id="createXls" src="" frameborder="0"></iframe>

<cfset ajaxOnLoad("init")>
