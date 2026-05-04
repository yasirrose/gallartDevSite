<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/campaigns.js.cfm" language="JavaScript"></script>'>
<cfajaxproxy cfc="admin.models.campaign" jsclassname="cfcproxy_campaigns">

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td colspan="2" valign="top" class="title">
			Double Click Campaign title to edit:
		</td>
	</tr>
	<tr>
		<td valign="top" width="300">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr>
					<td>
						<div id="aboveGrid" style="width: 402px;"></div>
						<cfgrid format="html" name="campaignGrid" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.campaign.getCampaigns({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
						    <cfgridcolumn name="campaign_title" header="Campaign Title" width="400">
						</cfgrid>
					</td>
				</tr>
			</table>										
			</cfform>
		</td>
	</tr>
</table>

<cfwindow width="200" height="150" name="deleteCampaignWin" modal="true" resizable="false" title="Delete Campaign" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td>
			Do you want to delete this campaign?<br><br>
			<input type="button" value="  YES  " onClick="deleteCampaign('yes')">&nbsp;&nbsp;<input type="button" value="  NO  " onClick="deleteCampaign('no')">
		</td>
	</tr>
</table>

	
</cfwindow>

<cfwindow name="editCampaignWin" modal="true" resizable="false" title="Add Campaign" width="300" height="200" headerStyle="background-color:##dd3a7d;">
	<cfform name="frmCampaign">
    <input type="hidden" name="pk_campaign" value="" />
		<table width="100%">
			<tr>
				<td colspan="2">
					Title:&nbsp;&nbsp;<cfinput name="txtCampaignTitle" size="40">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" name="btnAction" value="Update" onClick="savecampaign()">
				</td>
			</tr>
	</cfform>
</cfwindow>

<cfset ajaxOnLoad("init")>

