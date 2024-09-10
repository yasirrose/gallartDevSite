<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/email.js.cfm" language="JavaScript"></script>'>
<cfajaxproxy cfc="admin.models.email" jsclassname="cfcproxy_emailtemplate">
<cfoutput><script type="text/javascript" src="http://#server_name#/admin/scripts/validations.js"></script></cfoutput>
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td colspan="2" valign="top" class="title">
			Double click Email Title to edit template:
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="top">
			Insert emailLogId=[emailLogId] into url string of all links to activate tracker.
		</td>
	</tr>
	<tr>
		<td valign="top" width="300">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr>
					<td>
						<div id="aboveGrid" style="width: 502px;"></div>
						<cfgrid format="html" name="emailTemplateGrid" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.email.getEmailTemplates({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
						    <cfgridcolumn name="email_name" header="Email Title" width="500">
						</cfgrid>
					</td>
				</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>

<cfwindow width="200" height="150" name="deleteEmailTemplateWin" modal="true" resizable="false" title="Delete Email Template" headerStyle="background-color:##dd3a7d;">
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
			<td>
				Do you want to delete this email template?<br><br>
				<input type="button" value="  YES  " onClick="deleteEmailTemplate('yes')">&nbsp;&nbsp;<input type="button" value="  NO  " onClick="deleteEmailTemplate('no')">
			</td>
		</tr>
	</table>
</cfwindow>

<!--- <cfwindow name="editEmailTemplateWin" modal="true" resizable="false" title="Edit Email Template" width="775" height="750" headerStyle="background-color:##dd3a7d;">
	<cfform name="frmEmailTemplate">
    <input type="hidden" name="pk_emailtemplate" value="" />
		<table width="100%">
			<tr>
				<td colspan="2">
					Title:&nbsp;&nbsp;<cfinput name="txtEmailName" size="40">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<cftextarea name="txtEmailContent" id="txtEmailContent" width="725" height="625" richtext="yes" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" name="btnAction" value="Update" onClick="if(CheckEntries() == true){saveemailtemplate()}">
				</td>
			</tr>
	</cfform>
</cfwindow> --->
<cfset ajaxOnLoad("init")>
