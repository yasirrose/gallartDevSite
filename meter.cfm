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
<Table cellpadding="0" cellspacing="0" border="0" width="95%">
<cfloop query="metershow">
<cfset cqty = #qty# + #cqty#>
<tr>
	<td width="85%"><font size="1" face="arial">#name#</font></td>
	<td width="5%" align="center"><font size="1" face="arial">#qty#</font></td>
	<td width="10%" align="right"><font size="1" face="arial">#dollarformat(charge*qty)#</font></td>
</tr>
<cfset csum = (#charge#*#qty#) + #csum#>
</cfloop>

<Tr>
	<td colspan="2">
	<font size="1" face="verdana, arial"><b>Total:</b></font>
	</td>
	<td align="right"><font size="1" face="verdana, arial">#dollarformat(csum)#</font>
	</td>
</tr>
<tr>
	<td colspan="3" align="Center"><font size="1" face="arial">
	<a href="view.cfm?xss=#xss#&co=y">View #cqty# items in List</font>
	</td>
</tr>
</table>
</cfoutput>
</cfif>
</cfif>
