<cfajaxproxy cfc="admin.models.email" />
<script src="../js/jquery-1.3.2.js" type="text/javascript"></script>
<script src="../js/jquery.tablesorter.js" type="text/javascript"></script>
<script src="../js/jquery.tablesorter.pager.js" type="text/javascript"></script>
<script src="scripts/email.employeeEmail.js.cfm" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="../css/jquery/tablesorter.css">
<div>
	<div style="font-size:12px;font-weight:bold;padding: 5px 0;">Select Type:</div>
	<form>
		<!--- <select name="emailTemplates" id="emailTemplates" onchange="selectEmailTemplate(this.value)">
			<option value="">Please Select Template</option>
			<cfoutput query="getContactEmailTemplates">
				<option value="#pk_emailtemplate#">#email_name#</option>
			</cfoutput>
		</select> --->

		<select name="emailType" id="emailType">
			<option value="all">Please Select</option>
			<option value="orders">Orders Emails</option>
			<option value="newsletter">Newsletter Email</option>
		</select> 

	</form>
</div>
<!--- <cfif getLatestEmployeeOrderEmail.recordcount AND getRemainingOrderEmails.recordcount LT getEmployeeContactsOrders.recordcount>
<div id="completeLatest" style="font-size:11px;">
	Your latest email was not completed.  Would you like to complete it? <input type="button" value="View latest email template" onclick="viewLatestEmailTemplate()"/><br />
	<form><input type="button" value="Complete Latest Email" onclick="completeEmail()" /></form>
</div>
</cfif> --->

<cfset emailData = createObject("component", "admin.models.email").getCombinedEmailData()>

<!--- <cfdump var="#emailData#" abort="true"> --->

<div style="position:relative;">
	<h2>Contacts from Orders</h2>
	<!--- <cfoutput><div style="float:left;font-size:11px;">
		#getEmployeeContactsOrders.recordcount# records found</div><br />
		<form><input type="button" value="Email Contacts From Orders" onclick="emailOrderContacts()" /></form>
		<form><input type="button" value="Send Test Email To Me" onclick="mailToMe()" /></form>
	</cfoutput> --->

	<cfoutput>
	<div style="float:left;font-size:11px;">
		#emailData.recordCount# records found
	</div><br />
</cfoutput>

	<!--- <table border="0" cellspacing="1" class="tablesorter" id="emailContactsOrders">
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

	</table> --->

	<div>
		<form method="post" action="/admin/models/email.cfc?method=exportNewsletterCSV" id="newsletterExportForm">
			<button type="submit" id="exportNewsletterCsv" style="display: none;">Export Newsletter Emails to CSV</button>
		</form>
	</div>

	<table border="0" cellspacing="1" class="tablesorter" id="emailContactsOrders">
		<thead>
			<tr>
				<!--- <th>First Name</th> --->
				<!--- <th>Last Name</th> --->
				<th>Email</th>
				<th>Last Email Sent</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="emailData">
			<tr>
				<!--- <td>#fname#</td> --->
				<!--- <td>#lname#</td> --->
				<td>#email#</td>
				<td>#last_email_sent#</td>
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

<!--- <cfwindow name="emailProgress" modal="true" resizable="false" title="Email Progress" width="200" height="500" headerStyle="background-color:##dd3a7d;">
	<div id="emailProgressDisplay" style="font-size:11px;"></div>
</cfwindow> --->

<script>
	$(document).ready(function() {
		function loadEmailData(emailType) {
			
			$.ajax({
				url: "/admin/models/email.cfc?method=getCombinedEmailData&returnformat=json",
				type: "GET",
				data: { emailType: emailType },
				dataType: "json",
				success: function(data) {
					var thead = $('#emailContactsOrders thead');
					var tbody = $('#emailContactsOrders tbody');

					  const $table = $('#emailContactsOrders');

					$('#emailContactsOrders colgroup').remove();

					// $table.trigger("destroy");

					tbody.empty();
					thead.empty();

					var headerRow = '<tr><th>Email</th><th>Last Email Sent</th></tr>';
					thead.append(headerRow);

					
						var columns = data.COLUMNS;
						var rows = data.DATA;

						for (var i = 0; i < rows.length; i++) {
							var row = rows[i];
							var html = '<tr>';

							html += '<td>' + row[2] + '</td>'; // Email
							html += '<td>' + row[3] + '</td>'; // Created Date

							html += '</tr>';
							tbody.append(html);
						}

						$("#emailContactsOrders")
						.unbind() // unbind any previous handlers
						.tablesorter({
							widthFixed: true
						});

						$("#pagerOrders").empty().html(`
							<img src="../images/first.png" class="first"/>
							<img src="../images/prev.png" class="prev"/>
							<input type="text" class="pagedisplay"/>
							<img src="../images/next.png" class="next"/>
							<img src="../images/last.png" class="last"/>
							<select class="pagesize">
								<option value="20" >20</option>
								<option value="100" selected="selected">100</option>
								<option value="200">200</option>
								<option value="300">300</option>
							</select>
						`);

						$table.tablesorterPager({
							container: $("#pagerOrders"),
							size: parseInt($(".pagesize").val()) || 100,
							output: '{page}/{totalPages}'
						}); // reapply tablesorter
				},
				error: function(err) {
					console.error("AJAX Error: ", err);
				}
			});
		}

		// Initial call to load all data
		loadEmailData("all");

		// On dropdown change
		$('#emailType').change(function() {
			var selected = $(this).val();
			loadEmailData(selected);

			if (selected === 'newsletter') {
				$('#exportNewsletterCsv').show();
			} else {
				$('#exportNewsletterCsv').hide();
			}

		});
	});
</script>

<script>
// $(function() {
// 	$('#emailContactsOrders.tablesorter').tablesorter({
// 			widthFixed: false
// 		})
// 		.tablesorterPager({
// 			container: $("#pagerOrders"),
// 			size: 100,
// 			tableId: 'emailContactsOrders'
// 		})
// });

</script>

<style>
	#pagerOrders{
		position: static !important;
	}
</style>
