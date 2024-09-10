<cfajaxproxy cfc="admin.models.users" />
<cfajaxproxy bind="javascript:gridChange({data.pk_users})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/sellers.js.cfm" language="JavaScript"></script>'>

<script type="text/javascript">
getSellerName = function(){
	   var s = document.getElementById('fname').value + ' ' +
			document.getElementById('lname').value;
	   return s;
}
getSellerEmail = function(){
	   var s = document.getElementById('seller_email').value;
	   return s;
}
</script>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr>
<td valign="top">
<form method="post" action="index.cfm?event=sellers.latestListings">
<table border = "0" width = "500" cellpadding = "5" cellspacing = "0">
	<tr>
	   	<td style="font-size: 11px;"><strong>VIEW LATEST LISTINGS:</strong></td>
		<td align="right"><strong>Show:</strong></td>
		<td>
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
		<td style="padding-top: 10px;">
			<input type="submit" value="View">
		</td>
	</tr>
</table>
</form>
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
    	<td colspan="2" style="font-size: 11px;"><strong>SEARCH BY:</strong></td>
  	</tr>
	<tr>
		<td valign="top" width="450">
			<cfform name="gridForm">

			<table cellspacing="0" cellpadding="3" border="0" width="100%">
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
						<strong>Artist:</strong>
					</td>
					<td>
						<select name="searchArtist">
							<option value="">All
							<cfoutput query="getAllArtists" group="manufacturer">
							<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
								<option value="#manufacturer#">#ucase(manufacturer)#
							</cfif>
							</cfoutput>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Listed Artwork:</strong>
					</td>
					<td>
						<select name="searchListed">
							<option value="">Show all</option>
							<option value="Yes">Show only sellers who have listed artwork</option>
							<option value="No">Show only sellers who have not listed artwork</option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false); fillSearchFields();" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.users.getUsers({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail},{searchTitle},{searchArtist},{searchListed})">
							<cfgridcolumn name="fname" header="First Name" width="150">
							<cfgridcolumn name="lname" header="Last Name" width="150">
							<cfgridcolumn name="seller_email" header="Email" width="175">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<input type="button" value="New" onclick="showNew()">
			<cfform name="editForm">
			<cfinput type="hidden" name="pk_users" id="pk_users" bind="{data.pk_users}">
			<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
				<tr>
					<td id="stuff" colspan="2"></td>
				</tr>
				<tr>
					<td width="100">
						First Name:
					</td>
					<td>
						<cfinput type="text" name="fname" id="fname"  bind="{data.fname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Last Name:
					</td>
					<td>
						<cfinput type="text" name="lname" id="lname"  bind="{data.lname}" size="30">
					</td>
				</tr>
				<tr>
					<td>
						Email:
					</td>
					<td>
						<cfinput type="text" name="seller_email" id="seller_email"  bind="{data.seller_email}" size="30">&nbsp;
						<span  id="emailLink"></span>
					</td>
				</tr>
				<tr>
					<td>
						Cell Phone:
					</td>
					<td>
						<cfinput type="text" name="cellphone" id="cellphone"  bind="{data.cellphone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the cell phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
					</td>
				</tr>
				<tr>
					<td>
						Home Phone:
					</td>
					<td>
						<cfinput type="text" name="phone" id="phone"  bind="{data.phone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the home phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
					</td>
				</tr>
				<tr>
					<td>
						Business Phone:
					</td>
					<td>
						<cfinput type="text" name="businessphone" id="businessphone"  bind="{data.businessphone}" size="30" validate="regular_expression" pattern="^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$" mask="(999) 999-9999" message="Please enter the business phone number in the format (xxx) xxx-xxxx"> (xxx) xxx-xxxx
					</td>
				</tr>
				<tr>
					<td>
						Phone Outside the US:
					</td>
					<td>
						<cfinput type="text" name="otherphone" id="otherphone"  bind="{data.otherphone}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Website:
					</td>
					<td>
						<cfinput type="text" name="website" id="website"  bind="{data.website}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						Password:
					</td>
					<td>
						<cfinput type="text" name="password" id="password"  bind="{data.password}" size="30">&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="2" id="viewListings"></td>
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

<cfwindow name="viewListingsWin" modal="true" resizable="false" title="Edit Page" width="1150" height="800" headerStyle="background-color:##dd3a7d;">
	<script>
		getSellerId = function(){
		   var s = ColdFusion.getElementValue('sellerId');
		   return s;
		}
		getListingFrmTitle = function(){
		   var s = ColdFusion.getElementValue('listingFrmTitle');
		   return s;
		}
		getListingFrmArtist = function(){
		   var s = ColdFusion.getElementValue('listingFrmArtist');
		   return s;
		}
	</script>
	<cfform name="viewListingsFrm">
    <cfinput type="hidden" name="sellerId" id="sellerId" />
	<cfinput type="hidden" name="listingFrmTitle" id="listingFrmTitle" />
	<cfinput type="hidden" name="listingFrmArtist" id="listingFrmArtist" />
		<table width="100%">
			<tr>
				<td colspan="2" style="color: #ff0000;">
					To edit a field: double click field value, make change, then press Enter to save.
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<cfgrid format="html" name="sellerListingsGrid" pagesize="10" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.art.getListingsBySeller({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{sellerId},{listingFrmTitle},{listingFrmArtist})" selectmode="edit" insert="Yes" delete="Yes" onchange="cfc:admin.models.art.editListingsFromGrid({cfgridaction},{cfgridrow},{cfgridchanged},{searchSellerName},{searchSellerEmail})">
					    <cfgridcolumn name="name" header="Title" width="150">
						<cfgridcolumn name="manufacturer" header="Artist" width="125">
						<cfgridcolumn name="path" header="Medium" width="150">
						<cfgridcolumn name="size" header="Size" width="90">
						<cfgridcolumn name="listingdate" header="Listing Date" width="100">
						<cfgridcolumn name="caption" header="Description" width="200" select="yes">
						<cfgridcolumn name="retail_price" header="Retail Price" width="90" select="yes">
						<cfgridcolumn name="gallery_price" header="Gallery Price" width="90" select="yes">
						<cfgridcolumn name="Thumbnail" header="Thumb" width="50">
						<cfgridcolumn name="status" header="Status" width="75" values="Inactive,Active" valuesDisplay ="Inactive,Active" select="Yes">
					</cfgrid>
				</td>
			</tr>
		</table>
	</cfform>
</cfwindow>
