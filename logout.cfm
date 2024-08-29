<cfset temp = StructDelete(session,'sellerinfo') />	

<cfif isDefined('xss')>
	<cfset url_string = "index.cfm?xss="&xss />
<cfelse>
	<cfset url_string = "index.cfm" />
</cfif>

<cflocation addtoken="No" url="#url_string#">


