<cfoutput>
<table cellspacing="0" cellpadding="0" border="0" width="95%" align="center" style="padding-top: 5px; border-top: solid 2px ##db3a7d;">
	<tr>
		<td align="center">
			<a href="index.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>">HOME</a> | 
			<a href="logout.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>">LOG OUT</a>
		</td>
	</tr>
	<tr>
		<td align="center" style="font-size: 8pt; padding-bottom: 10px;">
			copyright #year(createodbcdate(now()))# www.gallart.com
		</td>
	</tr>
</table>
</cfoutput>
