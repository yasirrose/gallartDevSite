
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Order Report #DateFormat(createodbcdate(now()))#.xls""">

<cfcontent type="application/ms-excel" reset="Yes">

<cfset grandTotal = 0 />
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr bgcolor="##000000">
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Customer</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Order Number</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Sale</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Mode Of Payment</strong>
			</td>
		</tr>
		<cfloop query="getOrderReport">
		<tr>
			<td valign="top">
				#billname#
			</td>
			<td valign="top" align="center">
				#orderuid#
			</td>
			<td valign="top">
				#dollarFormat(total)#
			</td>
			<td valign="top" align="center">
				#payment_method#
			</td>
		</tr>
		<cfset grandTotal = grandTotal + total />
		</cfloop>
		<tr>
			<td colspan="2">
				<strong>TOTAL SALE</strong>
			</td>
			<td>
				#dollarFormat(grandTotal)#
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</cfoutput>