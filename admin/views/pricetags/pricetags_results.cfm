<link rel="stylesheet" href="../css/jquery/tablesorter.css" type="text/css" media="print, projection, screen" />
<cfhtmlhead text='<script type="text/javascript" src="../js/jquery-1.3.2.js" language="JavaScript"></script>'>
<cfhtmlhead text='<script type="text/javascript" src="../js/jquery.tablesorter.js" language="JavaScript"></script>'>
<cfhtmlhead text='<script type="text/javascript" src="../js/jquery.tablesorter.pager.js" language="JavaScript"></script>'>
	
<script type="text/javascript">
$(function() {
	$("#pricetagsTable")
		.tablesorter({
			widthFixed: true, 
			widgets: ['zebra'],
			headers: { 8: { sorter: false},9: { sorter: false} }
			
		})
	
	$('#includeColumn').toggle(function(){
		$('.productCheckbox').removeAttr('checked');
		return false;
		}, function() {
		$('.productCheckbox').attr('checked','checked');
		return false;
	});

});
</script>
<style>
	#includeColumn {
		cursor: pointer;
	}
</style>
<div style="text-align:left; padding-bottom: 10px;">
	<input type="button" value="Back To Search" onClick="location.href='index.cfm?event=pricetags'"><br><br>
	Number of records:  <cfoutput>#getListingsForSales.recordcount#</cfoutput>
</div>

<cfif getListingsForSales.recordcount>
<form method="post" action="index.cfm?event=pricetags.createPdf">
<table align="left" width="400">
     <tr>
        <td colspan="2">
            <strong>Show Retail Price:</strong>&nbsp;&nbsp;
            <input type="checkbox" name="show_retail" value="1" checked>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <strong>Show Gallery Price:</strong>&nbsp;&nbsp;
            <input type="checkbox" name="show_gallery" value="1" checked>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <strong>Show Sale Price:</strong>&nbsp;&nbsp;
            <input type="checkbox" name="show_sale" value="1" checked>
            Use sale price:<input type="radio" name="price_to_use" value="sale" checked="checked" />&nbsp;&nbsp;Use high estimate:<input type="radio" name="price_to_use" value="high estimate" />
        </td>
    </tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="Create PDF">
		</td>
	</tr>
</table>
<br /><br />
<table id="pricetagsTable" cellspacing="1" class="tablesorter" style="clear: both;">
	<thead> 
		<tr> 
			<th>Art ID</th> 
			<th>Artist</th> 
			<th>Title</th> 
			<th>Medium</th> 
			<th>Retail Price</th> 
			<th>Gallery Price</th> 
			<th>Sale Price</th>
            <th>High Estimate</th>
            <th></th>
			<th id="includeColumn">Include</th>
		</tr> 
	</thead> 
	<tbody> 
		<cfoutput query="getListingsForSales">
		<tr> 
			<td>
				#modelno#
			</td>
			<td>
				#manufacturer#									
			</td>
			<td>
				#name#
			</td>
			<td>
				#path#
			</td>
			<td>
				$#retail_price#		 	
			</td>
			<td>
				$#gallery_price#		 	
			</td>
			<td>
				$#special_price#		 	
			</td>
            <td>
				$#high_estimate#		 	
			</td>
            <td>
            	<img src="http://#server_name#/img/thumbnails/#uid#.jpg" height="50" border="0">
            </td>
			<td>
				<input type="Checkbox" name="productId"  class="productCheckbox" value="#uid#" checked="checked">
			</td>
		</tr>  
		</cfoutput>
	</tbody> 
</table>
</form>
<!---<div id="pager" class="pager">
	<form>
		<img src="../css/jquery/images/first.png" class="first"/>
		<img src="../css/jquery/images/prev.png" class="prev"/>
		<input type="text" class="pagedisplay"/>
		<img src="../css/jquery/images/next.png" class="next"/>
		<img src="../css/jquery/images/last.png" class="last"/>
		<select class="pagesize">
			<option selected="selected"  value="10">10</option>

			<option value="20">20</option>
			<option value="30">30</option>
			<option  value="40">40</option>
		</select>
	</form>
</div>--->
</cfif>


