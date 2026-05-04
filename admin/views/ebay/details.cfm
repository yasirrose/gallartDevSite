
<cfform name="editForm" method="post" action="index.cfm?event=ebay.process" enctype="multipart/form-data">
	<cfinput type="hidden" name="pk_ebay" id="pk_ebay" value="#url.pk_ebay#">
	<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
		<tr>
			<td class="2">
				<div style="text-align: left;"><input type="button" value="Back to Results" onClick="location.href='index.cfm?event=ebay'"></div>
			</td>
		</tr>
		<tr>
			<td width="100">
				First Name:
			</td>
			<td>
				<cfinput type="text" name="fname" id="fname"  size="30" value="#getEbay.recordset.fname#">
			</td>
		</tr>
		<tr>
			<td>
				Last Name:
			</td>
			<td>
				<cfinput type="text" name="lname" id="lname"  size="30" value="#getEbay.recordset.lname#">
			</td>
		</tr>
		<tr>
			<td>
				Email:
			</td>
			<td>
				<cfinput type="text" name="email" id="email"  size="30" value="#getEbay.recordset.email#">
			</td>
		</tr>
		<tr>
			<td>
				Artist:
			</td>
			<td>
				<select name="artist">
					<cfoutput query="getAllArtists" group="manufacturer">
					<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
						<option value="#manufacturer#" <cfif getEbay.recordset.artist EQ manufacturer>selected</cfif>>#ucase(manufacturer)#</option>
					</cfif>
					</cfoutput>
				</select>
			</td>
		</tr>
		<tr>
			<td valign="top">
				Comments:
			</td>
			<td>
				<cftextarea name="comments" cols="40" rows="2" style="height: 75px;"><cfoutput>#getEbay.recordset.comments#</cfoutput></cftextarea>
			</td>
		</tr>
		<cfif url.pk_ebay NEQ 0>
		<tr>
			<td valign="top">
				Upload Files:
			</td>
			<td>
				<input type="file" name="ebayFiles"><br />
				<span style="color: #ff0000;">Please upload only jpg images! Keep them around 200px wide.</span>
			</td>
		</tr>
		</cfif>
		<cfif getEbayUploads.recordset.recordcount>
		<tr>
			<td valign="top">
				Files Uploaded:
			</td>
			<td>
				<cfoutput query="getEbayUploads.recordset">
					<a href="http://#server_name#/ebay_uploads/#serverfile#" target="_blank">#ucase(serverfile)#</a>&nbsp;
					<input type="button" value="DELETE" onclick="location.href='index.cfm?event=ebay.deleteUpload&ebayId=#url.pk_ebay#&uploadId=#pk_ebay_uploads#'"><br />
				</cfoutput>
			</td>
		</tr>
		</cfif>
		<cfif url.pk_ebay NEQ 0>
		<tr>
			<td colspan="2" style="font-size: 14px;">
				Use this URL in your correspondence:<br />
				http://67.199.65.108/ebay/index.cfm?ebayId=<cfoutput>#url.pk_ebay#</cfoutput>
			</td>
		</tr>
		</cfif>
		<tr>
			<td colspan="2" >
				<cfinput type="submit" name="submit" value="Submit" />
			</td>
		</tr>
		<cfif url.pk_ebay NEQ 0>
		<tr>
			<td colspan="2" >
				<cfinput type="submit" name="delete" id="delete" value="Delete" onclick="return (confirm('DELETE -- ARE YOU SURE?'))" />
			</td>
		</tr>
		</cfif>
	</table>		
</cfform>