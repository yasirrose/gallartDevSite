<cfajaxproxy cfc="admin.models.email" />
<script src="../js/jquery-1.3.2.js" type="text/javascript"></script>
<script src="../js/jquery.tablesorter.js" type="text/javascript"></script>
<script src="../js/jquery.tablesorter.pager.js" type="text/javascript"></script>
<script src="scripts/email.employeeEmail.js.cfm" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="../css/jquery/tablesorter.css">
<div>
    <cfquery name="getTemplates" datasource="#application.dsource#">
        SELECT *
        FROM emailTemplateDesign           
    </cfquery>
	<div style="font-size:12px;font-weight:bold;padding: 5px 0;">Email Templates:</div>
	<form>
		<select name="emailTemplates" id="emailTemplates" onchange="loadTemplate(this.value)">
            <option value="">Please Select Template</option>
            <cfoutput>
                <!--- <cfif isDefined('getData') and getTemplates.name eq getData.name>Selected</cfif> --->
                <cfloop query="getTemplates">
                    <option value="#getTemplates.id#" >#getTemplates.name#</option>
                </cfloop>
            </cfoutput>
		</select>
	</form>
</div>
<!--- <input type="button" value="View latest email template" onclick="viewLatestEmailTemplate()"/> --->
<!--- <cfif getLatestEmployeeOrderEmail.recordcount AND getRemainingOrderEmails.recordcount LT getEmployeeContactsOrders.recordcount>
<div id="completeLatest" style="font-size:11px;">
	Your latest email was not completed.  Would you like to complete it? <input type="button" value="View latest email template" onclick="viewLatestEmailTemplate()"/><br />
	<form><input type="button" value="Complete Latest Email" onclick="completeEmail()" /></form>
</div>
</cfif> --->
<div style="position:relative;">
	<h2>Contacts from Orders</h2>
	<cfoutput><div style="float:left;font-size:11px;">
		#getEmployeeContactsOrders.recordcount# records found</div><br />
		<!--- <form><input type="button" value="Email Contacts From Orders" onclick="emailOrderContacts()" /></form>
		<form><input type="button" value="Send Test Email To Me" onclick="mailToMe()" /></form> --->
	</cfoutput>
	<table border="0" cellspacing="1" class="tablesorter" id="emailContactsOrders">
		<thead>
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>Last Email Sent</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="getEmployeeContactsOrders">
			<tr>
				<td>#fname#</td>
				<td>#lname#</td>
				<td>#email#</td>
				<td>#employee_email#</td>
			</tr>
			</cfoutput>
		</tbody>

	</table>

	<div id="pagerOrders" class="pager">
		<img src="../images/first.png" class="first"/>
		<img src="../images/prev.png" class="prev"/>
		<input type="text" class="pagedisplay"/>
		<img src="../images/next.png" class="next"/>
		<img src="../images/last.png" class="last"/>
		<select class="pagesize">
			<option value="20">20</option>
			<option value="100" selected="selected">100</option>
			<option value="200">200</option>
			<option value="300">300</option>
		</select>
	</div>
	<!---<div id="orderEmailsSent" style="width: 200px; height: 400px;border:1px solid #000;background-color:#EEE;position:absolute;top:0px;left:30%;padding:10px;display:none;font-size:11px;overflow-y:auto;">
		<b>Emails Sent:</b><br />
	</div>--->

</div>
<br /><br />
<!---<div style="position:relative;">
	<h2>Contacts from Leads</h2>
	<cfoutput><div style="float:left;font-size:11px;">
		#getEmployeeContactsLeads.recordcount# records found</div><br />
		<input type="button" value="Email Lead Contacts" onclick="emailLeadContacts()" />
	</cfoutput>
	<table border="0" cellspacing="1" class="tablesorter" id="emailContactsLeads">
		<thead>
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>Email Sent</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="getEmployeeContactsLeads">
			<tr>
				<td>#fname#</td>
				<td>#lname#</td>
				<td>#email#</td>
				<td>#employee_email#</td>
			</tr>
			</cfoutput>
		</tbody>

	</table>

	<div id="pagerLeads" class="pager">
		<img src="../images/first.png" class="first"/>
		<img src="../images/prev.png" class="prev"/>
		<input type="text" class="pagedisplay"/>
		<img src="../images/next.png" class="next"/>
		<img src="../images/last.png" class="last"/>
		<select class="pagesize">
			<option value="20">20</option>
			<option value="100" selected="selected">100</option>
			<option value="200">200</option>
			<option value="300">300</option>
		</select>
	</div>

	<div id="leadEmailsSent" style="width: 200px; height: 400px;border:1px solid #000;background-color:#EEE;position:absolute;top:0px;left:30%;padding:10px;display:none;font-size:11px;overflow-y:auto;">
		<b>Emails Sent:</b><br />
	</div>

</div>--->

<!--- <cfwindow name="emailTemplateWin" modal="true" resizable="false" title="Email Template" width="700" height="600" headerStyle="background-color:##dd3a7d;">
	<cfform name="contentForm" id="contentForm" action="index.cfm?event=email.saveEmailTemplate">
		<cftextarea name="emailContent" id="emailContent" richtext="yes" toolbar="Basic" width="650" height="500"></cftextarea>
		<input type="submit" class="emailTemplateSubmit" value="Select Template" />
	</cfform>
</cfwindow> --->

<cfwindow name="emailProgress" modal="true" resizable="false" title="Email Progress" width="200" height="500" headerStyle="background-color:##dd3a7d;">
	<div id="emailProgressDisplay" style="font-size:11px;"></div>
</cfwindow>

<script>
$(function() {
	$('#emailContactsOrders.tablesorter').tablesorter({
			widthFixed: true
		})
		.tablesorterPager({
			container: $("#pagerOrders"),
			size: 100,
			tableId: 'emailContactsOrders'
		})
});
$(function() {
	$('#emailContactsLeads.tablesorter').tablesorter({
			widthFixed: true
		})
		.tablesorterPager({
			container: $("#pagerLeads"),
			size: 100,
			tableId: 'emailContactsLeads'
		})
});

function loadTemplate(t){

	if(t != ''){
		window.open('index.cfm?event=emailTemplate.editorEmailTemplate&id=' + t, 'editor', 'width=800,height=800,left=0,top=0,resizable=yes,scrollbars=yes');

		/*
		var edit = new admin.models.email();
		getTemplate = edit.getEmailTemplate(t);
		emailContent = getTemplate.DATA[0][2];
		var emailContentId = document.forms['contentForm'].emailContent.id;
		// ColdFusion.RichText.setValue(emailContentId, emailContent);
		$('.emailTemplateSubmit').show();
		ColdFusion.Window.show('emailTemplateWin'); */
	}

}
</script>
