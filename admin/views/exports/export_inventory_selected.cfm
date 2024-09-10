<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="90%">
	<tr>
		<td valign="top"><br>
		<h3>EXPORT INVENTORY TO EXCEL SPREADSHEET</h3>
		<br>
		<cfif isDefined('form.create')>
			<cfparam name="form.active" default="0">
	
			<iframe src="index.cfm?event=exports.createXlsFileSelected&active=#form.active#&displayFields=#form.displayFields#" frameborder="0"></iframe>
			
			<cfelse>
			
			<form method="post" action="index.cfm?event=exports.selected">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
				<td colspan="2" style="font-size: 9pt;">
					<b>Choose Fields You Want To Export:</b>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="font-size: 9pt;">
					<input type="Checkbox" name="displayFields" value="ModelNo">Model No<br>
					<input type="Checkbox" name="displayFields" value="Artist">Artist<br>
					<input type="Checkbox" name="displayFields" value="Medium">Medium<br>
					<input type="Checkbox" name="displayFields" value="Retail">Retail Price<br>
					<input type="Checkbox" name="displayFields" value="Gallery">Gallery Price<br>
					<input type="Checkbox" name="displayFields" value="Sale">Sale Price<br>
					<input type="Checkbox" name="displayFields" value="Year">Year<br>
					<input type="Checkbox" name="displayFields" value="Size">Size<br>
					<input type="Checkbox" name="displayFields" value="Edition">Edition<br>
					<input type="Checkbox" name="displayFields" value="Low">Low Estimate<br>
					<input type="Checkbox" name="displayFields" value="High">High Estimate<br>
					<input type="Checkbox" name="displayFields" value="Desc">Description<br>
					<input type="Checkbox" name="displayFields" value="Thumbnail">Thumbnail<br>
					<input type="Checkbox" name="displayFields" value="Url">URL<br>
					<input type="Checkbox" name="active" value="1">Active Only
				</td>
			</tr>
				<tr>
					<td>
						<input type="Submit" value="CREATE EXCEL LISTING" name="create">
					</td>
				</tr>
			</table>
			</form>
			
			</cfif>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<input type="Button" value="Back" onclick="location.href='index.cfm?event=exports'" />
		</td>
	</tr>
</table>	
</cfoutput>