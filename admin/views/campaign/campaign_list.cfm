
<html>
<head>
<!--- The cfajaximport tag is required for the submitForm function to work
            because the page does not have any Ajax-based tags. --->
<cfajaximport>
<cfoutput>
<script type="text/javascript" src="http://#server_name#/js/jquery-1.3.2.js"></script>
<script>
    function addListing() {
        ColdFusion.Ajax.submitForm('addListing', 'http://#server_name#/admin/index.cfm?event=campaign.update_campaign_list', callback,
            errorHandler);
    }
    function callback(){
    	parent.refreshIframe();
    	alert("Listing Added")
    }
    function errorHandler(){
    	alert("There was an error.  Please try again.")
    }
    function deleteListing(listingId) {
    	$("##delId").val(listingId);
    	ColdFusion.Ajax.submitForm('delListing', 'http://#server_name#/admin/index.cfm?event=campaign.delete_campaign_listing', delCallback);
    }
    function delCallback(){
    	parent.refreshIframe();
    }
</script>
</cfoutput>
</head>
<body>
<cfoutput>
<cfform name="addListing" id="addListing">
	<input type="hidden" name="campaignId" id="campaignId" value="#url.campaignId#">
    <input type="hidden" name="listingId" id="listingId">
</cfform>

<cfform name="delListing" id="delListing">
    <input type="hidden" name="delId" id="delId">
</cfform>

<cfoutput>
	<link REL="STYLESHEET" TYPE="text/css" HREF="http://#server_name#/admin/css/main.css">
</cfoutput>

</cfoutput>

<table>
	<tr>
		<td colspan="4">
			<h4>Listings Added:</h4>
		</td>
	</tr>
	<tr>
		<td width="300">
			<strong>Title</strong>
		</td>
		<td width="100">
			<strong>Artist</strong>
		</td>
		<td width="100"></td>
		<td>
			<strong>Delete</strong>
		</td>
	</tr>
	<cfoutput query="getCampaignListings">
	<tr>
		<td>
			#name#
		</td>
		<td>
			#manufacturer#
		</td>
		<td>
			<img src="http://#server_name#/img/thumbnails/#uid#.jpg" height="50" />
		</td>
		<td>
			<a onclick="deleteListing('#uid#');return false;" style="cursor: pointer;"><img src="http://#server_name#/images/trash.gif" border="0" /></a>
		</td>
	</tr>
	</cfoutput>
<table>

</body>
</html>
