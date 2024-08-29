<cfset strCaptcha = Decrypt( url.c, "gallart-is-the-best", "CFMX_COMPAT", "HEX"	) />
<cfoutput>#strCaptcha#</cfoutput>