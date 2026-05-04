<cfajaxproxy cfc="admin.models.campaign" />
<cfoutput>
    <script type="text/javascript" src="http://#server_name#/js/jquery-1.3.2.js"></script>
</cfoutput>
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/campaign.js.cfm" language="JavaScript"></script>'>
<script>
	refreshIframe = function(){
		$("#campaignListFrame").attr("src","http://<cfoutput>#server_name#</cfoutput>/admin/index.cfm?event=campaign.campaign_list&campaignId=<cfoutput>#url.campaignId#</cfoutput>");
	}
</script>
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td>
			<a href="http://<cfoutput>#server_name#</cfoutput>/admin/index.cfm?event=campaign">BACK TO CAMPAIGN LIST</a>
		</td>
		<td>&nbsp;</td>
  	</tr>
	<tr>
    	<td>
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td style="font-size: 11px;">
						<strong>SEARCH BY:</strong>
					</td>
				</tr>
			</table>
		</td>
		<td>&nbsp;</td>
  	</tr>
	<tr>
		<td valign="top" width="350">
			<cfform name="gridForm" method="POST">
			<input type="Hidden" name="showResults" id="showResults" value="0" />
			<table cellspacing="5" cellpadding="3" border="0" width="100%">
				<tr>
					<td width="100" style="font-size: 10px;">
						<strong>Art ID:</strong>
					</td>
					<td>
						<cfinput name="searchModelno" id="searchModelno" size="10" />
					</td>

				</tr>
				<tr>
					<td style="font-size: 10px;">
						<strong>Title:</strong>
					</td>
					<td>
						<cfinput name="searchTitle" size="30" />
					</td>

				</tr>
				<tr>
					<td style="font-size: 10px;">
						<strong>Artist:</strong>
					</td>
					<td>
						<select name="searchArtist" id="searchArtist">
							<option value="">All
							<cfoutput query="getAllArtists" group="manufacturer">
							<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
								<option value="#manufacturer#">#ucase(manufacturer)#
							</cfif>
							</cfoutput>
						</select>
					</td>

				</tr>


				<tr>
					<td colspan="2" align="center">
						<input type="Reset"><cfinput type="button" name="searchBtn" id="searchBtn" value="Search" onclick="document.getElementById('showResults').value = 1;ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<cfgrid format="html" name="data" pagesize="10" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.campaign.getListings({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchModelno},{searchTitle},{searchArtist},{showResults})">
						    <cfgridcolumn name="name" header="Title" width="150">
							<cfgridcolumn name="manufacturer" header="Artist" width="150">
							<cfgridcolumn name="gallery_price" header="Gallery Price" width="100">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<cfoutput>
				<table width="100%">
					<tr>
						<td>
							<iframe src="http://#server_name#/admin/index.cfm?event=campaign.show_campaign&campaignId=#url.campaignId#" frameborder="0" width="100%" height="274"></iframe>
						</td>
					</tr>
					<tr>
						<td>
							<iframe src="http://#server_name#/admin/index.cfm?event=campaign.campaign_list&campaignId=#url.campaignId#" frameborder="0" width="100%" height="1200" id="campaignListFrame"></iframe>
						</td>
					</tr>
			</cfoutput>
		</td>
	</tr>
</table>


<cfset ajaxOnLoad("init")>
