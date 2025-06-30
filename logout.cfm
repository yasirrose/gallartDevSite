<cfset temp = StructDelete(session,'sellerinfo') />	
<cfif isDefined("session")>
    <cfset StructClear(session) />
    <cfset sessionInvalidate() />
</cfif>

<cfset url_string = "/" />


<cflocation addtoken="No" url="#url_string#">


