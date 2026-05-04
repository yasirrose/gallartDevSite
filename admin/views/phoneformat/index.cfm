<cfoutput>
<table cellspacing="0" cellpadding="10" border="0" width="100%">
	<tr>
		<td>
			<strong>Choose Database:</strong>
		</td>
	</tr>
	<tr>
		<td>
			<a href="index.cfm?event=phoneformat.edit&db=customers">CUSTOMERS</a>  #getUnformattedCustomers#
		</td>
	</tr>
	<tr>
		<td>
			<a href="index.cfm?event=phoneformat.edit&db=leads">LEADS</a> #getUnformattedLeads#
		</td>
	</tr>
	<tr>
		<td>
			<a href="index.cfm?event=phoneformat.edit&db=users">SELLERS</a> #getUnformattedSellers#
		</td>
	</tr>
</table>
</cfoutput>
