<cfajaxproxy cfc="admin.models.filterOption" />
<cfajaxproxy bind="javascript:gridChangeFilter({data.id})">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/filterOption.js.cfm" language="JavaScript"></script>'>

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr>
<td valign="top">
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<!--- <tr>
    	<td colspan="2" style="font-size: 11px;"><strong>SEARCH BY:</strong></td>
  	</tr> --->
	<tr>
		<td valign="top" width="400">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr style="display:none;">
					<td align="right">
						<strong>Filter Name:</strong>
					</td>
					<td>
						<cfinput name="searchLname" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
	
				<!--- <tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<input type="Reset">
						<cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('data', false);" />
					</td>
				</tr> --->
				<tr>
					<td colspan="3">
						<cfgrid format="html" name="data" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.filterOption.getFilterRecord({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
							<cfgridcolumn name="filterName" header="Filter Name" width="100">
							<cfgridcolumn name="filterType" header="Filter Type" width="100">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
		<td valign="top">
			<cfif session.userinfo.sa EQ 1 OR session.userinfo.email EQ 'waseemgallart@gmail.com'>
				<input type="button" value="New" onclick="showNew()">
			</cfif>
			<cfform name="editForm">
			<cfinput type="hidden" name="id" id="id" bind="{data.id}">
			<table border = "0" width = "500" cellpadding = "5" cellspacing = "0" class="editBox">
				<tr>
					<td id="stuff" colspan="2"></td>
				</tr>
				<tr>
					<td width="100">
						Filter Name
					</td>
					<td>
						<cfinput type="text" name="filterName" id="filterName" bind="{data.filterName}" size="30" required="true" message="Please enter the Filter Name.">
					</td>
				</tr>
				<tr>
					<td>
						Filter Type:
					</td>
					<td>
						<cfinput type="text" name="filterType" id="filterType" bind="{data.filterType}" size="30" required="true" message="Please enter the Filter Type.">
						<!--- <cfselect name="filterType" id="filterType" bind="{data.filterType}" required="true" message="Please select the Filter Type.">
                            <option value="Subject">Subject</option>
                            <option value="Style">Style</option>
                            <option value="Size">Size</option>
                            <option value="Type">Type</option>
                        </cfselect> --->
					</td>
				</tr>
				
				
				<tr>
					<td colspan="2">
						<cfif session.userinfo.sa EQ 1 OR session.userinfo.email EQ 'waseemgallart@gmail.com'>
							<cfset buttonStyle = "">
							<cfset deleteChecck = "1">
							
						<cfelse>
							<cfset buttonStyle = "display:none;">
							<cfset deleteChecck = "">

						</cfif>
						<cfinput type="hidden" value="#deleteChecck#" name="deleteCheck" id="deleteCheck" >
						<cfinput type="button" name="edit" id="edit" value="Edit" onclick="doEdit('edit');" style="#buttonStyle#" />
						<cfinput type="button" name="delete" id="delete" value="Delete" onclick="if (confirm('DELETE -- ARE YOU SURE?')){ doEdit('delete');}" style="#buttonStyle#" />
					</td>
					<!--- <td colspan="2" >
						<cfinput type="button" name="edit" id="edit" value="Edit" onclick="doEdit('edit');" />
						<cfinput type="button" name="delete" id="delete" value="Delete" onclick="if (confirm('DELETE -- ARE YOU SURE?')){ doEdit('delete');}" />
					</td> --->
				</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>

