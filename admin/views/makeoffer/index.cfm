<cfajaxproxy cfc="admin.models.makeoffer" />
<cfajaxproxy bind="javascript:gridChange({data.uid},{data.customer_email},{data.seller_email})">
<cfhtmlhead text='
	<script type="text/javascript" src="/admin/scripts/makeoffer.js.cfm" language="JavaScript"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
'>

	<style>

		.date-field div {
			float: none !important;
			width: max-content;
			display: inline-block;
		}
		.date-field input.datefieldinput {
			padding-right: 18px;
			max-width: 178px;
		}

		.date-field div#searchFromDategridForm_cf_buttondiv, .date-field div#searchToDategridForm_cf_buttondiv {
			position: absolute;
			top: 2px;
			right: 2px;
			padding: 0 !important;
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
						<td align="right">
							<strong>Last Name:</strong>
							<cfinput name="searchLname" size="30" />
						</td>
						<td align="right">
							<strong>Email:</strong>
							<cfinput name="searchEmail" size="30" />
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right" class="date-field">
							<strong>Date from:</strong>
							<cfinput name="searchFromDate" type="datefield" validate="date" size="30" />
						</td>
						<td align="right" class="date-field">
							<strong>Date to:</strong>
							<cfinput name="searchToDate" type="datefield" validate="date" size="30" />
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right">
							<strong>Title:</strong>
							<cfinput name="searchTitle" size="30" />
						</td>
						<td align="right">
							<input type="Reset">
							<cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
						</td>
						<td>&nbsp;</td>
					</tr>
					<!--- <tr>
						<td>&nbsp;</td>
						<td colspan="2">
							<iframe marginheight="0" marginwidth="0" style="margin-top: 10px;" src="http://23.20.226.157/admin/views/makeoffer/hideButtons.cfm" frameborder="0" width="200" height="40"></iframe>
						</td>
					</tr> --->
					<tr>
						<td colspan="3">
							<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.makeoffer.getMakeoffer({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail},{searchTitle},{searchFromDate},{searchToDate})">
								<cfgridcolumn name="name" header="Title" width="200">
								<!--- <cfgridcolumn name="customer_lname" header="Last Name" width="80"> --->
								<cfgridcolumn name="combine_customer_name" header=" Name" width="80">
								<cfgridcolumn name="customer_email" header="Email" width="175">
								<cfgridcolumn name="seller_lname" header="Seller" width="80">
								<cfgridcolumn name="offerdate" header="Date" width="75">
							</cfgrid>
						</td>
					</tr>
				</table>
			</cfform>
		</td>
		<td valign="top">

			<cfform name="editForm">
				<cfinput type="hidden" name="pk_makeoffer" id="pk_makeoffer" bind="{data.pk_makeoffer}">
				<cfinput type="hidden" name="moduleName" id="moduleName" value="admin/makeOffer">
				
				<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox" style="margin-top: 70px;">
					<tr>
						<td width="75">
							First Name:
							<br>
							<cfinput type="text" name="fname" id="fname"  bind="{data.customer_fname}" size="30">
						</td>
						<td>
							Last Name:
							<br>
							<cfinput type="text" name="lname" id="lname"  bind="{data.customer_lname}" size="30">
						</td>
					</tr>
					<!--- <tr>
						<td>
							Last Name:
						</td>
						<td>
							<cfinput type="text" name="lname" id="lname"  bind="{data.customer_lname}" size="30">
						</td>
					</tr> --->
					<tr>
						<td>
							Name:
							<br>
							<cfinput type="text" name="name" id="name"  bind="{data.customer_name}" size="30">
						</td>
						<td>
							Email:
							<br>
							<cfinput type="text" name="customer_email" id="customer_email"  bind="{data.customer_email}"  size="25">
							<span  id="emailLink"></span>
							
							<span  id="mailLog"></span>
						</td>
					</tr>
					<!--- <tr>
						<td>
							Email:
						</td>
						<td>
							<cfinput type="text" name="customer_email" id="customer_email"  bind="{data.customer_email}"  size="30">&nbsp;
							<span  id="emailLink"></span>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span  id="mailLog"></span>
						</td>
					</tr> --->
					<tr>
						<td>
							Phone:
							<br>
							<cfinput type="text" name="makeoffer_phone" id="makeoffer_phone"  bind="{data.makeoffer_phone}" size="30">
						</td>
						<td>
							Best Time To Call:
							<br>
							<cfinput type="text" name="best_time" id="best_time"  bind="{data.best_time}" size="30">
						</td>
					</tr>
					<!--- <tr>
						<td>
							Best Time To Call:
						</td>
						<td>
							<cfinput type="text" name="best_time" id="best_time"  bind="{data.best_time}" size="50">
						</td>
					</tr> --->
					<tr>
						<td>
							Retail Price: $
							<br>
							<cfinput type="text" name="retail_price" id="retail_price"  bind="{data.retail_price}" size="30">
						</td>
						<td>
							Gallery Price: $
							<br>
							<cfinput type="text" name="gallery_price" id="gallery_price"  bind="{data.gallery_price}" size="30">
						</td>
					</tr>
					<tr>
						
						<td>
							Sale Price: $
							<br>
							<cfinput type="text" name="sale_price" id="sale_price"  bind="{data.special_price}" size="30">
						</td>
						<td>
							Offer: $
							<br>
							<cfinput type="text" name="offer" id="offer"  bind="{data.offer}" size="30">
						</td>
						
					</tr>
					<!--- <tr>
						<td>
							Sale Price:
						</td>
						<td>
							$<cfinput type="text" name="sale_price" id="sale_price"  bind="{data.special_price}" size="30">
						</td>
					</tr> --->
					<!--- <tr>
						<td>
							Offer: $
							<br>
							<cfinput type="text" name="offer" id="offer"  bind="{data.offer}" size="30">
						</td>
						
					</tr> --->
					<tr>
						<td valign="top">
							Title:
							<br>
							<cfinput type="text" name="title" id="title"  bind="{data.name}" size="30">
						</td>
						<td>
							Artist:
							<br>
							<cfinput type="text" name="manufacturer" id="manufacturer"  bind="{data.manufacturer}" size="30">
						</td>
					</tr>
					<!--- <tr>
						<td valign="top">
							Artist:
						</td>
						<td>
							<cfinput type="text" name="manufacturer" id="manufacturer"  bind="{data.manufacturer}" size="50">
						</td>
					</tr> --->
					<tr>
						<td valign="top">
							Art ID:
							<br>
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

<style>
	.toast-center {
		top: 50% !important;
		left: 50% !important;
		transform: translate(-50%, -50%) !important;
		position: fixed !important;
		z-index: 999999 !important;
	}

	#toast-container > .toast {
		background-color: #ff4da6 !important;
		color: white !important;
	}
</style>

<iframe id="viewMailLog" src="" style="display: none; position: absolute; top: 165px; left: 10px; z-index: 1000; background-color: #fff;" height="575" width="615" frameborder="1"></iframe>

