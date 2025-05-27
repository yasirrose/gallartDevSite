<cfajaxproxy cfc="admin.models.purchases_consignments" />
<cfajaxproxy bind="javascript:gridChange({data.pk_purchases_consignments})">

<cfhtmlhead text='
    <script type="text/javascript" src="/admin/scripts/purchases_consignments.js.cfm" language="JavaScript"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
'>
</cfhtmlhead>

<script type="text/javascript">

function validEntries(frm) {

	if(editForm.medium.value == ''){
	alert('You must select a Medium.');
	return false;
	}

}
</script>

<style>

	#imageDisplay {
		display: flex;
		align-items: center;
		flex-wrap: wrap;
	}
	#imageDisplay .image-container {
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
		margin: 6px;
		gap: 6px;
	}
</style>

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
						    <!--- <cfgridcolumn name="name" header="Name" width="80"> --->
						    <cfgridcolumn name="user_name" header="Name" width="200">
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
									First Name:
								</td>
								<td>
									<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" size="25">
								</td>
							</tr>
							<tr>
								<td width="100" style="font-size: 10px;">
									Last Name:
								</td>
								<td>
									<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="25">
								</td>
							</tr>
							<tr>
								<td width="100" style="font-size: 10px;">
									Name:
								</td>
								<td>
									<cfinput type="text" name="name" id="name"  bind="{data.user_name}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Phone:
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
									Artist:
								</td>
								<td>
									<cfinput type="text" name="artist" id="artist"  bind="{data.artist}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Title:
								</td>
								<td>
									<cfinput type="text" name="title" id="title"  bind="{data.title}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Medium:
								</td>
								<td>
									<select name="medium" style="font-size: 8pt;">
										<option value="">Please Select
										<cfoutput query="getAllMedium">
											<option value="#path#">#path#
										</cfoutput>
									</select>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Price:
								</td>
								<td>
									<cfinput type="text" name="size" id="size"  bind="{data.size}" size="30">
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px; white-space: nowrap;">
									Additional Details
								</td>
								<td>
									<cftextarea name="additional_details" cols="40" rows="2" bind="{data.additional_details}" style="height: 40px;"></cftextarea>
								</td>
							</tr>
							<tr>
								<td  height="150" colspan="2">
									<div id="imageDisplay">
										<div class="img-box">

											<img src="" name="mainImg" id="mainImg" border="0" width="100"  /><br>
											<a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge
										</div>
									</div>
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

