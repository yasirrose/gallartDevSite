<!--- 


<cfoutput>
#getEmailsSent.recordcount# EMAILS SENT<br><br>
#getClickins.recordcount# CLICKINS<br><br>
</cfoutput>

<!--- <cfdump var="#getClickins#"> --->


<cfabort> --->
<cfajaxproxy cfc="admin.models.email" jsclassname="cfcproxy_emailtemplate">
<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/email.clickReports.js.cfm" language="JavaScript"></script>'>
<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td colspan="2" valign="top" class="title">
			Double click Email Title to view Click Report:
		</td>
	</tr>
	<tr>
		<td valign="top" width="300">
			<cfform name="gridForm">
			<table cellspacing="0" cellpadding="1" border="0" width="100%">
				<tr>
					<td>
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


<cfwindow name="displayClickReport" modal="true" resizable="false" title="Click Report" width="400" height="200" headerStyle="background-color:##dd3a7d;">
	<div style="float: left;font-family: Arial; font-size: 10px;">EMAILS SENT:&nbsp;</div><div id="emailsSent" style="float: left;font-family: Arial; font-size: 10px;"></div>
	<br><br>
	<div style="float: left;font-family: Arial; font-size: 10px;">CLICKINS:&nbsp;</div><div id="clickIns" style="float: left;font-family: Arial; font-size: 10px;"></div>
	
</cfwindow>

<cfset ajaxOnLoad("init")>

