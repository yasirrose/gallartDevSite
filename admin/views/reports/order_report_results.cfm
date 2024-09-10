<link rel="stylesheet" type="text/css" href="../css/jquery/tablesorter.css">
<style>
	.dollarAlign{
		text-align: right;
		padding-right: 50px !important;
	}
</style>
<script type="text/javascript" src="../js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="../js/jquery.tablesorter.js"></script>
<script type="text/javascript">
$(function() {
	$("table")
		.tablesorter({
			widthFixed: true, widgets: ['zebra']
		})
});
</script>
<table cellspacing="0" cellpadding="0" border="0" width="95%">
	<tr>
		<td>
			<input type="Button" onclick="location.href='index.cfm?event=reports.orderReportSearch'" value="Back To Search"><br><br>

<cfoutput>
<span style="font-size: 12px; font-weight: bold;">
Date Range: 
<cfif isDefined('form.previous')>
	<cfif form.previous EQ 'wednesday'>
		#dateFormat(dateAdd('d',-7,form.prevWednesday))# through #dateFormat(dateAdd('d',-1,form.prevWednesday))#
	<cfelseif form.previous EQ 'week'>
		#dateFormat(dateAdd('d',-6,createODBCDate(now())))# through #dateFormat(createODBCDate(now()))#
	<cfelseif form.previous EQ 'month'>
		#dateFormat(dateAdd('d',-27,createODBCDate(now())))# through #dateFormat(createODBCDate(now()))#
	<cfelseif form.previous EQ 'year'>
		#dateFormat(dateAdd('d',-364,createODBCDate(now())))# through #dateFormat(createODBCDate(now()))#
	</cfif>
<cfelse>
	<cfif form.fromDate NEQ ''>
		#dateFormat(form.fromDate)#
	<cfelse>
		Earliest record
	</cfif>
	&nbsp;to&nbsp;
	<cfif form.toDate NEQ ''>
		#dateFormat(form.toDate)#
	<cfelse>
		Latest record
	</cfif>
</cfif>
</span>
</cfoutput>
		</td>
	</tr>
	<tr>
		<td>
			<table border="0" cellspacing="1" class="tablesorter">
				<thead>
					<tr>
						<th>Employee</th>
						<th align="center">Total</th>
						<th align="center">Subtotal</th>
						<th align="center">Gallery Price</th>
						<th align="center">Retail Price</th>
						<th align="center">Balance Due</th>
						<th align="center">Commisission</th>
					</tr>
				</thead>
				<tbody>
					<cfoutput query="getOrderReport" group="fk_employees">
					<cfset sum_total = 0 />
					<cfset sum_amountsale = 0 />
					<cfset sum_gallery = 0 />
					<cfset sum_retail = 0 />
					<cfset sum_balancedue = 0 />
					<cfoutput>
						<cfset sum_total = sum_total + total />
						<cfset sum_amountsale = sum_amountsale + amountsale />
						<cfset sum_gallery = sum_gallery + total_gallery />
						<cfset sum_retail = sum_retail + total_retail />
						<cfset sum_balancedue = sum_balancedue + balancedue />
					</cfoutput>
					<cfset commission = ((sum_total - commission_minus) * commission_percent)/100 />
					<tr>
						<td>#emp_lname#, #emp_fname#</td>
						<td class="dollarAlign">#dollarFormat(sum_total)#</td>
						<td class="dollarAlign">#dollarFormat(sum_amountsale)#</td>
						<td class="dollarAlign">#dollarFormat(sum_gallery)#</td>
						<td class="dollarAlign">#dollarFormat(sum_retail)#</td>
						<td class="dollarAlign">#dollarFormat(sum_balancedue)#</td>
						<td class="dollarAlign">#dollarFormat(commission)#</td>
					</tr>
					</cfoutput>
				</tbody>
			</table>
		</td>
	</tr>
</table>
