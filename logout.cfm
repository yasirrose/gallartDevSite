<cfset temp = StructDelete(session,'sellerinfo') />	
<cfif isDefined("session")>
    <cfset StructClear(session) />
    <cfset sessionInvalidate() />
</cfif>

<cfset url_string = "/" />

<!--- Redirect ONLY to item page --->
<cfif structKeyExists(form,"redirect") AND len(trim(form.redirect)) AND findNoCase("/artist/", form.redirect)>
    <cfset url_string = form.redirect>
</cfif>

<cflocation addtoken="No" url="#url_string#">


