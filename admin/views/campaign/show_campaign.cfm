<cfoutput>
<link REL="STYLESHEET" TYPE="text/css" HREF="http://#server_name#/admin/css/main.css">

<form method="post" action="http://#server_name#/admin/index.cfm?event=campaign.edit_campaign" enctype="multipart/form-data">
<input type="hidden" name="pk_campaign" value="#url.campaignId#" />
<table width="100%">
	<tr>
		<td width="50px"><strong>Campaign:</strong> </td>
		<td><input type="text" name="title" value="#getCampaign.title#" style="width: 320px;"></td>
	</tr>
	<tr>
		<td width="50px"><strong>Active:</strong> </td>
		<td><input type="checkbox" name="active" <cfif getCampaign.active EQ 1>checked</cfif>></td>
	</tr>
	<tr>
		<td colspan="2" style="height: 200px;">
			<div style="height: 80px; overflow: scroll;">
				<cfset thisIcon = expandpath('.') & "\views\campaign\icons\campaign-icon-" & url.campaignId & ".png" />
				<cfif fileexists("#thisIcon#")>
					<img src="http://#server_name#/admin/views/campaign/icons/campaign-icon-#url.campaignId#.png?u=#randrange(1,1000)#" />
				</cfif>
			</div>
			<div style="clear: both; margin-top: 10px; height: 24px;">			

				<strong>Icon: </strong><input type="file" name="icon"> (Must be transparent png)
			</div>
			<div style="clear: both; margin-top: 10px; height: 24px;">
				<input type="submit" value="Update Campaign">
			</div>

		</td>
	</tr>
</table>
</form>

</cfoutput>

