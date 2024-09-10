<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/pages.js.cfm" language="JavaScript"></script>'>
<cfajaxproxy cfc="admin.models.pages" jsclassname="cfcproxy_pages">

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td colspan="2" valign="top" class="title">
			Double click Page Title to edit content:
		</td>
	</tr>
	<tr>
		<td valign="top" width="300">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr>
					<td>
						<cfgrid format="html" name="pageGrid" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.pages.getPages({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
						    <cfgridcolumn name="page_title" header="Page Title" width="400">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>

<!--- <cfwindow name="editPageWin" modal="true" resizable="false" title="Edit Page" width="900" height="800" headerStyle="background-color:##dd3a7d;">
	<cfform name="frmPage">
    <input type="hidden" name="pk_pages" value="" />
		<table width="100%">
			<tr>
				<td colspan="2">
					<cftextarea name="txtPageContent" id="txtPageContent" height="600" width="750" richtext="yes" />
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" name="btnAction" value="Update Page" onClick="javascript:savepage();"></td>
			</tr>
	</cfform>
</cfwindow> --->
<cfset ajaxOnLoad("init")>

