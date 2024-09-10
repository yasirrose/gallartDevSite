<!---
<script type="text/javascript">
	getLname = function(){
		   var s = ColdFusion.getElementValue('searchLname');
		   return s;
		}
	getEmail = function(){
		   var s = ColdFusion.getElementValue('searchEmail');
		   return s;
		}
	getEventTitle = function(){
		   var s = ColdFusion.getElementValue('searchEventTitle');
		   return s;
		}
	getFromDate = function(){
		   var s = ColdFusion.getElementValue('searchFromDate');
		   return s;
		}
	getToDate = function(){
		   var s = ColdFusion.getElementValue('searchToDate');
		   return s;
		}


  function doEdit(type) {

      var edit = new model.registrations();
      edit.setForm("editForm");

      if (type == 'edit'){

       if ( edit.editRegistrationsFromForm()) {
           ColdFusion.Grid.refresh('data',true);
		   //populateFirstRow();
       }
       else { alert( 'There was a problem in the processing.')}
        }
	 else if (type == 'delete'){
		document.getElementById('other_artist').value = '';
	     if ( edit.deleteRegistration()) {
            ColdFusion.Grid.refresh('data',true);
        }
        else { alert( 'There was a problem in the processing.')}
	    }
	document.getElementById('edit').value = 'Edit';
  	document.getElementById('delete').style.display = '';
  }

function init(){
 	registrationGrid = ColdFusion.Grid.getGridObject("data");
  	var ds = registrationGrid.getDataSource();
	var frm = document.forms["editForm"];
 	registrationGrid.on('rowclick',function(registrationGrid, rowIndex, record){
 	});
	ds.on('load',function(){clearSearch()});
 }
 function clearSearch() {
 	document.gridForm.searchLname.value = '';
	document.gridForm.searchEmail.value = '';
	document.gridForm.searchEventTitle.value = '';
	document.gridForm.searchFromDate.value = '';
	document.gridForm.searchToDate.value = '';
 }

</script>
<cfajaxproxy cfc="model.events" /> --->
<cfajaxproxy cfc="admin.models.events" />
<cfajaxproxy bind="javascript:gridChange({data.pk_event_registration})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/events.registrations.js.cfm" language="JavaScript"></script>'>

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
						<strong>Event Name:</strong>
					</td>
					<td>
						<cfinput name="searchEventTitle" size="30" />
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
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.events.getRegistrations({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail},{searchEventTitle},{searchFromDate},{searchToDate})">
						    <cfgridcolumn name="fname" header="First Name" width="75">
							<cfgridcolumn name="lname" header="Last Name" width="75">
							<cfgridcolumn name="email" header="Email" width="110">
							<cfgridcolumn name="event_title" header="Event" width="175">
							<cfgridcolumn name="regdate" header="Date" width="150">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<!--- <input type="button" value="New" onclick="showNew()"> --->
			<cfform name="editForm">
			<cfinput type="hidden" name="pk_event_registration" id="pk_event_registration" bind="{data.pk_event_registration}">
			<table border = "0" width = "500" cellpadding = "1" cellspacing = "0" bgcolor="eeeeee">
				<tr>
					<td>
						<table border = "0" width = "100%" cellpadding = "3" cellspacing = "0">
							<tr>
								<td width="130" style="font-size: 10px;">
									Event:
								</td>
								<td>
									<cfinput type="text" name="event_title" id="event_title"  bind="{data.event_title}" size="50" disabled="true" class="displayInput">
								</td>
							</tr>
							<tr>
								<td width="130" style="font-size: 10px;">
									First Name:
								</td>
								<td>
									<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Last Name:
								</td>
								<td>
									<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Address 1
								</td>
								<td>
									<cfinput type="text" name="address1" id="address1"  bind="{data.address1}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Address 2
								</td>
								<td>
									<cfinput type="text" name="address2" id="address2"  bind="{data.address2}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									City
								</td>
								<td>
									<cfinput type="text" name="city" id="city"  bind="{data.city}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									State
								</td>
								<td>
									<cfinput type="text" name="state" id="state"  bind="{data.state}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Zipcode
								</td>
								<td>
									<cfinput type="text" name="zip" id="zip"  bind="{data.zip}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Country
								</td>
								<td>
									<cfinput type="text" name="country" id="country"  bind="{data.country}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Primary Phone
								</td>
								<td>
									<cfinput type="text" name="primary_phone" id="primary_phone"  bind="{data.primary_phone}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Secondary Phone
								</td>
								<td>
									<cfinput type="text" name="secondary_phone" id="secondary_phone"  bind="{data.secondary_phone}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Email:
								</td>
								<td>
									<cfinput type="text" name="email" id="email"  bind="{data.email}" size="50">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Artist Interested In:
								</td>
								<td>
									<cfinput type="text" name="art_interested" id="art_interested"  bind="{data.art_interested}" size="50"  />
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" valign="top">
									Other Artist Not Listed:
								</td>
								<td>
									<cfinput type="text" name="other_artist" id="other_artist"  bind="{data.other_artist}" size="50"  />
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Consignment Form:
								</td>
								<td>
									<cfinput type="Checkbox" name="consignment_form" id="consignment_form" value="1">
									<input type="Hidden" name="consignment_form">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Number of People in Party:
								</td>
								<td>
									<cfinput type="text" name="number_people" id="number_people"  bind="{data.number_people}" size="25">
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
