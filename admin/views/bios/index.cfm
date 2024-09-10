<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/bios.js.cfm" language="JavaScript"></script>'>
<cfajaxproxy cfc="admin.models.bios" jsclassname="cfcproxy_bios">

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td colspan="2" valign="top" class="title">
			Double click Artist to edit bio:
		</td>
	</tr>
	<tr>
		<td valign="top" width="300">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
            	<tr>
					<td align="right">
						<strong>Artist:</strong>
					</td>
                </tr>
                <tr>
					<td>
						<cfinput name="searchArtist" size="30" />
					</td>
					<td>&nbsp;</td>
				</tr>
                <tr>
					<td>
						<input type="Reset"><cfinput type="button" name="searchBtn" value="Search" onclick="ColdFusion.Grid.refresh('bioGrid', false);" />
					</td>
				</tr>
				<tr>
					<td>
						<cfinput type="button" name="addbio" value="Add Bio" onclick="onAdd()" />
						<cfinput type="button" name="deletebio" value="Delete Bio" onclick="onDelete()" />
					</td>
				</tr>
				<tr>
					<td>
						<cfgrid format="html" name="bioGrid" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.bios.getBios({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchArtist})">
						    <cfgridcolumn name="artist" header="Artist" width="500">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>

<cfwindow width="200" height="150" name="deleteBioWin" modal="true" resizable="false" title="Delete Bio" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td>
			Do you want to delete this bio?<br><br>
			<input type="button" value="  YES  " onClick="deleteBio('yes')">&nbsp;&nbsp;
			<input type="button" value="  NO  " onClick="deleteBio('no')">
		</td>
	</tr>
</table>


</cfwindow>

<!--- <cfwindow name="editBioWin" modal="true" resizable="false" title="Edit Bio" width="775" height="750" headerStyle="background-color:##dd3a7d;">
	<cfform name="frmBio">
    <input type="hidden" name="pk_bios" value="" />
		<table width="100%">
			<tr>
				<td colspan="2">
					Artist:&nbsp;&nbsp;
                    <select name="txtArtist">
                    	<cfoutput query="getAllGallartArtists">
                        	<option value="#manufacturer#">#manufacturer#</option>
                        </cfoutput>
                    </select>
                    <!---<cfinput name="txtArtist" size="40">--->
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<cftextarea name="txtBio" id="txtBio" width="725" height="625" richtext="yes" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" name="btnAction" value="Update" onClick="{saveBio()}">
				</td>
			</tr>
	</cfform>
</cfwindow> --->
<cfset ajaxOnLoad("init")>
