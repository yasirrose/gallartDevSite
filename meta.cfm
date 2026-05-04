<cfparam name="application.siteCanonicalBaseUrl" default="https://gallart.com">
<cfparam name="application.siteBaseUrl" default="https://gallart.com">
<cfparam name="application.siteName" default="Gallart">

<cfset seoDescriptionDefault = "Fine Art Buy and Sell gallery with curated works by Warhol, Lichtenstein, Wesselmann, Indiana, Picasso, Chagall, Haring, Max, Britto, Neiman, and more.">
<cfset seoKeywordsDefault = "fine art, buy art, sell art, warhol, lichtenstein, wesselmann, picasso, chagall, haring, peter max, britto, neiman">
<cfset seoTitle = companyname & " - " & titletext>
<cfset seoDescription = seoDescriptionDefault>
<cfset seoKeywords = seoKeywordsDefault>
<cfset seoRobots = "index, follow, max-image-preview:large">
<cfset canonicalPath = cgi.script_name>

<cfif isDefined("pageTitle") AND len(trim(pageTitle))>
		<cfset seoTitle = trim(pageTitle)>
</cfif>
<cfif isDefined("pageDescription") AND len(trim(pageDescription))>
		<cfset seoDescription = trim(pageDescription)>
</cfif>
<cfif isDefined("pageKeywords") AND len(trim(pageKeywords))>
		<cfset seoKeywords = trim(pageKeywords)>
</cfif>
<cfif isDefined("pageRobots") AND len(trim(pageRobots))>
		<cfset seoRobots = trim(pageRobots)>
</cfif>
<cfif isDefined("pageCanonicalPath") AND len(trim(pageCanonicalPath))>
		<cfset canonicalPath = trim(pageCanonicalPath)>
<cfelseif structKeyExists(cgi, "path_info") AND len(trim(cgi.path_info))>
		<cfset canonicalPath = trim(cgi.path_info)>
</cfif>

<cfif left(canonicalPath, 4) EQ "http">
		<cfset canonicalUrl = canonicalPath>
<cfelse>
		<cfif left(canonicalPath, 1) NEQ "/">
				<cfset canonicalPath = "/" & canonicalPath>
		</cfif>
		<cfset canonicalUrl = application.siteCanonicalBaseUrl & canonicalPath>
</cfif>

<cfoutput>
<meta name="description" content="#HTMLEditFormat(seoDescription)#">
<meta name="keywords" content="#HTMLEditFormat(seoKeywords)#">
<meta name="robots" content="#HTMLEditFormat(seoRobots)#">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="canonical" href="#HTMLEditFormat(canonicalUrl)#">

<meta property="og:type" content="website">
<meta property="og:site_name" content="#HTMLEditFormat(application.siteName)#">
<meta property="og:title" content="#HTMLEditFormat(seoTitle)#">
<meta property="og:description" content="#HTMLEditFormat(seoDescription)#">
<meta property="og:url" content="#HTMLEditFormat(canonicalUrl)#">

<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="#HTMLEditFormat(seoTitle)#">
<meta name="twitter:description" content="#HTMLEditFormat(seoDescription)#">

<script type="application/ld+json">
{
	"@context": "https://schema.org",
	"@type": "Organization",
	"name": "#JSStringFormat(application.siteName)#",
	"url": "#JSStringFormat(application.siteCanonicalBaseUrl)#",
	"logo": "#JSStringFormat(application.siteCanonicalBaseUrl)#/img/djlogo.gif",
	"contactPoint": [{
		"@type": "ContactPoint",
		"telephone": "+1-305-932-6166",
		"contactType": "customer service"
	}],
	"sameAs": [
		"https://www.facebook.com/pages/GallArt/119056118127427"
	]
}
</script>
<script type="application/ld+json">
{
	"@context": "https://schema.org",
	"@type": "WebSite",
	"name": "#JSStringFormat(application.siteName)#",
	"url": "#JSStringFormat(application.siteCanonicalBaseUrl)#",
	"potentialAction": {
		"@type": "SearchAction",
		"target": "#JSStringFormat(application.siteCanonicalBaseUrl)#/artists/search/{search_term_string}",
		"query-input": "required name=search_term_string"
	}
}
</script>
</cfoutput>
