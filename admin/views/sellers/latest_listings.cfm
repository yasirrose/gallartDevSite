<cfajaxproxy cfc="admin.models.art" />
<cfajaxproxy cfc="admin.models.mailer" />
<cfajaxproxy bind="javascript:latestGridChange({data.uid})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/sellers.latestlistings.js.cfm" language="JavaScript"></script>'>

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr>
<td valign="top">
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td valign="top" width="450">
			<cfform name="gridForm">

			<table cellspacing="0" cellpadding="3" border="0" width="100%">
				<tr>
					<td colspan="3">
						<table cellspacing="0" cellpadding="3" border="0" width="100%">
							<tr>
							   	<td style="font-size: 11px;"><strong>VIEW LATEST LISTINGS:</strong></td>
								<td><strong>Show:</strong>&nbsp;
									<select name="searchActive">
										<option value="">All</option>
										<option value="1">Active Only</option>
										<option value="0">Inactive Only</option>
									</select>
								</td>
								<td><strong>Timeframe:</strong></td>
								<td>
									<select name="searchTimeframe">
										<option value="">Show all</option>
										<option value="week">Previous Week</option>
										<option value="month">Previous Month</option>
										<option value="twomonths">Previous Two Months</option>
									</select>
								</td>
								<td>
									<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="button" value="Back To Seller Management" onclick="location.href='index.cfm?event=sellers'" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.art.getLatestListings({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchActive},{searchTimeframe})">
							<cfgridcolumn name="lname" header="Seller" width="150">
							<cfgridcolumn name="name" header="Title" width="150">
							<cfgridcolumn name="manufacturer" header="Artist" width="150">
							<cfgridcolumn name="gallery_price" header="Gallery Price" width="100">
							<cfgridcolumn name="listingDate" header="Date" width="75">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>


		</td>
		<td valign="top">
			<cfform name="latestEditForm">
			<cfinput type="hidden" name="uid" id="uid" bind="{data.uid}">
			<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
				<tr>
					<td id="stuff" colspan="2"></td>
				</tr>
				<tr>
					<td width="100">
						First Name:
					</td>
					<td>
						<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" size="30" class="displayInput" disabled>
					</td>
				</tr>
				<tr>
					<td>
						Last Name:
					</td>
					<td>
						<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="30" class="displayInput" disabled>
					</td>
				</tr>
				<tr>
					<td>
						Email:
					</td>
					<td>
						<cfinput type="text" name="seller_email" id="seller_email" size="30" class="displayInput" disabled>&nbsp;
						<span  id="emailLink"></span>
					</td>
				</tr>
				<tr>
					<td>
						Phone:
					</td>
					<td>
						<cfinput type="text" name="phone" id="phone"  bind="{data.phone}" size="30" class="displayInput" disabled>&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Title:
					</td>
					<td>
						<cfinput type="text" name="name" id="name"  bind="{data.name}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top">
						Artist:
					</td>
					<td>
						<select name="manufacturer" id="manufacturer">
						<cfoutput query="getAllArtists" group="manufacturer">
							<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
							<option value="#manufacturer#">#ucase(manufacturer)#
							</cfif>
						</cfoutput>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Medium:
					</td>
					<td>
						<select name="path">
							<cfoutput query="getAllMedium" group="path">
								<option value="#path#">#ucase(path)#
							</cfoutput>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Size:
					</td>
					<td>
						<cfinput type="text" name="size" id="size"  bind="{data.size}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top">
						Description:
					</td>
					<td>
						<cftextarea name="caption" id="caption"  bind="{data.caption}" cols="40" rows="5" />
					</td>
				</tr>
				<tr>
					<td>
						Retail Price:
					</td>
					<td>
						<cfinput type="text" name="retail_price" id="retail_price"  bind="{data.retail_price}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Gallery Price:
					</td>
					<td>
						<cfinput type="text" name="gallery_price" id="gallery_price"  bind="{data.gallery_price}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Active:
					</td>
					<td>
						<input type="radio" name="active" value="1">Active <input type="radio" name="active" value="0">Inactive
					</td>
				</tr>
				<tr>
					<td>
						Thumbnail:
					</td>
					<td id="imageDisplay" height="150">
						<img src="" name="mainImg" id="mainImg" border="0" width="100"  /><br>
						<a href="" id="clickEnlarge" target="_blank">Click</a> to enlarge<br><br>
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
<script language="JavaScript">
	for(i = 0; i < gridForm.searchActive.options.length; i++){
		if(gridForm.searchActive.options[i].value == '<cfoutput>#form.searchActive#</cfoutput>'){
			gridForm.searchActive.options[i].selected = true;
		}
		else{
			gridForm.searchActive.options[i].selected = false;
		}
	}
	for(i = 0; i < gridForm.searchTimeframe.options.length; i++){
		if(gridForm.searchTimeframe.options[i].value == '<cfoutput>#form.searchTimeframe#</cfoutput>'){
			gridForm.searchTimeframe.options[i].selected = true;
		}
		else{
			gridForm.searchTimeframe.options[i].selected = false;
		}
	}

</script>
