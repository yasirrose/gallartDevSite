<!--- thickbox --->
<script type="text/javascript" src="../js/thickbox-compressed.js"></script>
<link rel="stylesheet" href="../css/thickbox.css" type="text/css" media="screen" />
<!--- <style>
	#TB_ajaxContent.TB_modal {
	height: 600px !important;
}
</style> --->
<cfoutput>
	<div class="search-box">
		<div class="row">
			<div class="col-md-12 ms-3">
				<cfinclude template="alpha_search.cfm">
			</div>

			<div class="col-md-12">
				<cfinclude template="gallery_search.cfm">
			</div>
			<!-- <div class="col-md-6">
				<cfinclude template="database_search.cfm">
			</div> -->
		
		</div>
	</div>
<!--- <table border="0" cellspacing="0" cellpadding="0" background="images/search3.jpg" style="background-repeat: no-repeat; background-position: top;" width="627" height="157">
	<tr>
		<td style="padding-left: 150px; padding-top: 35px;">
			<cfinclude template="gallery_search.cfm">
		</td>
	</tr>
	<tr>
		<td style="padding-left: 150px; padding-bottom: 3px;">
			<cfinclude template="database_search.cfm">
		</td>
	</tr>
	<tr>
		<td style="padding-right: 25px;" height="45">
			<cfinclude template="alpha_search.cfm">
		</td>
	</tr>
</table> --->
</cfoutput>
<div id="picturegallery_help" style="display: none;">
	<div style="float: right;"><a href="#" onclick="tb_remove();" style="color: #dd3a7d; font-weight: bold; font-size: 13px; text-decoration: none;">CLOSE</a><br><br></div>
	<div style="clear: both; overflow-y: scroll; height: 300px;">
		<p>
			Select the dropdown to view all artwork. This will take you to a page with thumbnail listings of every work of art in our system. Click on any thumbnail to view details.
			<!--- Select an artist from the dropdown to view all artwork by that artist.  You will be taken to a page of thumbnail listings of every work of art by that artist in our system.  Click on the thumbnail for a detailed view. --->
		</p>
	</div>
</div>
<div id="databaseview_help" style="display: none; height: 700px;">
	<div style="float: right;"><a href="#" onclick="tb_remove();" style="color: #dd3a7d; font-weight: bold; font-size: 13px; text-decoration: none;">CLOSE</a><br><br></div>
	<div style="clear: both; padding-top: 10px; overflow-y: scroll; height: 300px;">
		<p>
			Select an artist from the dropdown to see a listing of all the artwork by that artist in our database.  The listing is text only, and can be printed out for your records.
		</p>
	</div>
</div>