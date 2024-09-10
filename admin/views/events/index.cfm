<cfajaxproxy cfc="admin.models.events" />
<cfajaxproxy bind="javascript:gridChange({data.pk_event_registration_title})"> 
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/events.js.cfm" language="JavaScript"></script>'>
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
    	<td colspan="2" style="font-size: 11px;"><strong>EVENTS:</strong></td>
  	</tr>
	<tr>
		<td valign="top" width="500">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.events.getEvents({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
						    <cfgridcolumn name="event_title" header="Title" width="225">
							<cfgridcolumn name="event_date" header="Date" width="125">
							<cfgridcolumn name="event_location" header="Location" width="150">
							<cfgridcolumn name="isCurrent" header="Current" width="75">
							<cfgridcolumn name="datestamp" header="Created" width="125">
						</cfgrid>
					</td>
				</tr>
			</table>										
			</cfform>
		</td>
		<td valign="top">
			<input type="button" value="New" onclick="showNew()">
			<cfform name="editForm">
			<cfinput type="hidden" name="pk_event_registration_title" id="pk_event_registration_title" bind="{data.pk_event_registration_title}">
			<table border = "0" width = "500" cellpadding = "1" cellspacing = "0" bgcolor="eeeeee">
				<tr>
					<td>
						<table border = "0" width = "100%" cellpadding = "3" cellspacing = "0">
							<tr>
								<td width="130" style="font-size: 10px;">
									Title:
								</td>
								<td>
									<cfinput type="text" name="event_title" id="event_title"  bind="{data.event_title}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Date:
								</td>
								<td>
									<cfinput type="datefield" name="event_date" id="event_date"  bind="{data.event_date}" size="50" validate="date">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Location:
								</td>
								<td>
									<cfinput type="text" name="event_location" id="event_location"  bind="{data.event_location}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Current:
								</td>
								<td>
									<cfinput type="Checkbox" name="isCurrent" id="isCurrent" value="1">
									<input type="Hidden" name="isCurrent">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Created:
								</td>
								<td>
									<cfinput type="text" name="datestamp" id="datestamp"  bind="{data.datestamp}" size="50" disabled="true" class="displayInput">
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


