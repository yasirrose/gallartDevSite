<cfajaxproxy cfc="admin.models.ebay" />
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/ebay.js.cfm" language="JavaScript"></script>'>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr>
<td valign="top">
<input type="button" value="Add New" onclick="location.href='index.cfm?event=ebay.details&pk_ebay=0'" />
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
    	<td colspan="2" style="font-size: 11px;"><strong>SEARCH BY:</strong></td>
  	</tr>
	<tr>
		<td valign="top" width="300">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="300">
				<tr>
					<td align="right">
						<strong>Last Name:</strong>
					</td>
					<td>
						<cfinput name="searchLname" size="30" />
					</td>

				</tr>
				<tr>
					<td align="right">
						<strong>Email:</strong>
					</td>
					<td>
						<cfinput name="searchEmail" size="30" />

					</td>

				</tr>
				<tr>
					<td align="right">
						<strong>Artist:</strong>
					</td>
					<td>
						<cfinput name="searchArtist" size="30" />
					</td>

				</tr>
				<tr>
					<td align="right">
						<strong>Date from:</strong>
					</td>
					<td nowrap>
						<cfinput name="searchFromDate" type="datefield" validate="date" size="10" />
					</td>

				</tr>
				<tr>
					<td align="right">
						<strong>Date to:</strong>
					</td>
					<td nowrap>
						<cfinput name="searchToDate" type="datefield" validate="date" size="10" />
					</td>

				</tr>
					<td colspan="2" align="center">
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.ebay.getEbayResults({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchLname},{searchEmail},{searchArtist},{searchFromDate},{searchToDate})">
						    <cfgridcolumn name="artist" header="Artist" width="175">
							<cfgridcolumn name="lname" header="Last Name" width="80">
							<cfgridcolumn name="email" header="Email" width="175">
							<cfgridcolumn name="datestamp" header="Date" width="125">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>

<cfset ajaxOnLoad("init")>
