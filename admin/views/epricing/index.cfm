<cfajaxproxy cfc="admin.models.epricing" />
<cfajaxproxy bind="javascript:gridChange({data.uid},{data.customer_email},{data.seller_email})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/epricing.js.cfm" language="JavaScript"></script>'>

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
					<td align="right">
						<strong>Title:</strong>
					</td>
					<td>
						<cfinput name="searchTitle" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Date from:</strong>
					</td>
					<td nowrap>
						<cfinput name="searchFromDate" type="datefield" validate="date" size="10" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
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
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.epricing.getEpricing({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail},{searchTitle},{searchFromDate},{searchToDate})">
						    <cfgridcolumn name="name" header="Title" width="200">
							<cfgridcolumn name="customer_lname" header="Last Name" width="80">
							<cfgridcolumn name="customer_email" header="Email" width="175">
							<cfgridcolumn name="seller_lname" header="Seller" width="80">
							<cfgridcolumn name="datestamp" header="Date" width="75">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">

			<cfform name="editForm">
			<cfinput type="hidden" name="pk_epricing" id="pk_epricing" bind="{data.pk_epricing}">
			<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
				<tr>
					<td width="75">
						First Name:
					</td>
					<td>
						<cfinput type="text" name="fname" id="fname"  bind="{data.customer_fname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Last Name:
					</td>
					<td>
						<cfinput type="text" name="lname" id="lname"  bind="{data.customer_lname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Email:
					</td>
					<td>
						<cfinput type="text" name="customer_email" id="customer_email"  bind="{data.customer_email}"  size="30">&nbsp;
						<span  id="emailLink"></span>
					</td>
				</tr>
				<tr>
					<td>
						Phone:
					</td>
					<td>
						<cfinput type="text" name="epricing_phone" id="epricing_phone"  bind="{data.epricing_phone}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Phone Outside the US:
					</td>
					<td>
						<cfinput type="text" name="epricing_otherphone" id="epricing_otherphone"  bind="{data.epricing_otherphone}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Best Time To Call:
					</td>
					<td>
						<cfinput type="text" name="best_time" id="best_time"  bind="{data.best_time}" size="50">
					</td>
				</tr>
				<tr>
					<td>
						Retail Price:
					</td>
					<td>
						$<cfinput type="text" name="retail_price" id="retail_price"  bind="{data.retail_price}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Gallery Price:
					</td>
					<td>
						$<cfinput type="text" name="gallery_price" id="gallery_price"  bind="{data.gallery_price}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Sale Price:
					</td>
					<td>
						$<cfinput type="text" name="sale_price" id="sale_price"  bind="{data.sale_price}" size="30">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Title:
					</td>
					<td>
						<cfinput type="text" name="title" id="title"  bind="{data.name}" size="50">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Artist:
					</td>
					<td>
						<cfinput type="text" name="manufacturer" id="manufacturer"  bind="{data.manufacturer}" size="50">
					</td>
				</tr>
				<tr>
					<td valign="top">
						Art ID:
					</td>
					<td>
						<cfinput type="text" name="modelno" id="modelno"  bind="{data.modelno}" size="30">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="0" cellpadding="4" border="0" width="100%" id="displaySellerInfo">
							<tr>
								<td width="75" valign="top">
									Seller:
								</td>
								<td style="padding-left: 10px;">
									Name:
								</td>
								<td>
									<cfinput type="text" name="seller_fname" id="seller_fname"  bind="{data.seller_fname}" size="15" class="displayInput" disabled>
									<cfinput type="text" name="seller_lname" id="seller_lname"  bind="{data.seller_lname}" size="25" class="displayInput" disabled>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td style="padding-left: 10px;">
									Email:
								</td>
								<td>
									<cfinput type="text" name="seller_email" id="seller_email"  bind="{data.seller_email}" size="35" class="displayInput" disabled>&nbsp;<span  id="emailLinkSeller"></span>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td style="padding-left: 10px;">
									Phone:
								</td>
								<td>
									<cfinput type="text" name="seller_phone" id="seller_phone"  bind="{data.seller_phone}" size="25" class="displayInput" disabled>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" id="artImg"></td>
				</tr>
				<tr>
					<td colspan="2" >
						<cfinput type="button" name="delete" id="delete" value="Delete" onclick="if (confirm('DELETE -- ARE YOU SURE?')){ doEdit('delete');}" />
					</td>
				</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>

<iframe id="viewMailLog" src="" style="display: none; position: absolute; top: 165px; left: 10px; z-index: 1000; background-color: #fff;" height="575" width="615" frameborder="1"></iframe>

