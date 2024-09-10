<cfajaxproxy cfc="admin.models.appraisals" />
<cfajaxproxy bind="javascript:gridChange({data.pk_appraisal})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/appraisals.js.cfm" language="JavaScript"></script>'>

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
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.appraisals.getAppraisals({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail},{searchFromDate},{searchToDate})">
						    <cfgridcolumn name="fname" header="First Name" width="80">
							<cfgridcolumn name="lname" header="Last Name" width="80">
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
			<cfinput type="hidden" name="pk_appraisal" id="pk_appraisal" bind="{data.pk_appraisal}">
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
								<td style="font-size: 10px;">
									Last Name:
								</td>
								<td>
									<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Address
								</td>
								<td>
									<cfinput type="text" name="address" id="address"  bind="{data.address}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									City
								</td>
								<td>
									<cfinput type="text" name="city" id="city"  bind="{data.city}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									State
								</td>
								<td>
									<cfinput type="text" name="state" id="state"  bind="{data.state}" size="25">
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
									Email:
								</td>
								<td>
									<cfinput type="text" name="email" id="email"  bind="{data.email}" size="25">
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
									Best Time to Contact
								</td>
								<td>
									<cfinput type="text" name="besttime" id="besttime"  bind="{data.besttime}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Artist First Name
								</td>
								<td>
									<cfinput type="text" name="artist_fname" id="artist_fname"  bind="{data.artist_fname}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Artist Last Name
								</td>
								<td>
									<cfinput type="text" name="artist_lname" id="artist_lname"  bind="{data.artist_lname}" size="25">
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
									Year
								</td>
								<td>
									<cfinput type="text" name="year" id="year"  bind="{data.year}" size="25">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Edition Number if Applicable
								</td>
								<td>
									<cfinput type="text" name="edition" id="edition"  bind="{data.edition}" size="25">
								</td>
							</tr>
						</table>
					</td>
					<td valign="top" style="font-size: 10px;">
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td id="imageDisplay" height="150">
									<img src="" name="mainImg" id="mainImg" border="0" width="100"  /><br>
									<a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge<br><br>
								</td>
							</tr>
							<!--- can't upload image using ajax --->
							<!--- <tr>
								<td>
									Upload New:&nbsp;<input type="File" name="thisImage" id="thisImage" />
								</td>
							</tr> --->
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table border = "0" width = "100%" cellpadding = "1" cellspacing = "0">
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
								<td valign="top">
									&nbsp;
								</td>
								<td>
									<table cellspacing="0" cellpadding="3" border="0" width="100%">
										<tr>
											<td style="font-size: 10px;">
												<cfinput type="Radio" name="ground" value="Paper">Paper
											</td>
										</tr>
										<tr>
											<td style="font-size: 10px;">
												<cfinput type="Radio" name="ground" value="Canvas">Canvas
											</td>
										</tr>
										<tr>
											<td style="font-size: 10px;">
												<cfinput type="Radio" name="ground" value="Board">Board
											</td>
										</tr>
										<tr>
											<td style="font-size: 10px;">
												<cfinput type="Radio" name="ground" value="Other">Other:&nbsp;&nbsp;<cfinput type="Text" name="groundOther" id="groundOther" bind="{data.groundOther}" size="25" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Size (Unframed)
								</td>
								<td>
									<cfinput type="text" name="size_unframed" id="size_unframed"  bind="{data.size_unframed}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Size with Frame(if necessary)
								</td>
								<td>
									<cfinput type="text" name="size_with_frame" id="size_with_frame"  bind="{data.size_with_frame}" size="30">
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									Condition
								</td>
								<td>
									<cfinput type="text" name="condition" id="condition"  bind="{data.condition}" size="30">
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Signature
								</td>
								<td>
									<cftextarea name="signature" cols="40" rows="2" bind="{data.signature}" style="height: 40px;"></cftextarea>
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Description
								</td>
								<td>
									<cftextarea name="description" cols="40" rows="2" bind="{data.description}" style="height: 40px;"></cftextarea>
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Reason For Appraisal
								</td>
								<td style="font-size: 10px;">
									<cfinput type="Checkbox" name="reason" id="reason" value="Personal">Personal<br>
									<cfinput type="Checkbox" name="reason" id="reason" value="Retail Replacement">Retail Replacement<br>
									<cfinput type="Checkbox" name="reason" id="reason" value="Wholesale Replacement">Wholesale Replacement<br>
									<cfinput type="Checkbox" name="reason" id="reason" value="Estimate range of sale price within 30 days">Estimate range of sale price within 30 days<br>
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Purchased From
								</td>
								<td valign="top">
									<cfinput type="text" name="purchased_from" id="purchased_from"  bind="{data.purchased_from}" size="30">
								</td>
							</tr>
							<tr>
								<td valign="top" style="font-size: 10px;">
									Past Appraisals Given
								</td>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td style="font-size: 10px;">
												From Where:
											</td>
											<td>
												<cfinput type="text" name="appraisal_where" id="appraisal_where"  bind="{data.appraisal_where}" size="30">
											</td>
										</tr>
										<tr>
											<td style="font-size: 10px;">
												Year:
											</td>
											<td>
												<cfinput type="text" name="appraisal_year" id="appraisal_year"  bind="{data.appraisal_year}" size="30">
											</td>
										</tr>
										<tr>
											<td style="font-size: 10px;">
												Amount:
											</td>
											<td>
												<cfinput type="text" name="appraisal_amount" id="appraisal_amount"  bind="{data.appraisal_amount}" size="30">
											</td>
										</tr>
									</table>
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

