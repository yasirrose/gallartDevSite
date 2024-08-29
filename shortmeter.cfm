<cfif parameterexists(xss)>
<cfquery name="metershow" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
Select * from cart
	inner join products ON cart.pid = products.uid 
where trackerid = '#xss#'
</cfquery> 
<cfset cqty = 0>
<cfset csum = 0>
<cfif metershow.recordcount gt 0>
<cfoutput>
<Table cellpadding="0" cellspacing="0" border="0" width="100%">
<cfloop query="metershow">
<cfset cqty = #qty# + #cqty#>
<cfset csum = (#charge#*#qty#) + #csum#>
</cfloop>

<Tr>
	<td>
	<a href="view.cfm?xss=#xss#&co=y">#cqty# item(s) - <b>Total:</b> #dollarformat(csum)#</a>
	</td>
	<td align="right">
		<a href="view.cfm?xss=#xss#&co=y">VIEW CART</a>
	</td>

</tr>
</table>
</cfoutput>
</cfif>
</cfif>
