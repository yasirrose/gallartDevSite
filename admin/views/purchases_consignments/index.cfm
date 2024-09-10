<cfajaxproxy cfc="admin.models.purchases_consignments" />
<cfajaxproxy bind="javascript:gridChange({data.pk_purchases_consignments})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/purchases_consignments.js.cfm" language="JavaScript"></script>'>

<script type="text/javascript">

function validEntries(frm) {

	if(editForm.medium.value == ''){
	alert('You must select a Medium.');
	return false;
	}

}
</script>

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
						<strong>Name:</strong>
					</td>
					<td>
						<cfinput name="searchName" size="30" />
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
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.purchases_consignments.getPurchasesConsignments({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchName},{searchEmail},{searchFromDate},{searchToDate})">
						    <cfgridcolumn name="name" header="Name" width="80">
							<cfgridcolumn name="email" header="Email" width="175">
							<cfgridcolumn name="datestamp" header="Date" width="150">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<!--- <input type="button" value="New" onclick="showNew()"> --->
			<cfform name="editForm" enctype="multipart/form-data" onsubmit="return CheckEntries()">
			<cfinput type="hidden" name="pk_purchases_consignments" id="pk_purchases_consignments" bind="{data.pk_purchases_consignments}">
			<table border = "0" width = "500" cellpadding = "1" cellspacing = "0" class="editBox">
				<tr>
					<td>
						<table border = "0" width = "100%" cellpadding = "1" cellspacing = "0">
							<tr>
								<td width="100" style="font-size: 10px;">
									Name:
								</td>
								<td>
									<cfinput type="text" name="name" id="name"  bind="{data.name}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Phone
								</td>
								<td>
									<cfinput type="text" name="phone" id="phone"  bind="{data.phone}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Email:
								</td>
								<td>
									<cfinput type="text" name="customer_email" id="customer_email"  bind="{data.customer_email}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Artist
								</td>
								<td>
									<cfinput type="text" name="artist" id="artist"  bind="{data.artist}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Title
								</td>
								<td>
									<cfinput type="text" name="title" id="title"  bind="{data.title}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Medium
								</td>
								<td>
									<select name="medium" style="font-size: 8pt;">
										<option value="">Please Select
										<cfoutput query="getAllMedium">
											<option value="#path#">#ucase(path)#
										</cfoutput>
									</select>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Size
								</td>
								<td>
									<cfinput type="text" name="size" id="size"  bind="{data.size}" size="30">
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Additional Details
								</td>
								<td>
									<cftextarea name="additional_details" cols="40" rows="2" bind="{data.additional_details}" style="height: 40px;"></cftextarea>
								</td>
							</tr>
							<tr>
								<td id="imageDisplay" height="150">
									<img src="" name="mainImg" id="mainImg" border="0" width="100"  /><br>
									<a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge<br><br>
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

