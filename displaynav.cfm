<cfif isDefined('cat')>
	<cfif parameterexists(url.cat)>
		<cfset catpath = #url.cat#>
	<cfelseif parameterexists(productinfo.path)>
		<cfset catpath = #productinfo.path#>
	<cfelse>
		<cfset catpath = "">
	</cfif>
	
	<cfset catmax = #ListLen(catpath,":")#>
	<CFLOOP INDEX="numcat" FROM=1 TO=#catmax# STEP="1">
		<cfif not parameterexists(catitem)>
			<cfset catitem = #ListGetAt(catpath, numcat, ":")#>
		<cfelse>
			<cfset catitem = #catitem# & ":" & #ListGetAt(catpath, numcat, ":")#>
		</cfif>
		<cfoutput>
			<a href="products.cfm?cat=#URLEncodedFormat(catitem)#&xss=#xss#">
			<b>#ListGetAt(catpath, numcat, ":")#</b>
			</a>
			<font face="verdana, arial, helvetica"  size="1" color="000000">></font>
		</cfoutput>
	</CFLOOP>
</cfif>
