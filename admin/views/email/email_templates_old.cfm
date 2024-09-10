<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/email.js.cfm" language="JavaScript"></script>'>
<cfajaxproxy cfc="admin.models.email" jsclassname="cfcproxy_emailtemplate">

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td valign="top" width="300">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr>
					<td>
						<cfgrid format="html" name="emailTemplateGrid" pagesize="15" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.email.getEmailTemplates({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
						    <cfgridcolumn name="email_name" header="Email Title" width="400">
						</cfgrid>
					</td>
				</tr>
			</table>										
			</cfform>
		</td>
	</tr>
</table>

<cfwindow name="editEmailTemplateWin" modal="true" resizable="false" title="Edit Email Template" width="775" height="750" headerStyle="background-color:##dd3a7d;">
	<cfform name="frmEmailTemplate">
    <input type="hidden" name="pk_emailtemplate" value="" />
		<table width="100%">
			<tr>
				<td colspan="2">
					<cfinput name="txtEmailName" size="40">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<cftextarea name="txtEmailContent" id="txtEmailContent" width="725" height="625" richtext="yes" />
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" name="btnAction" value="Update Email Template" onClick="javascript:savepage();"></td>
			</tr>
	</cfform>
</cfwindow>
<cfset ajaxOnLoad("init")>

