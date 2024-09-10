<cfajaxproxy cfc="admin.models.requests" />
<cfajaxproxy bind="javascript:gridChange({data.pk_requests})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/requests.js.cfm" language="JavaScript"></script>'>

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
					<td align="right" style="font-size: 10px;">
						<strong>Title:</strong>
					</td>
					<td>
						<cfinput name="searchTitle" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right" style="font-size: 10px;">
						<strong>Artist:</strong>
					</td>
					<td>
						<cfinput name="searchArtist" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right" style="font-size: 10px;">
						Status
					</td>
					<td>
						<select name="searchStatus">
							<option value="">All
							<cfoutput query="getRequestStatus">
							<option value="#pk_request_status#">#status_name#
							</cfoutput>
						</select>
					</td>
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
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.requests.getRequests({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail},{searchTitle},{searchArtist},{searchStatus},{searchFromDate},{searchToDate})">
							<cfgridcolumn name="title" header="Title" width="150">
						    <cfgridcolumn name="artist" header="Artist" width="100">
							<cfgridcolumn name="lname" header="Requested By" width="120">
							<cfgridcolumn name="req_email" header="Email" width="150">
							<cfgridcolumn name="requestDate" header="Date" width="75">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<cfform name="editForm">
			<cfinput type="hidden" name="pk_requests" id="pk_requests" bind="{data.pk_requests}">
			<table border = "0" width = "600" cellpadding = "1" cellspacing = "0" class="editBox">
				<tr>
					<td>
						<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
							<tr>
								<td width="100" style="font-size: 10px;">
									First Name:
								</td>
								<td>
									<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" size="30" class="displayInput" disabled>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Last Name:
								</td>
								<td>
									<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="30" class="displayInput" disabled>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Email:
								</td>
								<td>
									<cfinput type="text" name="req_email" id="req_email"  bind="{data.req_email}" size="30" class="displayInput" disabled>
									<span  id="emailLink"></span>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Phone
								</td>
								<td>
									<cfinput type="text" name="phone" id="phone"  bind="{data.phone}" size="30" class="displayInput" disabled>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Title
								</td>
								<td>
									<cfinput type="text" name="title" id="title"  bind="{data.title}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Artist
								</td>
								<td>
									<cfinput type="text" name="artist" id="artist"  bind="{data.artist}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Responses
								</td>
								<td id="responses">

								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Status
								</td>
								<td>
									<select name="fk_request_status">
										<cfoutput query="getRequestStatus">
										<option value="#pk_request_status#">#status_name#
										</cfoutput>
									</select>
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

