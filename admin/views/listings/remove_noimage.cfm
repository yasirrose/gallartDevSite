<link rel="stylesheet" type="text/css" href="../css/jquery/tablesorter.css">
<script type="text/javascript" src="../js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="../js/jquery.tablesorter.js"></script>
<script type="text/javascript" src="../js/jquery.tablesorter.pager.js"></script>
<script type="text/javascript">
$(function() {
	$("table")
		.tablesorter({
			widthFixed: true, widgets: ['zebra']
		})
		.tablesorterPager({
				container: $("#pager"),
				size: 25,
				tableId: 'removeDupResults'
			});
});
</script>
<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td>
			<table cellspacing="0" cellpadding="0" border="0" width="500">
				<tr>
					<td>
						<strong>LISTINGS WITH MISSING IMAGES</strong><br><br>
					</td>
				</tr>
				<tr>
					<td>
						Click on title or artist to view items with no image on listings page.
					</td>
				</tr>
				<tr>
					<td>
						<table border="0" width="500" cellspacing="1" class="tablesorter" id="removeDupResults">
							<thead>
								<tr>
									<th>Title</th>
									<th>Artist</th>
								</tr>
							</thead>
							<tbody>
								<cfoutput query="getNoimage">
								<tr>
									<td><a href="index.cfm?event=listings&title=#name#&artist=#manufacturer#" style="color: ##000000; text-decoration: none;" target="_blank">#name#</a></td>
									<td><a href="index.cfm?event=listings&title=#name#&artist=#manufacturer#" style="color: ##000000; text-decoration: none;" target="_blank">#manufacturer#</a></td>
								</tr>
								</cfoutput>
							</tbody>
						</table>
						<div id="pager" class="pager">
							<img src="../images/first.png" class="first"/>
							<img src="../images/prev.png" class="prev"/>
							<input type="text" class="pagedisplay"/>
							<img src="../images/next.png" class="next"/>
							<img src="../images/last.png" class="last"/>
							<select class="pagesize">
								<option value="25" selected>25</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
